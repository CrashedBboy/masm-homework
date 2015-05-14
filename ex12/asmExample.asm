TITLE Example of ASM                (asmExample.ASM)

INCLUDE Irvine32.inc

Str_copyN PROTO,
 	source:PTR BYTE, 	; source string
 	target:PTR BYTE,	; target string
 	maxChars:DWORD		; max chars to copy
 
main          EQU start@0

.data
	string_1 BYTE "102502559"      ;填入組員1學號
	string_2 BYTE "102502557",0    ;填入組員2學號

.code
main PROC

	call Clrscr

	INVOKE Str_copyN,			; copy string_1 to string_2
	  ADDR string_1 ,
	  ADDR string_2 + 9,
	  (SIZEOF string_2) - 1 	; save space for null byte

; Display the destination string
	mov  edx,OFFSET string_2
	call WriteString
	call Crlf
	call WaitMsg
	exit
main ENDP

Str_copyN PROC USES eax ecx esi edi,
 	source:PTR BYTE, 		    ; source string
 	target:PTR BYTE,		    ; target string
 	maxChars:DWORD			; max chars to copy
;
; Copy a string from source to target, limiting the number
; of characters to copy. Value in maxChars does not include
; the null byte.

	mov	ecx,maxChars		; specify count for REP
	mov	esi,source       ; assign source
	mov	edi,target       ; assign target
	cld               	; direction = forward 
; (clear direction flag)
	rep movsb      		; copy the string
	mov	al,0            ; set null byte
	stosb 				; append null byte
	ret
Str_copyN ENDP

END main