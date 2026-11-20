	.file	"A_program_to_check_if_a_Binary_Tree_is_BST_or_not.c"
	.text
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
	.globl	maxValue
	.def	maxValue;	.scl	2;	.type	32;	.endef
	.seh_proc	maxValue
maxValue:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movl	$0, %eax
	testq	%rcx, %rcx
	je	.L2
	movq	8(%rcx), %rcx
	call	maxValue
	movl	%eax, %ebx
	movq	16(%rsi), %rcx
	call	maxValue
	cmpl	%eax, %ebx
	cmovge	%ebx, %eax
	cmpl	%eax, (%rsi)
	cmovge	(%rsi), %eax
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	minValue
	.def	minValue;	.scl	2;	.type	32;	.endef
	.seh_proc	minValue
minValue:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	testq	%rcx, %rcx
	je	.L7
	movq	8(%rcx), %rcx
	call	minValue
	movl	%eax, %ebx
	movq	16(%rsi), %rcx
	call	minValue
	cmpl	%eax, %ebx
	cmovle	%ebx, %eax
	cmpl	%eax, (%rsi)
	cmovle	(%rsi), %eax
.L5:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L7:
	movl	$1000000000, %eax
	jmp	.L5
	.seh_endproc
	.globl	isBST
	.def	isBST;	.scl	2;	.type	32;	.endef
	.seh_proc	isBST
isBST:
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
	testq	%rcx, %rcx
	je	.L12
	movq	8(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L10
	movq	%rsi, %rcx
	call	maxValue
	movl	$0, %edx
	cmpl	(%rbx), %eax
	jg	.L8
.L10:
	movq	16(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L11
	movq	%rdi, %rcx
	call	minValue
	movl	$0, %edx
	cmpl	(%rbx), %eax
	jl	.L8
.L11:
	movq	%rsi, %rcx
	call	isBST
	movl	%eax, %edx
	testl	%eax, %eax
	jne	.L15
.L8:
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L15:
	movq	%rdi, %rcx
	call	isBST
	testl	%eax, %eax
	setne	%dl
	movzbl	%dl, %edx
	jmp	.L8
.L12:
	movl	$1, %edx
	jmp	.L8
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
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movl	$4, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$5, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$6, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	%rbx, %rcx
	call	isBST
	testl	%eax, %eax
	je	.L17
	leaq	.LC0(%rip), %rcx
	call	printf
.L18:
	call	getchar
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L17:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L18
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
