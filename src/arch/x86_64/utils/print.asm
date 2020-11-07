printf:
    pusha
.loop:
    mov al, [si]
    cmp al, 0
    je .end
    mov ah, 0x0e
    int 10h
    add si, 1
    jmp .loop
.end:
    popa
    ret    
