// Lab2-1：一位全加器。s 为三输入异或；c_out 在至少两个输入为 1 时置位。
module Adder(
    input a,
    input b,
    input c_in,
    output s,
    output c_out
);
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) |  (c_in & (a ^ b));
    
endmodule 
