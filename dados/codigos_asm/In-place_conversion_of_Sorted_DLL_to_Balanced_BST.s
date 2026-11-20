	.file	"In-place_conversion_of_Sorted_DLL_to_Balanced_BST.c"
	.text
	.globl	sortedListToBSTRecur
	.def	sortedListToBSTRecur;	.scl	2;	.type	32;	.endef
	.seh_proc	sortedListToBSTRecur
sortedListToBSTRecur:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rdi
	movl	%edx, %ebx
	movl	$0, %ebp
	testl	%edx, %edx
	jle	.L1
	movl	%edx, %esi
	shrl	$31, %esi
	addl	%edx, %esi
	sarl	%esi
	movl	%esi, %edx
	call	sortedListToBSTRecur
	movq	(%rdi), %rbp
	movq	%rax, 16(%rbp)
	movq	(%rdi), %rax
	movq	8(%rax), %rax
	movq	%rax, (%rdi)
	subl	%esi, %ebx
	leal	-1(%rbx), %edx
	movq	%rdi, %rcx
	call	sortedListToBSTRecur
	movq	%rax, 8(%rbp)
.L1:
	movq	%rbp, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	countNodes
	.def	countNodes;	.scl	2;	.type	32;	.endef
	.seh_proc	countNodes
countNodes:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L7
	movl	$0, %eax
.L6:
	movq	8(%rcx), %rcx
	addl	$1, %eax
	testq	%rcx, %rcx
	jne	.L6
.L4:
	ret
.L7:
	movl	$0, %eax
	jmp	.L4
	.seh_endproc
	.globl	sortedListToBST
	.def	sortedListToBST;	.scl	2;	.type	32;	.endef
	.seh_proc	sortedListToBST
sortedListToBST:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, 48(%rsp)
	call	countNodes
	movl	%eax, %edx
	leaq	48(%rsp), %rcx
	call	sortedListToBSTRecur
	addq	$40, %rsp
	ret
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
	je	.L11
	movq	%rax, 16(%rdx)
.L11:
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
	je	.L12
	leaq	.LC0(%rip), %rsi
.L14:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L14
.L12:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
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
	je	.L16
	movl	(%rcx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	preOrder
	movq	8(%rbx), %rcx
	call	preOrder
	nop
.L16:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Given Linked List\0"
	.align 8
.LC2:
	.ascii "\12 PreOrder Traversal of const ructed BST \12 \0"
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
	movl	$7, %edx
	movq	%rbx, %rcx
	call	push
	movl	$6, %edx
	movq	%rbx, %rcx
	call	push
	movl	$5, %edx
	movq	%rbx, %rcx
	call	push
	movl	$4, %edx
	movq	%rbx, %rcx
	call	push
	movl	$3, %edx
	movq	%rbx, %rcx
	call	push
	movl	$2, %edx
	movq	%rbx, %rcx
	call	push
	movl	$1, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	40(%rsp), %rcx
	call	printList
	movq	40(%rsp), %rcx
	call	sortedListToBST
	movq	%rax, %rbx
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	preOrder
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
