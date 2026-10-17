# Lab5-1 手写冒泡排序：a0 为 long long 数组地址，a1 为元素个数。
# 按有符号数升序原地排序，仅使用调用者保存寄存器，为不调用其他函数的叶子函数。
.text
.globl  bubble_sort

bubble_sort:
   li t0, 0                #i=0，初始化外层循环变量

outer_loop:
    addi t1, a1, -1         #t1=len-1
    bge t0, t1, end_sort    #如果i>=len-1，排序结束，跳转到end_sort
    li t2, 0                #j=0，初始化内层循环变量

inner_loop:
    addi t3, a1, -1         #t3=len-1
    sub t3, t3, t0          #t3=len-1-i
                            #已经排好的后面部分不再比较
    bge t2, t3, next_outer  #如果j>=len-1-i
                            #内层循环结束，进入下一轮外层循环
    slli t4, t2, 3          #t4=j*8
                            #long long占8字节
                            #左移3位相当于乘8
    add t5, a0, t4          #t5=arr+j*8
                            #得到arr[j]的地址
    ld t6, 0(t5)            #t6=arr[j]
                            #从内存读取arr[j]
    ld a2, 8(t5)            #a2=arr[j+1]
                            #arr[j+1]地址=arr[j]地址+8
    ble t6, a2, no_swap     #如果arr[j]<=arr[j+1]
                            #已经有序，不交换
                            #跳转到no_swap
    sd a2, 0(t5)            #arr[j]=arr[j+1]
    sd t6, 8(t5)            #arr[j+1]=原arr[j]
no_swap:
    addi t2, t2, 1          #j++
    j inner_loop            #回到内层循环继续比较
next_outer:
    addi t0, t0, 1          #i++
    j outer_loop            #回到外层循环
end_sort:
    jr ra                   #返回调用者
