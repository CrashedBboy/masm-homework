TITLE Example of ASM                (asmExample.ASM)

INCLUDE Irvine32.inc
 
main          EQU start@0

.data
	BitStr0 BYTE 0FFh
	BitStr1 BYTE 81h
	BitStr2 BYTE 81h
	BitStr3 BYTE 81h
	BitStr4 BYTE 0FFh
	BitStr5 BYTE 1
	BitStr6 BYTE 1
	BitStr7 BYTE 0FFh
	ChStr0 BYTE 8 dup (?)
	ChStr1 BYTE 8 dup (?)
	ChStr2 BYTE 8 dup (?)
	ChStr3 BYTE 8 dup (?)
	ChStr4 BYTE 8 dup (?)
	ChStr5 BYTE 8 dup (?)
	ChStr6 BYTE 8 dup (?)
	ChStr7 BYTE 8 dup (?)
.code
change PROC
	mov cx, 8
	mov ebx, 0
	L1:
		MOV eax, [esi]
		BT eax, ebx
		JC L2
		MOV al, 20h
		MOV [edi], al
		JMP L3
	L2:
		MOV al, 23h
		MOV [edi], al
	L3:
		INC ebx
		INC edi
		LOOP L1
	RET
change ENDP
main PROC
	MOV cx, 8
	MOV esi, offset BitStr0
	MOV edi, offset ChStr0
	L1:
		mov dx, cx
		CALL change
		mov cx, dx
		INC esi
		LOOP L1
	MOV edi, offset ChStr0
	MOV cx, 8
	L2:
		MOV dx, cx
		MOV cx, 8
		ADD edi, 7
		L3:
			MOV al, [edi]
			call WriteChar
			DEC edi
			LOOP L3
		ADD edi, 9
		MOV cx, dx
		MOV bx, 0
		CALL Crlf
		LOOP L2
	CALL WaitMsg
	exit
main ENDP
END main