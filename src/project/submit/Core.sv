// Project-1/2：RV64I 单周期数据通路，IF/ID/EXE/MEM/WB 是功能分段。
// 本实现依赖课程单周期内存模型，没有实现等待总线响应的停顿控制。
// 末尾 MultiFSM 仅将 stall 固定为 0，是多周期 bonus 的占位模块。
`include "core_struct.vh"
module Core(
    input  clk,     
    input  rst,   
    Mem_ift.Master imem_ift, 
    Mem_ift.Master dmem_ift,  
    output cosim_valid,
    output CorePack::CoreInfo cosim_core_info
);
    import CorePack::*;
    // IF 取指阶段
    //   - PC寄存器：时序电路，上升沿更新
    //   - 指令选择：DRAM读出64位，根据PC[2]选择高/低32位指令
    //   - imem接口：r_request_valid=1保持常开
    addr_t pc, next_pc;
    inst_t inst;
    reg_ind_t rs1, rs2, rd;
    // PC寄存器
    always @(posedge clk) begin
        if (rst)
            pc <= 64'd0;    // 复位时PC归零
        else
            pc <= next_pc;  // 正常更新到下一条指令地址
    end
    // 指令内存请求：以PC为地址读指令
    assign imem_ift.r_request_bits.raddr = pc;
    assign imem_ift.r_request_valid = 1'b1;   // 常开读请求
    assign imem_ift.r_reply_ready = 1'b1;      // 常开接收响应
    // 指令选择：DRAM为64位对齐，RISC-V指令32位，根据PC[2]选择半字
    assign inst = pc[2] ? imem_ift.r_reply_bits.rdata[63:32]  // PC[2]=1取高32位
                        : imem_ift.r_reply_bits.rdata[31:0];   // PC[2]=0取低32位
    // 从指令中提取寄存器索引
    assign rs1 = inst[19:15];  // 源寄存器1
    assign rs2 = inst[24:20];  // 源寄存器2
    assign rd  = inst[11:7];   // 目的寄存器
    // ID 译码阶段
    //   - Controller: 二段译码生成所有控制信号
    //   - RegFile: 读取寄存器值（写回在WB阶段完成）
    //   - ImmGen: 立即数生成
    // 控制信号声明
    logic we_reg, we_mem, re_mem, npc_sel;
    imm_op_enum immgen_op;
    alu_op_enum alu_op;
    cmp_op_enum cmp_op;
    alu_asel_op_enum alu_asel;
    alu_bsel_op_enum alu_bsel;
    wb_sel_op_enum wb_sel;
    mem_op_enum mem_op;
    // 控制单元例化
    controller ctrl (
        .inst(inst),
        .we_reg(we_reg),
        .we_mem(we_mem),
        .re_mem(re_mem),
        .npc_sel(npc_sel),
        .immgen_op(immgen_op),
        .alu_op(alu_op),
        .cmp_op(cmp_op),
        .alu_asel(alu_asel),
        .alu_bsel(alu_bsel),
        .wb_sel(wb_sel),
        .mem_op(mem_op)
    );
    // 提取opcode，用于判断无条件跳转指令
    wire opcode_t opcode;
    assign opcode = inst[6:0];
    wire is_jal  = (opcode == JAL_OPCODE);   // JAL无条件跳转
    wire is_jalr = (opcode == JALR_OPCODE);  // JALR无条件跳转
    // 寄存器堆例化
    data_t read_data_1, read_data_2, write_data;
    RegFile rf (
        .clk(clk),
        .rst(rst),
        .we(we_reg),
        .read_addr_1(rs1),
        .read_addr_2(rs2),
        .write_addr(rd),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );
    // 立即数生成（组合逻辑，根据不同指令类型拼接imm字段）
    data_t imm;
    always_comb begin
        case (immgen_op)
            I_IMM:  imm = {{52{inst[31]}}, inst[31:20]};                     // I型12位符号扩展
            S_IMM:  imm = {{52{inst[31]}}, inst[31:25], inst[11:7]};         // S型12位符号扩展
            B_IMM:  imm = {{52{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; // B型13位(LSB=0)
            U_IMM:  imm = {{32{inst[31]}}, inst[31:12], 12'd0};              // U型高20位，低12位置零
            UJ_IMM: imm = {{44{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; // J型21位(LSB=0)
            default: imm = 64'd0;
        endcase
    end
    // EXE 执行阶段
    //   - ALU输入选择：MUX根据控制信号选择操作数来源
    //   - ALU：执行算术/逻辑运算
    //   - Cmp：执行分支条件比较
    data_t alu_a, alu_b, alu_res;
    // ALU A口MUX：选择PC/RS1/0
    assign alu_a = (alu_asel == ASEL_PC)  ? pc :
                   (alu_asel == ASEL_REG) ? read_data_1 : 64'd0;
    // ALU B口MUX：选择IMM/RS2/0
    assign alu_b = (alu_bsel == BSEL_IMM) ? imm :
                   (alu_bsel == BSEL_REG) ? read_data_2 : 64'd0;
    // ALU例化
    ALU alu_inst (
        .a(alu_a),
        .b(alu_b),
        .alu_op(alu_op),
        .res(alu_res)
    );
    // Cmp例化：用于B型指令的条件判断
    logic cmp_res, br_taken;
    Cmp cmp_inst (
        .a(read_data_1),
        .b(read_data_2),
        .cmp_op(cmp_op),
        .cmp_res(cmp_res)
    );
    // 分支跳转判断：无条件跳转(JAL/JALR)或条件满足(B型)
    assign br_taken = is_jal | is_jalr | cmp_res;
    // MEM 访存阶段
    //   - DataPkg: 将待写数据按地址对齐打包
    //   - MaskGen: 生成写字节掩码
    //   - dmem接口: 连接读写通道
    //   - DataTrunc: 读回数据截取和扩展
    // 数据打包：将reg_data按字节偏移写入64位对齐位置
    data_t dmem_wdata_pkg;
    DataPkg data_pkg_inst (
        .mem_op(mem_op),
        .reg_data(read_data_2),
        .dmem_waddr(alu_res),
        .dmem_wdata(dmem_wdata_pkg)
    );
    // 掩码生成：控制写操作只覆盖有效字节
    mask_t dmem_wmask_gen;
    MaskGen mask_gen_inst (
        .mem_op(mem_op),
        .dmem_waddr(alu_res),
        .dmem_wmask(dmem_wmask_gen)
    );
    // 数据内存读请求通道（Load使用）
    assign dmem_ift.r_request_valid = re_mem;
    assign dmem_ift.r_request_bits.raddr = alu_res;   // 读地址来自ALU计算结果
    assign dmem_ift.r_reply_ready = 1'b1;
    // 数据内存写请求通道（Store使用）
    assign dmem_ift.w_request_valid = we_mem;
    assign dmem_ift.w_request_bits.waddr = alu_res;   // 写地址来自ALU计算结果
    assign dmem_ift.w_request_bits.wdata = dmem_wdata_pkg;
    assign dmem_ift.w_request_bits.wmask = dmem_wmask_gen;
    assign dmem_ift.w_reply_ready = 1'b1;
    // 数据截取：从64位读回数据中截取有效字节并做符号/零扩展
    data_t dmem_rdata_trunc;
    DataTrunc data_trunc_inst (
        .dmem_rdata(dmem_ift.r_reply_bits.rdata),
        .mem_op(mem_op),
        .dmem_raddr(alu_res),
        .read_data(dmem_rdata_trunc)
    );
    // WB 写回阶段
    //   - 根据wb_sel选择写回源：ALU结果/内存数据/PC+4/0
    always_comb begin
        case (wb_sel)
            WB_SEL_ALU: write_data = alu_res;          // ALU计算结果
            WB_SEL_MEM: write_data = dmem_rdata_trunc; // 内存读出数据（已截取）
            WB_SEL_PC:  write_data = pc + 64'd4;       // PC+4（JAL/JALR）
            default:    write_data = 64'd0;
        endcase
    end
    // 程序结束/非法指令检测
    //   - 当opcode不属于RV64I已知类型时，认定遇到非法/结束指令
    //   - CPU停机，停止向Spike提交差分测试，避免PC失配
    wire is_unknown = ~((opcode == LOAD_OPCODE) |    // 0000011
                        (opcode == IMM_OPCODE) |     // 0010011
                        (opcode == AUIPC_OPCODE) |   // 0010111
                        (opcode == IMMW_OPCODE) |    // 0011011
                        (opcode == STORE_OPCODE) |   // 0100011
                        (opcode == REG_OPCODE) |     // 0110011
                        (opcode == LUI_OPCODE) |     // 0110111
                        (opcode == REGW_OPCODE) |    // 0111011
                        (opcode == BRANCH_OPCODE) |  // 1100011
                        (opcode == JALR_OPCODE) |    // 1100111
                        (opcode == JAL_OPCODE));     // 1101111
    // NPC (Next PC) 逻辑
    //   - 非法指令：PC保持不变（停机）
    //   - 跳转：JALR目标=(rs1+imm)最低位清零，JAL/B-type目标=pc+imm
    //   - 顺序：PC+4
    assign next_pc = is_unknown ? pc :
        (npc_sel & br_taken) ?
        (is_jalr ? {alu_res[63:1], 1'b0} : (pc + imm)) :
        (pc + 64'd4);
    assign cosim_valid = ~is_unknown;
    assign cosim_core_info.pc        = pc;
    assign cosim_core_info.inst      = {32'b0, inst}; 
    assign cosim_core_info.rs1_id    = {59'b0, rs1};
    assign cosim_core_info.rs1_data  = read_data_1;
    assign cosim_core_info.rs2_id    = {59'b0, rs2};
    assign cosim_core_info.rs2_data  = read_data_2;
    assign cosim_core_info.alu       = alu_res;
    assign cosim_core_info.mem_addr  = dmem_ift.r_request_bits.raddr;
    assign cosim_core_info.mem_we    = {63'b0, we_mem};
    assign cosim_core_info.mem_wdata = dmem_ift.w_request_bits.wdata;
    assign cosim_core_info.mem_rdata = dmem_ift.r_reply_bits.rdata;
    assign cosim_core_info.rd_we     = {63'b0, we_reg & (rd != 5'd0)}; 
    assign cosim_core_info.rd_id     = {59'b0, rd};
    assign cosim_core_info.rd_data   = (rd == 5'd0) ? 64'd0 : write_data; 
    assign cosim_core_info.br_taken  = {63'b0, br_taken};
    assign cosim_core_info.npc       = next_pc;

endmodule

module MultiFSM(
    input  clk,
    input  rst,
    Mem_ift.Master imem_ift,
    Mem_ift.Master dmem_ift,
    input  we_mem,
    input  re_mem,
    input  CorePack::addr_t pc,
    input  CorePack::addr_t alu_res,
    input  CorePack::data_t data_package,
    input  CorePack::mask_t mask_package,
    output stall
);
    import CorePack::*;

    assign stall = 1'b0;   // 单周期CPU：无停顿

endmodule
