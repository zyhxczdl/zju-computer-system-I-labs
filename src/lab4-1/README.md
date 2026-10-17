# lab4-1：卷积运算单元

组合滑动窗口、四路乘法和加法树，实践 valid-ready 握手与背压。

对应课程文档：`lab4-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/Shift.sv：窗口；Multiplier.sv：乘法；ConvOperator.sv：四路乘加；ConvUnit.sv：整体连接；sim/：激励与对拍。

当前乘加实现固定为 4 路，依赖 Conv::LEN=4。结果按 2*Conv::WIDTH 位保存，加法超出位宽会截断。零初始化窗口，每次接收新数据后发送窗口；运算期间 kernel 需保持稳定。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
