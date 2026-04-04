#ifdef _WIN64
	#include <stdio.h>
	#include <windows.h>
	extern void printString(const char* p);
	extern void printHexNum(long long num);
	extern void printUnsignDecNum(long long num);
	extern void printSignDecNum(long long num);
	int main(void) {
		printString("Hello World!\n");
		printHexNum(0xffffffffffffffff);
		printUnsignDecNum(0xffffffffffffffff);
		printSignDecNum(0xffffffffffffffff);
		return 0;
	}
#endif
/*This is a testing program, I created it for you so you just need to run it and check for bugs*/