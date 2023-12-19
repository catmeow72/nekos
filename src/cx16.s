; X16 hardware/software registers

;   .cpu "w65c02"

RAM_BANK        = $00
ROM_BANK        = $01

; 16-bit ABI registers
r0              = $02
r1              = $04
r2              = $06
r3              = $08
r4              = $0a
r5              = $0c
r6              = $0e
r7              = $10
r8              = $12
r9              = $14
r10             = $16
r11             = $18
r12             = $1a
r13             = $1c
r14             = $1e
r15             = $20

; 1st VIA
VIA0_PRB        = $9f00
VIA0_PRA        = $9f01
VIA0_DDRB       = $9f02
VIA0_DDRA       = $9f03
VIA0_T1L        = $9f04
VIA0_T1H        = $9f05
VIA0_T1LL       = $9f06
VIA0_T1LH       = $9f07
VIA0_T2L        = $9f08
VIA0_T2H        = $9f09
VIA0_SR         = $9f0a
VIA0_ACR        = $9f0b
VIA0_PCR        = $9f0c
VIA0_IFR        = $9f0d
VIA0_IER        = $9f0e
VIA0_PRA2       = $9f0f

; 2nd VIA
VIA1_PRB        = $9f10
VIA1_PRA        = $9f11
VIA1_DDRB       = $9f12
VIA1_DDRA       = $9f13
VIA1_T1L        = $9f14
VIA1_T1H        = $9f15
VIA1_T1LL       = $9f16
VIA1_T1LH       = $9f17
VIA1_T2L        = $9f18
VIA1_T2H        = $9f19
VIA1_SR         = $9f1a
VIA1_ACR        = $9f1b
VIA1_PCR        = $9f1c
VIA1_IFR        = $9f1d
VIA1_IER        = $9f1e
VIA1_PRA2       = $9f1f

; VERA
ADDR_L          = $9f20
ADDR_M          = $9f21
ADDR_H          = $9f22
DATA0           = $9f23
DATA1           = $9f24
CTRL            = $9f25
IEN             = $9f26
ISR             = $9f27
IRQLINE_L       = $9f28
DC_VIDEO        = $9f29
DC_HSCALE       = $9f2a
DC_VSCALE       = $9f2b
DC_BORDER       = $9f2c
DC_HSTART       = $9f29
DC_HSTOP        = $9f2a
DC_VSTART       = $9f2b
DC_VSTOP        = $9f2c
L0_CONFIG       = $9f2d
L0_MAPBASE      = $9f2e
L0_TILEBASE     = $9f2f
L0_HSCROLL_L    = $9f30
L0_HSCROLL_H    = $9f31
L0_VSCROLL_L    = $9f32
L0_VSCROLL_H    = $9f33
L1_CONFIG       = $9f34
L1_MAPBASE      = $9f35
L1_TILEBASE     = $9f36
L1_HSCROLL_L    = $9f37
L1_HSCROLL_H    = $9f38
L1_VSCROLL_L    = $9f39
L1_VSCROLL_H    = $9f3a
AUDIO_CTRL      = $9f3b
AUDIO_RATE      = $9f3c
AUDIO_DATA      = $9f3d
SPI_DATA        = $9f3e
SPI_CTRL        = $9f3f

; YM2151
OPM_ADDR        = $9f40
OPM_DATA        = $9f41

; Emulator interface (not exist on real HW)
EMU_DBG_EN      = $9fb0
EMU_LOG_VIDEO   = $9fb1
EMU_LOG_KBD     = $9fb2
EMU_ECHO_MODE   = $9fb3
EMU_SAVE_ON_EXIT= $9fb4
EMU_GIF_REC     = $9fb5
EMU_CPU_TICK    = $9fb8
EMU_KEYMAP      = $9fbd
EMU_16_STRING   = $9fbe

; VERA internal addresses
VERA_PSG_BASE   = $1f9c0
PSG_FREQ        = 0
PSG_VOL         = 2
PSG_WAVE        = 3
VERA_PAL_BASE   = $1fa00
VERA_OAM_BASE   = $1fc00
OAM_ADDR        = 0
OAM_XPOS        = 2
OAM_YPOS        = 4
OAM_ATTR        = 6
OAM_SIZE        = 7

; VERA bit names
; IEN
IRQLINE_256     = %10000000
; IEN/ISR
ISR_VBLANK      = %00000001
ISR_LINE        = %00000010
ISR_SPRCOLL     = %00000100
ISR_AFLOW       = %00001000
ISR_COLL_MASK   = %11110000

; VERA address steps
VRAM_STEP_DEC   = $08
VRAM_STEP_0     = $00
VRAM_STEP_1     = $10
VRAM_STEP_2     = $20
VRAM_STEP_4     = $30
VRAM_STEP_8     = $40
VRAM_STEP_16    = $50
VRAM_STEP_32    = $60
VRAM_STEP_64    = $70
VRAM_STEP_128   = $80
VRAM_STEP_256   = $90
VRAM_STEP_512   = $a0
VRAM_STEP_40    = $b0
VRAM_STEP_80    = $c0
VRAM_STEP_160   = $d0
VRAM_STEP_320   = $e0
VRAM_STEP_640   = $f0

; YM2151 internal addresses
OPM_TEST        = $01
OPM_KEYON       = $08
OPM_NOISE       = $0f
OPM_CLKA1       = $10
OPM_CLKA2       = $11
OPM_CLKB        = $12
OPM_TIMER       = $14
OPM_LFRQ        = $18
OPM_PMD_AMD     = $19
OPM_W_CT        = $1b
OPM_RL_FB_CON   = $20
OPM_KC          = $28
OPM_KF          = $30
OPM_PMS_AMS     = $38
OPM_DT1_MUL     = $40
OPM_TL          = $60
OPM_KS_AR       = $80
OPM_AME_D1R     = $a0
OPM_DT2_D2R     = $c0
OPM_D1L_RR      = $e0
