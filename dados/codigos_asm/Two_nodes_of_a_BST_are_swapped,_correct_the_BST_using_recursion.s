	.file	"Two_nodes_of_a_BST_are_swapped,_correct_the_BST_using_recursion.c"
	.text
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
	.seh_endprologue
	movl	(%rcx), %eax
	movl	(%rdx), %r8d
	movl	%r8d, (%rcx)
	movl	%eax, (%rdx)
	ret
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
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	correctBSTUtil
	.def	correctBSTUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	correctBSTUtil
correctBSTUtil:
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
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rdi
	movq	%r8, %r12
	movq	%r9, %rbp
	movq	128(%rsp), %rsi
	testq	%rcx, %rcx
	je	.L3
	movq	8(%rcx), %rcx
	movq	%rsi, 32(%rsp)
	call	correctBSTUtil
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L5
	movl	(%rax), %edx
	cmpl	%edx, (%rbx)
	jge	.L5
	cmpq	$0, (%rdi)
	je	.L7
	movq	%rbx, 0(%rbp)
.L5:
	movq	%rbx, (%rsi)
	movq	16(%rbx), %rcx
	movq	%rsi, 32(%rsp)
	movq	%rbp, %r9
	movq	%r12, %r8
	movq	%rdi, %rdx
	call	correctBSTUtil
	nop
.L3:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L7:
	movq	%rax, (%rdi)
	movq	%rbx, (%r12)
	jmp	.L5
	.seh_endproc
	.globl	correctBST
	.def	correctBST;	.scl	2;	.type	32;	.endef
	.seh_proc	correctBST
correctBST:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	leaq	72(%rsp), %rdx
	leaq	48(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	56(%rsp), %r9
	leaq	64(%rsp), %r8
	call	correctBSTUtil
	movq	72(%rsp), %rax
	testq	%rax, %rax
	je	.L8
	movq	56(%rsp), %rdx
	testq	%rdx, %rdx
	je	.L10
	movl	(%rax), %ecx
	movl	(%rdx), %r8d
	movl	%r8d, (%rax)
	movl	%ecx, (%rdx)
.L8:
	addq	$88, %rsp
	ret
.L10:
	movq	64(%rsp), %rdx
	testq	%rdx, %rdx
	je	.L8
	movl	(%rax), %ecx
	movl	(%rdx), %r8d
	movl	%r8d, (%rax)
	movl	%ecx, (%rdx)
	jmp	.L8
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printInorder
	.def	printInorder;	.scl	2;	.type	32;	.endef
	.seh_proc	printInorder
printInorder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L11
	movq	8(%rcx), %rcx
	call	printInorder
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	printInorder
	nop
.L11:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Inorder Traversal of the original tree \0"
	.align 8
.LC2:
	.ascii "\12Inorder Traversal of the fixed tree \0"
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
	movl	$6, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$10, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$2, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$1, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rsi
	movl	$3, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	16(%rbx), %rsi
	movl	$12, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	16(%rbx), %rsi
	movl	$7, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	printInorder
	movq	%rbx, %rcx
	call	correctBST
	leaq	.LC2(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	printInorder
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
