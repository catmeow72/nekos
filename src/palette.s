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
palette_loop_1:
	lda (r0),y
	sta DATA0
	iny
	cpy #0
	bne palette_loop_1
	lda r0+1
	inc
	sta r0+1
	ldy #0
palette_loop_2:
	lda (r0),y
	sta DATA0
	iny
	cpy #0
	bne palette_loop_2
	rts

palette:
	.incbin "DPAL.BIN"
palette_end: