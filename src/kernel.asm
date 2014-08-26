.set MAGIC, 0x1BADB002
.set MBOOT_FLAGS, 0x00000003
.set CHECKSUM, -(MAGIC + MBOOT_FLAGS)
.set STACK_SIZE, 0x4000

.text
.globl start
start:
	jmp multiboot_entry
	.align 4
multiboot_header:
	.long MAGIC
	.long MBOOT_FLAGS
	.long CHECKSUM
multiboot_entry:
	movl $(stack + STACK_SIZE), %esp
	call GenyKernel_Main
loop: hlt
	jmp loop
.section ".bss"
	.comm stack,STACK_SIZE
