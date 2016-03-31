%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;

	enterBinary db "Enter a (<16 bits) binary number: ", 0
	decimalValue db "Its decimal value is: ", 0



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
	shl bx, 1		; shift the register holding the bits to the left by one (this is irrelevant on the first iteration of loop, bits are all zeroes)
	cmp eax, 48		; check to see if character read was a 0
	je zero			; jump if character read was a 0
	jmp one			; jump if character read was not zero (assuming 1 in this case)
zero:
	mov dx, 65534		; set dx to a mask with a zero in the rightmost bit
	and bx, dx		; set rightmost bit of bx to zero
	inc ecx			; increment the number of chars read
	jmp main_loop		; jump to main loop
one:
	mov dx, 1		; set dx to a mask with a 1 in the rightmost bit, and zeros for the rest
	or bx, dx		; set rightmost bit of bx to one
	inc ecx			; increment the number of chars read
	jmp main_loop		; jump to main loop
end:
	mov eax, decimalValue	; print "Its decimal value is: "
	call print_string	; print "Its decimal value is: "
	movsx eax, bx		; print decimal value of number
	call print_int		; print decimal value of number
	call print_nl		; print a new line
	popa
	mov	eax, 0		; return back to C
	leave
	ret
