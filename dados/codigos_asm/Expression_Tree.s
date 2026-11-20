	.file	"Expression_Tree.c"
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
	movl	$32, %ecx
	call	malloc
	movb	%bl, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	movq	$0, 24(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%c \0"
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
	je	.L2
	movq	8(%rcx), %rcx
	call	printInorder
	movsbl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	printInorder
	nop
.L2:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	.seh_endprologue
	movq	head(%rip), %rax
	testq	%rax, %rax
	je	.L7
	movq	%rax, 24(%rcx)
	movq	%rcx, head(%rip)
.L4:
	ret
.L7:
	movq	%rcx, head(%rip)
	jmp	.L4
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	.seh_endprologue
	movq	head(%rip), %rax
	movq	24(%rax), %rdx
	movq	%rdx, head(%rip)
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii " The Inorder Traversal of Expression Tree: \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
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
	call	__main
	movb	$65, 41(%rsp)
	movb	$66, 42(%rsp)
	movb	$67, 43(%rsp)
	movb	$42, 44(%rsp)
	movb	$43, 45(%rsp)
	movb	$68, 46(%rsp)
	movb	$47, 47(%rsp)
	leaq	41(%rsp), %rbx
	leaq	48(%rsp), %rdi
	movabsq	$4503599627370539, %rbp
	jmp	.L12
.L15:
	btq	%rax, %rbp
	jnc	.L10
	movsbl	%cl, %ecx
	call	newNode
	movq	%rax, %rsi
	call	pop
	movq	%rax, %r12
	call	pop
	movq	%rax, 8(%rsi)
	movq	%r12, 16(%rsi)
	movq	%rsi, %rcx
	call	push
.L11:
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	je	.L14
.L12:
	movzbl	(%rbx), %ecx
	leal	-42(%rcx), %eax
	cmpb	$52, %al
	jbe	.L15
.L10:
	movsbl	%cl, %ecx
	call	newNode
	movq	%rax, %rsi
	movq	%rax, %rcx
	call	push
	jmp	.L11
.L14:
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	%rsi, %rcx
	call	printInorder
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	head
	.bss
	.align 8
head:
	.space 8
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
