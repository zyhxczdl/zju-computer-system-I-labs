module top(
  input [10:0] SW,
  output LD0
);

  Mux8T1_1 dut(
    .I(SW[7:0]),
    .S(SW[10:8]),
    .O(LD0)
  );

endmodule