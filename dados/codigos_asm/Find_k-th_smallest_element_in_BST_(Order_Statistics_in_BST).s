	.file	"Find_k-th_smallest_element_in_BST_(Order_Statistics_in_BST).c"
	.text
	.globl	new_node
	.def	new_node;	.scl	2;	.type	32;	.endef
	.seh_proc	new_node
new_node:
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
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	jg	.L7
	jl	.L8
.L4:
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
.L6:
	movl	%edx, %ecx
	call	new_node
	movq	%rax, %rbx
	jmp	.L4
.L7:
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
	jmp	.L4
.L8:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	jmp	.L4
	.seh_endproc
	.globl	kthSmallest
	.def	kthSmallest;	.scl	2;	.type	32;	.endef
	.seh_proc	kthSmallest
kthSmallest:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	testq	%rcx, %rcx
	je	.L11
	movq	8(%rcx), %rcx
	call	kthSmallest
	testq	%rax, %rax
	je	.L13
.L9:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L13:
	movl	count(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, count(%rip)
	movq	%rbx, %rax
	cmpl	%esi, %edx
	je	.L9
	movq	16(%rbx), %rcx
	movl	%esi, %edx
	call	kthSmallest
	jmp	.L9
.L11:
	movq	%rcx, %rax
	jmp	.L9
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "There are less than k nodes in the BST\0"
.LC1:
	.ascii "K-th Smallest Element is %d\0"
	.text
	.globl	printKthSmallest
	.def	printKthSmallest;	.scl	2;	.type	32;	.endef
	.seh_proc	printKthSmallest
printKthSmallest:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	kthSmallest
	testq	%rax, %rax
	je	.L17
	movl	(%rax), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	nop
.L14:
	addq	$40, %rsp
	ret
.L17:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L14
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$20, 32(%rsp)
	movl	$8, 36(%rsp)
	movl	$22, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$12, 48(%rsp)
	movl	$10, 52(%rsp)
	movl	$14, 56(%rsp)
	leaq	32(%rsp), %rbx
	leaq	60(%rsp), %rsi
	movl	$0, %ecx
.L19:
	movl	(%rbx), %edx
	call	insert
	movq	%rax, %rcx
	addq	$4, %rbx
	cmpq	%rsi, %rbx
	jne	.L19
	movl	$3, %edx
	call	printKthSmallest
	movl	$0, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	count
	.bss
	.align 4
count:
	.space 4
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
