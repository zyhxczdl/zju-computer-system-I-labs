# Lab5-1 递归阶乘：每层使用 32 字节栈帧保存 ra、s0 和参数 n。
# 递归调用覆盖 ra，所以返回前必须恢复；n=0 返回 1。
        .text
        .globl  factor
factor:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32
        sd      a0,-24(s0)
        ld      a5,-24(s0)
        bne     a5,zero,.L2
        li      a5,1
        j       .L3
.L2:
        ld      a5,-24(s0)
        addi    a5,a5,-1
        mv      a0,a5
        call    factor
        mv      a4,a0
        ld      a5,-24(s0)
        mul     a5,a4,a5
.L3:
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
