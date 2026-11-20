	.file	"Pascal\222s_Triangle.c"
	.text
	.globl	binomialCoeff
	.def	binomialCoeff;	.scl	2;	.type	32;	.endef
	.seh_proc	binomialCoeff
binomialCoeff:
	.seh_endprologue
	movl	%ecx, %r9d
	subl	%edx, %r9d
	cmpl	%edx, %r9d
	cmovg	%edx, %r9d
	testl	%r9d, %r9d
	jle	.L4
	movl	$0, %r8d
	movl	$1, %eax
.L3:
	movl	%ecx, %edx
	subl	%r8d, %edx
	imull	%edx, %eax
	addl	$1, %r8d
	cltd
	idivl	%r8d
	cmpl	%r9d, %r8d
	jne	.L3
.L1:
	ret
.L4:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printPascal
	.def	printPascal;	.scl	2;	.type	32;	.endef
	.seh_proc	printPascal
printPascal:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %r12d
	movl	$1, %edi
	movl	$0, %esi
	leaq	.LC0(%rip), %rbp
	testl	%ecx, %ecx
	jg	.L7
.L6:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L10:
	movl	$10, %ecx
	call	putchar
	addl	$1, %esi
	addl	$1, %edi
	cmpl	%esi, %r12d
	je	.L6
.L7:
	movl	$0, %ebx
	testl	%esi, %esi
	js	.L10
.L9:
	movl	%ebx, %edx
	movl	%esi, %ecx
	call	binomialCoeff
	movl	%eax, %edx
	movq	%rbp, %rcx
	call	printf
	addl	$1, %ebx
	cmpl	%ebx, %edi
	jne	.L9
	jmp	.L10
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$7, %ecx
	call	printPascal
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
