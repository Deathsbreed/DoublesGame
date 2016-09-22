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
.section .data
    copyright:
        .ascii "Copyright (c) 2016 Nicolas A. Ortega\n\0"
    welcome:
        .ascii "Welcome to the doubles game.\n\0"
    input:
        .int 0
    base:
        .ascii "2^%d=\0"
    scan:
        .ascii "%d"

.section .text
    .global _start

_start:
    movq $copyright, %rdi
    call printf
    movq $welcome, %rdi
    call printf

    movq $1, %r10
    pushq %r10

    call gameloop

    movq $0, %rdi
    call exit

#####
# gameloop: The main loop for the minigame.
#
.type gameloop, @function
gameloop:
    movq 8(%rsp), %rsi
    movq $base, %rdi
    call printf
    movq $input, %rsi
    movq $scan, %rdi
    call scanf
    ret
