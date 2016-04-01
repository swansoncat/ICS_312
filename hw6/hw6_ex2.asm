%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;

	enterBinary db "Enter a (<16 bits) binary number: ", 0
	decimalValue db "Its decimal value is: ", 0
	tester db "test test test", 0
	kalen db "kalen kalen kalen", 0


segment .bss
;
; uninitialized data is put in the bss segment
;

	integerOne resw 1
	integerTwo resw 1


segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha
	mov esi, 0		; set esi to number of integers stored
start:
	mov eax, enterBinary	; print "Enter a (<16 bits) binary number: "
	call print_string	; print "Enter a (<16 bits) binary number: "
	mov ecx, 0		; set ecx as counter for number of chars read
	mov bx, 0		; use bx to store number that is read (will modify bits in this register)
main_loop:
	call read_char		; read a character
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
	cmp esi, 1		; check to see if the first number was already stored
	je store_second_number	; jump to block to store second number if first number was already stored
	mov [integerOne], bx	; store first number into integerOne
	inc esi			; increment counter for numbers stored
	cmp esi, 2		; check if two numbers have been stored already
	jl start		; ask for another integer if less than two numbers have been read
store_second_number:
	mov [integerTwo], bx	; store the second number into integerTwo
final_end:
	mov ax, [integerOne]	; set ax to first number
	mov bx, [integerTwo]	; set bx to second number
	add bx, ax		; add ax and bx, store in bx
	mov ecx, 0		; set ecx to 0 to use as counter for bits that have been read
begin_print:
	rol bx, 1		; roll all the bits in bx to the left
	jc one_carry		; if the bit was a one, jump
	mov eax, 0		; print "0"
	call print_int		; print "0"
	inc ecx			; increment number of bits read
	cmp ecx, 16		; check to see if 16 bits have been read
	jl begin_print		; if less than 16 bits have been read, jump to begnning of loop to read next bit
	je done			; if 16 bits have been read, jump to section to print hex
one_carry:
	mov eax, 1		; print "1"
	call print_int		; print "1"
	inc ecx			; increment number of bits read
	cmp ecx, 16		; check to see if 16 bits have been read
	jl begin_print		; if less than 16 bits have been read, jump to beginning of loop to read next bit
done:
	call print_nl		; print a new line
	mov esi, 0		; set esi to number of hex digits printed
done_h:
	cmp esi, 4		; check to see if 4 hex digits have already been printed
	je hex_end		; jump to end of program if 4 hex digits have been printed
	mov dx, 0		; set dx to sum that will be hex digit
	mov eax, 0		; set eax to 0
	mov ax, 16		; set ax to number representing value of the current bit of hex digit being checked
	mov cl, 2		; set cl as 2 for use in modifying value of the current bit of hex digit being checked
hex_start:
	div cl			; divide value of hex digit by 2	
	rol bx, 1		; shift bits in bx to the left
	jnc skip		; if bit was a 0, don't add anything to sum that will be hex digit
	add dx, ax		; if bit was a 1, add to dx the value of that bit
skip:
	cmp ax, 1		; check to see if value of current bit is 1
	je hex_print		; if current bit is 1, jump to hex printing block (similar to what would be a switch statement)
	jmp hex_start		; jump to beginning of hex_start loop, which is to determine value of the hex digit to be printed
hex_print:
	add esi, 1		; increment the number of hex digits printed by 1
	cmp dx, 0		; compare the value of the hex digit to 0
	jne hex_1		; jump to block to compare value of hex digit to 1 if dx is not equal to 0
	mov al, 48		; set al to ascii code for "0"
	call print_char		; print "0"
	jmp done_h		; jump to beginning of done_h loop, which is the start of determining value of a hex digit
hex_1:
	cmp dx, 1		;
	jne hex_2		;
	mov al, 49		;
	call print_char		;
	jmp done_h		;
hex_2:
	cmp dx, 2		;
	jne hex_3		;
	mov al, 50		;
	call print_char		;	
	jmp done_h		;
hex_3:
	cmp dx, 3		;
	jne hex_4		;
	mov al, 51		;
	call print_char		;
	jmp done_h		;
hex_4:
	cmp dx, 4		;
	jne hex_5		;
	mov al, 52		;
	call print_char		;
	jmp done_h		;
hex_5:
	cmp dx, 5		;
	jne hex_6		;
	mov al, 53		;
	call print_char		;
	jmp done_h		;
hex_6:
	cmp dx, 6		;
	jne hex_7		;
	mov al, 54		;
	call print_char		;
	jmp done_h		;
hex_7:
	cmp dx, 7		;
	jne hex_8		;
	mov al, 55		;
	call print_char		;
	jmp done_h		;
hex_8:
	cmp dx, 8		;
	jne hex_9		;
	mov al, 56		;
	call print_char		;
	jmp done_h		;	
hex_9:
	cmp dx, 9		;
	jne hex_a		;
	mov al, 57		;
	call print_char		;
	jmp done_h		;
hex_a:
	cmp dx, 10		;
	jne hex_b		;
	mov al, 65		;
	call print_char		;
	jmp done_h		;
hex_b:
	cmp dx, 11		;
	jne hex_c		;
	mov al, 66		;
	call print_char		;
	jmp done_h		;	
hex_c:
	cmp dx, 12		;
	jne hex_d		;
	mov al, 67		;
	call print_char		;
	jmp done_h		;
hex_d:
	cmp dx, 13		;
	jne hex_e		;
	mov al, 68		;
	call print_char		;
	jmp done_h		;
hex_e:
	cmp dx, 14		;
	jne hex_f		;
	mov al, 69		;
	call print_char		;
	jmp done_h		;
hex_f:
	mov al, 70		;
	call print_char		;
	jmp done_h		;
hex_end:
	call print_nl		; print new line
	popa
	mov	eax, 0		; return back to C
	leave
	ret
