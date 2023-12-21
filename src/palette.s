load_palette:
	lda #<palette
	sta r0
	lda #>palette
	sta r0+1
	stz CTRL
	stz ADDR_L
	lda #$FA
	sta ADDR_M
	lda #$11
	sta ADDR_H
	ldy #0
@loop0:
	lda (r0),y
	sta DATA0
	iny
	cpy #0
	bne @loop0
	inc r0+1
	ldy #0
@loop1:
	lda (r0),y
	sta DATA0
	iny
	cpy #0
	bne @loop1
	rts

palette:
	.incbin "DPAL.BIN"
palette_end: