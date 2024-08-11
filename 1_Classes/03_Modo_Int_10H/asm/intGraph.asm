; Programa dibuja una Caja mediante llamadas al BIOS (INT 10H),
; Servicio 00h   establece el modo de video y borra la pantalla
; ah = 00h 
; al = modo de video (0 ? 255)
; modo grafico al = 06H, 640X480 2 colores
   
; INT 10H Funcion 0CH
; Escribir un punto o pixel grafico
; LLAMADA:
; AH = 0CH
; AL = Valor del color a usar.
; BH = Pagina de video donde escribir el caracter.
; DX = Columna donde escribir el pixel (coordenada grafica x)
; CX = Fila donde escribir el pixel (coordenada grafica y)
   
    
.MODEL SMALL
.STACK 200H

.DATA
    tr DW 50  ; top row
    tc DW 100  ; top column
    br DW 100  ; bottom row
    bc DW 200  ; bottom column
    color DB 15

.CODE

    PROGI:
    mov ax,@data
    mov ds,ax


    mov ah,0
    mov al,6
    int 10H

    mov cx,bc
    sub cx,tc
    mov si,tr
    mov di,tc
   
    toploop:
        call    writedot
        inc di
    loop    toploop

    mov cx,br
    sub cx,tr
    mov si,tr
    
    sideloop:
        mov di,tc
        call    writedot
        mov di,bc
        call    writedot
        inc si
    loop    sideloop

    mov cx,bc
    sub cx,tc
    mov si,br
    mov di,tc
    
    botloop:
        call    writedot
        inc di
    loop    botloop



   .EXIT

    writedot PROC
        push    ax
        push    cx
        push    dx

        mov dx,si
        mov cx,di
        ;mov    al,color
        mov al,15
        mov ah,0cH
        int 10h

        pop dx
        pop cx
        pop ax
        ret
    writedot ENDP

    END PROGI
