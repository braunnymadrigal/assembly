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
    interFilaTamanno equ 19  ; cantidad de filas en el array interf, se refiere a cuantas veces se hace el db
    teclaEscape equ 027  ; valor ascii de la tecla escape
    
    
    ; Botones fila 04; inicio columna 10, incrementa en + 5, termina en columna 32
    ; Botones fila 08; inicio columna 10, incrementa en + 5, termina en columna 32
    ; Botones fila 12; inicio columna 10, incrementa en + 5, termina en columna 32
    ; Boton AC fila 16; inicio columna 10, termina en columna 13,
    ; mini recuadro area escribible = fila 17, de columna 29 a 33
    
    
    ;;; variables
    clickIzq db 0
    mouseCol db 0  ; numero de columna en la que se encuentra el puntero del mouse
    mouseFil db 0  ; numero de fila en la que se encuentra el puntero del mouse
    ; esto esta en fila 1 columna 11, y de ahi hasta 21 caracteres
    ; AA/BB*CC/DD=EEEE/FFFF  ; 21 caracteres
    numA1 db 0
    numA2 db 0
    numB1 db 0
    numB2 db 1
    opera db ?
    numC1 db 0
    numC2 db 0
    numD1 db 0
    dumD2 db 1
    numE1 db 0
    numE2 db 0
    numE3 db 0
    numE4 db 0
    numF1 db 0
    numF2 db 0
    numF3 db 0
    numF4 db 1

    
.CODE                                      
                                           
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; limpiar la flag                                           
    call PrintA  ; llamar a la rutina PrintA
    call CleanReg
    call InitMouse
    ;call AuxTest
    MainLoop:
        call CleanReg
        call GetClick  ; obtener cordenadas y estado de botones del mouse
        call CleanReg
        call AuxTest
        call CleanReg
        call AskToKey
        cmp al, teclaEscape
        jne MainLoop  ; si la telca ESC no ha sido presionada seguimos usando la calcu
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

CleanReg PROC  ; limpia los registros
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0
    ret
CleanReg ENDP

InitMouse PROC  ; pone el mouse a trabajar
    mov ax, 00h  ; inicializa los valores del mouse a por defecto tambien sirve para checkear si hay o no mouse instalado
    int 33h
    mov ax, 01h  ; muestra el puntero
    int 33h
    ret
InitMouse ENDP

AskToKey PROC  ; verifica que tecla ha sido presionada en el teclado
    mov ah, 01h  ; obtiene el estado del buffer del teclado
    int 16h
    jz NotPress  ; salta si ninguna tecla ha sido presionada
    mov ah,00h  ; lee la tecla presionada
    int 16h
    NotPress:
        ret
AskToKey ENDP

AuxTest PROC  ; impime ciertas variables para usarlo como debugger casero
    mov dl, 29  ; columna 1
    mov dh, 17 ; fila 0
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
    
    mov bl, 05h  ; elegir color, bl = fondo:caracter
    mov cx, 1  ; cuantas veces toca imprimir
    mov al, mouseCol  ; elegir caracter
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h 
   
    ret
AuxTest ENDP

GetClick PROC  ; obtiene donde hace click el usuario
    mov clickIzq, 0  ; pone el click izq en 0
    
    mov ax, 0003h  ; retorna la posicion del puntero y el estado de los botones
    int 33h
    
    or clickIzq, bl  ; deja lo que sea que haya en bl en clickIzq
    
    shr cx, 3  ; cx = cx/8
    shr dx, 3  ; dx = dx/8
    mov mouseCol, cl  ; numero en modo texto de la columna
    mov mouseFil, dl  ; numero en modo texto de la fila
    
    ret
GetClick ENDP
                     
end Begin  ; termina el programa
