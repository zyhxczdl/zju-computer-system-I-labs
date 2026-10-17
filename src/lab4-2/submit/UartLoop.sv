// Lab4-2（bonus）：单项缓存的串口回环。rstn 为低有效同步复位。
// 接收握手优先于 debug_send；发送握手完成前缓存数据保持不变。
// SEND 时暂停接收，上游须遵守 ready；debug_send 为电平信号，持续有效可能再次触发。
`include"uart_struct.vh"
module UartLoop(
    input clk,
    input rstn, 
    Decoupled_ift.Slave   uart_rdata, 
    Decoupled_ift.Master  uart_tdata, 
    input UartPack::uart_t debug_data, 
    input logic debug_send, 
    output UartPack::uart_t debug_rdata, 
    output UartPack::uart_t debug_tdata
);
    import UartPack::*; 
    //寄存器 
    uart_t rdata;                     // 接收到的数据
    logic rdata_valid;                // rdata 有效标志
    uart_t tdata;                     // 待发送的数据
    logic tdata_valid;                // tdata 有效标志
    // FSM 状态定义
    //   IDLE: 等待接收数据（uart_rdata.ready=1），不发送
    //   SEND: 发送回环数据（uart_tdata.valid=1），不接收
    typedef enum logic [1:0] {IDLE, SEND} state_t;
    state_t state_reg;                // 当前状态寄存器
    //主时序逻辑：回环状态机
    always @(posedge clk) begin
        if (!rstn) begin
            // 复位：清空所有寄存器和控制信号
            state_reg <= IDLE;
            uart_rdata.ready <= 1'b0;
            uart_tdata.valid <= 1'b0;
            uart_tdata.data <= 0;
            rdata <= 0;
            rdata_valid <= 1'b0;
            tdata <= 0;
            tdata_valid <= 1'b0;
        end else begin
            case (state_reg)
                // IDLE ：等待接收数据
                // 进入 SEND 的途径：1. 收到上位机数据（正常回环）2. debug_send 按钮被按下（调试模式）
                IDLE: begin
                    uart_rdata.ready <= 1'b1;   // 准备接收来自 UART 的数据
                    uart_tdata.valid <= 1'b0;   // 不发送数据
                    if (uart_rdata.valid && uart_rdata.ready) begin
                        // 回环路径：握手成功，收到上位机发来的数据
                        rdata <= uart_rdata.data;       // 保存接收到的原始数据
                        rdata_valid <= 1'b1;
                        tdata <= uart_rdata.data;       // 将接收到的数据作为待发送数据
                        tdata_valid <= 1'b1;
                        uart_rdata.ready <= 1'b0;       // 撤销 ready，停止接收
                        state_reg <= SEND;              // 转入发送状态
                    end else if (debug_send) begin
                        // 调试路径：按钮按下，直接发送 debug_data
                        tdata <= debug_data;            // 载入开关设定的数据
                        tdata_valid <= 1'b1;
                        uart_rdata.ready <= 1'b0;
                        state_reg <= SEND;              // 转入发送状态
                    end
                end
                // SEND 状态：发送回环数据给 UartUnit
                SEND: begin
                    uart_rdata.ready <= 1'b0;           // 不接收新数据
                    uart_tdata.data <= tdata;           // 将数据放到发送总线上
                    uart_tdata.valid <= 1'b1;           // 告知 UartUnit 数据已就绪
                    if (uart_tdata.valid && uart_tdata.ready) begin
                        // 握手成功！UartUnit 已接收数据
                        uart_tdata.valid <= 1'b0;       // 撤销 valid
                        tdata_valid <= 1'b0;            // 清除有效标志
                        rdata_valid <= 1'b0;
                        state_reg <= IDLE;              // 回到接收状态，等待下一个数据
                    end
                end
                default: state_reg <= IDLE;
            endcase
        end
    end
    assign debug_rdata = rdata; 
    assign debug_tdata = tdata; 
endmodule
