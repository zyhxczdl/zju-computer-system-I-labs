// Lab1-2：32 位四选一组合选择器，每个选择值覆盖一整组 32 位输入。
module Mux4T1_32(
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [31:0] I3,
    input [1:0] S,
    output [31:0] O
);

    // 选择值 00/01/10/11 对应 I0/I1/I2/I3。
assign O = (S == 2'b00)? I0:
    (S == 2'b01)? I1:
    (S == 2'b10)? I2:
    I3;

endmodule

