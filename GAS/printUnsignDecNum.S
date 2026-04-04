.section .bss
buf:
	.skip 24
bufZ:
	.skip 8
.section .text
	.global printUnsignDecNum
printUnsignDecNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq $0, 32(%rsp)
	movq $0x0a, %rcx
	movq 136(%rsp), %rax
	movq $23, %r11
	xor %r8, %r8
loop:
	xorq %rdx, %rdx
	movq 136(%rsp), %r10
	div %rcx
	movq %rax, 136(%rsp)
	mul %rcx
	subq %rax, %r10
	addq $0x30, %r10
	addq $1, %r8
	movb %r10, buf(%rip, %r11)
	movq 136(%rsp), %r10
	cmpq $0, %r10
	je end
	subq $1, %r11
	jmp loop
end:
	movq %r8, 40(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, %rcx
	leaq buf(%rip, %r11), %rdx
	movq 40(%rsp), %r8
	leaq bufZ(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	addq $128, %rsp
	retq