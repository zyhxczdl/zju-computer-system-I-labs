# Lab5-1 手写递归：a0 输入非负 n，也用于返回结果；F(0)=F(1)=1。
# 32 字节栈帧中 24/16/8/0(sp) 依次保存 ra、s0、n、F(n-1)。
.text
.globl  fibonacci

fibonacci:
    addi sp, sp, -32            #开辟32字节栈空间
    sd ra, 24(sp)               #保存返回地址ra
    sd s0, 16(sp)               #保存s0
    addi s0, sp, 32             #建立栈帧指针
    sd a0, 8(sp)                #保存参数 n
    beq a0, zero, base_case     #如果n==0，跳转
    li t0, 1                    #t0=1
    beq a0, t0, base_case       #如果n==1，跳转
    ld a0, 8(sp)                #取回n
    addi a0, a0, -1             #a0=n-1
    call fibonacci              #fibonacci(n-1)
    sd a0, 0(sp)                #保存fibonacci(n-1)
    ld a0, 8(sp)                #再次取回n
    addi a0, a0, -2             #a0=n-2
    call fibonacci              #fibonacci(n-2)
    ld t1, 0(sp)                #t1=fibonacci(n-1)
    add a0, a0, t1              #a0=fib(n-2)+fib(n-1)
    j end_func                  #跳到函数结束
base_case:
    li a0, 1                    #返回1
end_func:
    ld ra, 24(sp)               #恢复ra
    ld s0, 16(sp)               #恢复s0
    addi sp, sp, 32             #回收栈空间
    jr ra                       #返回调用者
