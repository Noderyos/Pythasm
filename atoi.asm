BITS 64

; Convert the string at the address of R10 
; to an integer in R11


section .text

_atoi:
	mov r14, r10
	call _strlen
	push rcx
	xor rcx,rcx
	push rax
	xor rax,rax
	push rbx
_atoi_loop:
	movzx rdx, byte[r10+rcx]
	sub rdx, "0"
	imul rax, 10
	add rax, rdx
	inc rcx
	cmp rcx,r15
	jne _atoi_loop
	xor r11,r11
	mov r11,rax
	pop rbx
	pop rax
	pop rcx
	ret


_strlen: ; input R14 => adress of the string
		 ; output R15 => size of the string
	push r13
	xor r15, r15
_strl_loop:
	mov r13b, byte[r14+r15]
	inc r15
	cmp r13b, 0x0
	jne _strl_loop

	dec r15
	dec r15
	pop r13
	ret
