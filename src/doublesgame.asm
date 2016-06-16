##
# DoublesGame
# Copyright (c) 2016 Nicolás A. Ortega
# License: GNU GPLv3
#
# Description:
#   DoublesGame is a small game where you are given 2^X where X is a number
# that continuously increases (starting from 1). You then have to enter the
# correct answer to the equation in order to continue. There are three
# other responses aside from giving a number answer to the equation, these
# are a `help' command, which displays the two other commands, the `answer'
# command which will allow you to skip a double giving you the correct
# answer, and the `exit' command which will close the game.
#
# Variables:
#   %rbx    Correct result of double
#   %r10    Power used in double equation
#
.section .data
    copyright:
        .ascii "Copyright (c) 2016 Nicolas A. Ortega\n"
    welcome:
        .ascii "Welcome to the doubles game.\n"
    base:
        .ascii "2^"

.section .text
    .global _start

_start:
    movq $copyright, %rdi           # First argument (string)
    movq $37, %rsi                  # Second argument (string size)
    call print

    movq $welcome, %rdi             # First argument (string)
    movq $29, %rsi                  # Second argument (string size)
    call print

    movq $2, %rbx                   # Move first result to %rbx
    movq $1, %r10                   # Move power number to %r10
    main_loop:                      # Main loop of the program
        movq $base, %rdi            # First argument (string)
        movq $2, %rsi               # Second argument (string size)
        call print
        movq %r10, %rdi             # First argument
        call print_num
        pushq $0x3A                 # Push the `:' character onto the stack
        movq %rsp, %rdi             # First argument (pointer to the `:' character)
        movq $1, %rsi               # Second argument
        call print
        addq $8, %rsp               # We are no longer using that space in memory

    movq $60, %rax                  # Define exit system call
    movq $0, %rdi                   # Return 0 on exit
    syscall

#FUNCTION: PRINT
# Description:
#   Print to stdout.
#
# Arguments:
#   %rdi    string to print
#   %rsi    size of string
#
.type print, @function
print:
    movq %rsi, %rdx                 # Move string size for syscall
    movq %rdi, %rsi                 # Move string for syscall
    movq $1, %rax                   # Define write syscall
    movq $1, %rdi                   # Define stdout as stream out file
    syscall
    ret                             # Return back to the next instruction

#FUNCTION: PRINT_NUM
# Description:
#   Convert a number to its ASCII equivalent  and print it to stdout.
#
# Arguments:
#   %rdi    number to print
#
.type print_num, @function
print_num:
    movq %rdi, %rax                 # Number to divide from
    movq $10, %r11                  # Number to divide by
    movq $0, %r12                   # Digit counter
    convert_digit_loop:
        idivq %r11                  # %rax /= 10, %rdx = %rax % 10
        addq $48, %rdx              # Get the ascii value of %rdx
        pushq %rdx                  # Save it on the stack for later usage
        incq %r12                   # Increment digit counter
        cmpq $0, %rax               # Compare %rax to 0
        jne convert_digit_loop      # If not zero redo loop

    print_digit_loop:
        movq $1, %rsi               # Second argument
        popq %rdi                   # First argument
        call print
        decq %r12                   # Decrease digit counter
        cmpq $0, %r12               # Compare
        jne print_digit_loop        # If not zero redo loop
    ret
