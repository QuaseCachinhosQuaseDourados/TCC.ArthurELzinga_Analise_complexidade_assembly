	.file	"Inorder_Tree_Traversal_without_recursion_and_without_stack!.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	MorrisTraversal
	.def	MorrisTraversal;	.scl	2;	.type	32;	.endef
	.seh_proc	MorrisTraversal
MorrisTraversal:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L1
	leaq	.LC0(%rip), %rsi
	jmp	.L6
.L7:
	movq	%rax, %rdx
.L3:
	movq	16(%rdx), %rax
	cmpq	%rbx, %rax
	setne	%r8b
	testq	%rax, %rax
	setne	%cl
	testb	%cl, %r8b
	jne	.L7
	testq	%rax, %rax
	je	.L10
	movq	$0, 16(%rdx)
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	16(%rbx), %rbx
.L4:
	testq	%rbx, %rbx
	je	.L1
.L6:
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	jne	.L3
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	16(%rbx), %rbx
	jmp	.L4
.L10:
	movq	%rbx, 16(%rdx)
	movq	8(%rbx), %rbx
	jmp	.L4
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	newtNode
	.def	newtNode;	.scl	2;	.type	32;	.endef
	.seh_proc	newtNode
newtNode:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$24, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
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
	movl	$1, %ecx
	call	newtNode
	movq	%rax, %rbx
	movl	$2, %ecx
	call	newtNode
	movq	%rax, 8(%rbx)
	movl	$3, %ecx
	call	newtNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$4, %ecx
	call	newtNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rsi
	movl	$5, %ecx
	call	newtNode
	movq	%rax, 16(%rsi)
	movq	%rbx, %rcx
	call	MorrisTraversal
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
