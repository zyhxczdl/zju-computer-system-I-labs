// Lab4-1：连接滑动窗口 Shift 和四路乘加 ConvOperator。
// 内部使用 valid-ready 传递窗口；外部需在一次计算期间保持 kernel 稳定。
`include"conv_struct.vh"
module ConvUnit (
    input clk,
    input rst, 
    input Conv::data_t in_data,
    input Conv::data_vector kernel, 
    input in_valid, 
    output in_ready, 
    output Conv::result_t result,
    output out_valid, 
    input out_ready
);
    // Shift 与 ConvOperator 之间的 valid-ready 握手连接信号
    Conv::data_vector shift_data;   // Shift 输出的 4 个数据
    logic shift_out_valid;          // Shift 的 valid → ConvOperator 的 in_valid
    logic shift_out_ready;          // ConvOperator 的 in_ready → Shift 的 out_ready
    //接收外部数据并维护滑动窗口
    Shift shift_inst (
        .clk(clk),
        .rst(rst),
        .in_data(in_data),
        .in_valid(in_valid),
        .in_ready(in_ready),
        .data(shift_data),
        .out_valid(shift_out_valid),
        .out_ready(shift_out_ready)
    );
    //执行卷积运算
    ConvOperator conv_op_inst (
        .clk(clk),
        .rst(rst),
        .kernel(kernel),
        .data(shift_data),
        .in_valid(shift_out_valid),
        .in_ready(shift_out_ready),
        .result(result),
        .out_valid(out_valid),
        .out_ready(out_ready)
    );

endmodule
