    .include "cx16.s"

    .org $0000

    .org $C000
NMI:        ; The non maskable interrupt

RESET:      ; reset vector
    jmp     main_loop
main_loop:  ; infinite loop
    jmp     main_loop

IRQ:

    .org $FFFA
    .word NMI
    .word RESET
    .word IRQ
