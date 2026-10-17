// Lab5-1：区间 [a,b] 累加的 C 参考实现；输入应避免 long long 溢出。
long long acc(long long a, long long b) {
  long long res = 0;
  for (long long i = a; i <= b; ++i) {
    res += i;
  }
  return res;
}