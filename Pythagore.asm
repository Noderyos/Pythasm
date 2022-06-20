bits 64

%include "atoi.asm"
%include "itoa.asm"

section .bss
    firstValue resb 16
    secondValue resb 16
    result resb 16

section .data
    txt1 db "Quel est la longeur du premier nombre ? "
    txt1_l equ $-txt1
    txt2 db "Quel est la longeur du second nombre ? "
    txt2_l equ $-txt2
    res db "L",0x27,"hypothenuse vaut : "
    res_l equ $-res
    aa db 0xa

section .text

global _start
extern le_sqrt 

_start:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, txt1
    mov rdx, txt1_l
    syscall                  ; Ask for a length

    mov rax, 0x0
    mov rdi, 0x0
    mov rsi, firstValue
    mov rdx, 16
    syscall             ; input a



    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, txt2
    mov rdx, txt2_l
    syscall                  ; Ask for b length

    mov rax, 0x0
    mov rdi, 0x0
    mov rsi, secondValue
    mov rdx, 16
    syscall             ; input b

    mov r10, firstValue
    call _atoi

    mov rax,r11
    mov rbx,r11
    mul rax
    mov r12,rax

    mov r10, secondValue
    call _atoi
    mov rax,r11
    mov rbx,r11
    mul rax

    add r12,rax            ;r12 contient a²+b²

    mov rdi,r12
    call le_sqrt

    mov r12, rax
    call _lenght_int
    mov r11, r14
    push r14
    mov r14, rax
    mov r15, result
    call _itoa

    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, res
    mov rdx, res_l
    syscall

    mov rax, 0x1
    mov rdi, 0x1
    pop rdx
    mov rsi, r15
    syscall

    mov rax, 0x1
    mov rdi, 0x1
    mov rdx, 0x1
    mov rsi, aa
    syscall

; input R14 => value
; input R11 => log10 of the value
; input R15 => adress of the string


_exit:
    mov rax,0x3c
    mov rsi,0x0
    syscall

_lenght_int:
    mov r14,0
    push rax ; diviseur
    push rbx ;dividende
    push r12 ;Résulat c (a²+b²=c²)
_lenght_int_loop:

    mov rax,r12
    mov rbx,10
    cqo
    idiv rbx
    mov r12,rax
    inc r14
    cmp r12, 0xa 
    jge _lenght_int_loop
    inc r14
    pop r12
    pop rbx
    pop rax
    ret