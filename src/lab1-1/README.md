# lab1-1：八选一多路选择器

由门级四选一选择器级联构建一位八选一选择器。

对应课程文档：`lab1-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/MUX4T1_1.v：门级四选一；Mux8T1_1.v：八选一；sim/：仿真；syn/：开关与 LED 连接。

整体功能为 O=I[S]。现有 testbench 对 I=8'b10101010 遍历 S，主要用于观察波形，并非所有输入的穷举断言测试。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
