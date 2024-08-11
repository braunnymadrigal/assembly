; Autor : C24436  braunny
; TITLE Proy. Dibujar diagonal de caracteres 
.model SMALL                               
.STACK 512                                 
    
                                       
.DATA                                                               
  car DB "*"  ; definir caracter
  numloops EQU 20  ; constante que expresa cuantas veces deseamos iterar por el loop

  
.CODE                                      
                                           
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; clears flag                                
    mov ax, 0B800h  ; direccion de la tarjeta VGA para el modo texto             
    mov es, ax  ; parte de un registro completo = es:di                     
    mov di, 0  ; posicion del puntero            
    call Print  ; llama a la rutina Print                                   
    call Getch  ; llama a la rutina Getch                                  
    .EXIT
                           
                                          
Getch PROC NEAR                        
    mov ah, 10h  ; leer caracter del teclado expandido                                            
    int 16h  ; interrupcion 16h                      
    ret                                                                    
Getch ENDP                                
                                          
                                   
Print PROC                     
    mov ah, 0Fh  ; ah = color = fondo:caracter          
    mov cx, numloops  ; condicion de parada, cuantas veces se itera            
    mov si, 0  ; indice o contador                 
    Store_Chars:                          
        mov al, car  ;  ax == ah:al, mueve el caracter especifico a al            
        stosw  ; guarda ax en la direccion es:di                      
        inc si  ; incrementa el indice o contador
        add di,162  ; cambia la posicion del siguiente caracter
        loop Store_Chars                  
        ret                        
Print ENDP
                           
end Begin  ; termina ejecucion
