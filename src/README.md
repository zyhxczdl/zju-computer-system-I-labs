# zju 计算机系统I 实验

按 Lab0 至 Lab5 的编号排列，CPU Project 独立列出。每个目录的 README 包含文件职责、接口和运行方法。

| 编号 | 内容 | 代码说明 | 课程文档 |
| --- | --- | --- | --- |
| lab0-1 | 数字电路仿真环境准备 | [README](lab0-1/README.md) | `lab0-1.md` |
| lab0-2 | FPGA 实验环境准备 | [README](lab0-2/README.md) | `lab0-2.md` |
| lab0-3 | 四输入组合逻辑扩展练习 | [README](lab0-3/README.md) | `lab0-2.md` |
| lab1-1 | 八选一多路选择器 | [README](lab1-1/README.md) | `lab1-1.md` |
| lab1-2 | 七段数码管译码与复合选择器 | [README](lab1-2/README.md) | `lab1-2.md` |
| lab2-1 | 参数化全加减法器 | [README](lab2-1/README.md) | `lab2-1.md` |
| lab3-1 | 有限状态机 | [README](lab3-1/README.md) | `lab3-1.md` |
| lab3-2 | 计数器与 BCD 定时器 | [README](lab3-2/README.md) | `lab3-2.md` |
| lab3-3 | 无符号乘法器 | [README](lab3-3/README.md) | `lab3-3.md` |
| lab4-1 | 卷积运算单元 | [README](lab4-1/README.md) | `lab4-1.md` |
| lab4-2 | 串口回环（bonus） | [README](lab4-2/README.md) | `lab4-2.md` |
| lab5-1 | RISC-V 汇编程序设计 | [README](lab5-1/README.md) | `lab5-1.md` |
| lab5-2 | RISC-V 汇编程序调试 | [README](lab5-2/README.md) | `lab5-2.md` |
| project | RV64I 单周期 CPU | [README](project/README.md) | `project-1.md` |

## 环境与依赖

本仓库仅保留 `src/` 中的实验代码及本目录内的说明。表格中的课程文档文件名仅用于对应实验编号，文档和图片请在课程原仓库查阅。

RTL 仿真需要 Linux/WSL、GNU Make、C++17 编译器和支持 `--timing` 的 Verilator 5；查看波形需要 GTKWave。上板还需要 Vivado 和 Nexys A7。Lab5 需要 RISC-V GNU 交叉编译器，以及 QEMU 或 Spike/pk。

各实验 Makefile 默认通过 `../../repo/sys-project` 查找课程框架。使用时可将本仓库 `src/` 放入已经配置好的课程工作区，或在运行 Makefile 时设置 `DIR_REPO=/absolute/path/to/course/repo`。课程框架、工具链、第三方库和文档均不随此仓库上传。

迁移机器时，需要按本机环境配置 Makefile 的 `VIVADO_SETUP`、`include/*.vh` 的初始化文件路径，以及 `lab5-1/simulate.sh` 的 Spike/pk 路径。具体命令见各实验 README。
