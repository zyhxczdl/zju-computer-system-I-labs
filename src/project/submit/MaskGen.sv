// Project-1：每一位掩码对应总线中的一个字节，最低位控制最低字节。
// 根据存储宽度生成连续掩码，再按地址低三位移动；只覆盖当前总线字。
`include "core_struct.vh"
module MaskGen(
    input  CorePack::mem_op_enum mem_op, 
    input  CorePack::addr_t dmem_waddr, 
    output CorePack::mask_t dmem_wmask
);

    import CorePack::*;

    always_comb begin
        case (mem_op)
            MEM_D: dmem_wmask = 8'hFF;                    // SD：全部8字节写入
            MEM_W: dmem_wmask = 8'h0F << dmem_waddr[2:0]; // SW：连续4字节
            MEM_H: dmem_wmask = 8'h03 << dmem_waddr[2:0]; // SH：连续2字节
            MEM_B: dmem_wmask = 8'h01 << dmem_waddr[2:0]; // SB：1字节
            default: dmem_wmask = 8'd0;                   // 不写内存
        endcase
    end

endmodule
