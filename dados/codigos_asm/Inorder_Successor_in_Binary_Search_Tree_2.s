	.file	"Inorder_Successor_in_Binary_Search_Tree_2.c"
	.text
	.globl	inOrderSuccessor
	.def	inOrderSuccessor;	.scl	2;	.type	32;	.endef
	.seh_proc	inOrderSuccessor
inOrderSuccessor:
	.seh_endprologue
	movq	16(%rdx), %rax
	testq	%rax, %rax
	jne	.L2
	testq	%rcx, %rcx
	je	.L11
	movl	(%rdx), %r8d
	jmp	.L7
.L11:
	movq	%rcx, %rax
	jmp	.L1
.L8:
	movq	%rdx, %rax
.L2:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	jne	.L8
.L1:
	ret
.L5:
	jle	.L1
	movq	16(%rcx), %rcx
.L6:
	testq	%rcx, %rcx
	je	.L1
.L7:
	movl	(%rcx), %edx
	cmpl	%edx, %r8d
	jge	.L5
	movq	%rcx, %rax
	movq	8(%rcx), %rcx
	jmp	.L6
	.seh_endproc
	.globl	minValue
	.def	minValue;	.scl	2;	.type	32;	.endef
	.seh_proc	minValue
minValue:
	.seh_endprologue
	movq	%rcx, %rax
	jmp	.L13
.L14:
	movq	%rdx, %rax
.L13:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	jne	.L14
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
	.globl	insert
	.def	insert;	.scl	2;	.type	32;	.endef
	.seh_proc	insert
insert:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L20
	cmpl	%edx, (%rcx)
	jl	.L19
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
	movq	%rbx, 24(%rax)
	movq	%rbx, %rax
.L16:
	addq	$32, %rsp
	popq	%rbx
	ret
.L20:
	movl	%edx, %ecx
	call	newNode
	jmp	.L16
.L19:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	movq	%rbx, 24(%rax)
	movq	%rbx, %rax
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "\12 Inorder Successor of %d is %d \0"
	.align 8
.LC1:
	.ascii "\12 Inorder Successor do esn't exit\0"
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
	movl	$20, %edx
	movl	$0, %ecx
	call	insert
	movl	$8, %edx
	movq	%rax, %rcx
	call	insert
	movl	$22, %edx
	movq	%rax, %rcx
	call	insert
	movl	$4, %edx
	movq	%rax, %rcx
	call	insert
	movl	$12, %edx
	movq	%rax, %rcx
	call	insert
	movl	$10, %edx
	movq	%rax, %rcx
	call	insert
	movl	$14, %edx
	movq	%rax, %rcx
	call	insert
	movq	8(%rax), %rdx
	movq	16(%rdx), %rdx
	movq	16(%rdx), %rbx
	movq	%rbx, %rdx
	movq	%rax, %rcx
	call	inOrderSuccessor
	testq	%rax, %rax
	je	.L22
	movl	(%rax), %r8d
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
.L23:
	call	getchar
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L22:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L23
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
