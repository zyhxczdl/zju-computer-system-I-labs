// Lab4-1：valid-ready 滑动窗口。仅在 in_valid && in_ready 时移入一个元素。
// 发送窗口时保持数据，直到 out_valid && out_ready；初始窗口以零填充。
`include"conv_struct.vh"
module Shift (
    input clk,
    input rst,
    input Conv::data_t in_data,
    input in_valid, 
    output reg in_ready,  
    output Conv::data_vector data,  
    output reg out_valid,
    input out_ready 
);
    // RDATA: 接收数据状态，等待 caller 发送新数据
    // TDATA: 发送数据状态，等待后端 ConvOperator 接收数据
    typedef enum logic {RDATA, TDATA} fsm_state;
    fsm_state state_reg;
    // 移位寄存器组：维护 4 个数据的滑动窗口
    // data_reg[3] 最新进入的数据
    // data_reg[0] 最早进入的数据
    Conv::data_t data_reg [Conv::LEN-1:0];
    integer i;
    //主时序逻辑：状态机 + 移位操作
    always @(posedge clk) begin
        if (rst) begin
            // 复位：回到接收状态，清空所有控制信号和数据
            state_reg <= RDATA;
            in_ready <= 1'b0;
            out_valid <= 1'b0;
            for (i = 0; i < Conv::LEN; i = i + 1) begin
                data_reg[i] <= {Conv::WIDTH{1'b0}};
            end
        end else begin
            case (state_reg)
                // RDATA 状态：接收数据
                RDATA: begin
                    in_ready <= 1'b1;
                    out_valid <= 1'b0;
                    if (in_valid && in_ready) begin
                        // data_reg[0] ← data_reg[1] ← data_reg[2] ← data_reg[3]
                        // data_reg[3] ← 新数据 in_data
                        // 最早的 data_reg[0] 被丢弃
                        for (i = 0; i < Conv::LEN - 1; i = i + 1) begin
                            data_reg[i] <= data_reg[i+1];
                        end
                        data_reg[Conv::LEN-1] <= in_data; 
                        in_ready <= 1'b0; 
                        state_reg <= TDATA;
                    end
                end
                // TDATA 状态：发送数据
                TDATA: begin
                    in_ready <= 1'b0; 
                    out_valid <= 1'b1; 
                    if (out_valid && out_ready) begin
                        out_valid <= 1'b0; 
                        state_reg <= RDATA; 
                    end
                end
                default: state_reg <= RDATA;
            endcase
        end
    end
    //将内部 data_reg 数组连接到输出 data 结构体 
    generate
        for (genvar j = 0; j < Conv::LEN; j = j + 1) begin
            assign data.data[j] = data_reg[j];
        end
    endgenerate

endmodule
