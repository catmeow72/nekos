load_palette:
	lda #<palette ; Load the low byte of the palette
	sta r0 ; Store it in r0l
	lda #>palette ; Load the high byte of the palette
	sta r0+1 ; Store it in r0h
	stz CTRL ; Select DATA0
	stz ADDR_L ; Set ADDR to $1FA00 with 1 byte increment
	lda #$FA
	sta ADDR_M
	lda #$11
	sta ADDR_H
	ldy #0 ; Copy 256 bytes
palette_loop_1:
	lda (r0),y ; Load the palette data
	sta DATA0 ; Put it in the VERA
	iny ; Increment Y
	cpy #0 ; If Y has overflowed, move on to the next loop
	bne palette_loop_1 ; Otherwise, repeat the loop
	lda r0+1 ; Increment r0h so that the next 256 bytes can be copied
	inc
	sta r0+1
	ldy #0 ; Copy 256 more bytes
palette_loop_2:
	lda (r0),y ; Load the palette data again
	sta DATA0 ; Put it in the VERA
	iny ; Increment Y
	cpy #0 ; If Y has overflowed, we're done
	bne palette_loop_2 ; Otherwise, repeat the loop
	rts

palette:
	.incbin "DPAL.BIN"
palette_end: