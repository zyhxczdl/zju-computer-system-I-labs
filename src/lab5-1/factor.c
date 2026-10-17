// Lab5-1：阶乘递归参考实现，输入为非负且结果适配 long long 的整数。
long long factor(long long n) {
  if (n == 0) {
    return 1;
  }
  return n * factor(n - 1);
}