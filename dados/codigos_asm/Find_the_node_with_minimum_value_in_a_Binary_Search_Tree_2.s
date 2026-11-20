	.file	"Find_the_node_with_minimum_value_in_a_Binary_Search_Tree_2.c"
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
	je	.L6
	cmpl	%edx, (%rcx)
	jl	.L5
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
.L2:
	addq	$32, %rsp
	popq	%rbx
	ret
.L6:
	movl	%edx, %ecx
	call	newNode
	jmp	.L2
.L5:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	movq	%rbx, %rax
	jmp	.L2
	.seh_endproc
	.globl	minValue
	.def	minValue;	.scl	2;	.type	32;	.endef
	.seh_proc	minValue
minValue:
	.seh_endprologue
	jmp	.L8
.L9:
	movq	%rax, %rcx
.L8:
	movq	8(%rcx), %rax
	testq	%rax, %rax
	jne	.L9
	movl	(%rcx), %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\12 Minimum value in BST is %d\0"
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
	movl	$4, %edx
	movl	$0, %ecx
	call	insert
	movq	%rax, %rbx
	movl	$2, %edx
	movq	%rax, %rcx
	call	insert
	movl	$1, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$3, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$6, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$5, %edx
	movq	%rbx, %rcx
	call	insert
	movq	%rbx, %rcx
	call	minValue
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
