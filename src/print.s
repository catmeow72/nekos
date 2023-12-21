;.include "cx16.s"
gotoxy:
	stx pos_x
	sty pos_y
	rts
incx:
	lda pos_x
	inc
	and #$7F
	sta pos_x
	cmp #0
	bne :+
	lda pos_y
	inc
	and #$3F
	sta pos_y
:	rts
newline:
	stz pos_x
	lda pos_y
	inc
	and #$3F
	sta pos_y
	rts
chrout:
	cmp #$0A
	beq newline
	tax
	stz pos_idx
	lda pos_y
	phx
	and #$3F
	sta pos_idx+1
	txa
	and #1
	sta pos_idx
	lda pos_x
	asl
	sta pos_idx
;	lda pos_idx
	asl
	stz CTRL
	lda pos_idx
	sta ADDR_L
	lda pos_idx+1
	sta ADDR_M
	lda #$10
	sta ADDR_H
	pla
	sta DATA0
	lda #%00010010
	sta DATA0
	jmp incx
:	rts
strout:
	ldy #0
	sty str_idx
:	lda (r0),y
	jsr chrout
	ldy str_idx
	iny
	sty str_idx
	lda (r0),y
	cmp #0
	bne :-
:	rts