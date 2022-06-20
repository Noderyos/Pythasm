BITS 64

; Convert the int at R10
; to a string at address of R11
section .bss
	salut resb 16


section .text

_itoa: ; input R14 => value
		; input R11 => log10 of the value
		; input R15 => adress of the string
	push rax
	push rbx
	push r13
	push r14
	xor rax,rax
	xor rbx,rbx
_itoa_loop:
	dec r11
	mov rax, r14
	mov rbx, 10
	cqo
	idiv rbx
	push rax
	imul rax, 10
	mov r13, r14
	sub r13, rax
	add r13, "0"
	
	mov [r15+r11], r13b
	pop r14
	cmp rax, 0xa
	jge _itoa_loop

	pop r14
	pop r13
	pop rbx
	pop rax
	ret

_print:
	mov rax, 0x1
	mov rdi, 0x1
	mov rsi, r15
	mov rdx, r8
	syscall
	ret