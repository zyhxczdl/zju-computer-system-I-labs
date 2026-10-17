# lab3-1：有限状态机

实现含四个状态的时序控制器，理解状态转移和异步复位。

对应课程文档：`lab3-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/FSM.sv：状态寄存器与组合转移逻辑；include/Define.vh：预留定义文件。

rstn 低有效异步复位至 S0；a 优先于 b，S3 保持到复位。课程测试使用 DPI-C 参考模型，成功时输出 success!!!。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
