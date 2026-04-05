.section .bss
buf:
    .skip 32
bufZ:
    .skip 32
.section .data
atC:
    .ascii "@"
mapC:
    .ascii "0123456789abcdef"
.section .text
    .global drawBytes
    .global printHexNum
    .global printSignDecNum
    .global printString
    .global printUnsignDecNum
drawBytes:
    movq %rcx, 8(%rsp)
    movq %rdx, 16(%rsp)
    movq %r8, 24(%rsp)
    movq %r9, 32(%rsp)
    subq $256, %rsp
    movq $-11, %rcx
    call GetStdHandle
    movq %rsi, 40(%rsp)
    movq %rdi, 48(%rsp)
    movq %rax, 56(%rsp)
    movq 264(%rsp), %rsi
    leaq 272(%rsp), %rdi
    xor %rcx, %rcx
.mainLoop:
    movb (%rsi), %cl
    addq $1, %rsi
    cmpb $'@', %cl
    je .mainProcessing
    cmpb $0, %cl
    je .mainEnding
    movq 56(%rsp), %rcx
    movq %rsi, %rdx
    subq $1, %rdx
    movq $1, %r8
    leaq bufZ(%rip), %r9
    movq $0, 32(%rsp)
    call WriteFile
    jmp .mainLoop
.mainProcessing:
    movb (%rsi), %cl
    addq $1, %rsi
    cmpb $'s', %cl
    je .String
    cmpb $'d', %cl
    je .SignDecNum
    cmpb $'u', %cl
    je .UnsignDecNum
    cmpb $'x', %cl
    je .HexNum
    movq 56(%rsp), %rcx
    leaq atC(%rip), %rdx
    movq $1, %r8
    leaq bufZ(%rip), %r9
    movq $0, 32(%rsp)
    call WriteFile
    movq 56(%rsp), %rcx
    movq %rsi, %rdx
    subq $1, %rdx
    movq $1, %r8
    leaq bufZ(%rip), %r9
    movq $0, 32(%rsp)
    call WriteFile
    jmp .mainLoop
.String:
    movq (%rdi), %rcx
    call printString
    addq $8, %rdi
    jmp .mainLoop
.SignDecNum:
    movq (%rdi), %rcx
    call printSignDecNum
    addq $8, %rdi
    jmp .mainLoop
.UnsignDecNum:
    movq (%rdi), %rcx
    call printUnsignDecNum
    addq $8, %rdi
    jmp .mainLoop
.HexNum:
    movq (%rdi), %rcx
    call printHexNum
    addq $8, %rdi
    jmp .mainLoop
.mainEnding:
    movq 40(%rsp), %rsi
    movq 48(%rsp), %rdi
    addq $256, %rsp
    ret
# printString
printString:
	movq %rcx, 8(%rsp)
	subq $64, %rsp
	movq %rdi, 40(%rsp)
	movq %rsi, 48(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, 56(%rsp)
	movq 72(%rsp), %rsi
	xor %r8, %r8
	xor %rcx, %rcx
.stringLoop:
	movb (%rsi, %rcx), %dil
	cmpb $0, %dil
	je .stringEnd
	addq $1, %r8
	addq $1, %rcx
	jmp .stringLoop
.stringEnd:
	movq 56(%rsp), %rcx
	movq 72(%rsp), %rdx
	leaq bufZ(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	movq 40(%rsp), %rdi
	movq 48(%rsp), %rsi
	addq $64, %rsp
	ret
# printSignDecNum
printSignDecNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq 136(%rsp), %rcx
	movq %rcx, 40(%rsp)
	movq $0, 32(%rsp)
	movq $0x8000000000000000, %r10
	movq %rsi, 72(%rsp)
	leaq buf(%rip), %rsi
	xor %r8, %r8
	movq 136(%rsp), %rcx
	test %rcx, %r10
	movq $0x0a, %r10
	movq 136(%rsp), %rax
	movq $23, %rcx
	je .SignLoop
	movq 136(%rsp), %rcx
	negq %rcx
	movq %rcx, %rax
	movq %rcx, 136(%rsp)
	movq $23, %rcx
.SignLoop:
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
	je .SignEnd
	subq $1, %rcx
	jmp .SignLoop
.SignEnd:
	movq %rcx, 64(%rsp)
	movq %r8, 48(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, 56(%rsp)
	movq 40(%rsp), %r10
	test %r10, %r10
	js .SignEnd1
	movq 64(%rsp), %rcx
	leaq (%rsi, %rcx), %rdx
	movq 56(%rsp), %rcx
	movq 48(%rsp), %r8
	leaq bufZ(%rip), %r9
	call WriteFile
	jmp .SignExit
.SignEnd1:
	movq 64(%rsp), %rcx
	subq $1, %rcx
	movb $0x2d, (%rsi, %rcx)
	leaq (%rsi, %rcx), %rdx
	movq 56(%rsp), %rcx
	movq 48(%rsp), %r8
	addq $1, %r8
	leaq bufZ(%rip), %r9
	call WriteFile
.SignExit:
	movq 72(%rsp), %rsi
	addq $128, %rsp
	ret
# printUnsignDecNum
printUnsignDecNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq $0, 32(%rsp)
	movq %rdi, 48(%rsp)
	leaq buf(%rip), %rdi
	movq $0x0a, %rcx
	movq 136(%rsp), %rax
	movq $23, %r11
	xor %r8, %r8
.UnsignLoop:
	xorq %rdx, %rdx
	movq 136(%rsp), %rax
	movq 136(%rsp), %r10
	div %rcx
	movq %rax, 136(%rsp)
	mul %rcx
	subq %rax, %r10
	addq $0x30, %r10
	addq $1, %r8
	movb %r10b, (%rdi, %r11)
	movq 136(%rsp), %r10
	cmpq $0, %r10
	je .UnsignEnd
	subq $1, %r11
	jmp .UnsignLoop
.UnsignEnd:
	movq %r11, 56(%rsp)
	movq %r8, 40(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, %rcx
	movq 56(%rsp), %r11
	leaq buf(%rip), %rdi
	leaq (%rdi, %r11), %rdx
	movq 40(%rsp), %r8
	leaq bufZ(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	movq 48(%rsp), %rdi
	addq $128, %rsp
	ret
# printHexNum
printHexNum:
	movq %rcx, 8(%rsp)
	subq $128, %rsp
	movq $0, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %r13, 48(%rsp)
	movq %r14, 56(%rsp)
	movq %rsi, 64(%rsp)
	movq %rdi, 72(%rsp)
	leaq mapC(%rip), %rsi
	leaq buf(%rip), %rdi
	movq $0x0f, %r14
	movq 136(%rsp), %r13
	xorq %r12, %r12
	notq %r12
	shrq $60, %r12
	xor %r8, %r8
.HexLoop:
	movq %r13, %rcx
	andq %r12, %rcx
	movb (%rsi, %rcx), %r10b
	movb %r10b, (%rdi, %r14)
	addq $1, %r8
	shrq $4, %r13
	cmpq $0, %r13
	je .HexEnd
	subq $1, %r14
	jmp .HexLoop
.HexEnd:
	movq %r8, 80(%rsp)
	movq $-11, %rcx
	call GetStdHandle
	movq %rax, %rcx
	leaq (%rdi, %r14), %rdx
	movq 80(%rsp), %r8
	leaq bufZ(%rip), %r9
	movq $0, 32(%rsp)
	call WriteFile
	movq 40(%rsp), %r12
	movq 48(%rsp), %r13
	movq 56(%rsp), %r14
	movq 64(%rsp), %rsi
	movq 72(%rsp), %rdi
	addq $128, %rsp
	ret