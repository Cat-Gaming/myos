[org 0x7c00]

global start

section .text

start:
    xor ax, ax
    cli
    mov ss, ax
    mov sp, 0x7c00
    sti

    mov si, boot_string
    call printf
    mov si, version_string
    call printf

    call read_disk
    mov si, success_reading_disk
    call printf

    jmp kernel_space
jmp $

%include "src/arch/x86_64/utils/print.asm"
%include "src/arch/x86_64/utils/read_disk.asm"

boot_string: db "Bootloader Successfully Loaded.", 0xd, 0xa, 0
version_string: db "MyOS version 0.1 Alpha", 0xd, 0xa, 0
success_reading_disk: db "Successfully Read Disk!", 0xd, 0xa, 0

times 510 - ($-$$) db 0
dw 0xaa55