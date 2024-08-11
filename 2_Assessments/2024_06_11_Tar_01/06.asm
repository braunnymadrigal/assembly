; Autor : C24436  Braunny Madrigal Barrantes
; TITLE Proy. Calculadora Cuenta Pollos de Racionales
; Ya tengo el CleanVent y el PrintChar fully operational letsgoooo
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
    
    ; mini recuadro area escribible = fila 17, de columna 29 a 33
    
    
    ;;; variables
    ;; MOUSE
    clickIzq db 0
    mouseCol db 0  ; numero de columna en la que se encuentra el puntero del mouse
    mouseFil db 0  ; numero de fila en la que se encuentra el puntero del mouse
    ;; MOUSE
    
    ;; VENTANITA
    seconds db 1
    
    ; AA/BB*CC/DD=EEEE/FFFF  ; 21 caracteres ; esto esta en fila 1 columna 11, y de ahi hasta 21 caracteres
    auxB01 db 0  ;
    auxB02 db 0  ; variables de 8 bits auxiliares
    
    valorVenta db 000,000,000,000,001,000,000,000,000,000,001,000  ; array de valores
    contaArray db 0  ; saber en que parte del array toca insertar
    contaVenta db 11 ; saber en que parte de la ventana toca impirmir
    
    FilaSup db 004,004,004,004,004,008,008,008,008,008,012,012,012,012,012,016
    ColuIzq db 010,015,020,025,030,010,015,020,025,030,010,015,020,025,030,010
    FilaInf db 006,006,006,006,006,010,010,010,010,010,014,014,014,014,014,018
    ColuDer db 012,017,022,027,032,012,017,022,027,032,012,017,022,027,032,013 
    Caracte db 048,049,050,051,052,053,054,055,056,057,043,045,042,047,061,111

    
.CODE                                      
                                           
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; limpiar la flag                                           
    call PrintA  ; llamar a la rutina PrintA
    call CleanReg
    call InitMouse
    MainLoop:
        call CleanReg
        call Delay  ; funcion de delay, ella obliga a que el click se mantenga presionado en el boton si el usuario desea que este sea registrado
        call CleanReg
        call GetClick  ; obtener cordenadas y estado de botones del mouse
        call CleanReg
        call CheckClick  ; ver si hubo click y guardar respectivo ASCII en auxB01
        call CleanReg
        call DoWhat
        mov auxB01, 0
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

CheckClick PROC  ; ver si hubo click y poner ascii y valor en sus respectivas variables
    cmp clickIzq, 01
    jne NotClick
    mov si, 00  ; poner iterador en 0
    LoopBox:  ; la idea es hacerle loop para ver si el click se dio en alguna de las 16 cajas
        mov al, FilaSup[si]  ; ver valor numero si del array FilaSup
        mov ah, FilaInf[si]
        mov bl, ColuIzq[si]
        mov bh, ColuDer[si]

        cmp al, mouseFil
        jnl AskLoop  ; if (FilaSup esta abajo de mouseFil)
        cmp ah, mouseFil
        jng AskLoop
        cmp bl, mouseCol
        jnl AskLoop
        cmp bh, mouseCol
        jng AskLoop
        
        mov cl, Caracte[si]
        mov auxB01, cl
        jmp NotClick
        
        AskLoop:
            inc si  ; ++si
            cmp si, 16
            jl LoopBox
    NotClick:
        ret
CheckClick ENDP

PrintChar PROC  ; impime un char especifico
    mov dl, contaVenta  ; columna contaVenta
    mov dh, 01 ; fila 0
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
        
    mov bl, 05h  ; elegir color, bl = fondo:caracter
    mov cx, 1  ; cuantas veces toca imprimir
    mov al, auxB01  ; elegir caracter
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h
    
    ;inc contaVenta  ; nuevo lugar en contaVenta
    PrintChRet:
        ret
PrintChar ENDP

Delay PROC  
    delaying:   
    ;GET SYSTEM TIME.
      mov  ah, 2ch
      int  21h      ; RETURN SECONDS IN DH.
      ;CHECK IF ONE SECOND HAS PASSED. 
      cmp  dh, seconds  ; IF SECONDS ARE THE SAME...
      je   delaying     ;    ...WE ARE STILL IN THE SAME SECONDS.
      mov  seconds, dh  ; SECONDS CHANGED. PRESERVE NEW SECONDS.
      ret
Delay ENDP

DoWhat PROC
    cmp auxB01, 0  ; queremos ver si hubo un boton clickeado
    je DoWhatRet
    cmp contaArray, 12  ; verificamos que el usuario no supere la maxima cantidad de ops permitidas
    jge DoWhatRet
    cmp auxB01, 111  ; preguntados si el boton clickeado fue un AC
    je callCleanVent  ; si es igual toca limpiar ventanita
    call PrintChar
    inc contaVenta
    ; call StoreInA  ; llama para que guarda el char en x posi
    jmp DoWhatRet  ; salirnos
    callCleanVent:
        call CleanVent  ; toca limpiar ventanita
    DoWhatRet:
        ret
DoWhat ENDP

CleanVent PROC  ; limpia la ventanita y limpia todo en general para simular que la calcu se reinicio
    mov dl, 11  ; columna 11
    mov dh, 01 ; fila 0
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
        
    mov bl, 05h  ; elegir color, bl = fondo:caracter
    mov cx, 23  ; cuantas veces toca imprimir
    mov al, 032  ; caracter espacio en blanco
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h
    
    mov contaVenta, 11  ; otra vez se inicia en columna 11

    ret
CleanVent ENDP
                     
end Begin  ; termina el programa
