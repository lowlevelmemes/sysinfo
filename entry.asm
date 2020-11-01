bits 32

section .multiboot
global multiboot
multiboot:
    dd 0x1badb002
    dd (1<<0)|(1<<1)
    dd -((1<<0)|(1<<1) + 0x1badb002)

section .text
global _start
extern kmain
_start:
    mov esp, 0x100000
    jmp kmain