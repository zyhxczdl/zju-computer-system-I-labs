// Lab0-2 扩展练习（目录 lab0-3）：用与、或、非门实现四输入逻辑表达式。
// 组合逻辑无时钟；s_logisimNet* 保留原理图导出的网络编号。
module main( 
   input I0,
   input I1,
   input I2,
   input I3,
   output O 
);

   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet2;
   wire s_logisimNet3;
   wire s_logisimNet4;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;
   wire s_logisimNet9;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet13;

   assign s_logisimNet4  = I3;
   assign s_logisimNet3 = I2;
   assign s_logisimNet2 = I1;
   assign s_logisimNet1 = I0;
   assign O = s_logisimNet5;

   assign s_logisimNet9 = ~s_logisimNet4;
   assign s_logisimNet8 = ~s_logisimNet3;
   assign s_logisimNet7 = ~s_logisimNet2;
   assign s_logisimNet6 = ~s_logisimNet1;

   OR_GATE_5_INPUTS #(.BubblesMask(5'h0))
      GATES_1 (.input1(s_logisimNet0),
               .input2(s_logisimNet13),
               .input3(s_logisimNet12),
               .input4(s_logisimNet11),
               .input5(s_logisimNet10),
               .result(s_logisimNet5));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_2 (.input1(s_logisimNet7),
               .input2(s_logisimNet8),
               .input3(s_logisimNet9),
               .result(s_logisimNet0));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_3 (.input1(s_logisimNet6),
               .input2(s_logisimNet3),
               .input3(s_logisimNet7),
               .result(s_logisimNet13));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_4 (.input1(s_logisimNet6),
               .input2(s_logisimNet2),
               .input3(s_logisimNet4),
               .result(s_logisimNet12));

   AND_GATE_2_INPUTS #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet3),
               .input2(s_logisimNet4),
               .result(s_logisimNet11));

   AND_GATE_2_INPUTS #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet1),
               .input2(s_logisimNet3),
               .result(s_logisimNet10));


endmodule
