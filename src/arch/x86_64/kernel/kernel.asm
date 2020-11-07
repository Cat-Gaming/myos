[org 0x7e00]

main:
    mov si, kernel_version_string
    call printf
jmp $

%include "src/arch/x86_64/utils/print.asm"
kernel_version_string: db "Kernel Version 0.1", 0xd, 0xa, 0