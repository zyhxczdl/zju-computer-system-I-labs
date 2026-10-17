# lab2-1：参数化全加减法器

用一位全加器级联构建可配置宽度的行波进位加减法器。

对应课程文档：`lab2-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

submit/adder.v：一位全加器；adders.v：进位链；add_subs.v：补码减法；sim/：随机差分测试。

默认 LENGTH=32，课程任务包含 64 位应用；可由实例参数指定。do_sub=1 时计算 a+(~b)+1；输出 c 为进位，不能直接作为有符号溢出。Vivado 的初始数据路径见 include/initial_file.vh。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
make verilate
make wave
```

生成开发板比特流前，按本机环境设置 Makefile 的 `VIVADO_SETUP`，并检查 include 中的内存初始化路径，再运行 `make bitstream`。硬件上板结果需要实际连接 Nexys A7 验证。
