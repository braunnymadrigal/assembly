; debug 13.asm

.model SMALL                               
.STACK 512                                 
     
                                      
.DATA
    diviOpAscii equ 47  ; valor ascii del operador de dividir
    sizeArrNumAscii equ 5  ; tamano del array rNumAscii
    
    auxB01 db 0  ; variable de 08 bits auxiliar

    contaVenta db 11 ; saber en que columna de la ventana toca impirmir
    
    numE dw 9999  ; este es el EEEE, considerando los 4 digitos
    impY db 0  ; funciona como booleano para saber si ya se imprimio resultado
    arrNumAscii db 00,00,00,00,00  ; array con valores a imprimir de numero E o F en ASCII
    
.CODE                                      
                                       
Begin:                                     
    mov ax, @data     
    mov ds, ax                                           
    cld  ; limpiar la flag
    call SelChResPr
    .EXIT

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

end Begin  ; termina el programa
