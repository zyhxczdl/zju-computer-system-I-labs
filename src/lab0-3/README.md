# lab0-3：四输入组合逻辑扩展练习

完成 Lab0-2 实验报告要求的四输入逻辑表达式、仿真和引脚映射。

对应课程文档：`lab0-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/：四输入逻辑与门级模块；sim/testbench.v：遍历 16 种输入；syn/：开发板顶层和引脚约束。

本目录对应 Lab0-2 的扩展练习，docs 中没有单独的 lab0-3.md。O = (~I1 & ~I2 & ~I3) | (~I0 & I2 & ~I1) | (~I0 & I1 & I3) | (I2 & I3) | (I0 & I2)。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
