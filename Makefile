CC = i686-elf-gcc
LD = i686-elf-ld
AS = nasm

C_FILES = $(shell find ./ -type f -name '*.c')
ASM_FILES = $(shell find ./ -type f -name '*.asm')
REAL_FILES = $(shell find ./real -type f -name '*.real')
OBJ = $(C_FILES:.c=.o) $(ASM_FILES:.asm=.o)
BINS = $(REAL_FILES:.real=.bin)
CFLAGS = -O2 -nostdlib -ffreestanding -Iinc
LDFLAGS = -Tlinker.ld

.PHONY: clean run

kernel.elf: $(BINS) $(OBJ)
	$(LD) $(OBJ) $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.o: %.asm
	$(AS) $< -f elf32 -o $@

%.bin: %.real
	$(AS) $< -f bin -o $@

clean:
	rm -f $(BINS) $(OBJ) kernel.elf

run:
	qemu-system-i386 -kernel kernel.elf -m 32M