	.file	"Delete_a_node_in_a_Doubly_Linked_List.c"
	.text
	.globl	deleteNode
	.def	deleteNode;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteNode
deleteNode:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	(%rcx), %rax
	testq	%rdx, %rdx
	je	.L1
	testq	%rax, %rax
	je	.L1
	cmpq	%rdx, %rax
	je	.L6
.L3:
	movq	8(%rdx), %rax
	testq	%rax, %rax
	je	.L4
	movq	16(%rdx), %rcx
	movq	%rcx, 16(%rax)
.L4:
	movq	16(%rdx), %rax
	testq	%rax, %rax
	je	.L5
	movq	8(%rdx), %rcx
	movq	%rcx, 8(%rax)
.L5:
	movq	%rdx, %rcx
	call	free
	nop
.L1:
	addq	$40, %rsp
	ret
.L6:
	movq	8(%rdx), %rax
	movq	%rax, (%rcx)
	jmp	.L3
	.seh_endproc
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	movl	$24, %ecx
	call	malloc
	movl	%esi, (%rax)
	movq	$0, 16(%rax)
	movq	(%rbx), %rdx
	movq	%rdx, 8(%rax)
	testq	%rdx, %rdx
	je	.L8
	movq	%rax, 16(%rdx)
.L8:
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printList
	.def	printList;	.scl	2;	.type	32;	.endef
	.seh_proc	printList
printList:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L9
	leaq	.LC0(%rip), %rsi
.L11:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L11
.L9:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "\12 Original Linked list \0"
.LC2:
	.ascii "\12 Modified Linked list \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rbx
	movl	$2, %edx
	movq	%rbx, %rcx
	call	push
	movl	$4, %edx
	movq	%rbx, %rcx
	call	push
	movl	$8, %edx
	movq	%rbx, %rcx
	call	push
	movl	$10, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	printList
	movq	40(%rsp), %rdx
	movq	%rbx, %rcx
	call	deleteNode
	movq	40(%rsp), %rax
	movq	8(%rax), %rdx
	movq	%rbx, %rcx
	call	deleteNode
	movq	40(%rsp), %rax
	movq	8(%rax), %rdx
	movq	%rbx, %rcx
	call	deleteNode
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	printList
	call	getchar
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	free;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
