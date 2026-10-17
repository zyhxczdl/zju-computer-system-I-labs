// Project-2：先按 opcode 分类，再由 funct3/funct7 生成数据通路控制。
// 模块名为小写 controller；调用方应按模块名实例化，不能依据文件名推断大小写。
`include "core_struct.vh"
module controller (
    input  CorePack::inst_t inst, 
    output logic we_reg, 
    output logic we_mem, 
    output logic re_mem,
    output logic npc_sel, 
    output CorePack::imm_op_enum immgen_op, 
    output CorePack::alu_op_enum alu_op, 
    output CorePack::cmp_op_enum cmp_op,  
    output CorePack::alu_asel_op_enum alu_asel, 
    output CorePack::alu_bsel_op_enum alu_bsel, 
    output CorePack::wb_sel_op_enum wb_sel, 
    output CorePack::mem_op_enum mem_op 
);
    import CorePack::*;
    //阶段一：从指令中提取关键字段
    wire opcode_t opcode = inst[6:0];    // 操作码
    wire funct3_t funct3 = inst[14:12];  // funct3字段
    wire funct7_t funct7 = inst[31:25];  // funct7字段
    //阶段一：根据opcode判断指令类型
    wire is_load   = (opcode == LOAD_OPCODE);     // LOAD: LB/LH/LW/LD/LBU/LHU/LWU
    wire is_imm    = (opcode == IMM_OPCODE);      // I型ALU: ADDI/SLTI/...
    wire is_auipc  = (opcode == AUIPC_OPCODE);    // AUIPC
    wire is_immw   = (opcode == IMMW_OPCODE);     // I型W: ADDIW/SLLIW/...
    wire is_store  = (opcode == STORE_OPCODE);    // STORE: SB/SH/SW/SD
    wire is_reg    = (opcode == REG_OPCODE);      // R型: ADD/SUB/SLL/...
    wire is_lui    = (opcode == LUI_OPCODE);      // LUI
    wire is_regw   = (opcode == REGW_OPCODE);     // R型W: ADDW/SUBW/...
    wire is_branch = (opcode == BRANCH_OPCODE);   // B型: BEQ/BNE/BLT/...
    wire is_jalr   = (opcode == JALR_OPCODE);     // JALR
    wire is_jal    = (opcode == JAL_OPCODE);      // JAL
    //阶段二：生成控制信号
    // 寄存器写使能：所有需要写回rd的指令类型
    assign we_reg   = is_reg | is_imm | is_load | is_immw |is_lui | is_auipc | is_regw | is_jalr | is_jal;
    // 内存写使能：只有store指令需要写内存
    assign we_mem   = is_store;
    // 内存读使能：只有load指令需要读内存
    assign re_mem   = is_load;
    // PC跳转选择：分支、JAL、JALR需要改变PC
    assign npc_sel  = is_branch | is_jal | is_jalr;
    // 立即数生成类型选择
    // I型/I型W/LOAD/JALR使用I型立即数，STORE使用S型，BRANCH使用B型
    // LUI/AUIPC使用U型，JAL使用UJ型，其他默认IMM0
    assign immgen_op = is_imm | is_load | is_jalr      ? I_IMM  :
                       is_store                        ? S_IMM  :
                       is_branch                       ? B_IMM  :
                       is_lui | is_auipc               ? U_IMM  :
                       is_jal                          ? UJ_IMM :
                       is_immw                         ? I_IMM  :
                                                         IMM0;
    // ALU A口选择：LUI选择0（用于移位立即数），AUIPC/JAL/BRANCH选择PC，其余选RS1
    assign alu_asel = is_lui                           ? ASEL0    :
                       (is_auipc | is_jal | is_branch) ? ASEL_PC  :
                                                         ASEL_REG;
    // ALU B口选择：R型和R型W选择RS2，其余选择立即数
    assign alu_bsel = (is_reg | is_regw)               ? BSEL_REG :
                                                         BSEL_IMM;
    // 写回数据源选择：LOAD从内存读，JAL/JALR写PC+4，STORE/BRANCH不写回，其余写ALU结果
    assign wb_sel   = is_load                           ? WB_SEL_MEM :
                      (is_jal | is_jalr)               ? WB_SEL_PC  :
                      (is_store | is_branch)           ? WB_SEL0    :
                                                         WB_SEL_ALU;
    // 访存操作类型：根据指令类型和funct3确定读/写的位宽和有无符号
    always_comb begin
        unique casez ({is_load, is_store, funct3})
            //Load指令
            {1'b1, 1'b0, LB_FUNCT3}:  mem_op = MEM_B;   // 读字节，符号扩展
            {1'b1, 1'b0, LH_FUNCT3}:  mem_op = MEM_H;   // 读半字，符号扩展
            {1'b1, 1'b0, LW_FUNCT3}:  mem_op = MEM_W;   // 读字，符号扩展
            {1'b1, 1'b0, LD_FUNCT3}:  mem_op = MEM_D;   // 读双字
            {1'b1, 1'b0, LBU_FUNCT3}: mem_op = MEM_UB;  // 读字节，零扩展
            {1'b1, 1'b0, LHU_FUNCT3}: mem_op = MEM_UH;  // 读半字，零扩展
            {1'b1, 1'b0, LWU_FUNCT3}: mem_op = MEM_UW;  // 读字，零扩展
            //Store指令
            {1'b0, 1'b1, SB_FUNCT3}:  mem_op = MEM_B;   // 写字节
            {1'b0, 1'b1, SH_FUNCT3}:  mem_op = MEM_H;   // 写半字
            {1'b0, 1'b1, SW_FUNCT3}:  mem_op = MEM_W;   // 写字
            {1'b0, 1'b1, SD_FUNCT3}:  mem_op = MEM_D;   // 写双字
            default:                  mem_op = MEM_NO;   // 不访存
        endcase
    end
    // 分支比较类型：仅branch指令有效，根据funct3选择比较方式
    always_comb begin
        cmp_op = CMP_NO;  // 默认非分支指令
        if (is_branch) begin
            case (funct3)
                BEQ_FUNCT3:  cmp_op = CMP_EQ;   // 相等
                BNE_FUNCT3:  cmp_op = CMP_NE;   // 不等
                BLT_FUNCT3:  cmp_op = CMP_LT;   // 有符号小于
                BGE_FUNCT3:  cmp_op = CMP_GE;   // 有符号大于等于
                BLTU_FUNCT3: cmp_op = CMP_LTU;  // 无符号小于
                BGEU_FUNCT3: cmp_op = CMP_GEU;  // 无符号大于等于
                default:     cmp_op = CMP_NO;
            endcase
        end
    end
    // ALU运算类型：根据指令类型和funct3/funct7确定具体运算
    always_comb begin
        alu_op = ALU_DEFAULT;
        if (is_reg) begin
            // R型指令：ADD/SUB/SLL/SLT/SLTU/XOR/SRL/SRA/OR/AND
            // SUB和SRA由funct7的最高位(bit30)区分
            case ({funct7, funct3})
                {7'b0000000, ADD_FUNCT3}:  alu_op = ALU_ADD;
                {7'b0100000, SUB_FUNCT3}:  alu_op = ALU_SUB;
                {7'b0000000, SLL_FUNCT3}:  alu_op = ALU_SLL;
                {7'b0000000, SLT_FUNCT3}:  alu_op = ALU_SLT;
                {7'b0000000, SLTU_FUNCT3}: alu_op = ALU_SLTU;
                {7'b0000000, XOR_FUNCT3}:  alu_op = ALU_XOR;
                {7'b0000000, SRL_FUNCT3}:  alu_op = ALU_SRL;
                {7'b0100000, SRA_FUNCT3}:  alu_op = ALU_SRA;
                {7'b0000000, OR_FUNCT3}:   alu_op = ALU_OR;
                {7'b0000000, AND_FUNCT3}:  alu_op = ALU_AND;
                default:                   alu_op = ALU_DEFAULT;
            endcase
        end else if (is_imm) begin
            // I型ALU指令：ADDI/SLTI/SLTIU/XORI/ORI/ANDI/SLLI/SRLI/SRAI
            // SRLI和SRAI由funct7的bit30区分
            case (funct3)
                ADD_FUNCT3:   alu_op = ALU_ADD;
                SLT_FUNCT3:   alu_op = ALU_SLT;
                SLTU_FUNCT3:  alu_op = ALU_SLTU;
                XOR_FUNCT3:   alu_op = ALU_XOR;
                OR_FUNCT3:    alu_op = ALU_OR;
                AND_FUNCT3:   alu_op = ALU_AND;
                SLL_FUNCT3:   alu_op = ALU_SLL;
                SRL_FUNCT3: begin
                    if (funct7 == 7'b0000000)
                        alu_op = ALU_SRL;   // 逻辑右移
                    else if (funct7 == 7'b0100000)
                        alu_op = ALU_SRA;   // 算术右移
                end
                default:      alu_op = ALU_DEFAULT;
            endcase
        end else if (is_regw) begin
            // R型W指令：ADDW/SUBW/SLLW/SRLW/SRAW（32位运算，符号扩展至64位）
            case ({funct7, funct3})
                {7'b0000000, ADDW_FUNCT3}:  alu_op = ALU_ADDW;
                {7'b0100000, SUBW_FUNCT3}:  alu_op = ALU_SUBW;
                {7'b0000000, SLLW_FUNCT3}:  alu_op = ALU_SLLW;
                {7'b0000000, SRLW_FUNCT3}:  alu_op = ALU_SRLW;
                {7'b0100000, SRAW_FUNCT3}:  alu_op = ALU_SRAW;
                default:                    alu_op = ALU_DEFAULT;
            endcase
        end else if (is_immw) begin
            // I型W指令：ADDIW/SLLIW/SRLIW/SRAIW（32位立即数运算，符号扩展至64位）
            case (funct3)
                ADDW_FUNCT3:   alu_op = ALU_ADDW;
                SLLW_FUNCT3:   alu_op = ALU_SLLW;
                SRLW_FUNCT3: begin
                    if (funct7 == 7'b0000000)
                        alu_op = ALU_SRLW;
                    else if (funct7 == 7'b0100000)
                        alu_op = ALU_SRAW;
                end
                default:       alu_op = ALU_DEFAULT;
            endcase
        end else if (is_load | is_store | is_jalr | is_auipc | is_lui | is_jal) begin
            // LOAD/STORE/JALR/AUIPC/LUI/JAL 均使用加法计算地址或跳过
            alu_op = ALU_ADD;
        end
    end
endmodule
