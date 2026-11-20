	.file	"Level_Order_Traversal_(Breadth_First_Search_or_BFS)_of_Binary_Tree.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printCurrentLevel
	.def	printCurrentLevel;	.scl	2;	.type	32;	.endef
	.seh_proc	printCurrentLevel
printCurrentLevel:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	testq	%rcx, %rcx
	je	.L1
	cmpl	$1, %edx
	je	.L4
	jg	.L5
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L4:
	movl	(%rcx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L1
.L5:
	leal	-1(%rdx), %ebx
	movq	8(%rcx), %rcx
	movl	%ebx, %edx
	call	printCurrentLevel
	movq	16(%rsi), %rcx
	movl	%ebx, %edx
	call	printCurrentLevel
	jmp	.L1
	.seh_endproc
	.globl	height
	.def	height;	.scl	2;	.type	32;	.endef
	.seh_proc	height
height:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	$0, %eax
	testq	%rcx, %rcx
	je	.L6
	movq	8(%rcx), %rcx
	call	height
	movl	%eax, %esi
	movq	16(%rbx), %rcx
	call	height
	cmpl	%eax, %esi
	leal	1(%rsi), %ecx
	leal	1(%rax), %edx
	movl	%ecx, %eax
	cmovle	%edx, %eax
.L6:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	printLevelOrder
	.def	printLevelOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	printLevelOrder
printLevelOrder:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rdi
	call	height
	testl	%eax, %eax
	jle	.L10
	leal	1(%rax), %esi
	movl	$1, %ebx
.L12:
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	printCurrentLevel
	addl	$1, %ebx
	cmpl	%esi, %ebx
	jne	.L12
.L10:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
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
	.align 8
.LC1:
	.ascii "Level Order traversal of binary tree is \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$1, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$2, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$3, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$4, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rsi
	movl	$5, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	printLevelOrder
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
