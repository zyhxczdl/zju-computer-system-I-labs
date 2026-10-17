// Lab3-3：无符号移位累加乘法器，rst 为高有效同步复位。
// IDLE 接收 start 和操作数，WORK 迭代 LEN 次，FINAL 输出一个周期的 finish。
// product 在 finish=1 时为有效结果；忙时不接收新请求。当前计数写法要求 LEN>=2。
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

    localparam PRODUCT_LEN = LEN*2;
    logic [LEN-1:0] multiplicand_reg;
    logic [PRODUCT_LEN-1:0] product_reg;

    localparam CNT_LEN = $clog2(LEN);
    localparam CNT_NUM = LEN[CNT_LEN-1:0] - 1'b1;
    logic [CNT_LEN-1:0] work_cnt;

    typedef enum [1:0] {IDLE, WORK, FINAL} fsm_state;
    fsm_state fsm_state_reg;


    always @(posedge clk) begin
        if (rst) begin
            fsm_state_reg <= IDLE;
            work_cnt <= {CNT_LEN{1'b0}};
            multiplicand_reg <= {LEN{1'b0}};
            product_reg <= {PRODUCT_LEN{1'b0}};
        end else begin
            case (fsm_state_reg)
                IDLE: begin
                    if (start) begin
                        fsm_state_reg <= WORK;
                        work_cnt <= {CNT_LEN{1'b0}};
                        multiplicand_reg <= multiplicand;
                        product_reg <= {{LEN{1'b0}}, multiplier};
                    end
                end

                    WORK: begin
                    if (product_reg[0]) begin
                        product_reg <= { ( {1'b0, product_reg[PRODUCT_LEN-1:LEN]} + {1'b0, multiplicand_reg} ), product_reg[LEN-1:1] };
                    end else begin
                        product_reg <= { 1'b0, product_reg[PRODUCT_LEN-1:1] };
                    end

                    if (work_cnt == CNT_NUM) begin
                        fsm_state_reg <= FINAL;
                    end else begin
                        work_cnt <= work_cnt + 1'b1;
                    end
                end

                FINAL: begin
                    fsm_state_reg <= IDLE;
                end

                default: fsm_state_reg <= IDLE;
            endcase
        end
    end

    assign product = product_reg;
    assign finish  = (fsm_state_reg == FINAL);


endmodule