; TITLE Proy. Aritmetica Coqueta                              
.MODEL SMALL                             
.STACK 512                                 
                                           
.DATA                                                               
  x dw 6
  y db 10
  cocient db 0
  residuo db 0
  
.CODE
                                                                                 
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; Aritmetica                            
    call AritCoq                                                                                                
    .EXIT
    
AritCoq PROC
    mov ax, x
    mov bx, 0
    mov bl, y
    
    div bl
    
    mov cocient, al
    mov residuo, ah
    
    mov cx, 00

    ret
AritCoq ENDP

end Begin
      