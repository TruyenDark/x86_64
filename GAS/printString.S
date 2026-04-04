.section .bss
buf:
	.skip 8
.section .text
	.global printString
printString:
	movq %rax, 8(%rsp)
	subq $64, %rsp
	movq %rdi, 40(%rsp)
	movq %rsi, 48(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, 56(%rsp)
	movq 72(%rsp), %rsi
	xor %r8, %r8
	xor %rcx, %rcx
loop:
	movb (%rsi, %rcx), %dil
	cmpb $0, %dil
	je end
	addq $1, %r8
	addq $1, %rcx
	jmp loop
end:
	movq 56(%rsp), %rcx
	movq 72(%rsp), %rdx
	leaq buf(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	movq 40(%rsp), %rdi
	movq 48(%rsp), %rsi
	addq $64, %rsp
	ret