	.file	"Lowest_Common_Ancestor_in_a_Binary_Search_Tree..c"
	.text
	.globl	lca
	.def	lca;	.scl	2;	.type	32;	.endef
	.seh_proc	lca
lca:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rax
	testq	%rcx, %rcx
	je	.L2
	movl	(%rcx), %ecx
	cmpl	%r8d, %edx
	movl	%r8d, %r9d
	cmovge	%edx, %r9d
	cmpl	%r9d, %ecx
	jg	.L4
	cmpl	%r8d, %edx
	movl	%r8d, %r9d
	cmovle	%edx, %r9d
	cmpl	%r9d, %ecx
	jl	.L5
.L2:
	addq	$40, %rsp
	ret
.L4:
	movq	8(%rax), %rcx
	call	lca
	jmp	.L2
.L5:
	movq	16(%rax), %rcx
	call	lca
	jmp	.L2
	.seh_endproc
	.globl	newNode
	.def	newNode;	.scl	2;	.type	32;	.endef
	.seh_proc	newNode
newNode:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$24, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "LCA of %d and %d is %d \12\0"
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
	movl	$20, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$8, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$22, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$4, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rsi
	movl	$12, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	8(%rbx), %rax
	movq	16(%rax), %rsi
	movl	$10, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rax
	movq	16(%rax), %rsi
	movl	$14, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movl	$14, %r8d
	movl	$10, %edx
	movq	%rbx, %rcx
	call	lca
	movl	(%rax), %r9d
	movl	$14, %r8d
	movl	$10, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$8, %r8d
	movl	$14, %edx
	movq	%rbx, %rcx
	call	lca
	movl	(%rax), %r9d
	movl	$8, %r8d
	movl	$14, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$22, %r8d
	movl	$10, %edx
	movq	%rbx, %rcx
	call	lca
	movl	(%rax), %r9d
	movl	$22, %r8d
	movl	$10, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
