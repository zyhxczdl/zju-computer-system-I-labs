// Lab3-3 本地复用的 Lab3-2 计数器；实现说明参见 src/lab3-2/README.md。
module Cnt #(
    parameter BASE = 10,
    parameter INITIAL = 0
) (
    input en,
    input clk,
    input rstn,
    input low_co,
    input high_rst,
    output co,
    output reg [3:0] cnt
);

    assign co = en && low_co && (cnt == BASE - 1);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt <=4'(INITIAL);
        end else if (high_rst) begin
            cnt <= 0;
        end else if (en && low_co) begin
            if (cnt == BASE - 1)
                cnt <= 0;
            else
                cnt <= cnt + 1'b1;
        end
    end

endmodule