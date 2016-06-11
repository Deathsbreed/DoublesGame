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
        .ascii "Copyright (c) Nicolas A. Ortega\n"
    welcome:
        .ascii "Welcome to the doubles game.\n"
    base:
        .ascii "2^"

.section .text
    .global _start

_start:
    movq $copyright, %rdi           # First argument (string)
    movq $32, %rsi                  # Second argument (string size)
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
        # TODO: Convert number to character

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
