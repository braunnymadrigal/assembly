
.code

sumArr proc 
	;En ecx queda el arreglo 
	;En edx queda la cantidad de elementos
	;se retorna el resultado en eax 
	;RCX y RAX son registros de 64 bits
	;Deben tener cuidado de donde quedan los arguementos que envian desde c++.
	mov ebx, 0
	mov eax, 0
	suma: 
		add ebx, [RCX + RAX * 4]
		dec edx
		jz done
		inc eax
		jmp suma
	done:
		mov eax, 0 
		mov eax, ebx
	ret 
sumArr endp

end