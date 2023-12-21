;.include "cx16.s"
load_charset:
	lda #$80
	sta L1_TILEBASE
	stz L1_MAPBASE
	lda #%01100000
	sta L1_CONFIG
	stz L1_HSCROLL_L
	stz L1_HSCROLL_H
	stz L1_VSCROLL_L
	stz L1_HSCROLL_H
	lda L1_TILEBASE
	and #%11111100
	stz CTRL
	stz ADDR_L
	lda #$11
	sta ADDR_H
	lda #00
	sta ADDR_M
	stz charset_tmp
	stz charset_tmp+1
	lda #<charset_data
	sta r0
	lda #>charset_data
	sta r0+1
	ldx #0
	ldy #0
charset_loop:
	lda (r0),y
	sta DATA0
	iny
	cpy #0
	bne charset_loop
	ldy #0
	inx
	lda r0+1
	inc
	sta r0+1
	cpx #>charset_data_end
	bne charset_loop
	ldy #0
charset_loop_last_page:
	cpy #<charset_data_end
	beq :+
	lda (r0),y
	sta DATA0
	iny
	bra charset_loop_last_page
:	rts
charset_data:
	.incbin "font.bin",0
charset_data_end:
	