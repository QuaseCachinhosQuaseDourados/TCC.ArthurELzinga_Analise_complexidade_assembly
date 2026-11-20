	.file	"Pascal\222s_Triangle_using_Dynamic_Programming.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printPascal
	.def	printPascal;	.scl	2;	.type	32;	.endef
	.seh_proc	printPascal
printPascal:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, 0(%rbp)
	movslq	%ecx, %rax
	leaq	0(,%rax,4), %rdi
	movq	%rdi, -96(%rbp)
	imulq	%rax, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %rax
	testl	%ecx, %ecx
	jle	.L1
	movq	%rax, %r13
	movq	%rax, %r12
	subq	%rdi, %r12
	movq	%rax, %r15
	movq	%rax, -88(%rbp)
	movl	$1, %edi
	movl	$0, %esi
	leaq	.LC0(%rip), %r14
	jmp	.L3
.L10:
	movq	-88(%rbp), %rax
	movl	$1, (%rax,%rbx,4)
.L6:
	movl	0(%r13,%rbx,4), %edx
	movq	%r14, %rcx
	call	printf
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	je	.L8
.L7:
	cmpl	%ebx, %esi
	je	.L10
	testl	%ebx, %ebx
	je	.L10
	movl	(%r12,%rbx,4), %eax
	addl	-4(%r12,%rbx,4), %eax
	movl	%eax, (%r15,%rbx,4)
	jmp	.L6
.L8:
	movl	$10, %ecx
	call	putchar
	addl	$1, %esi
	movq	-96(%rbp), %rax
	addq	%rax, %r13
	addq	$1, %rdi
	addq	%rax, -88(%rbp)
	addq	%rax, %r12
	addq	%rax, %r15
	cmpl	%esi, 0(%rbp)
	je	.L1
.L3:
	movl	$0, %ebx
	testl	%esi, %esi
	jns	.L7
	jmp	.L8
.L1:
	leaq	-72(%rbp), %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
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
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
