read_disk:
    pusha
    mov ah, 02h
    mov al, 1 ; number of sectors to read
    mov ch, 0
    mov cl, 2 ; sector to read from
    mov dh, 0
    mov dl, 00h ; drive to read from
    mov bx, kernel_space
    int 13h
    jc error
    jmp success
error:
    mov si, disk_read_error_msg
    call printf
    jmp $
success:
    popa
    ret

kernel_space: equ 0x7e00
disk_read_error_msg: db "Error Reading Disk!", 0xd, 0xa, 0