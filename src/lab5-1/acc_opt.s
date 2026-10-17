# Lab5-1 -O2 累加示例：a5 保存当前加数，a0 保存累加值。
# 终点改为 b+1，以寄存器循环替代栈上的局部变量。
        .text
        .globl  acc
acc:
        mv      a5,a0
        bgt     a0,a1,.L4
        addi    a1,a1,1
        li      a0,0
.L3:
        add     a0,a0,a5
        addi    a5,a5,1
        bne     a5,a1,.L3
        ret
.L4:
        li      a0,0
        ret
