extern  malloc                        ; This is probably cheating

section .text
  global  _start

_start:
  ;read from source text
  call    read
  ;call    to_string
  call    crawl

  ;print file contents char by char
  ;print:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, corpus
    mov     edx, buflen
    int     0x80
    ;jg      print

  ;quit the kernel
  mov     eax, 1
  int     0x80

read:
  ;open the file
  mov     eax, 5
  mov     ebx, file
  mov     ecx, 0
  int     0x80
  
  mov     [fd_in], eax

  ;read from file
  mov     eax, 3
  mov     ebx, [fd_in]
  mov     ecx, corpus
  mov     edx, buflen
  int     0x80

  ;close fh
  mov     eax, 6
  mov     ebx, [fd_in]
  int     0x80
  
  ret

;to_string:
  
  ;ret
  
crawl:
  lea     di, offset corpus, 0
  mov     cx, 0h
  
  print:
    mov   dl, [di]
    mov   ah, 02h
    int   21h
    
    inc   di
    dec   cx
    jg    print

  ret

section .data
  ;file name to read
  file    db  "corpus.txt"

  ;data structure
  size_i:
    struc node
      char: resd  1
      num:  resd  1
      next: resd  1
    endstruc
  len     equ   $ - size_i

section .bss
  fd_in   resb  1
  corpus  resb  2729061               ; It's a hack!
  buflen: equ   $ - corpus