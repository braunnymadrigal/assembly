.data
msg1 BYTE "Unsigned overflow!",0dh,0ah,0
var1 DWORD 3
var2 DWORD 6
var3 DWORD 4
var4 DWORD ?

.code
main PROC

;Divide Overflow example:

	mov ax,1000h
	mov bl,0
	div bl
	jmp quit


;Example 1: 	var4 = (var1 + var2) * var3;
Example1:
	mov eax,var1
	add eax,var2
	mul var3		; EAX * var3
	jc  tooBig		; overflow?
	mov var4,eax
	jmp Example2

Example2:	; var4 = (var1 * 5) / (var2 - 3);

	mov eax,var1
	mov ebx,5
	mul ebx			; EDX:EAX = product
	mov ebx,var2
	sub ebx,3
	div ebx
	mov var4,eax



tooBig:
	mov edx,OFFSET msg1
	call WriteString

quit:
	exit
main ENDP
END main