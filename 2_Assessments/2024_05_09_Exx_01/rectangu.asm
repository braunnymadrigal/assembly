; Autor : C24436  braunny
; TITLE Proy. Dibujar_Rectangulo_Texto
.model SMALL                               
.STACK 512                                 
     
                                      
.DATA                                                               
    esqsupizq EQU 218  ; caracter esquina superior izquierda
    esqsupder EQU 191  ; caracter esquina superior derecha
    esqinfizq EQU 192  ; caracter esquina inferior izquierda
    esqinfder EQU 217  ; caracter esquina inferior derecha
    barraver EQU 179  ; caracter barra vertical
    barrahor EQU 196  ; caracter barra horizontal
    espacio EQU 20h  ; caracter espacio en blanco
    numlineashor EQU 21  ; numero de lineas horizontales de relleno
    pricar DB 0  ;  define el primer caracter a imprimir dentro del metodo Print_Row
    segcar DB 0  ; define el segundo caracter a imprimir dentro del metodo Print_Row
    tercar DB 0  ; define el tercer caracter a imprimir dentro del metodo Print_Row

    
.CODE                                      
                                           
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; limpiar la flag                                           
    call Print  ; llamar a la rutina Print                                                                  
    .EXIT

    
Print PROC                                                    
    mov al, 03h  ; definir tamano ventana (texto 80x25 16 colores)
    mov ah, 00h  ; modo 0 (elige resolucion)
    int 10h
    
    mov dl, 0  ; columna 1 
    mov dh, 0 ; fila 1
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
    
    mov bl, 42h  ; elegir color, bl = fondo:caracter
    
    ; definir caracteres para la fila superior
    mov pricar, esqsupizq  ; define el primer caracter
    mov segcar, barrahor  ; define el segundo caracter
    mov tercar, esqsupder  ; define el tercer caracter
    ; invoca la rutina
    call Print_Row
    
    ; definir caracteres para las filas de relleno
    mov pricar, barraver  ; define el primer caracter
    mov segcar, espacio  ; define el segundo caracter
    mov tercar, barraver  ; define el tercer caracter
    ; invoca la rutina
    call Print_Row
    call Print_Row
    call Print_Row
  
    ; definir caracteres para la fila inferor
    mov pricar, esqinfizq  ; define el primer caracter
    mov segcar, barrahor  ; define el segundo caracter
    mov tercar, esqinfder  ; define el tercer caracter
    ; invoca la rutina
    call Print_Row

    ret                 
Print ENDP


Print_Row PROC
    mov dl, 1  ; elige columna 1
    inc dh  ; incrementa la fila
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h  ; interrupcion 10h

    mov cx, 1  ; cuantas veces toca imprimir
    mov al, pricar  ; elegir caracter
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h
    
    inc dl  ; suma 1 a la columna
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h  ; interrupcion 10h
        
    mov cx, numlineashor ; cuantas veces toca imprimir
    mov al, segcar  ; elegir caracter
    mov ah,09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h
    
    add dl, numlineashor  ; suma el numero de lineas horizontales a la columna
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h  ; interrupcion 10h
    
    mov cx,1  ; cuantas veces toca imprimir
    mov al, tercar  ; elegir caracter
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h

    ret
Print_Row ENDP

                        
end Begin  ; termina el programa
       