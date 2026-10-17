// Lab3-3 DPI-C 参考模型：先把被乘数提升为 64 位，再相乘，避免 32 位溢出。
// 返回 1 表示完整的 64 位乘积匹配，返回 0 并打印差异表示失败。
#include <svdpi.h>
#include <stdio.h>

extern "C" unsigned int mul_judge (
    unsigned int multiplicand, 
    unsigned int multiplier,
    unsigned long long int product
){
    
    unsigned long long int simulate_result = (unsigned long long int)multiplicand*multiplier;
    unsigned int right = (simulate_result == product)?1:0;

    if(!right){
        printf("*********error***********\n");
        printf("simulation multiplicand = %08x, multiplier = %08x, product = %016llx\n", multiplicand, multiplier, simulate_result);
        printf("hardware   multiplicand = %08x, multiplier = %08x, product = %016llx\n", multiplicand, multiplier, product);
    }else{
        printf("simulation multiplicand = %08x, multiplier = %08x, product = %016llx\n", multiplicand, multiplier, simulate_result);
    }

    return right;
}
