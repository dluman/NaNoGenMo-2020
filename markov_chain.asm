section .text
    global  _start

_start:
    ;read from source text
    call    stats
    call    read

    ;print file contents
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, corpus
    mov     edx, fsize
    int     0x80

    ;quit the kernel
    mov     eax, 1
    int     0x80
    
stats:
    ;apparently syscode 28 gets size
    mov     eax, 28
    mov     ebx, file
    int     0x80
    
    ;save the file size
    mov     [fsize], eax
    int     0x80
 
    ret

read:
    ;open the file
    mov     eax, 5
    mov     ebx, file
    mov     ecx, 0
    mov     edx, 0777
    int     0x80
    
    mov     [fd_in], eax

    ;read from file
    mov     eax, 3
    mov     ebx, [fd_in]
    mov     ecx, corpus
    mov     edx, fsize
    int     0x80

    ;close fh
    mov     eax, 6
    mov     ebx, [fd_in]
    int     0x80
    
    ret

section .data
    file    db 'corpus.txt'

section .bss
    fd_in   resb 1
    fsize   resb 16
    corpus  resb 16