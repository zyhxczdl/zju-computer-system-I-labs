// Lab3-2：两位 BCD 计数器，cnt[7:4] 为十位、cnt[3:0] 为个位。
// BASE/INITIAL 使用普通整数参数；输出使用 BCD 编码，例如十进制 23 输出 8'h23。
// 到 BASE-1 且允许计数时同步清零两位，并向更高位发出 co。
module Cnt2num #(
    parameter BASE = 24,
    parameter INITIAL = 16
)(
    input en,
    input clk,
    input rstn,
    input low_co,
    input high_rst,
    output co,
    output [7:0] cnt
);

    localparam HIGH_BASE = 10;
    localparam LOW_BASE  = 10;
    localparam HIGH_INIT = INITIAL/10;
    localparam LOW_INIT  = INITIAL%10;
    localparam HIGH_CO   = (BASE-1)/10;
    localparam LOW_CO    = (BASE-1)%10;


    wire low_to_high_co; 
    wire is_at_limit;
    wire internal_rst;

    assign is_at_limit = (cnt[7:4] == 4'(HIGH_CO)) && (cnt[3:0] == 4'(LOW_CO));

    assign co = en && low_co && is_at_limit;

    assign internal_rst = high_rst || (en && low_co && is_at_limit);

    Cnt #(
        .BASE(LOW_BASE),
        .INITIAL(LOW_INIT)
    ) low_cnt_u (
        .en(en),
        .clk(clk),
        .rstn(rstn),
        .low_co(low_co),
        .high_rst(internal_rst),
        .co(low_to_high_co),
        .cnt(cnt[3:0])
    );

    Cnt #(
        .BASE(HIGH_BASE),
        .INITIAL(HIGH_INIT)
    ) high_cnt_u (
        .en(en),
        .clk(clk),
        .rstn(rstn),
        .low_co(low_to_high_co),
        .high_rst(internal_rst),
        .co(),
        .cnt(cnt[7:4])
    );


endmodule