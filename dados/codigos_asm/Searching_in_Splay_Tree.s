	.file	"Searching_in_Splay_Tree.c"
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
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	rightRotate
	.def	rightRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightRotate
rightRotate:
	.seh_endprologue
	movq	8(%rcx), %rax
	movq	16(%rax), %rdx
	movq	%rdx, 8(%rcx)
	movq	%rcx, 16(%rax)
	ret
	.seh_endproc
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
	.seh_endprologue
	movq	16(%rcx), %rax
	movq	8(%rax), %rdx
	movq	%rdx, 16(%rcx)
	movq	%rcx, 8(%rax)
	ret
	.seh_endproc
	.globl	splay
	.def	splay;	.scl	2;	.type	32;	.endef
	.seh_proc	splay
splay:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L15
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	je	.L15
	jle	.L6
	movq	8(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L15
	movl	(%rsi), %eax
	cmpl	%edx, %eax
	jg	.L16
	jl	.L17
.L9:
	movq	8(%rbx), %rax
.L8:
	movq	16(%rax), %rdx
	movq	%rdx, 8(%rbx)
	movq	%rbx, 16(%rax)
	movq	%rax, %rbx
.L15:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L16:
	movq	8(%rsi), %rcx
	call	splay
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rdx
	movq	16(%rdx), %rax
	movq	%rax, 8(%rbx)
	movq	%rbx, 16(%rdx)
	movq	8(%rdx), %rax
	testq	%rax, %rax
	jne	.L13
	movq	%rdx, %rbx
	jmp	.L15
.L17:
	movq	16(%rsi), %rcx
	call	splay
	movq	%rax, 16(%rsi)
	movq	8(%rbx), %rdx
	movq	16(%rdx), %rax
	testq	%rax, %rax
	je	.L9
	movq	8(%rax), %rcx
	movq	%rcx, 16(%rdx)
	movq	%rdx, 8(%rax)
	movq	%rax, 8(%rbx)
	jmp	.L9
.L13:
	movq	%rdx, %rbx
	jmp	.L8
.L6:
	movq	16(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L15
	movl	(%rsi), %eax
	cmpl	%edx, %eax
	jg	.L18
	jl	.L19
.L11:
	movq	16(%rbx), %rax
.L12:
	movq	8(%rax), %rdx
	movq	%rdx, 16(%rbx)
	movq	%rbx, 8(%rax)
	movq	%rax, %rbx
	jmp	.L15
.L18:
	movq	8(%rsi), %rcx
	call	splay
	movq	%rax, 8(%rsi)
	movq	16(%rbx), %rdx
	movq	8(%rdx), %rax
	testq	%rax, %rax
	je	.L11
	movq	16(%rax), %rcx
	movq	%rcx, 8(%rdx)
	movq	%rdx, 16(%rax)
	movq	%rax, 16(%rbx)
	jmp	.L11
.L19:
	movq	16(%rsi), %rcx
	call	splay
	movq	%rax, 16(%rsi)
	movq	16(%rbx), %rdx
	movq	8(%rdx), %rax
	movq	%rax, 16(%rbx)
	movq	%rbx, 8(%rdx)
	movq	16(%rdx), %rax
	testq	%rax, %rax
	jne	.L20
	movq	%rdx, %rbx
	jmp	.L15
.L20:
	movq	%rdx, %rbx
	jmp	.L12
	.seh_endproc
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	splay
	addq	$40, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	preOrder
	.def	preOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	preOrder
preOrder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L22
	movl	(%rcx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rcx
	call	preOrder
	movq	16(%rbx), %rcx
	call	preOrder
	nop
.L22:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Preorder traversal of the modified Splay tree is \0"
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
	movl	$100, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$50, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$200, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$40, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rax
	movq	8(%rax), %rsi
	movl	$30, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rsi
	movl	$20, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movl	$20, %edx
	movq	%rbx, %rcx
	call	splay
	movq	%rax, %rbx
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	preOrder
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
