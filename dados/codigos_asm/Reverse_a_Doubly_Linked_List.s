	.file	"Reverse_a_Doubly_Linked_List.c"
	.text
	.globl	reverse
	.def	reverse;	.scl	2;	.type	32;	.endef
	.seh_proc	reverse
reverse:
	.seh_endprologue
	movq	(%rcx), %rax
	testq	%rax, %rax
	je	.L1
.L3:
	movq	16(%rax), %r8
	movq	8(%rax), %rdx
	movq	%rdx, 16(%rax)
	movq	%r8, 8(%rax)
	movq	%rdx, %rax
	testq	%rdx, %rdx
	jne	.L3
	testq	%r8, %r8
	je	.L1
	movq	16(%r8), %rax
	movq	%rax, (%rcx)
.L1:
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
	je	.L6
	movq	%rax, 16(%rdx)
.L6:
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
	je	.L7
	leaq	.LC0(%rip), %rsi
.L9:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L9
.L7:
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
	.ascii "\12 Reversed Linked list \0"
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
	movq	%rbx, %rcx
	call	reverse
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
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
