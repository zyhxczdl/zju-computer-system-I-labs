# lab3-3：无符号乘法器

使用移位累加和 start-finish 协议实现参数化多周期乘法。

对应课程文档：`lab3-3.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/Multiplier.sv：乘法状态机；sim/testbench.v：16 组随机请求；judge.v、judge.cpp：DPI-C 对拍；include/submit/：本地计数器副本。

IDLE 接收请求，WORK 执行 LEN 次迭代，FINAL 的 finish 有效一个周期。rst 高有效同步复位。当前计数表达式要求 LEN>=2；include/submit 的计数器不在当前 Makefile 的仿真源码搜索范围内。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
