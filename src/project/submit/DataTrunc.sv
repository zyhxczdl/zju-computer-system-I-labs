// Project-1：从 64 位读总线按字节偏移截取数据，再做符号或零扩展。
// 访问必须落在同一个 8 字节总线字内；跨界访问需额外逻辑。
`include "core_struct.vh"
module DataTrunc (
    input  CorePack::data_t dmem_rdata,  
    input  CorePack::mem_op_enum mem_op,  
    input  CorePack::addr_t dmem_raddr,
    output CorePack::data_t read_data
);
    import CorePack::*;

    always_comb begin
        case (mem_op)
            //有符号Load：符号扩展
            MEM_D: read_data = dmem_rdata;                                                   // LD：64位
            MEM_W: read_data = {{32{dmem_rdata[dmem_raddr[2:0]*8 + 31]}},                    // LW：取32位
                                dmem_rdata[dmem_raddr[2:0]*8 +: 32]};                        // 符号扩展至64位
            MEM_H: read_data = {{48{dmem_rdata[dmem_raddr[2:0]*8 + 15]}},                    // LH：取16位
                                dmem_rdata[dmem_raddr[2:0]*8 +: 16]};                        // 符号扩展
            MEM_B: read_data = {{56{dmem_rdata[dmem_raddr[2:0]*8 + 7]}},                     // LB：取8位
                                dmem_rdata[dmem_raddr[2:0]*8 +: 8]};                         // 符号扩展
            //无符号Load：零扩展 
            MEM_UW: read_data = {32'd0, dmem_rdata[dmem_raddr[2:0]*8 +: 32]};               // LWU：零扩展
            MEM_UH: read_data = {48'd0, dmem_rdata[dmem_raddr[2:0]*8 +: 16]};               // LHU：零扩展
            MEM_UB: read_data = {56'd0, dmem_rdata[dmem_raddr[2:0]*8 +: 8]};                // LBU：零扩展

            default: read_data = dmem_rdata;                                                 // 不截取
        endcase
    end

endmodule
