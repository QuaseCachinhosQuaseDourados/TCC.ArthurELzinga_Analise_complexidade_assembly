	.file	"Split_a_Circular_Linked_List_into_two_halves.c"
	.text
	.globl	splitList
	.def	splitList;	.scl	2;	.type	32;	.endef
	.seh_proc	splitList
splitList:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L1
	movq	8(%rcx), %r10
	cmpq	%r10, %rcx
	je	.L7
	movq	8(%r10), %rax
	cmpq	%rax, %rcx
	je	.L8
	movq	%rcx, %r10
.L5:
	movq	8(%r10), %r10
	movq	8(%rax), %r9
	cmpq	%rcx, %r9
	je	.L3
	movq	8(%r9), %rax
	cmpq	%rcx, %rax
	jne	.L5
.L4:
	movq	%r9, %rax
.L3:
	movq	%rcx, (%rdx)
	cmpq	%rcx, 8(%rcx)
	je	.L6
	movq	8(%r10), %rdx
	movq	%rdx, (%r8)
.L6:
	movq	8(%r10), %rdx
	movq	%rdx, 8(%rax)
	movq	%rcx, 8(%r10)
.L1:
	ret
.L7:
	movq	%r10, %rax
	jmp	.L3
.L8:
	movq	%r10, %r9
	movq	%rax, %r10
	jmp	.L4
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
	movl	$16, %ecx
	call	malloc
	movq	(%rbx), %r8
	movl	%esi, (%rax)
	movq	%r8, 8(%rax)
	movq	%r8, %rcx
	testq	%r8, %r8
	jne	.L12
	movq	%rax, 8(%rax)
	jmp	.L13
.L14:
	movq	%rdx, %rcx
.L12:
	movq	8(%rcx), %rdx
	cmpq	%r8, %rdx
	jne	.L14
	movq	%rax, 8(%rcx)
.L13:
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
	je	.L15
	movl	$10, %ecx
	call	putchar
	movq	%rsi, %rbx
	leaq	.LC0(%rip), %rdi
.L17:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	cmpq	%rbx, %rsi
	jne	.L17
.L15:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Original Circular Linked List\0"
.LC2:
	.ascii "\12First Circular Linked List\0"
.LC3:
	.ascii "\12Second Circular Linked List\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movq	$0, 56(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 40(%rsp)
	leaq	56(%rsp), %rbx
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
	movq	56(%rsp), %rcx
	call	printList
	leaq	48(%rsp), %rdx
	leaq	40(%rsp), %r8
	movq	56(%rsp), %rcx
	call	splitList
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	48(%rsp), %rcx
	call	printList
	leaq	.LC3(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	printList
	call	getchar
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
