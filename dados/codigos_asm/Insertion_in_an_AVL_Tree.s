	.file	"Insertion_in_an_AVL_Tree.c"
	.text
	.globl	height
	.def	height;	.scl	2;	.type	32;	.endef
	.seh_proc	height
height:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L3
	movl	24(%rcx), %eax
.L1:
	ret
.L3:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.globl	max
	.def	max;	.scl	2;	.type	32;	.endef
	.seh_proc	max
max:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovge	%edx, %eax
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
	movl	$32, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	movl	$1, 24(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	rightRotate
	.def	rightRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightRotate
rightRotate:
	.seh_endprologue
	movq	8(%rcx), %rax
	movq	16(%rax), %r8
	movq	%rcx, 16(%rax)
	movq	%r8, 8(%rcx)
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L11
	movl	24(%rdx), %r9d
.L7:
	testq	%r8, %r8
	je	.L12
	movl	24(%r8), %edx
.L8:
	cmpl	%r9d, %edx
	cmovl	%r9d, %edx
	addl	$1, %edx
	movl	%edx, 24(%rcx)
	movq	16(%rax), %rdx
	testq	%rdx, %rdx
	je	.L13
	movl	24(%rdx), %ecx
.L9:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	je	.L14
	movl	24(%rdx), %edx
.L10:
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, 24(%rax)
	ret
.L11:
	movl	$0, %r9d
	jmp	.L7
.L12:
	movl	$0, %edx
	jmp	.L8
.L13:
	movl	$0, %ecx
	jmp	.L9
.L14:
	movl	$0, %edx
	jmp	.L10
	.seh_endproc
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
	.seh_endprologue
	movq	16(%rcx), %rax
	movq	8(%rax), %rdx
	movq	%rcx, 8(%rax)
	movq	%rdx, 16(%rcx)
	testq	%rdx, %rdx
	je	.L20
	movl	24(%rdx), %r8d
.L16:
	movq	8(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L21
	movl	24(%rdx), %edx
.L17:
	cmpl	%r8d, %edx
	cmovl	%r8d, %edx
	addl	$1, %edx
	movl	%edx, 24(%rcx)
	movq	16(%rax), %rdx
	testq	%rdx, %rdx
	je	.L22
	movl	24(%rdx), %ecx
.L18:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	je	.L23
	movl	24(%rdx), %edx
.L19:
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, 24(%rax)
	ret
.L20:
	movl	$0, %r8d
	jmp	.L16
.L21:
	movl	$0, %edx
	jmp	.L17
.L22:
	movl	$0, %ecx
	jmp	.L18
.L23:
	movl	$0, %edx
	jmp	.L19
	.seh_endproc
	.globl	getBalance
	.def	getBalance;	.scl	2;	.type	32;	.endef
	.seh_proc	getBalance
getBalance:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L28
	movq	8(%rcx), %rax
	testq	%rax, %rax
	je	.L29
	movl	24(%rax), %eax
.L26:
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L30
	movl	24(%rdx), %edx
.L27:
	subl	%edx, %eax
.L24:
	ret
.L29:
	movl	$0, %eax
	jmp	.L26
.L30:
	movl	$0, %edx
	jmp	.L27
.L28:
	movl	$0, %eax
	jmp	.L24
	.seh_endproc
	.globl	insert
	.def	insert;	.scl	2;	.type	32;	.endef
	.seh_proc	insert
insert:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
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
	je	.L43
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	jg	.L44
	jl	.L45
.L33:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L43:
	movl	%edx, %ecx
	call	newNode
	movq	%rax, %rbx
	jmp	.L33
.L44:
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
.L35:
	movq	16(%rbx), %rbp
	testq	%rbp, %rbp
	je	.L41
	movl	24(%rbp), %edx
.L36:
	movq	8(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L42
	movl	24(%rdi), %eax
.L37:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	movq	%rbx, %rcx
	call	getBalance
	cmpl	$1, %eax
	jle	.L38
	cmpl	%esi, (%rdi)
	jg	.L46
	cmpl	%esi, (%rdi)
	jge	.L33
	movq	%rdi, %rcx
	call	leftRotate
	movq	%rax, 8(%rbx)
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rbx
	jmp	.L33
.L45:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	jmp	.L35
.L41:
	movl	$0, %edx
	jmp	.L36
.L42:
	movl	$0, %eax
	jmp	.L37
.L46:
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rbx
	jmp	.L33
.L38:
	cmpl	$-1, %eax
	jge	.L33
	movl	0(%rbp), %eax
	cmpl	%esi, %eax
	jl	.L47
	jle	.L33
	movq	%rbp, %rcx
	call	rightRotate
	movq	%rax, 16(%rbx)
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rbx
	jmp	.L33
.L47:
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rbx
	jmp	.L33
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	preOrder
	.def	preOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	preOrder
preOrder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L48
	movl	(%rcx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rcx
	call	preOrder
	movq	16(%rbx), %rcx
	call	preOrder
	nop
.L48:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Preorder traversal of the const ructed AVL tree is \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movl	$10, %edx
	movl	$0, %ecx
	call	insert
	movl	$20, %edx
	movq	%rax, %rcx
	call	insert
	movl	$30, %edx
	movq	%rax, %rcx
	call	insert
	movl	$40, %edx
	movq	%rax, %rcx
	call	insert
	movl	$50, %edx
	movq	%rax, %rcx
	call	insert
	movl	$25, %edx
	movq	%rax, %rcx
	call	insert
	movq	%rax, %rbx
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	preOrder
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
