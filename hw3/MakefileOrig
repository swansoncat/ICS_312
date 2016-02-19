hw3_ex1: hw3_ex1.o asm_io.o driver.o
	gcc -m32 hw3_ex1.o asm_io.o driver.o -o hw3_ex1

hw3_ex1.o: hw3_ex1.asm
	nasm -f elf hw3_ex1.asm -o hw3_ex1.o

asm_io.o: asm_io.asm
	nasm -f elf -d ELF_TYPE asm_io.asm -o asm_io.o

driver.o: driver.c
	gcc -m32 -c driver.c -o driver.o
