	.file	"Program_to_calculate_pow(x,_n)_using_Divide_and_Conqueror_approach.c"
	.text
	.globl	power
	.def	power;	.scl	2;	.type	32;	.endef
	.seh_proc	power
power:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$1, %eax
	testl	%edx, %edx
	je	.L1
	testb	$1, %dl
	jne	.L3
	shrl	%edx
	call	power
	imull	%eax, %eax
.L1:
	addq	$32, %rsp
	popq	%rbx
	ret
.L3:
	shrl	%edx
	call	power
	imull	%eax, %ebx
	imull	%ebx, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$3, %edx
	movl	$2, %ecx
	call	power
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
