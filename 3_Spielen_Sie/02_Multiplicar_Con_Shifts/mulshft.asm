; TITLE Proy. Multiplicar_Usando_Solo_Los_Corrimientos                                      
.MODEL SMALL                               
.STACK 512                                 
                                           
.DATA                                                               
  number dw 0

.CODE
                                                                                 
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; clears the direction flag                                
    call Mult                                                                                                
    .EXIT
    
Mult PROC
    ; multiplicar ax por 18
    ; 18 = 2^4 + 2^1
    mov ax, 7
    mov bx, ax
    shl ax, 1
    shl bx, 4
    add ax, bx
    mov number, ax
    ret
Mult ENDP

end Begin
      