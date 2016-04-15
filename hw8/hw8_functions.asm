;; function inputArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "asm_io.inc"

segment .data
	input_array_not_implemented	db	"inputArray: NOT IMPLEMENTED",0
	enterInt db "Enter an integer: ", 0


segment .bss

segment .text

inputArray:
	push ebp		; push value of ebp onto th stack
	mov ebp, esp		; saved value of esp into ebp
	pusha			; save the content of all registers

	mov edi, [ebp+8]	; move address of Array into edi
	add edi, 40		; make edi address of dword immediately after last dword of array
	mov esi, [ebp+8]	; move address of Array into edi
begin_read:
	mov eax, enterInt	; print "Enter an integer: "
	call print_string	; print "Enter an integer: "
	call read_int		; read integer entered by user
	mov [esi], eax		; move integer read into the array
	add esi, 4		; increment index of array
	cmp esi, edi		; check to see if past last dword of array
	jnz begin_read		; if not past last dword of array, jump back to beginning of loop
end_read:
	popa			; restore value of all registers
	pop ebp			; restore prior value of ebp
	ret			; return from function


;; function printArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	print_array_not_implemented	db	"printArray: NOT IMPLEMENTED",0
	list db "List: ", 0
	comma db ", ", 0

segment .bss

segment .text

printArray:
	push ebp		; push value of ebp onto stack
	mov ebp, esp		; set value of ebp to esp
	pusha			; push value of all registers onto the stack
	mov edi, [ebp+8]	; move address of Array into edi
	add edi, 40		; make edi address of dword immediately after last dword of Array
	mov esi, [ebp+8]	; move address of Array into esi
	mov eax, list		; print "List: "
	call print_string	; print "List: "
begin_print:
	mov eax, [esi]		; move number at current index of the array into eax
	call print_int		; print the number at the current index of the array
	add esi, 4		; increment index of array
	cmp esi, edi		; check to see if past last index of the array
	jz end_print		; jump to end of subprogram if past last index of the array
	mov eax, comma		; print ", "
	call print_string	; print ", "
	jmp begin_print		; jump back to beginning of print loop
end_print:
	call print_nl		; print new line
	popa			; restore values of all registers
	pop ebp			; restore value of ebp
	ret			; return from subprogram

;; function findValue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	find_value_not_implemented	db	"findValue: NOT IMPLEMENTED",0

segment .bss

segment .text

findValue:
	mov	eax, find_value_not_implemented
	call	print_string
	call	print_nl
	mov	eax, 0
	ret


;; function swapValues
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	swap_values_not_implemented	db	"swapValues: NOT IMPLEMENTED",0

segment .bss

segment .text


swapValues:
	mov	eax, swap_values_not_implemented
	call	print_string
	call	print_nl
	mov	eax, 0
	ret

