TITLE Example of ASM	(asmExample.ASM)

INCLUDE Irvine32.inc

CountMatches PROTO,
	arrayA:PTR BYTE,
	arrayB:PTR BYTE,
	arrayLength:DWORD

main          EQU start@0

.data
	array1 BYTE 12, 34, 1, 4, 33, 42, 24, 55
	array2 BYTE 31, 34, 42, 4, 24, 1, 51, 3
.code
main PROC
	INVOKE CountMatches, ADDR array1, ADDR array2, LENGTHOF array1
	call DumpRegs
	exit
main ENDP

CountMatches PROC USES edx esi edi ecx,
					arrayA:PTR BYTE,
					arrayB:PTR BYTE,
					arrayLength:DWORD
	mov eax, 0
	mov esi, arrayA
	mov edi, arrayB
	mov ecx, arrayLength
	L1:
		mov dl, [esi]
		cmp [edi], dl
		jz EQUAL
		jmp FORWARD
	EQUAL:
		inc eax
	FORWARD:
		inc esi
		inc edi
		loop L1
CountMatches ENDP
END main
