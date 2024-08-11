; TITLE Proy. Multiplicar_Usando_Solo_Los_Corrimientos                                      
.MODEL SMALL                               
.STACK 512                                 
                                           
.DATA                                                               
  x dw 0

.CODE
                                                                                 
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; clears the direction flag

    mov ax,15
    mov bx,2
    mov cx,5
    mov dx,7
    
    cmp dx,ax
    jg ThenM

    cmp bx,cx
    jg ifAnd
    jmp ElseM
    
    ifAnd:
        cmp bx,dx
        jg ThenM
        jmp ElseM
    ThenM:
        mov x,1
        jmp Finish
    ElseM:
        mov x,2
    Finish:   
    .EXIT
end Begin