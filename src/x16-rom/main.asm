    .include "hw.asm"

* = $c000
nmiv
resv
irqv
-   bra -

* = $fffa
    .word nmiv
    .word resv
    .word irqv
    