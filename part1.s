@###############################################################
@
@    Sivalingam Periasamy - CS18M502
@    Char-Code - arm lab 4 - Part 1
@
@###############################################################
@ DATA SECTION
.data
Input:
	LENGTH:	.word 3
	START1: String1: .word 0x43 ,0x41, 0x54   @('C''A''T')
   @START2: String2: .word 0x42 ,0x41, 0x54   @('B''A''T')
   @START2: String2: .word 0x43 ,0x41, 0x54   @('C''A''T')
    START2: String2: .word 0x43 ,0x55, 0x54   @('C''U''T')
Output: 
	GREATER: .word 0x00000000

LDR R0, =LENGTH		@ R0 Address of LENGTH Variable
LDR R1, [R0]		@ R1 LENGTH of the input strings
LDR R2, =START1		@ R2 Address of String1	
LDR R3, =START2		@ R3 Address of String2
MOV R4, #0x00000000 @ R4 Initialize the result

LOOP:
	CMP R1, #0			@ Check if Char pending to compare
	BEQ EXIT			@ Exit if all Char compared
	LDR R5, [R2], #4 	@ Get one Char at a time of String1
	LDR R6, [R3], #4 	@ Get one Char at a time of String2
	SUB R1, #1			@ Update Length of remaining Char
	CMP R5, R6			@ Check if Chars GE and Loop
	BGE LOOP
	
SET_GREATER:
	MOV R4, #0xffffffff    @ R4 Update the result
	
EXIT:
	LDR R7, = GREATER      @ R5 Address of GREATER
	STR R4, [R7]           @ Store Result R4 in GREATER
