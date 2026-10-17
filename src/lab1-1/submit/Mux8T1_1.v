// Lab1-1：两个四选一模块并行选择低四路和高四路，再由 S[2] 选择输出。
// S[1:0] 在两组中选择相同下标，整体功能为 O = I[S]。
module Mux8T1_1( 
   input [7:0] I,
   input [2:0] S,
   output O 
);
   wire out_1,out_2;
   MUX4T1_1 mux_1(.I0(I[0]),.I1(I[1]),.I2(I[2]),.I3(I[3]),.S(S[1:0]),.O(out_1));
   MUX4T1_1 mux_2(.I0(I[4]),.I1(I[5]),.I2(I[6]),.I3(I[7]),.S(S[1:0]),.O(out_2));
   assign O =S[2] ? out_2 : out_1;
endmodule
