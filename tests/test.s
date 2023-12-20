; testing the VERA module

CHROUT = $FFD2

start:
;   lda     #'a'
;   jsr     CHROUT

    lda     #%00010000
    sta     $9F22

do_something:
    lda     #$12
    sta     $9F23
    jmp     do_something

    
    rts
