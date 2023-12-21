    .include "cx16.s"
    .org $0000

    .org $C000
NMI:        ; The non maskable interrupt
    rti     ; keep this code for right here
RESET:      ; The reset interrupt

    jmp     main_loop
main_loop:
	lda #$80
	sta CTRL
	lda #2
	sta CTRL
	stz DC_HSTART
	lda #(640>>2)
	sta DC_HSTOP
	stz DC_VSTART
	lda #(480>>2)
	sta DC_HSTOP
	stz CTRL
	lda #$21
	sta DC_VIDEO
	lda #128
	sta DC_HSCALE
	sta DC_VSCALE
	stz DC_BORDER
	stz CTRL
	stz ADDR_L
	stz ADDR_M
	lda #$10
	sta ADDR_H
	ldx #0
	ldy #0
:	stz DATA0
	iny
	bne :-
	dex
	bne :-
	stz CTRL
	stz ADDR_L
	stz ADDR_M
	lda #$11
	sta ADDR_H
	ldx #0
	ldy #0
:	stz DATA0
	iny
	bne :-
	dex
	bne :-
	jsr load_palette
	jsr load_charset
	ldx #0
	ldy #0
	jsr gotoxy
	lda #<hello_world
	sta r0
	lda #>hello_world
	sta r0+1
	jsr strout
main_loop_inner:
    jmp     main_loop_inner
hello_world:
	.asciiz "Hello, world!",$0A,"This is line 2!",0
IRQ:
    rti

	.include "palette.s"
	.include "charset.s"
	.include "print.s"
	.include "vars.s"
    .org $FFFA
	.word NMI
	.word RESET
	.word IRQ
