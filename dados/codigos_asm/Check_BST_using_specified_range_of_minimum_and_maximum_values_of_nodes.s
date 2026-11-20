	.file	"Check_BST_using_specified_range_of_minimum_and_maximum_values_of_nodes.c"
	.text
	.globl	isBSTUtil
	.def	isBSTUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	isBSTUtil
isBSTUtil:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%r8d, %edi
	testq	%rcx, %rcx
	je	.L3
	movl	(%rcx), %esi
	cmpl	%edx, %esi
	jl	.L4
	cmpl	%r8d, %esi
	jle	.L5
.L4:
	movl	$0, %eax
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L5:
	movq	8(%rcx), %rcx
	leal	-1(%rsi), %r8d
	call	isBSTUtil
	testl	%eax, %eax
	je	.L1
	leal	1(%rsi), %edx
	movq	16(%rbx), %rcx
	movl	%edi, %r8d
	call	isBSTUtil
	testl	%eax, %eax
	setne	%al
	movzbl	%al, %eax
	jmp	.L1
.L3:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.globl	isBST
	.def	isBST;	.scl	2;	.type	32;	.endef
	.seh_proc	isBST
isBST:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$2147483647, %r8d
	movl	$-2147483648, %edx
	call	isBSTUtil
	addq	$40, %rsp
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
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Is BST\0"
.LC1:
	.ascii "Not a BST\0"
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
	movl	$4, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$2, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$5, %ecx
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
	movq	%rbx, %rcx
	call	isBST
	testl	%eax, %eax
	je	.L9
	leaq	.LC0(%rip), %rcx
	call	printf
.L10:
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L9:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L10
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
