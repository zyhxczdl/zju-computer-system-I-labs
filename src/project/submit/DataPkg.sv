// Project-1：按地址低三位将待写字节放到 64 位总线对应位置。
// 配合 MaskGen 使用；当前实现不处理跨越一个 8 字节总线字的访问。
`include "core_struct.vh"
module DataPkg(
    input  CorePack::mem_op_enum mem_op,  
    input  CorePack::data_t reg_data,  
    input  CorePack::addr_t dmem_waddr, 
    output CorePack::data_t dmem_wdata 
);

    import CorePack::*;

    always_comb begin
        case (mem_op)
            MEM_D: dmem_wdata = reg_data;                                     // SD：8字节直接写
            MEM_W: dmem_wdata = 64'(reg_data[31:0]) << (dmem_waddr[2:0] * 8); // SW：4字节对齐
            MEM_H: dmem_wdata = 64'(reg_data[15:0]) << (dmem_waddr[2:0] * 8); // SH：2字节对齐
            MEM_B: dmem_wdata = 64'(reg_data[7:0])  << (dmem_waddr[2:0] * 8); // SB：1字节对齐
            default: dmem_wdata = 64'd0;                                      // 不写内存
        endcase
    end

endmodule
