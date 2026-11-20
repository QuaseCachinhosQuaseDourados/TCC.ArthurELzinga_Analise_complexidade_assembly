	.file	"Sorted_insert_for_circular_linked_list.c"
	.text
	.globl	sortedInsert
	.def	sortedInsert;	.scl	2;	.type	32;	.endef
	.seh_proc	sortedInsert
sortedInsert:
	.seh_endprologue
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L10
	movl	(%rdx), %r9d
	cmpl	%r9d, (%r8)
	jl	.L7
	movq	%r8, %r9
	jmp	.L5
.L10:
	movq	%rdx, 8(%rdx)
	movq	%rdx, (%rcx)
	jmp	.L1
.L8:
	movq	%rax, %r9
.L5:
	movq	8(%r9), %rax
	cmpq	%r8, %rax
	jne	.L8
	movq	%rdx, 8(%r9)
	movq	(%rcx), %rax
	movq	%rax, 8(%rdx)
	movq	%rdx, (%rcx)
.L1:
	ret
.L7:
	movq	%r8, %rcx
	jmp	.L4
.L9:
	movq	%rax, %rcx
.L4:
	movq	8(%rcx), %rax
	cmpq	%r8, %rax
	je	.L6
	cmpl	(%rax), %r9d
	jg	.L9
	movq	%rax, %r8
.L6:
	movq	%r8, 8(%rdx)
	movq	%rdx, 8(%rcx)
	jmp	.L1
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
	je	.L11
	movl	$10, %ecx
	call	putchar
	movq	%rsi, %rbx
	leaq	.LC0(%rip), %rdi
.L13:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	cmpq	%rbx, %rsi
	jne	.L13
.L11:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	call	__main
	movl	$12, 48(%rsp)
	movl	$56, 52(%rsp)
	movl	$2, 56(%rsp)
	movl	$11, 60(%rsp)
	movl	$1, 64(%rsp)
	movl	$90, 68(%rsp)
	movq	$0, 40(%rsp)
	leaq	48(%rsp), %rbx
	leaq	72(%rsp), %rdi
	leaq	40(%rsp), %rsi
.L16:
	movl	$16, %ecx
	call	malloc
	movl	(%rbx), %edx
	movl	%edx, (%rax)
	movq	%rax, %rdx
	movq	%rsi, %rcx
	call	sortedInsert
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L16
	movq	40(%rsp), %rcx
	call	printList
	movl	$0, %eax
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
