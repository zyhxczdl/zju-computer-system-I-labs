// Project-1：32 个逻辑通用寄存器，双组合读端口、单上升沿写端口。
// x0 直接读出零并禁止写入，rst 为高有效同步复位。
`include "core_struct.vh"
module RegFile (
    input  clk,                         
    input  rst,                            
    input  we,                              
    input  CorePack::reg_ind_t read_addr_1,  
    input  CorePack::reg_ind_t read_addr_2, 
    input  CorePack::reg_ind_t write_addr,   
    input  CorePack::data_t write_data,    
    output CorePack::data_t read_data_1,
    output CorePack::data_t read_data_2  
);

    import CorePack::*;
    integer i;
    data_t register [1:31];                  // x1-x31，x0恒零不存储
    // 读端口：组合逻辑，x0返回0
    assign read_data_1 = (read_addr_1 == 5'd0) ? 64'd0 : register[read_addr_1];
    assign read_data_2 = (read_addr_2 == 5'd0) ? 64'd0 : register[read_addr_2];
    // 写端口：时序逻辑，上升沿且we=1且非x0时写入
    always @(posedge clk) begin
        if (rst) begin
            // 复位时清零所有寄存器
            for (i = 1; i < 32; i = i + 1)
                register[i] <= 64'd0;
        end else if (we && write_addr != 5'd0) begin
            // 写使能有效且目标非x0时写入
            register[write_addr] <= write_data;
        end
    end
endmodule
