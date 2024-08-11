; Autor : C24436  Braunny Madrigal Barrantes
; TITLE Proy. Calculadora Cuenta Pollos de Racionales
; 
; UNIVERSIDAD DE COSTA RICA
; CI-0118 Lenguaje Ensamblador
; ESCUELA DE CIENCIAS DE LA COMPUTACI?N E INFORM?TICA
; Dr. Carlos Vargas
; I Ciclo del 2024
; 
; Primera Tarea Programada
; 
; Descripci?n del Proyecto:
; Programar en lenguaje ensamblador de modo individual la simulaci?n de ?una calculadora? 
; que ?nicamente opere con n?meros racionales. Esta calculadora debe permitir las siguientes operaciones:
; ? Suma
; ? Resta
; ? Multiplicaci?n
; ? Divisi?n

.model SMALL                               
.STACK 512
.386                                 
     
;;;; SEGMENTO DE DATOS (VARIABLES, CONSTANTES Y ARREGLOS)                       
.DATA
    ;;; INTERFAZ
    ; estos son los valores asciis que seran impresos para representar la interfaz
    ; cada linea en el array interf representa una linea a renderizar en pantalla, todos los valores son ASCII en decimal
    ; la primer linea que define interf se impimira en la fila 00
    ; el primer valor de una fila en interf, (el primer valor en un db), se imprime en la columna 11 y de alli aumenta la columna en 1
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

    ;;; CONSTANTES
    interFilaTamanno equ 19  ; cantidad de filas en el array interf, se refiere a cuantas veces se hace el db
    teclaEscape equ 027  ; valor ascii de la tecla escape
    sumaOpAscii equ 43  ; valor ascii del operador suma
    restOpAscii equ 45  ; valor ascii del operador resta
    multOpAscii equ 42  ; valor ascii del operador de multiplicar
    diviOpAscii equ 47  ; valor ascii del operador de dividir
    iguaOpAscii equ 61  ; valor ascii del operador de igual
    miniRecFilG equ 17  ; fila en la que se escribe en el mini rec de los errores
    miniRecColI equ 29  ; primer columna del mini rec de los errores
    miniRecColF equ 33  ; ultima columna del mini rec de los errores
    sizeArrNumAscii equ 5  ; tamano del array rNumAscii
    
    ;;; VARIABLES
    mensajeError db 069,082,082,079,082  ; mensaje error que se escribe mini recuadro, cada valor es un ascii, todos juntos imprimen ERROR
    
    ;; MOUSE
    clickIzq db 0  ; funciona como booleano para determina si se ha presionado el click izq o no
    mouseCol db 0  ; numero de columna en la que se encuentra el puntero del mouse
    mouseFil db 0  ; numero de fila en la que se encuentra el puntero del mouse
    
    ;; DELAY
    seconds db 1  ; segundos para el delay
    
    ;; VENTANITA
    ; AA/BB*CC/DD=EEEE/FFFF  ; 21 caracteres ; esto esta en fila 1 columna 11
    auxB01 db 0  ; variable auxiliar de 08 bits
    auxB02 db 0  ; variable auxiliar de 08 bits
    auxW01 dw 0  ; variable auxiliar de 16 bits
    
    arrayVenta db 000,000,047,000,001,047,000,000,047,000,001,000  ; array de valores que el usuario ha escrito en la ventanita
    contaArray dw 0  ; saber en que parte del array arrayVenta toca insertar
    contaVenta db 11 ; saber en que parte de la ventana toca imprimir, ya que siempre es fila, este lo que marca es la columna
    
    ; Estos arreglos sirven para mapear donde estan los botones y que son, se pueden leer tal que:
    ;           0   1   2   3   4   5   6   7   8   9   +   -   *   /   =  AC
    FilaSup db 004,004,004,004,004,008,008,008,008,008,012,012,012,012,012,016  ; la fila superior del caracter en tal posicion
    ColuIzq db 010,015,020,025,030,010,015,020,025,030,010,015,020,025,030,010  ; la columna izquierda del caracter en tal posicion
    FilaInf db 006,006,006,006,006,010,010,010,010,010,014,014,014,014,014,018  ; la fila inferior del caracter en tal posicion
    ColuDer db 012,017,022,027,032,012,017,022,027,032,012,017,022,027,032,013  ; la columna derecha del caracter en tal posicion
    Caracte db 048,049,050,051,052,053,054,055,056,057,043,045,042,047,061,111  ; valor ascii del caracter en tal posicion, excepto para el AC, que es represantado con una d
    
    ;; ERROR y NEGATIVO
    varError db 0  ; funciona como booleano para saber si el usuario ingresa datos a la calcu (ventanita) de forma incorrecta
    varNegativo db 0  ; funciona como booleano para saber si toca imprimir un signo de negativo antes del resultado
    
    ;; RESULTADOS
    numA dw 0  ; este es el AA, considerando ambos digitos
    numB dw 0  ; este el el BB, considerando ambos digitos
    opeR dw 0  ; este es el * , o cualquier otro operador
    numC dw 0  ; este es el CC, considerando ambos digitos
    numD dw 0  ; este es el DD, considerando ambos digitos
    numE dw 0  ; este es el EEEE, considerando los 4 digitos
    numF dw 0  ; este es el FFFF, considerando los 4 digitos
    impY db 0  ; funciona como booleano para saber si ya se imprimio resultado
    arrNumAscii db 00,00,00,00,00  ; array con valores a imprimir de numero E o F en ASCII, se usa el mismo arreglo para manejar la impresion

;;;; SEGMENTO DE CODIGO O TEXTO (PROCS Y RUTINAS)
.CODE                                     
                                           
Begin:
;------------------------------------------------------------------
; Nombre del punto de entrada: Begin
; Prop?sito: Inicia la ejecuci?n del programa.
; Descripci?n: Realiza la inicializaci?n de los registros y llama a las rutinas necesarias
;              para iniciar la calculadora y gestionar las interacciones con el usuario a trav?s del mouse y el teclado.
;------------------------------------------------------------------                                     
    mov ax, @data  ; Carga el segmento de datos en ax
    mov ds, ax  ; Inicializa ds con el segmento de datos                                             
    cld  ; Establece la direcci?n hacia adelante                                          
    call PrintA  ; Llama a la rutina PrintA para imprimir la interfaz de la calculadora
    call CleanReg  ; Limpia los registros
    call InitMouse  ; Inicializa el mouse
    MainLoop:
        call CleanReg  ; Limpia los registros
        call Delay  ; Funci?n de delay que permite que un bot?n del mouse se mantenga presionado
        call CleanReg  ; Limpia los registros
        call GetClick  ; Obtiene las coordenadas y el estado de los botones del mouse
        call CleanReg  ; Limpia los registros
        call CheckClick  ; Verifica si se ha hecho clic y guarda el ASCII correspondiente en auxB01
        call CleanReg  ; Limpia los registros
        call DoWhat  ; Realiza la operaci?n correspondiente al clic
        call CleanReg  ; Limpia los registros
        call CheckErr  ; Verifica si hay alg?n error
        call CleanReg  ; Limpia los registros
        call CompFin  ; Verifica si se debe calcular el resultado
        call CleanReg  ; Limpia los registros
        call PrintErr  ; Imprime cualquier error
        call CleanReg  ; Limpia los registros
        mov auxB01, 0  ; Limpia auxB01
        call AskToKey  ; Verifica qu? tecla se ha presionado
        cmp al, teclaEscape
        jne MainLoop  ; Si la tecla ESC no ha sido presionada, contin?a usando la calculadora
    .EXIT
  
PrintA PROC
;------------------------------------------------------------------
; Nombre del procedimiento: PrintA
; Prop?sito: Imprime la interfaz de la calculadora.
; Descripci?n: Establece la resoluci?n de la pantalla y llama a PrintRows para imprimir las filas de la interfaz.
;------------------------------------------------------------------
    mov al, 00h  ; definir tamano ventana (texto 40x25 16 colores)
    mov ah, 00h  ; modo 0 (elige resolucion)
    int 10h
    mov dl, 10  ; columna 1
    mov dh, 00 ; fila 0
    mov bh, 0  ; pagina 0
    mov ah, 02h  ; modo 2 (manipula el puntero)
    int 10h
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
;------------------------------------------------------------------
; Nombre del procedimiento: PrintRows
; Prop?sito: Imprime las filas de la interfaz de la calculadora.
; Descripci?n: Itera sobre el array <<interf>> e imprime los caracteres en la pantalla.
;------------------------------------------------------------------
    LoopRows:
        mov ax, 00h  ; limpiar ax
        mov bx, 00h  ; limpiar bx
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

CleanReg PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CleanReg
; Prop?sito: Limpia los registros.
; Descripci?n: Establece todos los registros (ax, bx, cx, dx, si, di) en 0 y retorna.
;------------------------------------------------------------------
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0
    ret
CleanReg ENDP

InitMouse PROC
;------------------------------------------------------------------
; Nombre del procedimiento: InitMouse
; Prop?sito: Inicializa el mouse para su uso.
; Descripci?n: Utiliza la funci?n de interrupci?n 33h para inicializar los valores del mouse.
;              Muestra el puntero del mouse y retorna.
;------------------------------------------------------------------
    mov ax, 00h  ; inicializa los valores del mouse a por defecto tambien sirve para checkear si hay o no mouse instalado
    int 33h
    mov ax, 01h  ; muestra el puntero
    int 33h
    ret
InitMouse ENDP

AskToKey PROC
;------------------------------------------------------------------
; Nombre del procedimiento: AskToKey
; Prop?sito: Verifica qu? tecla ha sido presionada en el teclado.
; Descripci?n: Utiliza la funci?n de interrupci?n 16h para obtener el estado del buffer del teclado.
;              Si una tecla ha sido presionada, lee la tecla y retorna. Si ninguna tecla ha sido presionada,
;              salta a la etiqueta NotPress y retorna.
;------------------------------------------------------------------
    mov ah, 01h  ; obtiene el estado del buffer del teclado
    int 16h
    jz NotPress  ; salta si ninguna tecla ha sido presionada
    mov ah,00h  ; lee la tecla presionada
    int 16h
    NotPress:
        ret
AskToKey ENDP

GetClick PROC
;------------------------------------------------------------------
; Nombre del procedimiento: GetClick
; Prop?sito: Obtiene la posici?n donde el usuario ha hecho clic.
; Descripci?n: Inicializa clickIzq a 0 y llama a la funci?n de interrupci?n 33h para obtener la posici?n del puntero
;              y el estado de los botones. Luego, asigna el estado del bot?n izquierdo a clickIzq y calcula
;              las coordenadas de la fila y la columna.
;------------------------------------------------------------------
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

CheckClick PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CheckClick
; Prop?sito: Verifica si se ha producido un clic y determina si el clic fue dentro de una de las 16 cajas definidas.
; Descripci?n: Comprueba si clickIzq es igual a 1 para determinar si se ha hecho clic izquierdo.
;              Luego, itera sobre las 16 cajas definidas para verificar si el clic se encuentra dentro de alguna de ellas.
;              Si encuentra una coincidencia, asigna el valor ASCII correspondiente a auxB01.
;------------------------------------------------------------------
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
            inc si
            cmp si, 16
            jl LoopBox
            jmp NotClick        
    NotClick:
        ret
CheckClick ENDP

PrintChar PROC
;------------------------------------------------------------------
; Nombre del procedimiento: PrintChar
; Prop?sito: Imprime un car?cter espec?fico en la pantalla.
; Descripci?n: Utiliza la interrupci?n 10h con funci?n 02h para posicionar el cursor en la posici?n deseada.
;              Luego, utiliza la interrupci?n 10h con funci?n 09h para imprimir el car?cter en esa posici?n.
;------------------------------------------------------------------
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

    PrintChRet:
        ret
PrintChar ENDP

Delay PROC
;------------------------------------------------------------------
; Nombre del procedimiento: Delay
; Prop?sito: Genera un retraso de aproximadamente un segundo.
; Descripci?n: Utiliza la interrupci?n 21h con funci?n 2ch para obtener el tiempo del sistema en segundos.
;              Compara el segundo actual con el segundo almacenado previamente.
;              Si el segundo actual es igual al almacenado, se sigue en el mismo segundo hasta que cambie.
;              Cuando cambia el segundo, se actualiza el segundo almacenado y se retorna.
; Fuente: https://stackoverflow.com/questions/44246397/delay-in-assembly-8086
; Autor de la respuesta: Jose Manuel Abarca Rodr?guez (https://stackoverflow.com/users/3298930/jose-manuel-abarca-rodr?guez)
; Fecha de la respuesta: 30 de mayo de 2017
;------------------------------------------------------------------
    delaying:
          mov ah, 2ch  ;  GET SYSTEM TIME.
          int 21h  ; RETURN SECONDS IN DH.
          cmp dh, seconds  ; CHECK IF ONE SECOND HAS PASSED.  IF SECONDS ARE THE SAME...
          je delaying  ; ...WE ARE STILL IN THE SAME SECONDS.
          mov seconds, dh  ; SECONDS CHANGED. PRESERVE NEW SECONDS.
    ret
Delay ENDP

DoWhat PROC
;------------------------------------------------------------------
; Nombre del procedimiento: DoWhat
; Prop?sito: Realiza la acci?n correspondiente al bot?n clickeado.
; Descripci?n: Verifica si se ha clickeado un bot?n, si es un bot?n AC
;              o si se ha alcanzado el l?mite de operaciones permitidas.
;              Llama a PrintChar para imprimir el car?cter correspondiente
;              y a StoreInA para almacenarlo, adem?s de limpiar la ventana
;              en caso de ser necesario.
;------------------------------------------------------------------
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

CleanVent PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CleanVent
; Prop?sito: Limpia la ventana y las variables para simular el reinicio de la calculadora.
; Descripci?n: Limpia la ventana de caracteres y errores, y reinicia las variables utilizadas
;              para simular que la calculadora se ha reiniciado.
;------------------------------------------------------------------
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
    mov varNegativo, 00  ; se marca que no es negativa

    ret
CleanVent ENDP

StoreInA PROC
;------------------------------------------------------------------
; Nombre del procedimiento: StoreInA
; Prop?sito: Llama a los procedimientos correspondientes basados en contaArray.
; Descripci?n: Dependiendo del valor de contaArray, llama a FiNum, SeNum o OpNum
;              y luego retorna al punto de llamada.
;------------------------------------------------------------------
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

    callFirst:
        call FiNum
        jmp stoRet
    callSecon:
        call SeNum
        jmp stoRet
    callOpera:
        call OpNum  ; este no es un num, es el de operador
        jmp stoRet
    stoRet:
        ret
StoreInA ENDP

FiNum PROC
;------------------------------------------------------------------
; Nombre del procedimiento: FiNum
; Prop?sito: Convierte un car?cter ASCII num?rico en su equivalente decimal
;            y lo almacena en arrayVenta.
; Descripci?n: Convierte el valor ASCII en auxB01 (que representa un d?gito num?rico)
;              a su equivalente decimal y lo guarda en la posici?n correspondiente
;              de arrayVenta, incrementando contaArray en 1.
;------------------------------------------------------------------
    sub auxB01, 48  ; convertir ascii a decimal
    mov al, auxB01
    mov si, contaArray
    mov arrayVenta[si], al  ; poner valor decimal en arrayVenta
    inc contaArray
    ret
FiNum ENDP

SeNum PROC
;------------------------------------------------------------------
; Nombre del procedimiento: SeNum
; Prop?sito: Almacena el n?mero ingresado en arrayVenta.
; Descripci?n: Verifica si el valor ASCII en auxB01 representa un n?mero
; (entre 0 y 9). Si es as?, convierte el valor ASCII a decimal y lo guarda 
; en la posici?n correspondiente de arrayVenta, incrementando contaArray. Si no es un n?mero, no realiza ninguna acci?n.
;------------------------------------------------------------------
    cmp auxB01, 47  ; if auxB01 mayor 47
    jg ifSeNum
    jmp elseSeNum

    ifSeNum:
        cmp auxB01, 58  ; tengo que ser menor que 58 para ejecutar el if
        jge elseSeNum
        sub auxB01, 48  ; convertir ascii a decimal
        mov al, auxB01
        mov si, contaArray  
        mov arrayVenta[si], al  ; poner valor decimal en arrayVenta
        inc contaArray
        jmp retSeNum 
        
    elseSeNum:
        mov si, contaArray  ; contador para el array
        dec si  ; --si
        mov ah, arrayVenta[si]  ; ah nos va a servir como variable auxiliar
        mov arrayVenta[si], 00  ; ; ponemos (contaArray - 1) en 0
        inc si  ; ++si
        mov arrayVenta[si], ah  ; ponemos contaArray en ah, osea lo que habia en el array en la posi anterior
        inc si  ; ++si
        mov al, auxB01
        mov arrayVenta[si], al  ; ponemos en contaArray + 1 el ascii del operador que nos hayan mandado
        add contaArray, 2  ; se modifico la actual y la siguiente y por ende toca incrementar en 2
        jmp retSeNum
        
    retSeNum:
        ret
SeNum ENDP

OpNum PROC
;------------------------------------------------------------------
; Nombre del procedimiento: OpNum
; Prop?sito: Almacena el operador aritm?tico ingresado en arrayVenta.
; Descripci?n: Toma el valor ASCII del operador aritm?tico ingresado en auxB01 y lo guarda en la posici?n correspondiente de arrayVenta, luego incrementa contaArray.
;------------------------------------------------------------------
    mov al, auxB01  ; poner valor ascii del operador en arrayVenta
    mov si, contaArray
    mov arrayVenta[si], al
    inc contaArray
    ret
OpNum ENDP

CheckErr PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CheckErr
; Prop?sito: Verifica si hay errores en los n?meros ingresados y marca varError si es as?.
; Descripci?n: Comprueba si los d?gitos ingresados est?n dentro del rango v?lido (0-9), y si el operador de igualdad (=) est? presente y en la posici?n correcta.
;------------------------------------------------------------------
    mov varError, 0  ; reinicia la varError a 0
    cmp arrayVenta[0], 9  ; if arrayVenta[0] > 9
    jg ConfirmErr
    cmp arrayVenta[0], 0  ; if arrayVenta[0] < 0
    jl ConfirmErr
    cmp arrayVenta[1], 9  ; if arrayVenta[1] > 9
    jg ConfirmErr
    cmp arrayVenta[1], 0  ; if arrayVenta[1] < 0
    jl ConfirmErr
    cmp arrayVenta[2], diviOpAscii  ; if arrayVenta[2] != diviOpAscii
    jne ConfirmErr
    cmp arrayVenta[3], 9  ; if arrayVenta[3] > 9
    jg ConfirmErr
    cmp arrayVenta[3], 0  ; if arrayVenta[3] < 0
    jl ConfirmErr
    cmp arrayVenta[4], 9 ; if arrayVenta[4] > 9
    jg ConfirmErr
    cmp arrayVenta[4], 0  ; if arrayVenta[4] < 0
    jl ConfirmErr
    cmp arrayVenta[5], multOpAscii  ; if arrayVenta[5] < multOpAscii
    jl ConfirmErr
    cmp arrayVenta[5], diviOpAscii  ; if arrayVenta[5] > diviOpAscii
    jg ConfirmErr
    cmp arrayVenta[6], 9  ; if arrayVenta[6] > 9
    jg ConfirmErr
    cmp arrayVenta[6], 0  ; if arrayVenta[6] < 0
    jl ConfirmErr
    cmp arrayVenta[7], 9  ; if arrayVenta[7] > 9
    jg ConfirmErr
    cmp arrayVenta[7], 0  ; if arrayVenta[7] < 0
    jl ConfirmErr
    cmp arrayVenta[8], diviOpAscii  ; if arrayVenta[8] != diviOpAscii
    jne ConfirmErr
    cmp arrayVenta[9], 9  ; if arrayVenta[9] > 9
    jg ConfirmErr
    cmp arrayVenta[9], 0  ; if arrayVenta[9] < 0
    jl ConfirmErr
    cmp arrayVenta[10], 9  ; if arrayVenta[10] > 9
    jg ConfirmErr
    cmp arrayVenta[10], 0  ; if arrayVenta[10] < 0
    jl ConfirmErr
    mov al, arrayVenta[4]  ; registro que va a servir para verificar si segundo Num es menor que 1
    add al, arrayVenta[3]  ; al = arrayVenta[3] + arrayVenta[4]
    cmp al, 1  ; if al < 1
    jl ConfirmErr
    mov al, arrayVenta[10]  ; registro que va a servir para verificar si segundo Num es menor que 1
    add al, arrayVenta[9]  ; al = arrayVenta[9] + arrayVenta[10]
    cmp al, 1  ; if al < 1
    jl ConfirmErr
    cmp arrayVenta[11], 0  ; if arrayVenta[11] > 0
    jg ifIgualOp
    jmp retCheckErr

    ifIgualOp:
        cmp arrayVenta[11], iguaOpAscii  ; if arrayVenta[11] != iguaOpAscii
        jne ConfirmErr
        jmp retCheckErr

    ConfirmErr:
        mov varError, 1  ; marcar que si hay error
        jmp retCheckErr
    retCheckErr:
        ret
CheckErr ENDP

PrintErr PROC
;------------------------------------------------------------------
; Nombre del procedimiento: PrintErr
; Prop?sito: Imprime el mensaje de error en el mini recuadro si hay un error.
;------------------------------------------------------------------
    cmp varError, 01  ; if varError != 1
    jne retPrintErr
    
    ; if not, then: hacemos esto
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

CompFin PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CompFin
; Prop?sito: Verifica si se debe computar la operaci?n y realiza
;            las operaciones necesarias para preparar los operandos
;            y llama a ExeOper y PrintRes si no hay errores.
;------------------------------------------------------------------
    cmp impY, 1  ; if impY == 1
    je retComp
    cmp varError, 0  ; if varError == 0
    je ifComp
    jmp retComp

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
       
       call ExeOper  ; llamar a hacer el calculo de EEEE/FFFF
       call PrintRes  ; llamar a imprimir EEEE/FFFF

    retComp:
        ret
CompFin ENDP

ExeOper PROC
;------------------------------------------------------------------
; Nombre del procedimiento: ExeOper
; Prop?sito: Ejecutar la operaci?n especificada en opeR
; Descripci?n: Este procedimiento realiza la operaci?n aritm?tica
;              correspondiente seg?n el valor almacenado en opeR,
;              actualizando los valores de numE y numF.
;------------------------------------------------------------------
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
        mov si, numE  ; si = numE
        mov auxW01, si  ; auxW01 = (numA * numD), para manejar el negativo mejor tener este auxGuardado
        sub numE, di  ; numE = (numA * numD) - (numC * numB)
        cmp numE, 0  ; if numE >= 0
        jge restExCallJump
        mov varNegativo, 01  ; quiere decir que tenemos un numero negativo resultado de la resta
        sub di, auxW01  ;  di = (numC*numB) - (numA*numD)
        mov numE, di  ; numE = (numC*numB) - (numA*numD)
        mov auxW01, 00  ; la limpiamos
        restExCallJump:
            ; denominador
            mov ax, numD
            mul numB  ; ax = numB * numD
            mov numF, ax  ; numF = numB * numD
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
        ; ver si hubo error en cuanto a dividir por 0
        cmp numF, 00  ; if numF != 0
        jne retExeOper
        mov varError, 01
        jmp retExeOper

    retExeOper:
        ret
ExeOper ENDP

PrintRes PROC
;------------------------------------------------------------------
; Nombre del procedimiento: PrintRes
; Prop?sito: Imprimir el resultado almacenado en numE y numF
; Descripci?n: Este procedimiento verifica si hay errores en los
;              datos de entrada. Si no hay errores, imprime el
;              resultado almacenado en numE y numF, incluyendo la
;              opci?n de imprimir un signo negativo si es necesario.
;------------------------------------------------------------------
    cmp varError, 01  ; if varError == 1
    je retPrintRes
    cmp numE, 00  ; if numE == 0
    je printNumE
    cmp varNegativo, 01  ; if varNegativo == 1
    je printNegativo    
    jmp printNumE
    
    printNegativo:
        mov auxB01, restOpAscii  ; ponemos en auxB01 el valor a imprimir
        call PrintChar  ; llamamos al metodo que imprime
        inc contaVenta  ; incrementos la columna en la que se imprime en ventanita
        jmp printNumE

    printNumE:
        mov ax, numE  ; registro usado ya que no se puede pasar directamente de var a var
        mov auxW01, ax  ; ahora si, auxW01 = numE
        call SelChResPr  ; hora de imprimir numE
        call CleanArrNAsc  ; limpia el array

        cmp numE, 00  ; if numE == 0
        je retPrintRes

        mov auxB01, diviOpAscii  ; ponemos en auxB01 el valor a imprimir
        call PrintChar  ; llamamos al metodo que imprime
        inc contaVenta  ; incrementos la columna en la que se imprime en ventanita
        jmp printNumF
        
    printNumF:
        mov ax, numF  ; registro usado ya que no se puede pasar directamente de var a var
        mov auxW01, ax  ; ahora si, auxW01 = numF
        call SelChResPr  ; hora de imprimir numF
        call CleanArrNAsc  ; limpia el array
        jmp retPrintRes
        
    retPrintRes:
        mov impY, 01  ; marca que ya se imprimio
        ret
PrintRes ENDP

SelChResPr PROC
;------------------------------------------------------------------
; Nombre del procedimiento: SelChResPr
; Prop?sito: Seleccionar y preparar los caracteres a imprimir del
;            resultado almacenado en auxW01 y guardarlos en el
;            array arrNumAscii.
; Descripci?n: Este procedimiento convierte el valor de auxW01 a
;              caracteres ASCII y los guarda en arrNumAscii, 
;              omitiendo ceros iniciales y finalmente imprimiendo 
;              los caracteres uno por uno.
;------------------------------------------------------------------
    mov si, 0
    ; guardar residuos en el arreglo
    LoopSaveChPr: ; peque?o bucle para guardar los valores de auxW01 a imprimir en arrNumAscii
        mov dx, 0    ; dividendo high
        mov ax, auxW01  ; dividendo low
        mov cx, 10
        div cx  ; ax = cociente de (auxW01/10),  dx = residuo de (auxW01/10)
        add dx, 48  ; convierte el residuo a su caracter ASCII
        mov arrNumAscii[si], dl  ; guardar residuo convertido a caracter ASCII
        mov auxW01, ax  ; gracias a la division anterior, auxW01 = auxW01 / 10, guardamos ese cociente aqui
        inc si  ; incrementa el indice de arrNumAscii
        cmp si, sizeArrNumAscii  ; if si < sizeArrNumAscii
        jl LoopSaveChPr
        
    mov si, sizeArrNumAscii  ; si = 5
    dec si  ; decrementa en 1 para tener un indice valido
    mov di, 0  ; usamos otro indice, ya que es m?s facil contar de menos a mas

    ; salta los ceros iniciales
    SkipLeadingZeros:
        cmp arrNumAscii[si], '0'
        jnz PrintLoop  ; si el caracter no es <<0>>, saltar al bucle de impresion
        dec si
        cmp si, 1  ; if si >= 1
        jge SkipLeadingZeros
        
    ; rutina de impresion
    PrintLoop:
        ; imprime posiciones del arreglo
        mov ah, arrNumAscii[si]  ; usamos el arreglo como mediador
        mov auxB01, ah  ; tenemos el valor a imprimir
        call PrintChar  ; imprime el car?cter en auxB01
        inc contaVenta  ; ++contaVenta
        dec si  ; --si, osea que en la pr?xima iteraci?n se imprime el ?ndice actual del array - 1
        cmp si, 0  ; if si >= 0
        jge PrintLoop

    ret
SelChResPr ENDP

CleanArrNAsc PROC
;------------------------------------------------------------------
; Nombre del procedimiento: CleanArrNAsc
; Prop?sito: Limpiar el array arrNumAscii, estableciendo todos sus
;            elementos a cero.
; Descripci?n: Este procedimiento recorre el array arrNumAscii y
;              establece cada uno de sus elementos a cero, 
;              utilizando un bucle para iterar a trav?s del array.
;------------------------------------------------------------------
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
