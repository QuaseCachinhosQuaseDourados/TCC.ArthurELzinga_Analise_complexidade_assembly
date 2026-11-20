	.file	"Write_program_to_calculate_pow(x,_n)_3.c"
	.text
	.globl	power
	.def	power;	.scl	2;	.type	32;	.endef
	.seh_proc	power
power:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %esi
	movl	%edx, %ebx
	movl	$1, %eax
	testl	%edx, %edx
	jne	.L5
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L5:
	shrl	%edx
	call	power
	testb	$1, %bl
	jne	.L3
	imull	%eax, %eax
	jmp	.L1
.L3:
	imull	%eax, %esi
	imull	%esi, %eax
	jmp	.L1
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
