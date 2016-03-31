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
	inc ecx			; increment number of chars read
	cmp eax, 48		;
	je zero			;
	jmp one			;
zero:
	mov dx, 65534		; set dx to a mask with a zero in the rightmost bit
	mov edi, ecx		; set edi to the number of bits read
rotate_mask_zero:
	cmp edi, 0		;
	je end_zero_loop	;
	rol dx, 1		;
	dec edi			;
	jmp rotate_mask_zero	;
end_zero_loop:
	and bx, dx		;
	jmp main_loop		;
one:
	mov dx, 1		; set dx to a mask with a 1 in the rightmost bit, and zeros for the rest
	mov edi, ecx		;  set edi to the number of bits read
rotate_mask_one:
	cmp edi, 0		;
	je end_one_loop		;
	rol dx, 1		;
	dec edi			;
	jmp rotate_mask_one	;
end_one_loop:
	and bx, dx		;
	jmp main_loop		;
end:
	mov eax, decimalValue	; print "Its decimal value is: "
	call print_string	; print "Its decimal value is: "
	movzx eax, bx		; print decimal value of number
	call print_int		; print decimal value of number
	
	popa
	mov	eax, 0		; return back to C
	leave
	ret
