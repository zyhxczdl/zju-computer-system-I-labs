// Lab1-2：十六进制七段译码。a~g 和 p 为低电平点亮，LE=1 强制熄灭。
// 各段的或项列举的是应熄灭该段的输入值；point=1 点亮小数点。
`timescale 1ns / 1ps

module SegDecoder (
    input wire [3:0] data,
    input wire point,
    input wire LE,

    output wire a,
    output wire b,
    output wire c,
    output wire d,
    output wire e,
    output wire f,
    output wire g,
    output wire p
);
  
  wire wire0, wire1, wire2, wire3;
  wire inv_wire0, inv_wire1, inv_wire2, inv_wire3;
  assign {wire3 ,wire2, wire1, wire0} = data;
  assign {inv_wire0, inv_wire1, inv_wire2, inv_wire3} = {~wire0, ~wire1, ~wire2, ~wire3};
  
  // minterms for number 0-f
  wire [15:0] and_gate;
  assign and_gate[1] = wire0 & inv_wire1 & inv_wire2 & inv_wire3; // 1
  assign and_gate[4] = inv_wire0 & inv_wire1 & wire2 & inv_wire3; // 4
  assign and_gate[11] = wire0 & wire1 & inv_wire2 & wire3; // B
  assign and_gate[13] = wire0 & inv_wire1 & wire2 & wire3; // D
  assign and_gate[0] = inv_wire3 & inv_wire2 & inv_wire1 & inv_wire0; //0
  assign and_gate[2] = inv_wire3 & inv_wire2 & wire1 & inv_wire0; //2
  assign and_gate[3] = inv_wire3 & inv_wire2 & wire1 & wire0; //3
  assign and_gate[5] = inv_wire3 & wire2 & inv_wire1 & wire0; //5
  assign and_gate[6] = inv_wire3 & wire2 & wire1 & inv_wire0; //6
  assign and_gate[7] = inv_wire3 & wire2 & wire1 & wire0; //7
  assign and_gate[8] = wire3 & inv_wire2 & inv_wire1 & inv_wire0; //8
  assign and_gate[9] = wire3 & inv_wire2 & inv_wire1 & wire0; //9
  assign and_gate[10] = wire3 & inv_wire2 & wire1 & inv_wire0; //A
  assign and_gate[12] = wire3 & wire2 & inv_wire1 & inv_wire0; //C
  assign and_gate[14] = wire3 & wire2 & wire1 & inv_wire0; //E
  assign and_gate[15] = wire3 & wire2 & wire1 & wire0; //F
  // SegDecoder for a
  wire a_or, a_result;
  assign a_or = and_gate[1] | and_gate[4] | and_gate[11] | and_gate[13];
  assign a_result = a_or | LE;
  assign a = a_result;
  
 // b~g 同样列出熄灭段的最小项，LE 统一控制消隐。
  wire b_or, b_result;
  assign b_or = and_gate[5] | and_gate[6] | and_gate[11] | and_gate[12] | and_gate[14] | and_gate[15];
  assign b_result = b_or | LE;
  assign b = b_result;

  wire c_or, c_result;
  assign c_or = and_gate[2] | and_gate[12] | and_gate[14] | and_gate[15];
  assign c_result = c_or | LE;
  assign c = c_result;

 wire d_or, d_result;
  assign d_or = and_gate[1] | and_gate[4] | and_gate[7] | and_gate[10] | and_gate[15];
  assign d_result = d_or | LE;
  assign d = d_result;

  wire e_or, e_result;
  assign e_or = and_gate[1] | and_gate[3] | and_gate[4] | and_gate[5] | and_gate[7] | and_gate[9];
  assign e_result = e_or | LE;
  assign e = e_result;

  wire f_or, f_result;
  assign f_or = and_gate[1] | and_gate[2] | and_gate[3] | and_gate[7] | and_gate[13];
  assign f_result = f_or | LE;
  assign f = f_result;

  wire g_or, g_result;
  assign g_or = and_gate[0] | and_gate[1] | and_gate[7] |and_gate[12];
  assign g_result = g_or | LE;
  assign g = g_result;

  assign p = (~point) | LE;
endmodule