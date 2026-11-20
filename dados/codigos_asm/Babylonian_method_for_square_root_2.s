	.file	"Babylonian_method_for_square_root_2.c"
	.text
	.globl	squareRoot
	.def	squareRoot;	.scl	2;	.type	32;	.endef
	.seh_proc	squareRoot
squareRoot:
	.seh_endprologue
	cmpl	$1, %ecx
	jle	.L4
	movl	%ecx, %r8d
	movl	$1, %edx
.L3:
	addl	%edx, %r8d
	movl	%r8d, %r9d
	shrl	$31, %r9d
	addl	%r8d, %r9d
	sarl	%r9d
	movl	%r9d, %r8d
	movl	%ecx, %eax
	cltd
	idivl	%r9d
	movl	%eax, %edx
	cmpl	%eax, %r9d
	jg	.L3
.L2:
	movl	%r8d, %eax
	ret
.L4:
	movl	%ecx, %r8d
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "root of %d is %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$49, %ecx
	call	squareRoot
	movl	%eax, %r8d
	movl	$49, %edx
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
