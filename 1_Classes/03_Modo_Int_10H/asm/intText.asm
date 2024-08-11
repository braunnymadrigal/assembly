; TITLE Proy. Prints_Chars_TextMode                                          
.MODEL SMALL                               
.STACK 512                                 
                                           
.DATA                                                               
  chars db "123456"
  
.CODE
                                                                                 
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; clears the direction flag                                
    mov ax,0B800h  ; address of vga card for text mode             
    mov es,ax  ; register:  es:di                    
    mov di,0                     
    call Print  ; stores the characters to print in es:di                                                                  
    call Getch  ; calls the way in which the BIOS is invoke                                  
    .EXIT
                           
                                       
Getch PROC NEAR                        
    mov ah, 10h  ; Read expanded keyboard character                                           
    int 16h                       
    ret                                                                      
Getch ENDP                                
                                          
                                   
Print PROC                                                     
        mov ah, 03H  ; color              
        mov cx, 6                  
        mov si, 0                  
    Keep:                          
        mov al, chars[si]  ; character to store             
        stosw  ; Store AX = ah:al, at address ES:DI                   
        inc si                     
        loop Keep                  
        ret                        
Print ENDP
                           
end Begin 
      