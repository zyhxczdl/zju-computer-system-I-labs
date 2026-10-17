# lab3-2：计数器与 BCD 定时器

实现可级联的模数计数器，并用两位 BCD 表示 24 进制计数。

对应课程文档：`lab3-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/Cnt.sv：4 位计数器；Cnt2num.sv：两位 BCD，默认 BASE=24、INITIAL=16。

rstn 为低有效异步复位；high_rst 在时钟沿强制归零。en 和 low_co 共同允许递增；co 可传给高位计数器。两位 BCD 输出的 8'h23 表示十进制 23。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
