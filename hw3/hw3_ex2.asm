%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;

	enterString db "Enter a 5-character string: ", 0
	str1 db "String #1: ", 0
	str2 db "String #2: ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

	tStr1 resb 6
	tStr2 resb 11

segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha

	mov eax, enterString	; print "Enter a 5-character string: "
	call print_string	; print "Enter a 5-character string: "
	mov ebx, tStr1		; move the address of tStr1 into the ebx register
	add ebx, 4		; change the address in the ebx register to 4 places forward
	call read_char		; read the first character in the string
	mov [ebx], al		; move the char in register al into the address in register ebx
	sub ebx, 1		; change the address in th ebx register to 1 place back
	call read_char		; read the second character in the string
	mov [ebx], al		; move the char in register al into the address in register ebx
	sub ebx, 1		; change the address in th ebx register to 1 place back
	call read_char		; read the third character in the string
	mov [ebx], al		; move the char in register al into the address in register ebx
	sub ebx, 1		; change the address in th ebx register to 1 place back
	call read_char		; read the third character in the string
	mov [ebx], al		; move the char in register al into the address in register ebx
	sub ebx, 1		; change the address in th ebx register to 1 place back
	call read_char		; read the third character in the string
	mov [ebx], al		; move the char in register al into the address in register ebx
	add ebx, 5		; change the address in th ebx register to 1 place back
	mov [ebx], byte 0	; add end of string character
	mov eax, tStr1
	call print_string


	popa
	mov	eax, 0		; return back to C
	leave
	ret

