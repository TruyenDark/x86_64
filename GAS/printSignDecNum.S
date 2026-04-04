.section .bss
buf:
	.skip 24
bufZ:
	.skip 8
.section .text
	.global printSignDecNum
printSignDecNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq %rcx, 40(%rsp)
	movq $0, 32(%rsp)
	movq $0x8000000000000000, %r10
	movq %rsi, 72(%rsp)
	leaq buf(%rip), %rsi
	xor %r8, %r8
	test %rcx, %r10
	movq $0x0a, %r10
	movq 136(%rsp), %rax
	movq $23, %rcx
	je loop
	movq 136(%rsp), %rcx
	negq %rcx
	movq %rcx, %rax
	movq %rcx, 136(%rsp)
	movq $23, %rcx
loop:
	xor %rdx, %rdx
	movq 136(%rsp), %r11
	movq 136(%rsp), %rax
	div %r10
	movq %rax, 136(%rsp)
	mul %r10
	subq %rax, %r11
	addq $0x30, %r11
	addq $1, %r8
	movb %r11b, (%rsi, %rcx)
	movq 136(%rsp), %r11
	cmpq $0, %r11
	je end
	subq $1, %rcx
	jmp loop
end:
	movq %rcx, 64(%rsp)
	movq %r8, 48(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, 56(%rsp)
	movq 40(%rsp), %r10
	test %r10, %r10
	js end1
	movq 64(%rsp), %rcx
	leaq (%rsi, %rcx), %rdx
	movq 56(%rsp), %rcx
	movq 48(%rsp), %r8
	leaq bufZ(%rip), %r9
	call WriteFile
	jmp exit
end1:
	movq 64(%rsp), %rcx
	subq $1, %rcx
	movb $0x2d, (%rsi, %rcx)
	leaq (%rsi, %rcx), %rdx
	movq 56(%rsp), %rcx
	movq 48(%rsp), %r8
	addq $1, %r8
	leaq bufZ(%rip), %r9
	call WriteFile
exit:
	movq 72(%rsp), %rsi
	addq $128, %rsp
	ret