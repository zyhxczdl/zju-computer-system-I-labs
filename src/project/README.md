# project：RV64I 单周期 CPU

实现 RV64I 数据通路、控制译码与课程 Spike 差分测试接口。

对应课程文档：`project-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/Core.sv：顶层；Controller.sv：译码；ALU.sv、Cmp.sv：运算比较；RegFile.sv：寄存器；DataPkg.sv、MaskGen.sv、DataTrunc.sv：访存适配。

Project-1 和 Project-2 共用本目录，另见课程原仓库的 `project-2.md`。现有 Core 是单周期实现，末尾 MultiFSM 的 stall 固定为 0，未实现 project-bonus 的多周期总线等待；不应将其视为已完成的多周期 CPU。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate TESTCASE=sample
make verilate TESTCASE=rtype
make verilate TESTCASE=full
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
