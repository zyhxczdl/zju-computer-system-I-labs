// Lab2-1：复用同一加法器计算 a+b 或 a-b。
// do_sub=1 时逐位取反 b，并将初始进位置 1，实现 a + (~b) + 1。
// c 为补码加法的输出进位；减法时不能直接解释为借位或有符号溢出。
module AddSubers #(
    parameter LENGTH = 32
)(
    input [LENGTH-1:0] a,
    input [LENGTH-1:0] b,
    input do_sub,
    output [LENGTH-1:0] s,
    output c
);
    wire [LENGTH-1:0] b_xor;

    assign b_xor = b ^ {LENGTH{do_sub}};

    Adders #(
        .LENGTH(LENGTH)
    ) u_adders_inst (
        .a   (a),
        .b   (b_xor),
        .c_in (do_sub),
        .s (s),
        .c_out(c)
    );
    
endmodule