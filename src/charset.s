;.include "cx16.s"
load_charset:
	lda #$10
	sta L1_TILEBASE
	stz L1_MAPBASE
	lda #%01100000
	sta L1_CONFIG
	lda L1_TILEBASE
	and #%11111100
	stz CTRL
	stz ADDR_L
	rol
	tax
	and #1
	ora #$10
	sta ADDR_H
	txa
	and #$FE
	sta ADDR_M
	stz charset_tmp
	stz charset_tmp+1
	ldy #0
	lda #<charset_data
	sta r0
	lda #>charset_data
	sta r0+1
@loop:
	lda (r0),y
	sta DATA0
	iny
	sty charset_tmp
	cmp #0
	bne @loop
	ldy charset_tmp+1
	iny
	cmp #>charset_data_end
	beq :+
	sty charset_tmp+1
	ldy r0+1
	iny
	sty r0+1
	stz r0
	ldy #0
	bra @loop
:	lda (r0),y
	sta DATA0
	iny
	sty charset_tmp
	cmp #<charset_data_end
	bne :-
	rts
charset_tmp:
	.res 2
charset_data:
	.incbin "font.bin"
charset_data_end:
	