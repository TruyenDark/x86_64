#if defined(_WIN64) || defined(_M_X64) || defined(_M_ARM64)
	#include <stdio.h>
	#include <windows.h>
	extern void drawBytes(const char* fmt, ...);
	extern void printString(const char* fmt);
	extern void printHexNum(long long val);
	extern void printUnsignDecNum(long long val);
	extern void printSignDecNum(long long val);
	int main(void) {
		printString("Hello World!\n");
		printHexNum(0xffffffffffffffff);
		printString("\n");
		printUnsignDecNum(0xffffffffffffffff);
		printString("\n");
		printSignDecNum(0xffffffffffffffff);
		printString("\n");
		drawBytes("String: @s\nUnsigned 64-bit integer: @u\nSigned 64-bit integers: @d\n64-bit hexadecimal number: @x", "It works!", 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff);
		return 0;
	}
#elif defined(__ANDROID__) || defined(__aarch64__)
    #include <stdio.h>
    extern void arm64_print(const char* fmt, ...);
    extern void string_plugin(const char* fmt);
    extern void hexadecimal_addition(long long val);
    extern void unsigned_decimal_utility(long long val);
    extern void signed_decimal_utility_64bit(long long val);
    int main(void) {
        string_plugin("Hello World!\n");
        hexadecimal_addition(0xffffffffffffffff);
        string_plugin("\n");
        unsigned_decimal_utility(0xffffffffffffffff);
        string_plugin("\n");
        signed_decimal_utility_64bit(0xffffffffffffffff);
        string_plugin("\n");
        arm64_print("String: @s\nUnsigned 64-bit integer: @u\nSigned 64-bit integers: @d\n64-bit hexadecimal number: @x", "It works!", 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff);
        return 0;
    }
#elif defined(__linux__) || defined(__x86_64__) || defined(__aarch64__)
	# error "Use the MSVC (Microsoft Visual C++) compiler from Windows 64-bit to build various Linux distributions."
#else
	# error "Actually, I already have a draft for the AArch64 architecture. But because I'm lazy, I haven't uploaded it yet, so I'm using some professional compiler to translate it into ARM64 Assembly for now."
#endif
/*This is a testing program, I created it for you so you just need to run it and check for bugs*/