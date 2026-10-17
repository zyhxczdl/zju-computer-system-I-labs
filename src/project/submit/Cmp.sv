// Project-1：分支比较器。LT/GE 使用有符号比较，LTU/GEU 使用无符号比较。
// 非分支的 CMP_NO 落入默认分支，cmp_res=0。
`include "core_struct.vh"
module Cmp (
    input  CorePack::data_t a,
    input  CorePack::data_t b, 
    input  CorePack::cmp_op_enum cmp_op, 
    output logic cmp_res 
);

    import CorePack::*;

    always_comb begin
        case (cmp_op)
            CMP_EQ:  cmp_res = (a == b);                    // a等于b
            CMP_NE:  cmp_res = (a != b);                    // a不等于b
            CMP_LT:  cmp_res = ($signed(a) < $signed(b));   // 有符号比较：a < b
            CMP_GE:  cmp_res = ($signed(a) >= $signed(b));  // 有符号比较：a >= b
            CMP_LTU: cmp_res = (a < b);                     // 无符号比较：a < b
            CMP_GEU: cmp_res = (a >= b);                    // 无符号比较：a >= b
            default: cmp_res = 1'b0;                        // 非分支指令，不跳转
        endcase
    end

endmodule
