;.include "cx16.s"
gotoxy:
	stx pos_x
	sty pos_y
	rts
chrout:
	tax
	stz pos_idx
	lda pos_y
	ror
	phx
	tax
	and #$7F
	sta pos_idx+1
	txa
	plx
	sta pos_idx
	lda pos_x
	and #$7F
	ora pos_idx
	sta pos_idx
;	lda pos_idx
	sta tmp
	asl
	stz CTRL
	sta ADDR_L
	lda pos_idx+1
	asl
	phx
	tax
	lda tmp
	and #1
	sta tmp
	txa
	plx
	ora tmp
	sta ADDR_M
	lda #$10
	sta ADDR_H
	txa
	sta DATA0
	lda #%00010010
	sta DATA0
	lda pos_x
	inc
	and #$3F
	sta pos_x
	cmp #0
	bne :+
	lda pos_y
	inc
	and #$7F
	sta pos_y
	rts
strout:
	ldy #0
	sty str_idx
:	lda (r0),y
	jsr chrout
	ldy str_idx
	lda (r0),y
	cmp #0
	beq :+
	iny
	sty str_idx
	bra :-
:	rts
tmp:
	.res 1
pos_x:
	.byte 0
pos_y:
	.byte 0
pos_idx:
	.word 0
str_idx:
	.byte 0