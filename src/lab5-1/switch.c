// Lab5-1：用于观察跳转表的 C 示例；case 20 有意继续执行 case 21。
int switch_eg(long long x, long long y) {
	long long result = y;
	switch (x) {
	case 20:
		result = result - 5;
	case 21:
		result = result + 19;
		break;
	case 22:
		result += 11;
		break;
	case 24:
	case 26:
		result -= 20;
		break;
	default:
		result = 0;
	}
	return result;
}