// Lab4-1：卷积单元使用的 LEN 位无符号乘法器，结果宽度为 2*LEN。
// start/finish 协议同 Lab3-3；LEN 由调用方传入，当前计数写法要求 LEN>=2。
`include"conv_struct.vh"
module Multiplier #(
    parameter LEN = 32 
) (
    input clk, 
    input rst, 
    input [LEN-1:0] multiplicand, 
    input [LEN-1:0] multiplier, 
    input start, 
    output [LEN*2-1:0] product,
    output finish
);
    localparam PRODUCT_LEN = LEN*2;              // 乘积位宽 = 2*LEN
    logic [LEN-1:0] multiplicand_reg;            // 被乘数寄存器（锁存输入值）
    logic [PRODUCT_LEN-1:0] product_reg;         // 乘积累积寄存器（2*LEN 位）
    // 计数器：共需 LEN 次迭代
    localparam CNT_LEN = $clog2(LEN);            // 计数器位宽：$clog2(LEN)
    localparam CNT_NUM = LEN[CNT_LEN-1:0] - 1'b1; // 计数上限 = LEN-1
    logic [CNT_LEN-1:0] work_cnt;                // 当前迭代计数
    // FSM 状态定义
    typedef enum [1:0] {IDLE, WORK, FINAL} fsm_state;
    fsm_state fsm_state_reg;
    //主时序逻辑：移位乘法状态机
    always @(posedge clk) begin
        if (rst) begin
            // 复位：清空所有寄存器
            fsm_state_reg <= IDLE;
            work_cnt <= {CNT_LEN{1'b0}};
            multiplicand_reg <= {LEN{1'b0}};
            product_reg <= {PRODUCT_LEN{1'b0}};
        end else begin
            case (fsm_state_reg)
                IDLE: begin
                    if (start) begin
                        // 启动计算，初始化各寄存器
                        fsm_state_reg <= WORK;
                        work_cnt <= {CNT_LEN{1'b0}};       // 计数器归零
                        multiplicand_reg <= multiplicand;   // 锁存被乘数
                        //   高 LEN 位为 0（累加初值），低 LEN 位存放乘数
                        product_reg <= {{LEN{1'b0}}, multiplier};
                    end
                end
                // WORK 状态：每周期检查 LSB，累加后右移
                // 类比手算乘法
                // 迭代 LEN 次后 product_reg 即为完整乘积
                WORK: begin
                    if (product_reg[0]) begin
                        // LSB=1：高 LEN 位累加被乘数，整体右移 1 位
                        product_reg <= { ( {1'b0, product_reg[PRODUCT_LEN-1:LEN]} + {1'b0, multiplicand_reg} ), product_reg[LEN-1:1] };
                    end else begin
                        // LSB=0：仅右移 1 位（高位补 0）
                        product_reg <= { 1'b0, product_reg[PRODUCT_LEN-1:1] };
                    end
                    if (work_cnt == CNT_NUM) begin
                        // 已完成全部 LEN 次迭代，进入完成状态
                        fsm_state_reg <= FINAL;
                    end else begin
                        work_cnt <= work_cnt + 1'b1;
                    end
                end
                // FINAL 状态：结果就绪，仅维持一个周期
                FINAL: begin
                    fsm_state_reg <= IDLE;   // 下一时钟周期回到空闲
                end
                default: fsm_state_reg <= IDLE;
            endcase
        end
    end
    assign product = product_reg;                // 乘积寄存器值全程输出
    assign finish  = (fsm_state_reg == FINAL);   // FINAL 状态时 finish=1
endmodule
