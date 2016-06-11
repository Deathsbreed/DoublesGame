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
