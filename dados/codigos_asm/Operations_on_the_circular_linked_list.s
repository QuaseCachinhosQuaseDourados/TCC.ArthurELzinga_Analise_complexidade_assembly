	.file	"Operations_on_the_circular_linked_list.c"
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
	movl	%esi, (%rax)
	movq	(%rbx), %r8
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
	cmpq	%rdx, %r8
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
	je	.L7
	movq	%rcx, %rbx
	leaq	.LC0(%rip), %rdi
.L8:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	cmpq	%rbx, %rsi
	jne	.L8
.L7:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Given node is not found in the list!!!\0"
	.text
	.globl	deleteNode
	.def	deleteNode;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteNode
deleteNode:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L10
	movq	%r8, %rax
	cmpl	%edx, (%r8)
	jne	.L12
	movq	8(%r8), %rdx
	movq	%r8, %rbx
	cmpq	%rdx, %r8
	jne	.L13
	movq	%r8, %rcx
	call	free
	movq	$0, (%rsi)
	jmp	.L10
.L19:
	movq	%rax, %rbx
.L13:
	movq	8(%rbx), %rax
	cmpq	%rax, %r8
	jne	.L19
	movq	%rdx, 8(%rbx)
	movq	(%rsi), %rcx
	call	free
	movq	8(%rbx), %rax
	movq	%rax, (%rsi)
	jmp	.L10
.L20:
	movq	%rcx, %rax
.L12:
	movq	8(%rax), %rcx
	cmpq	%rcx, %r8
	je	.L14
	cmpl	%edx, (%rcx)
	jne	.L20
.L15:
	movq	8(%rcx), %rdx
	movq	%rdx, 8(%rax)
	call	free
	jmp	.L10
.L14:
	cmpl	%edx, (%rcx)
	je	.L15
	leaq	.LC1(%rip), %rcx
	call	puts
	nop
.L10:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "List Before Deletion: \0"
.LC3:
	.ascii "List After Deletion: \0"
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
	movl	$5, %edx
	movq	%rbx, %rcx
	call	push
	movl	$7, %edx
	movq	%rbx, %rcx
	call	push
	movl	$8, %edx
	movq	%rbx, %rcx
	call	push
	movl	$10, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	printList
	movl	$7, %edx
	movq	%rbx, %rcx
	call	deleteNode
	leaq	.LC3(%rip), %rcx
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
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
