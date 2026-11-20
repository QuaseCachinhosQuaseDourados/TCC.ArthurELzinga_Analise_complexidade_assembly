	.file	"Reservoir_Sampling.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printArray
	.def	printArray;	.scl	2;	.type	32;	.endef
	.seh_proc	printArray
printArray:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%edx, %edx
	jle	.L2
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L3:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L3
.L2:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Following are k randomly selected items \0"
	.text
	.globl	selectKItems
	.def	selectKItems;	.scl	2;	.type	32;	.endef
	.seh_proc	selectKItems
selectKItems:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, %r12
	movl	%edx, %r14d
	movl	%r8d, %esi
	movslq	%r8d, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %r13
	movq	%r13, %rdi
	testl	%r8d, %r8d
	jle	.L11
	leal	-1(%r8), %ecx
	movl	$0, %eax
	jmp	.L7
.L12:
	movq	%rdx, %rax
.L7:
	movl	(%r12,%rax,4), %edx
	movl	%edx, (%rdi,%rax,4)
	leaq	1(%rax), %rdx
	cmpq	%rcx, %rax
	jne	.L12
	movl	%esi, %r15d
.L6:
	movl	$0, %ecx
	call	*__imp__time64(%rip)
	movl	%eax, %ecx
	call	srand
	cmpl	%r15d, %r14d
	jle	.L8
	leal	1(%r15), %ebx
	movslq	%ebx, %rbx
	subl	$1, %r14d
	subl	%r15d, %r14d
	movslq	%r15d, %r15
	leaq	2(%r14,%r15), %r14
	jmp	.L10
.L11:
	movl	$0, %r15d
	jmp	.L6
.L9:
	addq	$1, %rbx
	cmpq	%r14, %rbx
	je	.L8
.L10:
	call	rand
	cltd
	idivl	%ebx
	cmpl	%edx, %esi
	jle	.L9
	movslq	%edx, %rax
	movl	-4(%r12,%rbx,4), %edx
	movl	%edx, (%rdi,%rax,4)
	jmp	.L9
.L8:
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	%esi, %edx
	movq	%r13, %rcx
	call	printArray
	nop
	leaq	-88(%rbp), %rsp
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
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	movl	$7, 56(%rsp)
	movl	$8, 60(%rsp)
	movl	$9, 64(%rsp)
	movl	$10, 68(%rsp)
	movl	$11, 72(%rsp)
	movl	$12, 76(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %r8d
	movl	$12, %edx
	call	selectKItems
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	srand;	.scl	2;	.type	32;	.endef
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
