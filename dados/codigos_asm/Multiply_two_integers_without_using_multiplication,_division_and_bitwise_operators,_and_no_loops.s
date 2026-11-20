	.file	"Multiply_two_integers_without_using_multiplication,_division_and_bitwise_operators,_and_no_loops.c"
	.text
	.globl	multiply
	.def	multiply;	.scl	2;	.type	32;	.endef
	.seh_proc	multiply
multiply:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	testl	%edx, %edx
	je	.L2
	jg	.L4
	negl	%edx
	call	multiply
	negl	%eax
	movl	%eax, %edx
	jmp	.L2
.L4:
	subl	$1, %edx
	call	multiply
	leal	(%rax,%rbx), %edx
.L2:
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\12 %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$-11, %edx
	movl	$5, %ecx
	call	multiply
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
