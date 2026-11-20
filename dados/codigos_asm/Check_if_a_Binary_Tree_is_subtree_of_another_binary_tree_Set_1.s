	.file	"Check_if_a_Binary_Tree_is_subtree_of_another_binary_tree_Set_1.c"
	.text
	.globl	boolareIdentical
	.def	boolareIdentical;	.scl	2;	.type	32;	.endef
	.seh_proc	boolareIdentical
boolareIdentical:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movl	$1, %eax
	movq	%rcx, %rdx
	orq	%rsi, %rdx
	je	.L1
	testq	%rcx, %rcx
	je	.L4
	testq	%rsi, %rsi
	je	.L4
	movl	$0, %eax
	movl	(%rsi), %ecx
	cmpl	%ecx, (%rbx)
	je	.L6
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L6:
	movq	8(%rsi), %rdx
	movq	8(%rbx), %rcx
	call	areIdentical
	testl	%eax, %eax
	je	.L1
	movq	16(%rsi), %rdx
	movq	16(%rbx), %rcx
	call	areIdentical
	testl	%eax, %eax
	setne	%al
	movzbl	%al, %eax
	jmp	.L1
.L4:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.globl	boolisSubtree
	.def	boolisSubtree;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisSubtree
boolisSubtree:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	testq	%rdx, %rdx
	je	.L9
	movl	$0, %edx
	testq	%rcx, %rcx
	je	.L7
	movq	%rbx, %rdx
	call	areIdentical
	movl	$1, %edx
	testl	%eax, %eax
	je	.L13
.L7:
	movl	%edx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L13:
	movq	8(%rsi), %rcx
	movq	%rbx, %rdx
	call	isSubtree
	movl	$1, %edx
	testl	%eax, %eax
	jne	.L7
	movq	16(%rsi), %rcx
	movq	%rbx, %rdx
	call	isSubtree
	testl	%eax, %eax
	setne	%dl
	movzbl	%dl, %edx
	jmp	.L7
.L9:
	movl	$1, %edx
	jmp	.L7
	.seh_endproc
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
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Tree 2 is subtree of Tree 1\0"
	.align 8
.LC1:
	.ascii "Tree 2 is not a subtree of Tree 1\0"
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movl	$26, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$3, %ecx
	call	newNode
	movq	%rax, %rsi
	movq	%rax, 16(%rbx)
	movl	$3, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movl	$10, %ecx
	call	newNode
	movq	%rax, %rsi
	movq	%rax, 8(%rbx)
	movl	$4, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rax
	movq	8(%rax), %rsi
	movl	$30, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	8(%rbx), %rsi
	movl	$6, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movl	$10, %ecx
	call	newNode
	movq	%rax, %rsi
	movl	$6, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movl	$4, %ecx
	call	newNode
	movq	%rax, %rdi
	movq	%rax, 8(%rsi)
	movl	$30, %ecx
	call	newNode
	movq	%rax, 16(%rdi)
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	isSubtree
	testl	%eax, %eax
	je	.L16
	leaq	.LC0(%rip), %rcx
	call	printf
.L17:
	call	getchar
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L16:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L17
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	areIdentical;	.scl	2;	.type	32;	.endef
	.def	isSubtree;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
