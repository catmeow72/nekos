;.include "cx16.s"
load_charset:
	lda #$80 ; Set layer 1's tile pointer to $10000
	sta L1_TILEBASE
	stz L1_MAPBASE ; Set layer 1's map pointer to 0
	lda #%01100000 ; Set layer 1 to 64x128 tile mode
	sta L1_CONFIG
	stz L1_HSCROLL_L ; Zero out scroll
	stz L1_HSCROLL_H
	stz L1_VSCROLL_L
	stz L1_HSCROLL_H
	stz CTRL ; Select DATA0
	stz ADDR_L ; Set address to $10000
	stz ADDR_M
	lda #$11 ; Set 1 byte increment
	sta ADDR_H
	stz tmp ; Zero out temporary variables
	stz tmp+1
	lda #<charset_data ; Copy charset_data pointer to r0
	sta r0
	lda #>charset_data
	sta r0+1
	ldx #0 ; Prepare to copy charset
	ldy #0
charset_loop:
	lda (r0),y ; Load charset data
	sta DATA0 ; and copy it to VERA
	iny ; Increment Y
	cpy #0 ; If Y has overflowed, move on to the next check
	bne charset_loop ; Otherwise, repeat the loop
	ldy #0 ; Reset Y
	inx ; Increment X for high byte of index
	lda r0+1 ; Increment r0 high byte so we load the right data
	inc
	sta r0+1
	cpx #>charset_data_end ; If we're at the last 256 bytes, it's time to copy the last page
	bne charset_loop ; Otherwise, go back into the loop.
	ldy #0 ; Prepare to copy the last page
charset_loop_last_page:
	cpy #<charset_data_end ; Check if we're done yet.
	beq :+ ; If so, branch to the end
	lda (r0),y ; Otherwise, load charset data
	sta DATA0 ; and store it in the VERA
	iny ; Increment Y
	bra charset_loop_last_page ; repeat loop, which will branch to the end if we're done.
:	rts
charset_data:
	.incbin "font.bin",0
charset_data_end:
	