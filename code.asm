DOSSEG
.model SMALL
.stack 100h
.data
  
CR db 13,10,'$'
MSG db 'GAME Instruction: Rock=1, Paper= 2, Scissors= 3, $', 0
PL1 db 'Player 1: $', 0
PL2 db 'Player 2: $', 0
PL1_Win db 'Player 1 is the winner! $', 0
PL2_Win db 'Player 2 is the winner! $', 0
PLEQ db 'Player 1 = Player 2 $', 0
.code

BEGIN: MOV AX, @data
MOV DS, AX
MOV ES, AX
  
MOV DX, OFFSET MSG ; Game Instruction
MOV AH, 09h
INT 21h
  
MOV DX, OFFSET CR ; print Carrier Return
MOV AH, 09h
INT 21h
  
MOV DX, OFFSET PL1 ; Prompt of player1
MOV AH, 09h
INT 21h
  
MOV AH,08 ; Function to read a char from keyboard (Input by Player1)
INT 21h ; the char saved in AL
MOV AH,02 ; Function to display a char
MOV BL,AL ; Copy a saved char in AL to BL
MOV DL,AL ; Copy AL to DL to output it
INT 21h
  
MOV DX, OFFSET CR ; print Carrier Return
MOV AH, 09h
INT 21h
  
MOV DX, OFFSET PL2 ; Prompt of player2
MOV AH, 09h
INT 21h
  
MOV AH,08 ; Function to read a char from keyboard (Input by Player2)
INT 21h ; the char saved in AL
MOV AH,02 ; Function to display a char
MOV BH,AL ; Copy a saved char in AL to BH
MOV DL,AL ; Copy AL to DL to output it
INT 21h

MOV DX, OFFSET CR ; print Carrier Return
MOV AH, 09h
INT 21h
  
CMP BL, BH
JE EQUAL
  
;=======================================
CMP BL, '1'
JE EQ1   
CMP BL, '2'
JE EQ2
CMP BL, '3'
JE EQ3
  
EQ1:
CMP BH, '2'
JE P2_Win   
CMP BH, '3'
JE P1_Win   

EQ2:
CMP BH, '1'
JE P1_Win   
CMP BH, '3'
JE P2_Win

EQ3:
CMP BH, '1'
JE P2_Win   
CMP BH, '2'
JE P1_Win

;=======================================

P1_Win: ;Player 1 is winner
MOV DX, OFFSET PL1_Win   
MOV AH, 09h
INT 21h
JMP Final
  
EQUAL: ;Player 1 == Player 2
MOV DX, OFFSET PLEQ   
MOV AH, 09h
INT 21h
JMP Final
  
P2_Win: ;Player 2 is winner
MOV DX, OFFSET PL2_Win   
MOV AH, 09h
INT 21h
JMP Final
;=======================================

Final:   
MOV AH,4Ch ; Function to exit
MOV AL,00 ; Return 00
INT 21h
  
end BEGIN
