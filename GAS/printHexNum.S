.section .bss
buf:
	.skip 16
bufZ:
	.skip 8
.section .data
mapC:
	.ascii "0123456789abcdef"
.section .text
	.global printHexNum
printHexNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq $0, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %r13, 48(%rsp)
	movq %r14, 56(%rsp)
	movq $0x0f, %r14
	movq 136(%rsp), %r13
	xorq %r12, %r12
	notq %r12
	shrq $60, %r12
	xor %r8, %r8
loop:
	movq %r13, %rcx
	andq %r12, %rcx
	movb mapC(%rip, %rcx, ), %r10b
	movb %r10b, buf(%rip, %r14, )
	addq $1, %r8
	shrq $4, %r13
	cmpq $0, %r13
	je end
	subq $1, %r14
	jmp loop
end:
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, %rcx
	leaq buf(%rip, %r14), %rdx
	leaq bufZ(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	movq 40(%rsp), %r12
	movq 48(%rsp), %r13
	movq 56(%rsp), %r14
	addq $128, %rsp
	ret