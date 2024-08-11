PAGE	255, 255 
TITLE	EJE11.asm, coprocesador matemático.

.MODEL SMALL
.486	; CPU
.487	; FPU

; Segmento de pila.
.STACK 64

; Segmento de datos.
.DATA
	MyControlWord	DW		0000000000111111b
	MyStatusWord	DW		0000000000000000b
	MyInteger1		DW		1d
	MyInteger2		DD		2d
	MyFloat1		DD		1.5
	MyFloat2		DD		-1.5

; Segmento de código.
.CODE

	; Método principal.
	; =============
	MyMain	PROC	FAR

		; Inicializa el segmento de datos.
		MOV AX, @DATA
		MOV DS, AX

			; Control Register:  
			; ==============
			; Registro encargado de establecer las características de la manera en que operara la FPU.
			FLDCW MyControlWord		; Load Control Word. Carga el 'Control Register' de memoria.
			FSTCW MyControlWord		; Store Control Word. Guarda el 'Control Register' en memoria.

			; Status Register:  
			; ==============
			; Registro que muestra el estado del coprocesador.
			FSTSW MyStatusWord

			FINIT ; ¿? Inicialización automática del Control Register (37Fh) y el Status Register (00).

			; Instrucciones de movimiento de datos.
			; ==============================
			FLD	 MyFloat1		; Load.
			FLD ST
			FST	 MyFloat2		; Store without pop.
			FSTP MyFloat2		; Store with pop.
			FXCH				; Exchange. Intercambia ST(0) con ST(1).
			FXCH ST(5)			; Exchange. Intercambia ST(0) con ST(5).
			
			; Instrucciones de conversión:
			; ======================
			FILD MyInteger1		; De entero de 2 bytes a Float.
			FILD MyInteger2		; De entero de 4 bytes a Float.

			FIST MyInteger1		; De float a entero de 2 bytes sin sacar de la pila.
			FISTP MyInteger2		; De float a entero de 4 bytes scando de la pila.

			
			; Instrucciones aritméticas:
			; ====================
			FADD				; ST(0) = ST(0) + ST(1).
			FADD ST(2), ST(0)	; ST(x) = ST(X) + ST(0). Uno de los operandos siempre debe ser ST(0). En este caso x=2.
			FADD MyFloat1		; ST(0) = ST(0) + MyFloat1.

			FSUB				; ST(0) - ST(1)
			FSUBR				; ST(1) - ST(0)
			FSUB ST(2), ST(0)	; ST(x) = ST(X) - ST(0). Uno de los operandos siempre debe ser ST(0). En este caso x=2.
			FSUB MyFloat1		; ST(0) = ST(0) - MyFloat1.
			FSUBR MyFloat1		; ST(0) = MyFloat1 - ST(0).

			FMUL				; ST(0) = ST(0) * ST(1).
			FMUL ST(2), ST(0)	; ST(x) = ST(X) * ST(0). Uno de los operandos siempre debe ser ST(0). En este caso x=2.
			FMUL MyFloat1		; ST(0) = ST(0) * MyFloat1.

			FDIV				; ST(0) / ST(1)
			FDIVR				; ST(1) / ST(0)
			FDIV ST(2), ST(0)	 	; ST(x) = ST(X) / ST(0). Uno de los operandos siempre debe ser ST(0). En este caso x=2.
			FDIV MyFloat1		; ST(0) = ST(0) / MyFloat1.
			FDIVR MyFloat1		; ST(0) = MyFloat1 / ST(0).

			FSQRT		; Raíz cuadrada de ST(0).
			FABS		; Valor absoluto de ST(0).
			FCHS		; Cambia el símbolo de ST(0).

			; Instrucciones de comparación:
			; ========================
			FCOM		;¿ST(0) = ST(1)?
			FCOMP		;¿ST(0) = ST(1)?, y saca ST(0).
			FCOMPP	;¿ST(0) = ST(1)?, y saca ST(0) y ST(1).
			FCOM ST(2)	; ¿ST(0) = ST(x)?, en este caso x=2.
			FCOM MyFloat1	; ¿ST(0) = MyFloat1?

			FTST		; ¿ST(0) = 0.0?

			; Instrucciones de constantes:
			; ======================
			FLDZ	; Carga +0.0.
			FLD1	; Carga +1.0.
			FLDPI	; Carga PI
			FLDL2T ; Carga log2(10).
			FLDL2E ; Carga log2(e).
			FLDLG2 ; Carga log10(2).
			FLDLN2 ; Carga ln(2).

			; Otras instrucciones:
			; ================
			F2XM1		; ST(0) = (2 elevado a la ST(0)) - 1.

			; En radianes.
			FSIN		; ST(0) = SEN(ST(0))
			FCOS		; ST(0) = COS(ST(0))
			FSINCOS	; ST(0) = SEN(ST(0)) y ST(1) = COS(ST(0))
			FPTAN		; ST(0) = TAN(ST(0))

		; Finaliza el programa sin errores
		MOV AX, 4C00h
		INT 21h
	MyMain	ENDP

END MyMain