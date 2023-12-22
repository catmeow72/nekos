;.include "cx16.s"
gotoxy:
	stx pos_x ; Set position X
	sty pos_y ; Set position Y
	rts
incx:
	lda pos_x ; Load position X
	inc ; Increment it
	and #$7F ; Keep it within bounds
	sta pos_x ; Store it
	cmp #0 ; If it has overflowed the bounds, we'll need to increment position Y
	bne :+ ; Otherwise, we're done
	lda pos_y ; Load position Y
	inc ; Increment
	and #$3F ; Keep within bounds
	sta pos_y ; Store it
:	rts
newline:
	stz pos_x ; Zero out position X
	lda pos_y ; Load position Y
	inc ; Increment
	and #$3F ; Keep within bounds
	sta pos_y ; Store it
	rts
chrout:
	cmp #$0A ; Check for newline
	beq newline ; If it is newline, set position like it is
	tax ; Back up character
	stz pos_idx ; Zero out position index
	lda pos_y ; Load position Y
	and #$3F ; Keep Y within bounds
	sta pos_idx+1 ; Store position index high byte
	lda pos_x ; Load position X
	asl ; Shift left one to multiply by two, which also keeps it in bounds
	sta pos_idx ; Store it in the low byte of the address
	stz CTRL ; Select DATA0
	lda pos_idx ; Load address from pos_idx
	sta ADDR_L
	lda pos_idx+1
	sta ADDR_M
	lda #$10 ; Since the map base is at 0, we don't need to set the high address bit, so just set a 1 byte increment.
	sta ADDR_H
	txa ; Restore backed up character
	sta DATA0 ; Store the character in the VERA
	lda #%00010010 ; Load tile properties
	sta DATA0 ; Store them
	jmp incx ; Increment X and return
:	rts
strout:
	ldy #0 ; Load 0 in Y
:	lda (r0),y ; Load the character in the string
	cmp #0 ; Check if it's the NULL byte
	beq :+ ; If so, we're done.
	lda (r0),y ; Load the next character to check
	jsr chrout ; Write the character
	iny ; Increment Y for the next character
	bra :- ; Repeat the loop
:	rts