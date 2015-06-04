
INCLUDE Irvine32.inc
main          EQU start@0
.data
consoleHandle    DWORD ?
xyInit COORD <59,9> ; 起始座標
xyBound COORD <80,25> ; 一個頁面最大的邊界
xyPos COORD <40,12> ; 現在的游標位置

.code
main PROC

; Get the Console standard output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax
	
; 設定回到起始位置
START:
	call ClrScr
	INVOKE SetConsoleCursorPosition, consoleHandle, xyPos
	call ReadChar
	.IF ax == 1177h ;UP
		sub xyPos.y,1
	.ENDIF
	.IF ax == 1F73h ;DOWN
		add xyPos.y,1
	.ENDIF
	.IF ax == 1E61h ;LEFT
		sub xyPos.x,1
	.ENDIF
	.IF ax == 2064h ;RIGHT
		add xyPos.x,1
	.ENDIF
	.IF ax == 011Bh ;ESC
		jmp END_FUNC
	.ENDIF
	
	.IF xyPos.x == -1 ;x lowerbound
		mov xyPos.x,0
	.ENDIF
	mov ax,xyBound.x
	.IF xyPos.x >= ax
		mov xyPos.x,79
	.ENDIF
	
	.IF xyPos.y <= 0h
		mov xyPos.y, 1
	.ENDIF
	mov ax,xyBound.y
	.IF xyPos.y >= ax
		mov xyPos.y,25
	.ENDIF
	
	jmp START
END_FUNC:
	exit
main ENDP

END main