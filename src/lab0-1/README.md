# lab0-1：数字电路仿真环境准备

使用 Ngspice 观察 CMOS 反相器，使用 Logisim 绘制并验证组合逻辑。

对应课程文档：`lab0-1.md`（请在课程原仓库查阅）。返回[实验索引](../README.md)。

## 文件与实现

inv.sp：反相器网表；pdk/：随课程提供的 Skywater 130nm 器件模型。

网表以 1.8V 供电，Vin 从 0V 线性上升至 1.8V。Logisim 的 circuit 文件未包含在当前 src 中。

## 运行

在 Linux/WSL 中进入当前目录，准备好[实验索引与环境说明](../README.md)列出的工具和课程框架后执行：

```sh
ngspice inv.sp
```
