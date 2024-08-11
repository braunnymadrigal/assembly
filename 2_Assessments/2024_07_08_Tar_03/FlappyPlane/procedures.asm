; Copyright 2024 "Charlie's Angels"
;       <HENOC.ROJAS@ucr.ac.cr>
;       <BRAUNNY.MADRIGAL@ucr.ac.cr>
;       <KENDALL.VILLAFUERTE@ucr.ac.cr>
;       <MARCELO.PICADO@ucr.ac.cr>
;	    <RODRIGO.CARBALLO@ucr.ac.cr>

.code

; Procedimiento para sumar dos enteros
; @param rcx Primer entero
; @param rdx Segundo entero
; @return La suma de los dos enteros en rax
Sum PROC
	mov rax, rcx
	add rax, rdx
	ret
Sum ENDP

; Procedimiento para obtener la puntuación del juego
; @param rcx Coordenada X del avión
; @param rdx Coordenada X de la torre izquierda
; @param r8  Coordenada X de la torre derecha
; @return 1 si el avión está alineado con alguna torre, 0 en caso contrario
getGameScore PROC
	; if (planeX == towerLX || planeX == towerRX)
	cmp rcx, rdx  ; planeX == towerLX
	je equal
	cmp rcx, r8  ; || planeX == towerRX
	je equal
	jmp not_equal

	equal:
	mov rax, 1
	ret

	not_equal:
	mov rax, 0
	ret

getGameScore ENDP

; Procedimiento para verificar colisiones
; @param rcx Primer operando
; @param rdx Segundo operando
; @param r8  Tercer operando
; @param r9  Cuarto operando
; @return 1 si (op1 > op2) && (op3 > op4), 0 en caso contrario
collisions PROC
	movsxd rcx, ecx
    movsxd rdx, edx
	movsxd r8, r8d
    movsxd r9, r9d

	cmp rcx, rdx
	jg and1
	jmp false

	and1:
	cmp r8, r9
	jg true
	jmp false

	true:
	mov rax, 1
	ret

	false:
	mov rax, 0
	ret
collisions ENDP

; Procedimiento para verificar si un punto está en una línea
; @param rcx Punto a verificar
; @param rdx Inicio de la línea
; @param r8  Fin de la línea
; @return 1 si el punto está en la línea, 0 en caso contrario
CheckPointInLine PROC
	mov rax, 0  ; false

	cmp rcx, rdx
	jl retChPoint
	cmp rcx, r8
	jg retChPoint

	mov rax, 1  ; true

	retChPoint:
	ret
CheckPointInLine ENDP

END
