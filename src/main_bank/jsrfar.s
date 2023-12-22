	.include "abi.s"
jsrfar:
	pha ; Push registers
	phx
	phy
	php ; ... including processor flags
	tsx ; Copy stack pointer to X
	lda $105,x ; Stack starts at $100, and grows downward. $105 offsets it by 5
	sta jsrfar_addr_l ; Store in the low byte of the address pointer
	clc 
	adc #3 ; Add 3 for the return value, since we'll need to skip the parameters
	sta $105,x ; Store in the low byte of the return address
	lda $106,x ; Load the high byte of the return address. Again, $106 offsets the stack, but this time, by 6
	sta jsrfar_addr_h ; Store in the high byte of the address pointer
	adc #0 ; Add any carry necessary for the high byte.
	sta $106,x ; Store in the high byte of the return address.
	ldy #1 ; Start at byte 1 after the instruction
	lda (jsrfar_addr),y ; Load the low byte of the jump address parameter
	sta jump_addr ; Store it in the jump address variable that's outside of ROM/HIRAM.
	iny ; Increment Y for the next byte.
	lda (jsrfar_addr),y ; Load the high byte of the jump address parameter
	sta jump_addr+1 ; Store the high byte in the jump address variable.
	iny ; Increment Y for the next byte, which is the bank parameter
	lda (jsrfar_addr),y ; Load the bank parameter
	sta jump_bank ; Store it in the jump bank variable
	stz jsrfar_new_addr_l ; Load $7000 into jsrfar_new_addr, which is in ZP. Low byte is $00
	lda #$70 ; High byte for $7000 is $70
	sta jsrfar_new_addr_h ; Store the high byte
	lda #<jsrfar_inner ; Load the low byte of the inner address
	sta jsrfar_addr_l ; Store it in a ZP variable
	lda #>jsrfar_inner ; Load the high byte of the inner address
	sta jsrfar_addr_h ; Store it in the high byte of the same ZP variable
_jsrfar_loop:
	lda (jsrfar_addr),y
	sta (jsrfar_new_addr),y
	iny
	cpy #jsrfar_inner_end-jsrfar_inner
	bne _jsrfar_loop
	plp ; Restore registers in preparation for routine we're jumping to
	ply
	plx
	sta jsrfar_addr_l ; Use jarfar_addr as temporary storage.
	pla
	sta jsrfar_addr_h
:	lda #<_after_jsrfar ; Push _after_jsrfar so that rts goes there.
	pha
	lda #>_after_jsrfar
	pha
	ldx jsrfar_addr_l
	lda jsrfar_addr_h
	jmp (jsrfar_new_addr) ; Now that _after_jsrfar has been pushed, indirect jmp will act like jsr.
_after_jsrfar:
	rts
jsrfar_inner:
	sta jsrfar_addr_l ; Again, use jsrfar_addr_l as temporary storage, to back up A
	lda ROM_BANK ; Load current bank
	sta prev_bank ; Store it so we know what bank to switch back to.
	lda jump_bank ; Load jump bank
	sta ROM_BANK ; Store it to set bank
	lda #<_after_jsrfar_inner ; Push _after_jsrfar_inner so that rts will go there
	pha
	lda #>_after_jsrfar_inner
	pha
	lda jsrfar_addr_l ; Restore A for routine
	jmp (jump_addr) ; indirect jmp that will act like jsr
_after_jsrfar_inner:
	pha ; Back up A. No need for temporary variable since a push won't be used before the next pla for the backup
	lda prev_bank ; Load the bank backup
	sta ROM_BANK ; Restore it with the backup
	pla ; Retore A
	rts ; This RTS will go to the outer subroutine.
jsrfar_inner_end: