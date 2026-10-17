# zju 计算机系统I 实验

浙江大学《计算机系统 I》实验代码整理，涵盖数字逻辑电路、Verilog / SystemVerilog 设计、RISC-V 汇编与 RV64I 单周期 CPU。

代码按实验编号保存在 `src/` 中，各实验目录附有实现说明、接口约定与运行方法。完整索引见 [src/README.md](src/README.md)。

## 实验导航

| 编号 | 实验内容 | 说明与代码 |
| --- | --- | --- |
| Lab0-1 | SPICE 反相器仿真与数字电路环境 | [lab0-1](src/lab0-1/README.md) |
| Lab0-2 | FPGA 环境与门级组合逻辑 | [lab0-2](src/lab0-2/README.md) |
| Lab0-3 | 四输入组合逻辑扩展练习，属于 Lab0-2 | [lab0-3](src/lab0-3/README.md) |
| Lab1-1 | 八选一多路选择器 | [lab1-1](src/lab1-1/README.md) |
| Lab1-2 | 七段数码管译码与 32 位四选一选择器 | [lab1-2](src/lab1-2/README.md) |
| Lab2-1 | 参数化行波进位全加减法器 | [lab2-1](src/lab2-1/README.md) |
| Lab3-1 | 有限状态机 | [lab3-1](src/lab3-1/README.md) |
| Lab3-2 | 模数计数器与两位 BCD 计数器 | [lab3-2](src/lab3-2/README.md) |
| Lab3-3 | 移位累加无符号乘法器 | [lab3-3](src/lab3-3/README.md) |
| Lab4-1 | 滑动窗口、乘加与卷积运算单元 | [lab4-1](src/lab4-1/README.md) |
| Lab4-2 | UART 串口回环（bonus） | [lab4-2](src/lab4-2/README.md) |
| Lab5-1 | RISC-V 汇编、冒泡排序与递归斐波那契 | [lab5-1](src/lab5-1/README.md) |
| Lab5-2 | QEMU / GDB 与 Spike / OpenOCD 调试 | [lab5-2](src/lab5-2/README.md) |
| Project | RV64I 单周期 CPU 数据通路与控制单元 | [project](src/project/README.md) |

## 目录结构

```text
.
├── README.md
└── src/
    ├── README.md          # 实验索引与环境说明
    ├── lab0-1/ … lab5-2/ # 各阶段实验
    └── project/          # CPU 数据通路与控制单元
```

RTL 实验通常包含以下目录，具体以各实验实际文件为准：

- `submit/`：实验设计实现。
- `sim/`：本地仿真激励与参考模型。
- `syn/`：本地开发板顶层与引脚约束。
- `include/`：配置、头文件与复用模块。
- `Makefile`：仿真与综合入口。

## 环境与外部依赖

| 用途 | 工具 |
| --- | --- |
| RTL 仿真 | Linux / WSL、GNU Make、C++17 编译器、支持 `--timing` 的 Verilator 5 |
| 波形查看 | GTKWave |
| FPGA 综合与上板 | Vivado、Nexys A7 |
| 汇编编译与运行 | RISC-V GNU 交叉编译器、QEMU 或 Spike / pk |
| 程序调试 | GDB Multiarch；Spike 调试可配合 OpenOCD |
| 电路级仿真 | Ngspice；原理图实验使用 Logisim |

多个实验依赖课程提供的 `repo/sys-project` 框架。请从[课程原仓库](https://git.zju.edu.cn/zju-sys/sys1/sys1-sp26)获取并配置对应依赖；本仓库保留源码和自行补充的说明，课程讲义、图片与框架不在此分发。

## 使用方法

克隆代码：

```sh
git clone https://github.com/zyhxczdl/zju-computer-system-I-labs.git
cd zju-computer-system-I-labs
```

可以将 `src/` 中的代码放入已经配置好的课程工作区。也可以保持本仓库独立，通过 Makefile 的 `DIR_REPO` 参数指定课程依赖目录。该路径应指向包含 `sys-project/` 的 `repo/`，例如：

```sh
# 替换为本机已有的课程依赖目录
COURSE_REPO=/absolute/path/to/sys1-sp26/repo

# 乘法器仿真与波形查看
make -C src/lab3-3 verilate DIR_REPO="$COURSE_REPO"
make -C src/lab3-3 wave

# CPU 样例仿真
make -C src/project verilate TESTCASE=sample DIR_REPO="$COURSE_REPO"
```

Lab5-1 的静态汇编测试也可使用 QEMU 执行：

```sh
cd src/lab5-1
riscv64-linux-gnu-gcc bubble_sort_test.c bubble_sort.s -static -o bubble_sort_test
qemu-riscv64 bubble_sort_test
riscv64-linux-gnu-gcc fibonacci_test.c fibonacci.s -static -o fibonacci_test
qemu-riscv64 fibonacci_test
```

迁移机器或上板前，请检查 Makefile 的 `VIVADO_SETUP`、`include/*.vh` 中的初始化文件路径，以及 `lab5-1/simulate.sh` 的 `SPIKE_PATH` / `PK_PATH`。这些配置保留了原实验环境的路径，需要按本机设置。

## 实现与验证说明

整理时曾在已配置课程框架的本机环境重新运行 10 个 RTL 实验仿真，以及冒泡排序、斐波那契测试；CPU 运行了 `sample` 样例。各项覆盖范围以原有激励为准，不能将仿真正常退出等同于完整功能验证。本次整理未重新进行硬件上板验收。

CPU 当前为单周期实现。`Core.sv` 末尾的 `MultiFSM` 将 `stall` 固定为 0，多周期处理器 bonus 尚未实现。

Lab5-2 保留了用于调试的 `challenge` 二进制，其部分逻辑依赖可执行文件自身的散列；重新编译会改变对应的调试输入，使用时请区分二进制版本。

## 来源

实验题目与基础框架来自浙江大学计算机系统 I 课程。代码中的 Logisim 自动生成标记及第三方模型来源予以保留；相关内容的权利归原作者所有。
