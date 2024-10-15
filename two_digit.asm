ORG 100h

MOV DX, OFFSET msg_input  
MOV AH, 09h        
INT 21h            

MOV AH, 01h        
INT 21h            
MOV BL, AL         

CMP AL, '0'        
JL NotDigit        
CMP AL, '9'        
JG NotDigit        


SUB BL, '0'        

MOV AH, 01h        
INT 21h            
MOV BH, AL         


CMP AL, '0'        
JL NotDigit        
CMP AL, '9'        
JG NotDigit        


SUB BH, '0'        

SUB BL, BH         


MOV DX, OFFSET msg_output  
MOV AH, 09h        
INT 21h            


JNC PositiveResult  ; Jump if no carry (result is positive)
NEG BL              ; If result is negative, negate it to make it positive
MOV DL, '-'         ; Display '-' sign
MOV AH, 02h        
INT 21h            

PositiveResult:

ADD BL, '0'        

MOV DL, BL         
MOV AH, 02h        
INT 21h            

JMP EndProgram     

NotDigit:
MOV DX, OFFSET msg_error  
MOV AH, 09h        
INT 21h            

EndProgram:
MOV AH, 4Ch        
INT 21h            

msg_input  DB 'Enter two digits: $'
msg_output DB 0Dh, 0Ah, 'The subtraction result is: $'  
msg_error  DB 0Dh, 0Ah, 'Error: One or both inputs are not digits! $'  

END