.PHONY: all
all:
	nasm -f elf64 Pythagore.asm -o Pythagore.o
	gcc -ffreestanding -c sqrt.c -o sqrt.o
	ld -o app Pythagore.o sqrt.o

.PHONY: clean
clean:
	rm -f app *.o
