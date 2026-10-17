// Lab3-2：4 位模 BASE 计数器，BASE 应适配 4 位计数范围。
// rstn 异步载入 INITIAL，high_rst 在上升沿清零且优先于 en/low_co。
// co 是当前计数到终点且本拍允许递增时的组合进位信号。
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