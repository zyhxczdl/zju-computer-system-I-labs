# lab5-2：RISC-V 汇编程序调试

使用 QEMU/GDB 和 Spike/OpenOCD 分析 challenge 的控制流和寄存器。

对应课程文档：`lab5-2.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

challenge.c：带内联汇编的题目源码；challenge：当前 RISC-V ELF 调试对象；challenge.asm：已有反汇编；spike.cfg：OpenOCD 配置。

保留当前 challenge 二进制：phase_3 包含对可执行文件自身的散列，重新编译会改变其散列及对应输入。反汇编文件应对应同一个二进制，需要时执行 riscv64-linux-gnu-objdump -d challenge > challenge.asm。遵照实验要求，本次未改写 challenge.c。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
qemu-riscv64 -L /usr/riscv64-linux-gnu -g 1234 challenge
# 在另一个终端执行：
gdb-multiarch challenge
# 在 GDB 中：target remote localhost:1234
```
