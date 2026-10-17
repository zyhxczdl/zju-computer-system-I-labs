// Project-1：RV64I 算术逻辑单元，运算枚举来自 core_struct.vh。
// 64 位移位取 b[5:0]；W 指令仅计算低 32 位，再将结果符号扩展到 64 位。
`include "core_struct.vh"
module ALU (
    input  CorePack::data_t a, 
    input  CorePack::data_t b,
    input  CorePack::alu_op_enum alu_op, 
    output CorePack::data_t res
);
    import CorePack::*;
    always_comb begin
        case (alu_op)
            ALU_ADD:  res = a + b;                                           // 加法
            ALU_SUB:  res = a - b;                                           // 减法
            ALU_AND:  res = a & b;                                           // 按位与
            ALU_OR:   res = a | b;                                           // 按位或
            ALU_XOR:  res = a ^ b;                                           // 按位异或
            ALU_SLT:  res = {63'd0, $signed(a) < $signed(b)};                // 有符号比较
            ALU_SLTU: res = {63'd0, a < b};                                  // 无符号比较
            ALU_SLL:  res = a << b[5:0];                                     // 逻辑左移（移入0）
            ALU_SRL:  res = a >> b[5:0];                                     // 逻辑右移（移入0）
            ALU_SRA:  res = $signed(a) >>> b[5:0];                           // 算术右移（移入符号位）
            ALU_ADDW: res = 64'(signed'(a[31:0] + b[31:0]));                 // 32位加法，符号扩展
            ALU_SUBW: res = 64'(signed'(a[31:0] - b[31:0]));                 // 32位减法，符号扩展
            ALU_SLLW: res = 64'(signed'(a[31:0] << b[4:0]));                 // 32位移位量低5位
            ALU_SRLW: res = 64'(signed'(a[31:0] >> b[4:0]));                 // 32位移位量低5位
            ALU_SRAW: res = 64'(signed'($signed(a[31:0]) >>> b[4:0]));       // 32位算术右移
            default:  res = 64'd0;
        endcase
    end

endmodule
