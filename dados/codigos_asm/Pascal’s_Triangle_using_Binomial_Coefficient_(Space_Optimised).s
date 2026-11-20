	.file	"Pascal\222s_Triangle_using_Binomial_Coefficient_(Space_Optimised).c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printPascal
	.def	printPascal;	.scl	2;	.type	32;	.endef
	.seh_proc	printPascal
printPascal:
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
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
	testl	%ecx, %ecx
	jle	.L1
	leal	1(%rcx), %r12d
	movl	$2, %edi
	movl	$1, %esi
	movl	$1, %r13d
	leaq	.LC0(%rip), %rbp
	jmp	.L3
.L5:
	movl	$10, %ecx
	call	putchar
	addl	$1, %esi
	addl	$1, %edi
	cmpl	%r12d, %esi
	je	.L1
.L3:
	movl	$1, %ebx
	movl	%r13d, %r14d
	testl	%esi, %esi
	jle	.L5
.L4:
	movl	%r14d, %edx
	movq	%rbp, %rcx
	call	printf
	movl	%esi, %eax
	subl	%ebx, %eax
	imull	%r14d, %eax
	cltd
	idivl	%ebx
	movl	%eax, %r14d
	addl	$1, %ebx
	cmpl	%edi, %ebx
	jne	.L4
	jmp	.L5
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
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
	movl	$5, %ecx
	call	printPascal
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
