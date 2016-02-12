%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
	enterCharacter db "Enter a character: ",0
	enterInteger db "Enter a integer between 1 and 10: ",0
        characterWas db "The character entered was: '",0
	transformedCharacter db "The transformed character is: '",0
	apos db "'",0

segment .bss
;
; uninitialized data is put in the bss segment
;

	character resd 1
	integer resd 1

segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha
	mov eax, enterCharacter	; print "Enter a character: "
	call print_string 	; print "Enter a character: "
	call read_char		; reads the char inputted by user
	mov [character], eax	; saves the char inputted by the user into the variable 'character'
	mov eax, enterInteger	; print "Enter a integer between 1 and 10: "
	call print_string	; print "Enter a integer between 1 and 10: "
	call read_int		; reads the integer inputted by the user
	mov [integer], eax	; saves the integer inputted by the user into the variable 'integer'
	mov eax, characterWas	; print "The character entered was: "
	call print_string	; print "The character entered was: "
	mov eax, [character]	; move the character the user gave into eax
	call print_char		; print the character the user entered
	mov eax, [apos]
	call print_char
	call print_nl		; prints a new line
	mov eax, transformedCharacter	; print "The transformed character is: "
	call print_string	; print "The transformed character is: "
	mov eax, [character]	; transform character
	add eax, [integer]	; transform character
	call print_char		; print the transformed character
	mov eax, [apos]
	call print_char
	call print_nl
	popa
	mov	eax, 0		; return back to C
	leave
	ret

