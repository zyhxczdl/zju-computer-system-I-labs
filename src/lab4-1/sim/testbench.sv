`include"conv_struct.vh"
module Testbench;

    import Conv::*;

    reg clk;
    reg rst;
    data_t in_data;
    data_vector kernel;
    reg in_valid;
    wire in_ready;
    result_t result;
    wire out_valid;
    wire out_ready;

    integer i;
    initial begin
        // 初始化
        clk = 0;
        rst = 1;
        in_valid = 0;
        in_data = 0;

        // 设置卷积核 kernel 的值
        kernel.data[0] = 64'd2;
        kernel.data[1] = 64'd3;
        kernel.data[2] = 64'd4;
        kernel.data[3] = 64'd5;

        #10;
        rst = 0;
        #10;

        // 生成不少于 16 组随机测试样例，in_valid 满足 valid-ready 协议
        for (i = 0; i < 20; i = i + 1) begin
            in_data = {$random, $random};
            in_valid = 1;
            // 等待握手完成（valid & ready）
            @(posedge clk);
            while (!(in_valid && in_ready)) begin
                @(posedge clk);
            end
            in_valid = 0;
            // 随机等待若干周期再发下一个数据
            repeat($random % 5) @(posedge clk);
        end

        // 等待流水线排空，确保所有结果被 Judge 比对
        repeat(3000) @(posedge clk);

        $display("success!!!");
        $finish;
    end

    always begin
        #5;
        clk = ~clk;
    end

    ConvUnit conv_unit (
        .clk(clk),
        .rst(rst),
        .in_data(in_data),
        .kernel(kernel),
        .in_valid(in_valid),
        .in_ready(in_ready),

        .result(result),
        .out_valid(out_valid),
        .out_ready(out_ready)
    );

    assign out_ready = 1'b1;

    `ifdef VERILATE
        initial begin
            $dumpfile({`TOP_DIR,"/Testbench.vcd"});
            $dumpvars(0,dut);
            $dumpon;
        end

        wire error;
        Judge judge (
            .clk(clk),
            .rst(rst),
            .in_data(in_data),
            .kernel(kernel),
            .in_valid(in_valid),
            .in_ready(in_ready),

            .result(result),
            .out_valid(out_valid),
            .out_ready(out_ready),
            .error(error)
        );

        always@(negedge clk)begin
            if(error)begin
                $display("fail!!!");
                $finish;
            end
        end
    `endif

endmodule
