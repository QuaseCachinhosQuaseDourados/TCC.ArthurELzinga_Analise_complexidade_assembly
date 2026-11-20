	.file	"QuickSort_on_Doubly_Linked_List_2.c"
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
	.globl	lastNode
	.def	lastNode;	.scl	2;	.type	32;	.endef
	.seh_proc	lastNode
lastNode:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L5
	movq	8(%rcx), %rax
	testq	%rax, %rax
	jne	.L4
	movq	%rcx, %rax
	jmp	.L2
.L7:
	movq	%rdx, %rax
.L4:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	jne	.L7
.L2:
	ret
.L5:
	movq	%rcx, %rax
	jmp	.L2
	.seh_endproc
	.globl	partition
	.def	partition;	.scl	2;	.type	32;	.endef
	.seh_proc	partition
partition:
	.seh_endprologue
	movl	(%rdx), %eax
	movq	16(%rcx), %r9
	cmpq	%rcx, %rdx
	je	.L9
	movq	%rcx, %r8
	jmp	.L12
.L14:
	movq	%rcx, %r9
.L11:
	movl	(%r9), %r11d
	movl	%r10d, (%r9)
	movl	%r11d, (%r8)
.L10:
	movq	8(%r8), %r8
	cmpq	%r8, %rdx
	je	.L9
.L12:
	movl	(%r8), %r10d
	cmpl	%eax, %r10d
	jg	.L10
	testq	%r9, %r9
	je	.L14
	movq	8(%r9), %r9
	jmp	.L11
.L9:
	movq	%rcx, %rax
	testq	%r9, %r9
	je	.L13
	movq	8(%r9), %rax
.L13:
	movl	(%rax), %ecx
	movl	(%rdx), %r8d
	movl	%r8d, (%rax)
	movl	%ecx, (%rdx)
	ret
	.seh_endproc
	.globl	_quickSort
	.def	_quickSort;	.scl	2;	.type	32;	.endef
	.seh_proc	_quickSort
_quickSort:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	testq	%rdx, %rdx
	je	.L17
	cmpq	%rcx, %rdx
	je	.L17
	cmpq	%rcx, 8(%rdx)
	je	.L17
	call	partition
	movq	%rax, %rdi
	movq	16(%rax), %rdx
	movq	%rsi, %rcx
	call	_quickSort
	movq	8(%rdi), %rcx
	movq	%rbx, %rdx
	call	_quickSort
	nop
.L17:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	quickSort
	.def	quickSort;	.scl	2;	.type	32;	.endef
	.seh_proc	quickSort
quickSort:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	call	lastNode
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	_quickSort
	nop
	addq	$32, %rsp
	popq	%rbx
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
	je	.L21
	leaq	.LC0(%rip), %rsi
.L22:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L22
.L21:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
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
	je	.L25
	movq	%rax, 16(%rdx)
.L25:
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Linked List before sorting \0"
.LC2:
	.ascii "Linked List after sorting \0"
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
	movl	$5, %edx
	movq	%rbx, %rcx
	call	push
	movl	$20, %edx
	movq	%rbx, %rcx
	call	push
	movl	$4, %edx
	movq	%rbx, %rcx
	call	push
	movl	$3, %edx
	movq	%rbx, %rcx
	call	push
	movl	$30, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	40(%rsp), %rcx
	call	printList
	movq	40(%rsp), %rcx
	call	quickSort
	leaq	.LC2(%rip), %rcx
	call	puts
	movq	40(%rsp), %rcx
	call	printList
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
