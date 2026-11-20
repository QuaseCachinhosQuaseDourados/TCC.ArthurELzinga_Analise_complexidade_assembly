	.file	"Majority_Element_using_Binary_Search_Tree.c"
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
	movl	$1, 4(%rax)
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
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%r8, %rsi
	testq	%rcx, %rcx
	je	.L9
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	jg	.L10
	jl	.L11
	addl	$1, 4(%rcx)
.L7:
	movl	(%rsi), %eax
	cmpl	%eax, 4(%rbx)
	cmovge	4(%rbx), %eax
	movl	%eax, (%rsi)
	movq	%rbx, %rax
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L9:
	cmpl	$0, (%r8)
	jne	.L4
	movl	$1, (%r8)
.L4:
	movl	%edx, %ecx
	call	newNode
	jmp	.L2
.L10:
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
	jmp	.L7
.L11:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	jmp	.L7
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \12\0"
	.text
	.globl	inorder
	.def	inorder;	.scl	2;	.type	32;	.endef
	.seh_proc	inorder
inorder:
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
	je	.L12
	movq	8(%rcx), %rcx
	call	inorder
	movl	%esi, %eax
	shrl	$31, %eax
	addl	%esi, %eax
	sarl	%eax
	cmpl	%eax, 4(%rbx)
	jg	.L15
.L14:
	movq	16(%rbx), %rcx
	movl	%esi, %edx
	call	inorder
	nop
.L12:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L15:
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L14
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "No majority element\0"
	.text
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
	movl	$1, 48(%rsp)
	movl	$3, 52(%rsp)
	movl	$3, 56(%rsp)
	movl	$3, 60(%rsp)
	movl	$2, 64(%rsp)
	movl	$0, 44(%rsp)
	leaq	48(%rsp), %rbx
	leaq	68(%rsp), %rdi
	movl	$0, %ecx
	leaq	44(%rsp), %rsi
.L17:
	movq	%rsi, %r8
	movl	(%rbx), %edx
	call	insert
	movq	%rax, %rcx
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L17
	cmpl	$2, 44(%rsp)
	jle	.L18
	movl	$5, %edx
	call	inorder
.L19:
	movl	$0, %eax
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L18:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L19
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
