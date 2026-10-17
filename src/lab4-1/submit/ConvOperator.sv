// Lab4-1：四路无符号乘积加和；当前实现固定使用 data[0:3]，要求 Conv::LEN=4。
// 乘法结果先锁存到 stage1，再由组合加法树求和并锁存到 stage2。
// 各级加法宽度均为 2*Conv::WIDTH，超过此宽度的进位按位宽截断。
// 输出在握手完成前保持稳定；调用方需保证乘法器采样前输入窗口和 kernel 稳定。
`include"conv_struct.vh"
module ConvOperator(
    input clk, 
    input rst, 
    input Conv::data_vector kernel,
    input Conv::data_vector data,
    input in_valid, 
    output reg in_ready, 
    output Conv::result_t result, 
    output reg out_valid,
    input out_ready 
);
    localparam VECTOR_WIDTH = 2*Conv::WIDTH;
    // Stage1 寄存器：存储 4 个乘法器的输出
    logic [VECTOR_WIDTH-1:0] stage1_data_0;
    logic [VECTOR_WIDTH-1:0] stage1_data_1;
    logic [VECTOR_WIDTH-1:0] stage1_data_2;
    logic [VECTOR_WIDTH-1:0] stage1_data_3;
    logic stage1_valid_0;
    logic stage1_valid_1;
    logic stage1_valid_2;
    logic stage1_valid_3;
    // Stage2 寄存器：存储并行加法树的最终结果
    logic [VECTOR_WIDTH-1:0] stage2_data;
    logic stage2_valid;
    // 并行加法树
    // 第一级：两两相加 → add_01, add_23
    // 第二级：两个中间结果相加 → adder_tree_result
    wire [VECTOR_WIDTH-1:0] add_01, add_23;
    assign add_01 = stage1_data_0 + stage1_data_1;
    assign add_23 = stage1_data_2 + stage1_data_3;
    wire [VECTOR_WIDTH-1:0] adder_tree_result;
    assign adder_tree_result = add_01 + add_23;// 最终卷积结果
    // 乘法器控制信号（每个乘法器独立控制）
    logic          mult_start_0;
    logic          mult_start_1;
    logic          mult_start_2;
    logic          mult_start_3;
    logic          mult_finish_0;
    logic          mult_finish_1;
    logic          mult_finish_2;
    logic          mult_finish_3;
    logic [VECTOR_WIDTH-1:0] mult_product_0;
    logic [VECTOR_WIDTH-1:0] mult_product_1;
    logic [VECTOR_WIDTH-1:0] mult_product_2;
    logic [VECTOR_WIDTH-1:0] mult_product_3;
    // 从 data 和 kernel 结构体中抽出各元素的乘数和被乘数
    wire [Conv::WIDTH-1:0] mult_a_0, mult_a_1, mult_a_2, mult_a_3;
    wire [Conv::WIDTH-1:0] mult_b_0, mult_b_1, mult_b_2, mult_b_3;
    assign mult_a_0 = data.data[0];   assign mult_b_0 = kernel.data[0];
    assign mult_a_1 = data.data[1];   assign mult_b_1 = kernel.data[1];
    assign mult_a_2 = data.data[2];   assign mult_b_2 = kernel.data[2];
    assign mult_a_3 = data.data[3];   assign mult_b_3 = kernel.data[3];
    // 例化 4 个乘法器：并行计算 4 对数据的乘积
    //   卷积公式: result = data[0]*kernel[0] + data[1]*kernel[1] + data[2]*kernel[2] + data[3]*kernel[3]
    Multiplier #(.LEN(Conv::WIDTH)) mult0(
        .clk(clk), .rst(rst),
        .multiplicand(mult_a_0), .multiplier(mult_b_0),
        .start(mult_start_0), .product(mult_product_0), .finish(mult_finish_0)
    );
    Multiplier #(.LEN(Conv::WIDTH)) mult1(
        .clk(clk), .rst(rst),
        .multiplicand(mult_a_1), .multiplier(mult_b_1),
        .start(mult_start_1), .product(mult_product_1), .finish(mult_finish_1)
    );
    Multiplier #(.LEN(Conv::WIDTH)) mult2(
        .clk(clk), .rst(rst),
        .multiplicand(mult_a_2), .multiplier(mult_b_2),
        .start(mult_start_2), .product(mult_product_2), .finish(mult_finish_2)
    );
    Multiplier #(.LEN(Conv::WIDTH)) mult3(
        .clk(clk), .rst(rst),
        .multiplicand(mult_a_3), .multiplier(mult_b_3),
        .start(mult_start_3), .product(mult_product_3), .finish(mult_finish_3)
    );
    // 所有乘法器都完成的标志：4 路 finish 信号取逻辑与
    wire all_mult_finish = mult_finish_0 & mult_finish_1 & mult_finish_2 & mult_finish_3;
    // FSM 状态定义
    //   RDATA: 等待接收 Shift 发来的数据和卷积核
    //   WORK:  等待乘法器完成 → 锁存 stage1 → 加法树稳定 → 锁存 stage2
    //   TDATA: 将最终结果通过 valid-ready 协议发送给 caller
    typedef enum logic [1:0] {RDATA, WORK, TDATA} fsm_state;
    fsm_state state_reg;    // 当前状态寄存器
    //主时序逻辑：状态机控制整个卷积运算流程
    always @(posedge clk) begin
        if (rst) begin
            // 复位：清空所有寄存器和控制信号
            state_reg <= RDATA;
            in_ready <= 1'b0;
            out_valid <= 1'b0;
            mult_start_0 <= 1'b0; mult_start_1 <= 1'b0;
            mult_start_2 <= 1'b0; mult_start_3 <= 1'b0;
            stage1_data_0 <= {VECTOR_WIDTH{1'b0}}; stage1_valid_0 <= 1'b0;
            stage1_data_1 <= {VECTOR_WIDTH{1'b0}}; stage1_valid_1 <= 1'b0;
            stage1_data_2 <= {VECTOR_WIDTH{1'b0}}; stage1_valid_2 <= 1'b0;
            stage1_data_3 <= {VECTOR_WIDTH{1'b0}}; stage1_valid_3 <= 1'b0;
            stage2_data <= {VECTOR_WIDTH{1'b0}}; stage2_valid <= 1'b0;
        end else begin
            case (state_reg)
                // RDATA 状态：接收数据和卷积核
                RDATA: begin
                    in_ready <= 1'b1;      // 告知 Shift 可以发送数据
                    out_valid <= 1'b0;     // 尚无结果可输出
                    mult_start_0 <= 1'b0; mult_start_1 <= 1'b0;
                    mult_start_2 <= 1'b0; mult_start_3 <= 1'b0;
                    if (in_valid && in_ready) begin
                        // 握手成功.同时启动 4 个乘法器开始并行计算
                        mult_start_0 <= 1'b1; mult_start_1 <= 1'b1;
                        mult_start_2 <= 1'b1; mult_start_3 <= 1'b1;
                        // 清空旧数据，为新一轮计算做准备
                        stage1_valid_0 <= 1'b0; stage1_valid_1 <= 1'b0;
                        stage1_valid_2 <= 1'b0; stage1_valid_3 <= 1'b0;
                        stage2_valid <= 1'b0;
                        in_ready <= 1'b0;
                        state_reg <= WORK; 
                    end
                end
                // WORK 状态：等待乘法和加法依次完成
                // 阶段 1：等待 4 个乘法器全部 finish，锁存乘积到 stage1
                // 阶段 2：stage1 数据有效后，加法树稳定，锁存结果到 stage2
                WORK: begin
                    in_ready <= 1'b0;           //不接收新数据
                    mult_start_0 <= 1'b0; mult_start_1 <= 1'b0;
                    mult_start_2 <= 1'b0; mult_start_3 <= 1'b0;
                    // 阶段 1：所有乘法器完成，且 stage1 尚未锁存
                    if (all_mult_finish && !stage1_valid_0) begin
                        stage1_data_0 <= mult_product_0; stage1_valid_0 <= 1'b1;
                        stage1_data_1 <= mult_product_1; stage1_valid_1 <= 1'b1;
                        stage1_data_2 <= mult_product_2; stage1_valid_2 <= 1'b1;
                        stage1_data_3 <= mult_product_3; stage1_valid_3 <= 1'b1;
                    // 阶段 2：stage1 有效后，加法树组合逻辑已稳定，锁存最终结果
                    end else if (stage1_valid_0) begin
                        stage2_data <= adder_tree_result;   // 两级加法树的结果
                        stage2_valid <= 1'b1;
                        state_reg <= TDATA; 
                    end
                end
                // TDATA 状态：将最终结果发送给 caller
                TDATA: begin
                    in_ready <= 1'b0;
                    out_valid <= stage2_valid;  // 将 stage2 的有效标志传给外部
                    if (out_valid && out_ready) begin
                        out_valid <= 1'b0;       // 撤销 valid
                        state_reg <= RDATA;      // 回到接收状态，准备下一组计算
                    end
                end
                default: state_reg <= RDATA;
            endcase
        end
    end
    assign result = stage2_data;

endmodule
