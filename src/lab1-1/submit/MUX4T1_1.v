// Lab1-1：门级四选一选择器。S=0/1/2/3 时分别输出 I0/I1/I2/I3。
// 先将 S 译码为四条选通信号，再将各路输入与选通信号相与、相或。
/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : MUX4T1_1                                                     **
 **                                                                          **
 *****************************************************************************/

module MUX4T1_1( I0,
                 I1,
                 I2,
                 I3,
                 O,
                 S );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input       I0;
   input       I1;
   input       I2;
   input       I3;
   input [1:0] S;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output O;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [1:0] s_logisimBus7;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet10;
   wire       s_logisimNet11;
   wire       s_logisimNet12;
   wire       s_logisimNet13;
   wire       s_logisimNet14;
   wire       s_logisimNet15;
   wire       s_logisimNet16;
   wire       s_logisimNet17;
   wire       s_logisimNet2;
   wire       s_logisimNet3;
   wire       s_logisimNet4;
   wire       s_logisimNet5;
   wire       s_logisimNet6;
   wire       s_logisimNet8;
   wire       s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus7[1:0] = S;
   assign s_logisimNet12     = I0;
   assign s_logisimNet13     = I1;
   assign s_logisimNet14     = I2;
   assign s_logisimNet15     = I3;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign O = s_logisimNet6;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet8 = ~s_logisimBus7[1];

   // NOT Gate
   assign s_logisimNet10 = ~s_logisimBus7[0];

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet9),
               .input2(s_logisimNet12),
               .result(s_logisimNet17));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet0),
               .input2(s_logisimNet13),
               .result(s_logisimNet4));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet1),
               .input2(s_logisimNet14),
               .result(s_logisimNet5));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet3),
               .input2(s_logisimNet15),
               .result(s_logisimNet16));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_5 (.input1(s_logisimNet17),
               .input2(s_logisimNet4),
               .input3(s_logisimNet5),
               .input4(s_logisimNet16),
               .result(s_logisimNet6));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet10),
               .input2(s_logisimNet8),
               .result(s_logisimNet9));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimBus7[0]),
               .input2(s_logisimNet8),
               .result(s_logisimNet0));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet10),
               .input2(s_logisimBus7[1]),
               .result(s_logisimNet1));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimBus7[0]),
               .input2(s_logisimBus7[1]),
               .result(s_logisimNet3));


endmodule
