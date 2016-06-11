.section .data
    welcome:
        .ascii "Welcome to the doubles game.\n"

.section .text
    .global _start

_start:
    mov $1, %rax                    # Define write syscall
    mov $1, %rdi                    # Define stdout as out stream file
    mov $welcome, %rsi              # Give the string
    mov $29, %rdx                   # Give size of the string
    syscall

    mov $60, %rax                   # Define exit system call
    mov $0, %rdi                    # Return 0 on exit
    syscall
