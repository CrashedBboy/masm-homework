TITLE Example of ASM	(asmExample.ASM)

INCLUDE Irvine32.inc

CountMatches PROTO,
	arrayA:PTR SBYTE,
	arrayB:PTR SBYTE,
	arrayLength:DWORD
ExitProcess proto,dwExitCode:dword

main          EQU start@0

.data
	array1 SBYTE 12, 34, 1, 4, 33, 42, 24, 55
	array2 SBYTE 31, 34, 42, 4, 24, 1, 51, 3
	sameList SBYTE (LENGTHOF array1) Dup(?)
	sameNum BYTE 0
.code
main PROC
	INVOKE CountMatches, ADDR array1, ADDR array2, LENGTHOF array1
	call waitMsg
	INVOKE ExitProcess, 0
main ENDP

CountMatches PROC USES edx esi edi ecx,
					arrayA:PTR SBYTE,
					arrayB:PTR SBYTE,
					arrayLength:DWORD
	mov eax, 0
	mov esi, arrayA
	mov ecx, arrayLength
	L1:
		mov dl, [esi]
		push ecx
		mov ecx, sameNum
		L2:
			mov ebx, OFFSET sameList
			cmp [ebx], dl
			jz DUPLICATE
			jmp CONTINUE
			DUPLICATE:
				pop ecx
				jmp FORWARD
			CONTINUE:
				inc ebx
		LOOP L2
		mov ecx, arrayLength
		mov edi, arrayB 
		L3:
			cmp [edi], dl
			jz EQUAL
			jmp KEEP
			EQUAL:
				mov dh, sameNum
				mov sameList+dh, dl
				inc dh
				mov sameNum, dh
				pop ecx
				jmp FORWARD
			KEEP:
				inc edi
		LOOP L3
		pop ecx
		FORWARD:
			inc esi
	LOOP L1
	mov al, sameNum
	call DumpRegs
	ret
CountMatches ENDP
END main
