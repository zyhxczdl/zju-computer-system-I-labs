# lab4-2：串口回环（bonus）

利用 interface 和 valid-ready 接口将接收到的 UART 字节回传。

对应课程文档：`lab4-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/UartLoop.sv：回环状态机和调试发送；其余 UART/FIFO 模块来自课程框架。

rstn 低有效同步复位。接收优先于 debug_send，发送期间不接收下一项。验证需同时检查 transmit data 与 receive data 的对应关系，不能只依赖结尾的 success!!!。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
