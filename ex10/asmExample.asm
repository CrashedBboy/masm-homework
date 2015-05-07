TITLE Example of ASM                (asmExample.ASM)


INCLUDE Irvine32.inc

main          EQU start@0

.stack 4096
ExitProcess proto dwExitCode:dword
FindLargest proto aPtr:PTR SDWORD, arraySize:DWORD
;宣告FindLargest procedure 的prototype

.data
Ex1Array sdword 103522039 , 102502559 , 102502557	;陣列初始為103522039, 組員學號1 ,組員學號2
Ex2Array sdword -103522039 ,-102502559 , -102502557	;陣列初始為-103522039, 組員學號1加負號 ,組員學號2加負號


.code
main proc
	INVOKE FindLargest, ADDR Ex1Array, LENGTHOF Ex1Array
	INVOKE FindLargest, ADDR Ex2Array, LENGTHOF Ex2Array
	;呼叫 FindLargest procedure
	
	call WaitMsg
	invoke ExitProcess,0
main endp

FindLargest proc aPtr:PTR SDWORD, arraySize:DWORD
	push esi
	push ecx
	mov  eax,80000000h	   ; smallest possible 32bit signed integer
	mov  esi,aPtr
	mov  ecx,arraySize

L1: cmp  [esi],eax	   ; get current value
	jng  L2			  ; larger than max
	mov  eax,[esi]	   ; update max value

L2: add  esi,4
	loop L1
	
	call DumpRegs

	pop ecx
	pop esi
	ret    ; Return from subroutine
FindLargest endp

end main
