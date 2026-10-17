module Testbench;

    reg [7:0] I;
    reg [2:0] S;
    wire O;

    initial begin
        $monitor("Times=%0t ns|S=%b|I=%b|O=%b",$time,S,I,O);
        I=8'b10101010;
        S=3'b000;
        #10 S=3'b001;
        #10 S=3'b010;
        #10 S=3'b011;
        #10 S=3'b100;
        #10 S=3'b101;
        #10 S=3'b110;
        #10 S=3'b111;
        #10 ;
        $finish;
    end

    Mux8T1_1 dut( 
        .I(I),
        .S(S),
        .O(O) 
    );

    `ifdef VERILATE
		initial begin
			$dumpfile({`TOP_DIR,"/Testbench.vcd"});
			$dumpvars(0,dut);
			$dumpon;
		end
    `endif
    
endmodule
