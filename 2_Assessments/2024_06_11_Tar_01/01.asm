; Autor : C24436  Braunny Madrigal Barrantes
; TITLE Proy. Calculadora Cuenta Pollos de Racionales
.model SMALL                               
.STACK 512                                 
     
                                      
.DATA
    ;;; interfaz
    ; cada linea en el array interf representa una linea a renderizar en pantalla, todos los valores son ASCII en decimal
    interf db 218,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,191 
           db 179,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,179
           db 192,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,217
           db 032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032
           db 218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032
           db 179,048,179,032,032,179,049,179,032,032,179,050,179,032,032,179,051,179,032,032,179,052,179,032,032
           db 192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032
           db 032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032
           db 218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032
           db 179,053,179,032,032,179,054,179,032,032,179,055,179,032,032,179,056,179,032,032,179,057,179,032,032
           db 192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032
           db 032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032
           db 218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032,218,196,191,032,032
           db 179,043,179,032,032,179,045,179,032,032,179,042,179,032,032,179,047,179,032,032,179,061,179,032,032
           db 192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032,192,196,217,032,032
           db 032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032,032
           db 218,196,196,191,032,032,032,032,032,032,032,032,032,032,032,032,032,032,218,196,196,196,196,196,191
           db 179,065,067,179,032,032,032,032,032,032,032,032,032,032,032,032,032,032,179,046,046,046,046,046,179
           db 192,196,196,217,032,032,032,032,032,032,032,032,032,032,032,032,032,032,192,196,196,196,196,196,217
    ;;; constantes
    coluIniGeneral equ 10  ; primera posicion de columna a ser manipulada
    coluFinGeneral equ 34  ; ultima posicion de columna a ser manipulada
    interFilaTamanno equ 19  ; cantidad de filas en el array interf, se refiere a cuantas veces se hace el db
    sumaPosiInt equ 1, 2, 3, 6, 7, 8, 11, 12, 13, 16, 17, 18, 21, 22, 23
    ;;; variables

   
.CODE                                      
                                           
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; limpiar la flag                                           
    call PrintA  ; llamar a la rutina PrintA                                                                 
    .EXIT

    
PrintA PROC  ; PrintA: Rutina que Imprime la interfaz de la calculadora
    mov al, 00h  ; definir tamano ventana (texto 40x25 16 colores)
    mov ah, 00h  ; modo 0 (elige resolucion)
    int 10h
    
    mov dl, 10  ; columna 1
    mov dh, 00 ; fila 0
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
    ; el registro dx debe quedar intacto
    
    mov si, 0  ; va a funcionar como indice del array <<interf>>
    mov di, 25  ; va a funcionar como limite para el indice
    PrintALoop:
        call PrintRows
        inc dh ; fila++
        cmp dh, interFilaTamanno   ; if fila < cantidad_de_filas en ventana
        mov dl, 10  ; columna 10
        jl PrintALoop

    ret                 
PrintA ENDP

PrintRows PROC
    LoopRows:
        mov ax, 00h  ; limpiar ax
        mov bx, 00h  ; limpiar bx
        
        ; inc dl  ; columna++ 
        mov bh, 0  ; pagina 0
        mov ah, 02h  ; modo 2 (manipula el puntero)
        int 10h
        
        mov bl, 02h  ; elegir color, bl = fondo:caracter
        mov cx, 1  ; cuantas veces toca imprimir
        mov al, interf[si]  ; elegir caracter
        mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
        int 10h  ; interrupcion 10h
        
        inc dl  ; columna++
        inc si  ; index++
        
        cmp si, di
        jl LoopRows  ; if si < sizeof(row)
    
    add di, 25  ; aumenta el valor maximo por el que <<si>> puede iterar 
    ret
PrintRows ENDP
                     
end Begin  ; termina el programa
