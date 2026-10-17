// Lab2-1：参数化行波进位加法器。carry[i] 连接第 i 位输入进位，
// carry[i+1] 连接该位输出进位，最终 c_out 为最高位的无符号进位。
module Adders #(
    parameter LENGTH = 32
)(
    input [LENGTH-1:0] a,
    input [LENGTH-1:0] b,
    input c_in,
    output [LENGTH-1:0] s,
    output c_out
);
    wire [LENGTH:0] carry;

    assign carry[0] = c_in;
    assign c_out = carry[LENGTH];

    genvar i;
    generate
        for (i = 0; i < LENGTH; i = i + 1) begin : gen_rca
            Adder u_adder (
                .a   (a[i]),
                .b   (b[i]),
                .c_in (carry[i]),
                .s (s[i]),
                .c_out(carry[i+1])
            );
        end
    endgenerate

endmodule