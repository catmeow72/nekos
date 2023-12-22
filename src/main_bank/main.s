    .include "cx16.s"
    .org $0000

    .org $C000
NMI:        ; The non maskable interrupt
    rti     ; keep this code for right here
RESET:      ; The reset interrupt

    jmp     main_loop
main_loop:
	lda #$80 ; Load a reset value into A
	sta CTRL ; Store it into the VERA's CTRL flag to reset the VERA
	lda #2 ; Load 1 shifted left one for DCSEL
	sta CTRL ; Store it into the same place so that the VERA's DCSEL flag is correct for DC_(H/V)(START/STOP)
	stz DC_HSTART ; Load valid DC_HSTART/HSTOP values
	lda #(640>>2)
	sta DC_HSTOP
	stz DC_VSTART
	lda #(480>>2)
	sta DC_HSTOP
	stz CTRL ; Set DCSEL to 0
	lda #$21 ; Set valid video params
	sta DC_VIDEO
	lda #128 ; Set both DC_HSCALE and DC_VSCALE to 128
	sta DC_HSCALE ; .. DC_HSCALE
	sta DC_VSCALE ; .. DC_VSCALE
	stz DC_BORDER ; Zero out border color
	stz CTRL ; Select DATA0
	stz ADDR_L ; Select $00000
	stz ADDR_M
	lda #$10 ; ... with an address increment of 1
	sta ADDR_H
	ldx #0 ; Set up X and Y for loop
	ldy #0
:	stz DATA0 ; Zero the data pointer
	iny ; Increment Y to keep track of loop iters
	bne :- ; If non-zero, we're not done yet
	inx ; Now, increment X to act as the high byte of a 16 bit index of the loop
	bne :- ; If non-zero, we're still not done yet
	; The VERA address is valid. Keep going
	ldx #0 ; Reset X and Y for next loop
	ldy #0
:	stz DATA0 ; Same as before, until next comment.
	iny
	bne :-
	inx
	bne :-
	jsr load_palette ; Load the palette
	jsr load_charset ; Load the charset
	ldx #0 ; Load parameters for X and Y position
	ldy #0
	jsr gotoxy ; Set X and Y position.
	lda #<hello_world ; Copy hello_world pointer to r0
	sta r0
	lda #>hello_world
	sta r0+1 ; High byte of r0 since there's no r0h in cx16.s
	jsr strout ; Write the string
main_loop_inner: ; Infinite loop
    jmp     main_loop_inner
hello_world: ; $0A is line feed in ASCII
	.asciiz "Hello, world!",$0A,"This is line 2!",0
IRQ:
    rti
	; .includes are here since they expect to be right after ISRs
	.include "jsrfar.s"
	.include "palette.s"
	.include "charset.s"
	.include "print.s"
	.include "vars.s" ; This one sets the address, so it doesn't specifically need to be here
    .org $FFFA
	.word NMI
	.word RESET
	.word IRQ
