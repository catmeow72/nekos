.include "cx16.s"

.org $c000
    nmiv:
    resv:
    irqv:

.org $fffa
    .word nmiv
    .word resv
    .word irqv
