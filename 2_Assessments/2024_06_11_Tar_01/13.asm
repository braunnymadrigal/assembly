; Autor : C24436  Braunny Madrigal Barrantes
; TITLE Proy. Calculadora Cuenta Pollos de Racionales
; solucionado lo del mouse: siempre responde si se hace click en donde aparece y despues se mueve
; solucionado lo de la impresion de numeros grandes
; falta anadirle soporte para numeros negativos y empezar documentar todo bien gucci
.model SMALL                               
.STACK 512                                 
     
                                      
.DATA
    ;;; interfaz
    ; cada linea en el array interf representa una linea a renderizar en pantalla, todos los valores son ASCII en decimal
    ; la primer linea que define interf se impimira en la fila 00
    ; el primer valor de una fila en interf, (el primer valor en un db), se imprime en la columna 11 y de alli aumenta la columna
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
    sumaOpAscii equ 43  ; valor ascii del operador suma
    restOpAscii equ 45  ; valor ascii del operador resta
    multOpAscii equ 42  ; valor ascii del operador de multiplicar
    diviOpAscii equ 47  ; valor ascii del operador de dividir
    iguaOpAscii equ 61  ; valor ascii del operador de igual
    ; mini recuadro area escribible = fila 17, de columna 29 a 33
    miniRecFilG equ 17  ; fila en la que se escribe en el mini rec
    miniRecColI equ 29  ; primer columna del mini rec
    miniRecColF equ 33  ; ultima columna del mini rec
    ; resultado
    sizeArrNumAscii equ 5  ; tamano del array rNumAscii
    
    ;;; variables
    ;; array con mensaje error
    mensajeError db 069,082,082,079,082  ; mensaje error que se escribe mini recuadro
    
    ;; MOUSE
    clickIzq db 0  ; funciona como booleano para determina si se ha presionado el click izq o no
    mouseCol db 0  ; numero de columna en la que se encuentra el puntero del mouse
    mouseFil db 0  ; numero de fila en la que se encuentra el puntero del mouse
    
    ;; DELAY
    seconds db 1  ; segundo para el delay
    
    ;; VENTANITA
    ; AA/BB*CC/DD=EEEE/FFFF  ; 21 caracteres ; esto esta en fila 1 columna 11, y de ahi hasta 21 caracteres
    auxB01 db 0  ; variable de 08 bits auxiliar
    auxB02 db 0  ; variable de 08 bits auxiliar
    auxW01 dw 0  ; variable de 16 bits auxiliar
    
    arrayVenta db 000,000,047,000,001,047,000,000,047,000,001,000  ; array de valores
    contaArray dw 0  ; saber en que parte del array toca insertar
    contaVenta db 11 ; saber en que parte de la ventana toca impirmir
    
    FilaSup db 004,004,004,004,004,008,008,008,008,008,012,012,012,012,012,016
    ColuIzq db 010,015,020,025,030,010,015,020,025,030,010,015,020,025,030,010
    FilaInf db 006,006,006,006,006,010,010,010,010,010,014,014,014,014,014,018
    ColuDer db 012,017,022,027,032,012,017,022,027,032,012,017,022,027,032,013
    Caracte db 048,049,050,051,052,053,054,055,056,057,043,045,042,047,061,111
    
    ;; ERROR
    varError db 0  ; funciona como booleano para saber si el usuario ingresa datos a la calcu (ventanita) de forma incorrecta
    
    ;; RESULTADOS
    ; AA/BB*CC/DD=EEEE/FFFF
    numA dw 0  ; este es el AA, considerando ambos digitos
    numB dw 0  ; este el el BB, considerando ambos digitos
    opeR dw 0  ; este es el * , o cualquier otro operador
    numC dw 0  ; este es el CC, considerando ambos digitos
    numD dw 0  ; este es el DD, considerando ambos digitos
    numE dw 0  ; este es el EEEE, considerando los 4 digitos
    numF dw 0  ; este es el FFFF, considerando los 4 digitos
    impY db 0  ; funciona como booleano para saber si ya se imprimio resultado
    arrNumAscii db 00,00,00,00,00  ; array con valores a imprimir de numero E o F en ASCII


    
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
        call CheckErr
        call CleanReg
        call CompFin  ; ver si toca computar el resultado
        call CleanReg
        mov auxB01, 0  ; limpiamos
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
            jmp NotClick        
    NotClick:
        ret
CheckClick ENDP

PrintChar PROC  ; impime un char especifico
    mov dl, contaVenta  ; columna contaVenta
    mov dh, 01 ; fila 1
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
    cmp auxB01, 111  ; preguntados si el boton clickeado fue un AC
    je callCleanVent  ; si es igual toca limpiar ventanita
    cmp contaArray, 12  ; verificamos que el usuario no supere la maxima cantidad de ops permitidas
    jge DoWhatRet
    call PrintChar
    inc contaVenta
    call StoreInA  ; llama para que guarda el char en x posi
    jmp DoWhatRet  ; salirnos
    callCleanVent:
        call CleanVent  ; toca limpiar ventanita
    DoWhatRet:
        ret
DoWhat ENDP

CleanVent PROC  ; limpia la ventanita y limpia todo en general para simular que la calcu se reinicio
    ; PRIMERO: hora de limpiar ventanita de caracteres
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
    
    ; SEGUNDO: hora de limpiar ventanita de errores
    mov dl, miniRecColI  ; primera columna del miniRec
    mov dh, miniRecFilG ; fila 17
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
        
    mov bl, 02h  ; elegir color, bl = fondo:caracter
    mov cx, 5  ; cuantas veces toca imprimir
    mov al, 046  ; caracter espacio en blanco
    mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
    int 10h  ; interrupcion 10h
        
    ; TERCERO: hora de limpiar variables utilizadas
    mov contaVenta, 11  ; otra vez se inicia en columna 11
    mov contaArray, 00  ; contaArray otra vez inicia en 00
    mov arrayVenta[00], 000
    mov arrayVenta[01], 000
    mov arrayVenta[02], 047
    mov arrayVenta[03], 000
    mov arrayVenta[04], 001
    mov arrayVenta[05], 047
    mov arrayVenta[06], 000
    mov arrayVenta[07], 000
    mov arrayVenta[08], 047
    mov arrayVenta[09], 000
    mov arrayVenta[10], 001
    mov arrayVenta[11], 000
    mov impY, 00  ; otra vez se marca que aun no se ha impreso nada

    ret
CleanVent ENDP

StoreInA PROC
    cmp contaArray, 00  ; if
    je callFirst
    cmp contaArray, 01  ; if
    je callSecon
    cmp contaArray, 02  ; if
    je callOpera
    cmp contaArray, 03  ; if
    je callFirst
    cmp contaArray, 04  ; if
    je callSecon
    cmp contaArray, 05  ; if
    je callOpera
    cmp contaArray, 06  ; if
    je callFirst
    cmp contaArray, 07  ; if
    je callSecon
    cmp contaArray, 08  ; if
    je callOpera
    cmp contaArray, 09  ; if
    je callFirst
    cmp contaArray, 10  ; if
    je callSecon
    cmp contaArray, 11  ; if
    je callOpera

    ; etiquetas
    callFirst:
        call FiNum
        jmp stoRet
    callSecon:
        call SeNum
        jmp stoRet
    callOpera:
        call OpNum  ; este no es un num, es el de operador
        jmp stoRet
    ;;;
    stoRet:
        ret
StoreInA ENDP

FiNum PROC
    ; convertir ascii a decimal
    sub auxB01, 48
    mov al, auxB01
    ; poner valor decimal en arrayVenta
    mov si, contaArray
    mov arrayVenta[si], al
    ; incrementar contArray y retornar
    inc contaArray
    ret
FiNum ENDP

SeNum PROC
    cmp auxB01, 47  ; if auxB01 mayor 47
    jg ifSeNum
    jmp elseSeNum

    ; etiquetas
    ifSeNum:
        cmp auxB01, 58  ; tengo que ser menor que 58 para ejecutar el if
        jge elseSeNum
        ; convertir ascii a decimal
        sub auxB01, 48
        mov al, auxB01
        ; poner valor decimal en arrayVenta
        mov si, contaArray
        mov arrayVenta[si], al
        ; incrementar contArray y retornar
        inc contaArray
        jmp retSeNum 
        
    elseSeNum:
        mov si, contaArray  ; contador para el array
        dec si  ; --si
        mov ah, arrayVenta[si]  ; ah nos va a servir como variable auxiliar
        ; ponemos contaArray - 1 en 0
        mov arrayVenta[si], 00  ; ponemos esa posi en 00
        inc si  ; ++si
        ; ponemos contaArray en ah, osea lo que habia en el array en la posi anterior
        mov arrayVenta[si], ah
        inc si  ; ++si
        mov al, auxB01
        ; ponemos en contaArray + 1 el ascii del operador que nos hayan mandado
        mov arrayVenta[si], al
        add contaArray, 2  ; se modifico la actual y la siguiente y por ende toca incrementar en 2
        jmp retSeNum
        
    retSeNum:
        ret
SeNum ENDP

OpNum PROC
    mov al, auxB01
    ; poner valor ascii del operador en arrayVenta
    mov si, contaArray
    mov arrayVenta[si], al
    ; incrementar contArray y retornar
    inc contaArray
    ret
OpNum ENDP

CheckErr PROC
    mov varError, 0  ; reinicia la varError a 0
    cmp arrayVenta[0], 9  ; if arrayVenta[0] > 9
    jg callPrintErr
    cmp arrayVenta[1], 9  ; if arrayVenta[1] > 9
    jg callPrintErr
    cmp arrayVenta[2], diviOpAscii  ; if arrayVenta[2] != diviOpAscii
    jne callPrintErr
    cmp arrayVenta[3], 9  ; if arrayVenta[3] > 9
    jg callPrintErr
    cmp arrayVenta[4], 9 ; if arrayVenta[4] > 9
    jg callPrintErr
    cmp arrayVenta[5], multOpAscii  ; if arrayVenta[5] < multOpAscii
    jl callPrintErr
    cmp arrayVenta[5], diviOpAscii  ; if arrayVenta[5] > diviOpAscii
    jg callPrintErr
    cmp arrayVenta[6], 9  ; if arrayVenta[6] > 9
    jg callPrintErr
    cmp arrayVenta[7], 9  ; if arrayVenta[7] > 9
    jg callPrintErr
    cmp arrayVenta[8], diviOpAscii  ; if arrayVenta[8] != diviOpAscii
    jne callPrintErr
    cmp arrayVenta[9], 9  ; if arrayVenta[9] > 9
    jg callPrintErr
    cmp arrayVenta[10], 9  ; if arrayVenta[10] > 9
    jg callPrintErr
    mov al, arrayVenta[4]  ; registro que va a servir para verificar si segundo Num es menor que 1
    add al, arrayVenta[3]  ; al = arrayVenta[3] + arrayVenta[4]
    cmp al, 1  ; if al < 1
    jl callPrintErr
    mov al, arrayVenta[10]  ; registro que va a servir para verificar si segundo Num es menor que 1
    add al, arrayVenta[9]  ; al = arrayVenta[9] + arrayVenta[10]
    cmp al, 1  ; if al < 1
    jl callPrintErr
    cmp arrayVenta[11], 0  ; if arrayVenta[11] > 0
    jg ifIgualOp
    jmp retCheckErr

    ; etiquetas
    ifIgualOp:
        cmp arrayVenta[11], iguaOpAscii  ; if arrayVenta[11] != iguaOpAscii
        jne callPrintErr
        jmp retCheckErr

    callPrintErr:
        mov varError, 1  ; marcar que si hay error
        call PrintErr  ; imprimir palabra error en ventana
        jmp retCheckErr
    retCheckErr:
        ret
CheckErr ENDP

PrintErr PROC
    mov si, 0  ; funciona como indice del array mensajeError
    mov bh, 0  ; pagina 0
    mov dl, miniRecColI  ; columna miniRecColI
    mov dh, miniRecFilG  ; fila miniRecFilG
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h  ; interrupcion 10h
    
    LoopPrintErr:
        mov bl, 05h  ; elegir color, bl = fondo:caracter
        mov cx, 01  ; cuantas veces toca imprimir
        mov al, mensajeError[si]  ; caracter espacio en blanco
        mov ah, 09h  ; modo 9 (imprime un caracter n veces en un puntero definido)
        int 10h  ; interrupcion 10h
        
        inc si  ; incrementa el indice
        inc dl  ; incrementa la columna
        mov ah, 02h  ; modo 2 (manipula el puntero)
        int 10h  ; interrupcion 10h
        
        cmp si, 05  ; if si < 5
        jl LoopPrintErr

    retPrintErr:
        ret
PrintErr ENDP

CompFin PROC  ; manda a computar si no hay error y el usuario digito el =
    cmp impY, 1  ; if impY == 1
    je retComp
    cmp varError, 0  ; if varError == 0
    je ifComp
    jmp retComp
    
    ; etiquetas
    ifComp:
       cmp arrayVenta[11], iguaOpAscii  ; if arrayVenta[11] != iguaOpAscii
       jne retComp
       ; dejar listo a numA
       mov ax, 00  ; limpiar el registro
       mov al, arrayVenta[0]
       mov bx, 10  ; multiplicando
       mul bx  ; ax = arrayVenta[0]*10
       mov cx, 00  ; limpiar el registro
       mov cl, arrayVenta[1]
       add ax, cx  ; ax = arrayVenta[1] + ax
       mov numA, ax  ; numA = (arrayVenta[0]*10 + arrayVenta[1])
       ; dejar listo a numB
       mov ax, 00  ; limpiar el registro
       mov al, arrayVenta[3]
       mov bx, 10  ; multiplicando
       mul bx  ; ax = arrayVenta[3]*10
       mov cx, 00  ; limpiar el registro
       mov cl, arrayVenta[4]
       add ax, cx  ; ax = arrayVenta[4] + ax
       mov numB, ax  ; numB = (arrayVenta[3]*10 + arrayVenta[4])
       ; dejar listo a opeR
       mov ax, 00  ; limpiar el registro
       mov al, arrayVenta[5]
       mov opeR, ax  ; opeR = arrayVenta[5]
       ; dejar listo a numC
       mov ax, 00  ; limpiar el registro
       mov al, arrayVenta[6]
       mov bx, 10  ; multiplicando
       mul bx  ; ax = arrayVenta[6]*10
       mov cx, 00  ; limpiar el registro
       mov cl, arrayVenta[7]
       add ax, cx  ; ax = arrayVenta[7] + ax
       mov numC, ax  ; numC = (arrayVenta[6]*10 + arrayVenta[7])
       ; dejar listo a numD
       mov ax, 00  ; limpiar el registro
       mov al, arrayVenta[9]
       mov bx, 10  ; multiplicando
       mul bx  ; ax = arrayVenta[9]*10
       mov cx, 00  ; limpiar el registro
       mov cl, arrayVenta[10]
       add ax, cx  ; ax = arrayVenta[10] + ax
       mov numD, ax  ; numD = (arrayVenta[9]*10 + arrayVenta[10])       
       
       ; llamar a hacer el calculo de EEEE/FFFF
       call ExeOper
       ; llamar a imprimir EEEE/FFFF
       call PrintRes

    retComp:
        ret
CompFin ENDP

ExeOper PROC  ; ejecuta la operacion que este en opeR
    mov numE, 00  ; limpia numE
    mov numF, 00  ; limpia numF
    
    cmp opeR, sumaOpAscii  ; if opeR == sumaOpAscii
    je sumaEx
    cmp opeR, restOpAscii  ; if opeR == restOpAscii
    je restEx
    cmp opeR, multOpAscii  ; if opeR == multOpAscii
    je multEx
    cmp opeR, diviOpAscii  ; if opeR == diviOpAscii
    je diviEx
    jmp retExeOper  ; esto no deberia de ser necesario pero se realiza para seguir buenas practicas

    ; etiquetas
    call CleanReg  ; limpiamos registros
    sumaEx:
        ; numerador
        mov ax, numD
        mul numA  ; ax = numA * numD
        mov si, ax  ; si = numA * numD
        mov ax, numB
        mul numC  ; ax = numC * numB
        mov di, ax  ; di = numC * numB
        add numE, si  ; numE += (numA * numD)
        add numE, di  ; numE = (numA * numD) + (numC * numB)
        ; denominador
        mov ax, numD
        mul numB  ; ax = numB * numD
        mov numF, ax  ; numF = numB * numD
        ; jump ret
        jmp retExeOper
    restEx:
        ; numerador
        mov ax, numD
        mul numA  ; ax = numA * numD
        mov si, ax  ; si = numA * numD
        mov ax, numB
        mul numC  ; ax = numC * numB
        mov di, ax  ; di = numC * numB
        add numE, si  ; numE += (numA * numD)
        sub numE, di  ; numE = (numA * numD) - (numC * numB)
        ; denominador
        mov ax, numD
        mul numB  ; ax = numB * numD
        mov numF, ax  ; numF = numB * numD
        ; jump ret
        jmp retExeOper
    multEx:
        ; numerador
        mov ax, numC
        mul numA  ; ax = numA * numC
        mov numE, ax  ; numE = numA * numC
        ; denominador
        mov ax, numD
        mul numB  ; ax = numB * numD
        mov numF, ax  ; numF = numB * numD
        ; jump ret
        jmp retExeOper
    diviEx:
        ; numerador
        mov ax, numD
        mul numA  ; ax = numA * numD
        mov numE, ax  ; numE = numA * numD
        ; denominador
        mov ax, numC
        mul numB  ; ax = numB * numC
        mov numF, ax  ; numF = numB * numC
        ; jump ret
        jmp retExeOper

    retExeOper:
        ret
ExeOper ENDP

PrintRes PROC
    ; para numE
    mov ax, numE  ; registro usado ya que no se puede pasar directamente de var a var
    mov auxW01, ax  ; ahora si, auxW01 = numE
    call SelChResPr  ; hora de imprimir numE
    call CleanArrNAsc  ; limpia el array
    
    ; hora de imprimir el slash
    mov auxB01, diviOpAscii  ; ponemos en auxB01 el valor a imprimir
    call PrintChar  ; llamamos al metodo que imprime
    inc contaVenta  ; incrementos la columna en la que se imprime en ventanita    
    
    ; para numF
    mov ax, numF  ; registro usado ya que no se puede pasar directamente de var a var
    mov auxW01, ax  ; ahora si, auxW01 = numF
    call SelChResPr  ; hora de imprimir numF
    call CleanArrNAsc  ; limpia el array
      
    ; marcar que ya se imprimio y retornar
    mov impY, 01  ; marca que ya se imprimio
    ret
PrintRes ENDP

SelChResPr PROC ; selecciona caracter a imprimir del resultado, osea imprimir auxW01
    mov si, 00
    ; guardar residuos en el arreglo
    LoopSaveChPr: ; pequenno bucle para guardar los valores de auxW01 a imprimir en arrNumAscii
        mov dx, 00    ; dividendo high
        mov ax, auxW01  ; dividendo low
        mov cx, 10
        div cx  ; ax = cociente de (auxW01/10),  dx = residuo de (auxW01/10)
        add dx, 48  ; convierte el residuo a su car?cter ASCII
        mov arrNumAscii[si], dl  ; guardar residuo convertido a car?cter ASCII
        mov auxW01, ax  ; gracias a la division anterior, auxW01 = auxW01 / 10, guardamos ese cociente aqui
        inc si  ; disminuye el ?ndice de arrNumAscii
        cmp si, sizeArrNumAscii  ; if auxW01 < sizeArrNumAscii
        jl LoopSaveChPr
        
    mov si, sizeArrNumAscii  ; si = 5
    dec si  ; disminuye en 1 para tener un indice valido
    mov di, 00  ; usamos otro indice, ya que es mas facil contar de menos a mas
    
    ; imprime posiciones del arreglo
    LoopPrintChPr:
        mov ah, arrNumAscii[si]  ; usamos el arreglo como mediador
        mov auxB01, ah  ; tenemos el valor a imprimir
        call PrintChar  ; imprime el caracter en auxB01
        inc contaVenta  ; ++contaVente
        dec si  ; --si, osea que en proxima iteracion se imprime el indice actual de array - 1
        inc di  ; ++di
        cmp di, sizeArrNumAscii  ; if di < sizeArrNumAscii
        jl LoopPrintChPr

    ; time to return
    ret
SelChResPr ENDP

CleanArrNAsc PROC  ; limpia el arrayNumAscii
    mov si, 00  ; pone iterador en 0
    LoopClArrNAsc:
        mov arrNumAscii[si], 00
        inc si  ; ++si
        cmp si, sizeArrNumAscii  ; if si < sizeArrNumAscii
        jl LoopClArrNAsc
    retClArrNAsc:
        ret
CleanArrNAsc ENDP
                  
end Begin  ; termina el programa
