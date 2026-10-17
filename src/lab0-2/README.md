# lab0-2：FPGA 实验环境准备

将 Logisim 电路转换为 Verilog，用仿真与开发板验证门级组合逻辑。

对应课程文档：`lab0-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/main.v：三输入奇校验电路；submit/AND_GATE_3_INPUTS.v、OR_GATE_4_INPUTS.v：带输入反相掩码的门。

sim/、syn/、tcl/ 默认来自 repo/sys-project/lab0-2。BubblesMask 每一位为 1 表示将对应输入先取反。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
