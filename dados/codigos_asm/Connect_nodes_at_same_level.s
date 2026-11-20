	.file	"Connect_nodes_at_same_level.c"
	.text
	.globl	connectRecur
	.def	connectRecur;	.scl	2;	.type	32;	.endef
	.seh_proc	connectRecur
connectRecur:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L1
	movq	8(%rcx), %rax
	testq	%rax, %rax
	je	.L3
	movq	16(%rcx), %rdx
	movq	%rdx, 24(%rax)
.L3:
	movq	16(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L4
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L5
	movq	8(%rax), %rax
.L5:
	movq	%rax, 24(%rdx)
.L4:
	movq	8(%rbx), %rcx
	call	connectRecur
	movq	16(%rbx), %rcx
	call	connectRecur
	nop
.L1:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	connect
	.def	connect;	.scl	2;	.type	32;	.endef
	.seh_proc	connect
connect:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	$0, 24(%rcx)
	call	connectRecur
	nop
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	newnode
	.def	newnode;	.scl	2;	.type	32;	.endef
	.seh_proc	newnode
newnode:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$32, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	movq	$0, 24(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Following are populated nextRight pointers in the tree (-1 is printed if there is no nextRight) \0"
.LC1:
	.ascii "nextRight of %d is %d \12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$10, %ecx
	call	newnode
	movq	%rax, %rbx
	movl	$8, %ecx
	call	newnode
	movq	%rax, 8(%rbx)
	movl	$2, %ecx
	call	newnode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$3, %ecx
	call	newnode
	movq	%rax, 8(%rsi)
	movq	%rbx, %rcx
	call	connect
	leaq	.LC0(%rip), %rcx
	call	puts
	movq	24(%rbx), %rax
	movl	$-1, %r8d
	testq	%rax, %rax
	je	.L9
	movl	(%rax), %r8d
.L9:
	movl	(%rbx), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movq	24(%rax), %rdx
	movl	$-1, %r8d
	testq	%rdx, %rdx
	je	.L10
	movl	(%rdx), %r8d
.L10:
	movl	(%rax), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	16(%rbx), %rax
	movq	24(%rax), %rdx
	movl	$-1, %r8d
	testq	%rdx, %rdx
	je	.L11
	movl	(%rdx), %r8d
.L11:
	movl	(%rax), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movq	8(%rax), %rax
	movq	24(%rax), %rdx
	movl	$-1, %r8d
	testq	%rdx, %rdx
	je	.L12
	movl	(%rdx), %r8d
.L12:
	movl	(%rax), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
