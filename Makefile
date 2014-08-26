CC=gcc
CFLAGS=-nostdlib -fPIC -ffreestanding
AS=as

all: START.ELF

kernel.o: src/kernel.asm
	as -o $@ -c $<

GenyKernel_Main.o: src/GenyKernel_Main.c
	${CC} -o $@ -c $< ${CFLAGS}

START.ELF: kernel.o GenyKernel_Main.o
	${CC} -o geny/boot/$@ $^ -Tsrc/kernel.ld ${CFLAGS} -lgcc

iso: START.ELF
	grub-mkrescue -o geny.iso geny/

test: iso
	qemu-system-i386 geny.iso

clean:
	rm -f *.o *.iso geny/boot/START.ELF