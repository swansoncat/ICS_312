%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
	enterCharacter db "Enter a character: ",0
	enterInteger db "Enter a integer between 1 and 10: ",0
        characterWas db "The character entered was: ",0
	transformedCharacter db "The transformed character is : ",0

segment .bss
;
; uninitialized data is put in the bss segment
;

	character resb 1
	integer resb 1

segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha
	mov eax, enterCharacter	; print "Enter a character: "
	call print_string 	; print "Enter a character: "
	popa
	mov	eax, 0		; return back to C
	leave
	ret

