%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;

	enterInt db "Enter an integer: ", 0
	numPat db "number of patterns: ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
	global  asm_main
asm_main:
	enter 0,0		; setup routine
	pusha

	mov eax, enterInt	; print "Enter an integer: "
	call print_string	; print "Enter an integer: "
	call read_int		; read the integer from the user
	cmp eax, 0		; check to see if number is 0
	je end			; end program if number entered was 0
	mov ebx, eax		; set ebx to number entered by user
	mov edi, 0		; set edi to index to count number of bits read
read_bits:
	rol ebx, 1		; roll bits in ebx to the left
	jc print_one		; jump to code to print "1" if the bit read was 1
	mov eax, 0		; print "0"
	call print_int		; print "0"
	inc edi			; increment number of bits read
	cmp edi, 32		; check to see if 32 bits have been read
	jl read_bits		; jump back to beginning of read bits loop if less than 32 bits have been read
	je check_pattern	; jump to check pattern section if 32 bits have been read
print_one:
	mov eax, 1		; print "1"
	call print_int		; print "1"
	inc edi			; increment number of bits read
	cmp edi, 32		; check to see if 32 bits have been read
	jl read_bits		; jump back to beginning of read bits loop if less than 32 bits have been read
check_pattern:
	call print_nl		; print new line
	mov edi, 0		; set edi to index to count number of bits read
	mov esi, 0		; set esi to counter for patterns of "101" read
read_bits2:
	mov cl, bl		; move smallest 8 bits of number read into cl
	and cl, 7		; apply mask to cl, zeroing out all the bits except the lowest 3
	cmp cl, 5		; check to see if cl matches "00000101"
	jne skip		; skip if cl doesn't match 
	inc esi			; increment pattern counter if cl matches
skip:
	inc edi			; increment number of bits read
	cmp edi, 32		; check to see if 32 bits have been read
	je end			; jump to end if 32 bits have been read
	ror ebx, 1		; roll bits in ebx to the right
	jmp read_bits2		; jump to beginning of read_bits2 loop
end:
	mov eax, numPat		; print "number of patterns: "
	call print_string	; print "number of patterns: "
	mov eax, esi		; print # of patterns of "101"
	call print_int		; print # of patterns of "101"
	call print_nl		; print new line
	popa
	mov	eax, 0		; return back to C
	leave
	ret
