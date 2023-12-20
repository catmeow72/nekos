    .include "cx16.s"

    .org $0000

    .org $C000
NMI:        ; The non maskable interrupt
    rti     ; keep this code for right here
RESET:      ; The reset interrupt

    jmp     main_loop
main_loop:  ; infinite loop
    jmp     main_loop

IRQ:
    rti

    .org $FFFA
    .word NMI
    .word RESET
    .word IRQ
