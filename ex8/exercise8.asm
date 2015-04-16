TITLE Example of ASM                (asmExample.ASM)

INCLUDE Irvine32.inc


main          EQU start@0

.data
	myID DWORD 102502559d
	size_ID = 9
	space byte 7 DUP(0)
	myID_result byte "?????????", 0

.code
convert MACRO origin, len, result
	push eax
	push ecx
	push ebx
	push esi
	MOV ecx, len
	MOV ebx, 10d
	MOV esi, OFFSET result
	ADD esi, 8
	L1:
		MOV eax, origin
		TESt eax, 1b
		JNZ ODD
		MOV byte ptr[esi], 'B'
		DEC esi
		MOV edx,0
		DIV ebx
		MOV origin, eax
		LOOP L1
		ODD:
			MOV byte ptr[esi],'A'
			DEC esi
			MOV edx,0
			DIV ebx
			MOV origin, eax
		LOOP L1
	pop esi
	pop ebx
	pop ecx
	pop ebx
ENDM

main PROC
	mov eax, myID
	call WriteDec
	call Crlf
	convert myID, size_ID, myID_result
	mov edx, OFFSET myID_result
	call WriteString
	call Crlf
	call WaitMsg
	exit
	
main ENDP
END main