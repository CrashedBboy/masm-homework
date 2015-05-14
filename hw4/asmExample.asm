TITLE Example of ASM                (asmExample.ASM)

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
	;code detail
	exit
main ENDP

CountMatches PROC USES esi edi ecx,
		arrayA:PTR BYTE,
		arrayB:PTR BYTE,
		arrayLength:DWORD
CountMatches ENDP
END main