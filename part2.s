@###############################################################
@
@    Sivalingam Periasamy - CS18M502
@    Char-Code - arm lab 4 - Part 2
@
@###############################################################
@ DATA SECTION
.data
Input:
	STRING: .word 0x43 ,0x53, 0x36, 0x36, 0x32, 0x30 @('C''S''6''6''2''0')
   @SUBSTR: .word 0x43 ,0x53, 0x36   @('C''S''6')
   @SUBSTR: .word 0x36, 0x32, 0x30   @('6''2''0')      
    SUBSTR: .word 0x41 ,0x42, 0x41   @('A''B''A')
   @SUBSTR: .word 0x32
	End: .word 0x00
	
Output: 
	PRESENT: .word 0x00

LDR R0, =STRING		@ Address of STRING	
LDR R1, =SUBSTR		@ Address of SUBSTR
LDR R2, =End		@ Address of End
SUB R4, R1, R0		@ Length of STRING
SUB R5, R2, R1		@ Length of SUBSTR

CMP R4, R5			@ If STRING Length LT SUBSTR
BLT EXIT			@ Exit

RESET: 				@ Reset to restart the String match	
	MOV R3,#0		@ Initialize output to Zero
	MOV R8,#0		@ IF R8 EQ 0 THEN SET ELSE RESET
	MOV R2,R5		@ Copy of SUBSTR Length
	MOV R9,R1		@ Copy of SUBSTR Starting Address

SUBSTR_LOOP:
	CMP R2,#0			@ Check if SUBSTR Char pending to compare
	BEQ EXIT			@ Exit if all SUBSTR Char compared
	LDR R6,[R9],#4		@ Load Char of Substr
	SUB R2,R2,#4		@ Update Pending Char of SUBSTR
	
	STR_LOOP:
		CMP R4,#0			@ Check if STRING Char pending to compare
		BEQ EXIT			@ Exit if all STRING Char compared	
		LDR R7,[R0],#4		@ Load Char of STRING
		SUB R4,R4,#4		@ Update Pending Char of STRING
		CMP R6,R7 
		BNE RESET_CHK
		CMP R8,#0
		BEQ SET_FLAG
		B SUBSTR_LOOP
		
			SET_FLAG:
				SUB R3,R0,#4
				MOV R8,#1			@ Set to 1 to indicate it is continuous check
				B SUBSTR_LOOP			
			
			RESET_CHK:
				CMP R8,#1		@ Check if SUBSTR Started
				BNE STR_LOOP	@ If not keep looping String
				SUB R0,R0,#4	@ If Started then restart from first	
				B RESET
	
EXIT:
	LDR R7, = PRESENT      @ Address of PRESENT
	STR R3, [R7]           @ Store Result in PRESENT