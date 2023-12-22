	.include "abi.s"
jsrfar:
	phx
	phy
	pha
	php
	tsx
	lda $105,x
	sta jsrfar_addr_l
	clc
	adc #3
	sta $105,x
	lda $106,x
	sta jsrfar_addr_h
	adc #0
	sta $106,x
	ldy #1
	lda (jsrfar_addr),y
	sta jump_addr
	iny
	lda (jsrfar_addr),y
	sta jump_addr+1
	iny
	lda (jsrfar_addr),y
	sta jump_bank
	stz jsrfar_new_addr_l
	lda #$70
	sta jsrfar_new_addr_h
	ldy #0
	lda #<jsrfar_inner
	sta jsrfar_addr_l
	lda #>jsrfar_inner
	sta jsrfar_addr_h
_jsrfar_loop:
	pla
	lda (jsrfar_addr),y
	sta (jsrfar_new_addr),y
	iny
	cpy #jsrfar_inner_end-jsrfar_inner
	bne _jsrfar_loop
:	lda #<_after_jsrfar
	pha
	lda #>_after_jsrfar
	pha
	jmp (jsrfar_new_addr)
_after_jsrfar:
	plp
	pla
	ply
	plx
	rts
jsrfar_inner:
	pha
	lda jsrfar_addr_l
	clc
	adc #3
	sta jsrfar_addr_l
	lda jsrfar_addr_h
	adc #0
	sta jsrfar_addr_h
	lda jump_bank
	sta ROM_BANK
	pla
	sta jsrfar_new_addr
	lda #<_after_jsrfar_inner
	pha
	lda #>_after_jsrfar_inner
	pha
	lda jsrfar_new_addr
	jmp (jump_addr)
_after_jsrfar_inner:
	pha
	lda prev_bank
	sta ROM_BANK
	pla
	rts
jsrfar_inner_end: