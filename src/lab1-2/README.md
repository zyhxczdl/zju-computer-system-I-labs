# lab1-2：七段数码管译码与复合选择器

实现十六进制七段译码和 32 位四选一选择器。

对应课程文档：`lab1-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/SegDecoder.v：段码译码；Mux4T1_32.v：四选一；include/display.vh：显示内容。

a~g、p 低电平点亮；LE=1 消隐，point=1 点亮小数点。显示数据保留当前配置，可按实验要求自行替换。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
