# lab5-1：RISC-V 汇编程序设计

阅读编译生成的汇编，手写冒泡排序和递归斐波那契，并遵守调用约定。

对应课程文档：`lab5-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

acc/factor/switch 的 C 和汇编：阅读示例；bubble_sort.s、fibonacci.s：手写实现；*_test.c：测试；simulate.sh：Spike/pk 包装脚本。

先按本机环境设置 simulate.sh 的 SPIKE_PATH 和 PK_PATH。也可用 qemu-riscv64 执行静态链接的测试程序。排序按有符号 long long 升序；F(0)=F(1)=1，递归输入应为非负且避免溢出。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
riscv64-linux-gnu-gcc bubble_sort_test.c bubble_sort.s -o bubble_sort_test -static
./simulate.sh bubble_sort_test
riscv64-linux-gnu-gcc fibonacci_test.c fibonacci.s -o fibonacci_test -static
./simulate.sh fibonacci_test
```
