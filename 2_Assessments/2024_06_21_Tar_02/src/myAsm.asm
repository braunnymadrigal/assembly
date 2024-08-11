; Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
; Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
; Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
; Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>


.code  ; segmento de c�digo o texto


; ---------------------------------------------------------------
; AVXFoundationDetection PROC
;
; Descripci�n:
;   Esta funci�n utiliza la instrucci�n CPUID para verificar la
;   compatibilidad con AVX (Advanced Vector Extensions) en el
;   procesador.
;
; Entradas:
;   Ninguna.
;
; Salidas:
;   Retorna un valor booleano en el registro EAX:
;     - 1 si el procesador soporta AVX.
;     - 0 si el procesador no soporta AVX.
;
; Registros modificados:
;   EAX, EBX, ECX, RBX.
;
; ---------------------------------------------------------------
AVXFoundationDetection PROC
    push rbx                 ; Guarda el valor de RBX en la pila
    mov eax, 7               ; Carga 7 en EAX para solicitar informaci�n extendida
    mov ecx, 0               ; Carga 0 en ECX para el sub-�ndice de funci�n de CPUID
    cpuid                    ; Ejecuta la instrucci�n CPUID para obtener informaci�n del procesador
    shr ebx, 16              ; Desplaza 16 bits a la derecha en EBX
    and ebx, 1               ; Aplica una operaci�n AND a EBX para obtener el bit de AVX
    mov eax, ebx             ; Mueve el resultado a EAX para retornarlo como un booleano
    pop rbx                  ; Restaura el valor original de RBX
    ret                      ; Retorna a la instrucci�n de llamada
AVXFoundationDetection ENDP


; ---------------------------------------------------------------
; AVXSumTwoVectors PROC
;
; Descripci�n:
;   Esta funci�n suma dos vectores de n�meros flotantes utilizando
;   instrucciones AVX.
;
; Entradas:
;   rcx: Puntero al primer vector (myVector1).
;   rdx: Puntero al segundo vector (myVector2).
;
; Salidas:
;   El primer vector (myVector1) es actualizado con el resultado
;   de la suma.
;
; Registros modificados:
;   ZMM0, ZMM1, ZMM2, RCX, RDX.
;
; ---------------------------------------------------------------
AVXSumTwoVectors PROC
    vmovupd zmm0, zmmword ptr [rcx]   ; Carga el primer vector en ZMM0 desde la memoria
    vmovupd zmm1, zmmword ptr [rdx]   ; Carga el segundo vector en ZMM1 desde la memoria
    vaddpd zmm2, zmm0, zmm1           ; Suma los dos vectores y guarda el resultado en YMM2
    vmovupd zmmword ptr [rcx], zmm2   ; Guarda el resultado de vuelta en el primer vector (myVector1)
    ret                               ; Retorna a la instrucci�n de llamada
AVXSumTwoVectors ENDP

; ---------------------------------------------------------------
; AVXMulVecByScalar PROC
;
; Descripci�n:
;   Esta funci�n multiplica un vector de n�meros flotantes por
;   un escalar utilizando instrucciones AVX.
;
; Entradas:
;   rcx: Puntero al vector (myVector1).
;   rdx: Puntero al escalar (myNumber).
;
; Salidas:
;   El vector (myVector1) es actualizado con el resultado de la
;   multiplicaci�n por el escalar.
;
; Registros modificados:
;   XMM1, ZMM0, ZMM1, ZMM2, RCX, RDX.
;
; ---------------------------------------------------------------
AVXMulVecByScalar PROC
    vmovupd zmm0, zmmword ptr [rcx]   ; Carga el vector en ZMM0 desde la memoria
    vmovsd xmm1, qword ptr [rdx]      ; Carga el escalar en XMM1 desde la memoria
    vbroadcastsd zmm1, xmm1           ; Hace un broadcast del escalar a ZMM1
    vmulpd zmm2, zmm0, zmm1           ; Multiplica el vector por el escalar y guarda el resultado en ZMM2
    vmovupd zmmword ptr [rcx], zmm2   ; Guarda el resultado de vuelta en el vector (myVector1)
    ret                               ; Retorna a la instrucci�n de llamada
AVXMulVecByScalar ENDP

end  ; Fin del c�digo ensamblador
