section .text
  global  _start

_start:
  ;read from source text
  ;call    info
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

info:
  mov     eax, 4
  mov     ebx, file
  mov     ecx, fsize
  int     0x80
  
  mov     eax, dword[fsize + STAT.size]
  mov     [corpus], eax
  
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
  file    db  'corpus.txt'

section .bss
  fd_in   resb  1
  fsize   resb  64
  corpus  resb  2729061               ; It's a hack!

struc STAT
  .size:  resd  1
endstruc