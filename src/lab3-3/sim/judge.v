// Lab3-3：start 时保存请求操作数，finish 时通过 DPI-C 比较结果。
// 此模块使用低有效异步复位，与乘法器的 rst 极性相反。
import"DPI-C"function int mul_judge(
    input int unsigned multiplicand,
    input int unsigned multiplier,
    input longint unsigned product
);


module Judge (
    input clk,
    input rstn,
    input [31:0] multiplicand,
    input [31:0] multiplier,
    input start,
    input [63:0] product,
    input finish,
    output reg error
);

    reg [31:0] multiplicand_reg;
    reg [31:0] multiplier_reg;
    always@(posedge clk or negedge rstn)begin
        if(~rstn)begin
            multiplicand_reg <= 32'b0;
            multiplier_reg <= 32'b0;
        end else if(start)begin
            multiplicand_reg <= multiplicand;
            multiplier_reg <= multiplier;
        end
    end

    always@(posedge clk or negedge rstn)begin
        if(~rstn)begin
            error <= 1'b0;
        end else begin
            if(finish)begin
                if(mul_judge(multiplicand_reg,multiplier_reg,product)==32'b1)begin
                    error <= 1'b0;
                end else begin
                    error <= 1'b1;
                end
            end
        end
    end
    
endmodule //Judge
