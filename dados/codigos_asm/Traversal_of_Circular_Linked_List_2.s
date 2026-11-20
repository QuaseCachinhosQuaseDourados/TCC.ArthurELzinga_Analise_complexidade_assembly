	.file	"Traversal_of_Circular_Linked_List_2.c"
	.text
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
	movl	$16, %ecx
	call	malloc
	movq	(%rbx), %r8
	movl	%esi, (%rax)
	movq	%r8, 8(%rax)
	movq	%r8, %rcx
	testq	%r8, %r8
	jne	.L3
	movq	%rax, 8(%rax)
	jmp	.L4
.L5:
	movq	%rdx, %rcx
.L3:
	movq	8(%rcx), %rdx
	cmpq	%r8, %rdx
	jne	.L5
	movq	%rax, 8(%rcx)
.L4:
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
	testq	%rcx, %rcx
	je	.L6
	movq	%rcx, %rbx
	leaq	.LC0(%rip), %rdi
.L8:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	cmpq	%rbx, %rsi
	jne	.L8
.L6:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Contents of Circular Linked List\12 \0"
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
	movl	$12, %edx
	movq	%rbx, %rcx
	call	push
	movl	$56, %edx
	movq	%rbx, %rcx
	call	push
	movl	$2, %edx
	movq	%rbx, %rcx
	call	push
	movl	$11, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	printList
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
