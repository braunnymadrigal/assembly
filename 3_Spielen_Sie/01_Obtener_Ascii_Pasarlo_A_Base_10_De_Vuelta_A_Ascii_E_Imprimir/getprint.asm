; TITLE Proy. Get_ASCII_Char_Convert_it_To_Decimal_And_Then_Again_To_ASCII_And PRINT IT                                         
.MODEL SMALL                               
.STACK 512                                 
                                           
.DATA                                                               
  charUser db 0

.CODE
                                                                                 
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; clears the direction flag                                
    call GetInput  ; stores the characters to print in es:di                                                                  
    call PrintInput  ; calls the way in which the BIOS is invoke                                  
    .EXIT
    
GetInput PROC
    mov ah, 00h  ; Read key press 
    int 16h
    ; al = ASCII character of the button pressed
    mov charUser, al
    sub charUser, 54  ; convert lowercase ascii code to decimal number
    ret
GetInput ENDP

PrintInput PROC
    mov ah, 00h  ; Set video mode
    mov al, 03h  ; Set window size(text 80x25 16 colors)
    int 10h
    mov ah, 02h  ; Set cursor position
    mov bh, 00h  ; Page Number
    mov dh, 00h  ; Row Number
    mov dl, 00h  ; Column Number
    int 10h
    mov ah, 09h  ; Write character and attribute at cursor position
    ; AL = Character, BH = Page Number, BL = Color, CX = Number of times to print character
    mov bl, 12h
    mov cx, 01h
    mov al, charUser
    add al, 54  ; convert decimal number to lowercase ascii code
    int 10h
    ret
PrintInput ENDP
 
end Begin 
      