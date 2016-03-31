%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;

	enterBinary db "Enter a (<16 bits) binary number: ", 0
	decimalValue db "Its decimal value is: ", 0
	itsOne db "character read was a 1", 0
	itsZero db "character read was a 0", 0



segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha

	mov eax, enterBinary	; print "Enter a (<16 bits) binary number: "
	call print_string	; print "Enter a (<16 bits) binary number: "
	mov ecx, 0		; set ecx as counter for number of chars read
	mov bx, 0		; use bx to store number that is read (will modify bits in this register)
main_loop:
	call read_char		;
	cmp eax, 10		; check for new line
	je end			; jump to end if a new line character is read
	cmp ecx, 16		; check to see if 16 bits have been read
	je end			; jump to end if 16 bits have been read
	shl bx, 1		;
	cmp eax, 48		;
	je zero			;
	jmp one			;
zero:
	mov eax, itsZero
	call print_string
	call print_nl
	mov dx, 65534		; set dx to a mask with a zero in the rightmost bit
	and bx, dx		;
	inc ecx			; increment the number of chars read
	jmp main_loop		;
one:
	mov eax, itsOne
	call print_string
	call print_nl
	mov dx, 1		; set dx to a mask with a 1 in the rightmost bit, and zeros for the rest
	or bx, dx		;
	inc ecx			; increment the number of chars read
	jmp main_loop		;
end:
	mov eax, decimalValue	; print "Its decimal value is: "
	call print_string	; print "Its decimal value is: "
	movzx eax, bx		; print decimal value of number
	call print_int		; print decimal value of number
	call print_nl		; print a new line
	
	popa
	mov	eax, 0		; return back to C
	leave
	ret
