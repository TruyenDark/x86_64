#if defined(_WIN64) && defined(_M_X64) || defined(_M_ARM64)
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
#elif defined(__ANDROID__) && defined(__aarch64__)
	# error "Actually, I already have a draft for the AArch64 architecture. But because I'm lazy, I haven't uploaded it yet, so I'm using some professional compiler to translate it into ARM64 Assembly for now."
#elif defined(__linux__) && defined(__x86_64__) || defined(__aarch64__)
	# error "Use the MSVC (Microsoft Visual C++) compiler from Windows 64-bit to build various Linux distributions."
#endif
/*This is a testing program, I created it for you so you just need to run it and check for bugs*/