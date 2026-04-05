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
.mainEnding:
    movq 40(%rsp), %rsi
    movq 48(%rsp), %rdi
    addq $256, %rsp
    ret