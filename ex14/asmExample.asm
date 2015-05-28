TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

BoxWidth = 3
BoxHeight = 3

.data
boxTop    BYTE 0DAh, (BoxWidth - 2) DUP(0C4h), 0BFh
boxBody   BYTE 0B3h, (BoxWidth - 2) DUP(' '), 0B3h
boxBottom BYTE 0C0h, (BoxWidth - 2) DUP(0C4h),0D9h

outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
xyPosition COORD <10,5>

cellsWritten DWORD ?
attributes0 WORD BoxWidth DUP(0Ch)
attributes1 WORD (BoxWidth-1) DUP(0Eh),0Ah
attributes2 WORD BoxWidth DUP(0Bh)

	
.code
main PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE	; Get the console ouput handle
	mov outputHandle, eax	; save console handle
	call Clrscr
	; 畫出box的第一行

	INVOKE WriteConsoleOutputAttribute,
	  outputHandle, 
	  ADDR attributes0, 
	  BoxWidth,
	  xyPosition,
	  ADDR count

	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxTop,	; pointer to the top box line
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	; output count

	inc xyPosition+(TYPE xyPosition)/2	; 座標換到下一行位置

	mov ecx, (1)	; number of lines in body
	
	L1:	push ecx	; save counter 避免invoke 有使用到這個暫存器

	INVOKE WriteConsoleOutputAttribute,
	  outputHandle, 
	  ADDR attributes1,
	  BoxWidth, 
	  xyPosition,
	  ADDR count


	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxBody,	; pointer to the top box line
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	;

	inc xyPosition+(TYPE xyPosition)/2	; next line
	pop ecx	; restore counter
	loop L1

	INVOKE WriteConsoleOutputAttribute,
	  outputHandle, 
	  ADDR attributes2,
	  BoxWidth, 
	  xyPosition,
	  ADDR count


	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxBottom,	; pointer to the top box line
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	;

	call WaitMsg
	call Clrscr
	exit

main ENDP
END main