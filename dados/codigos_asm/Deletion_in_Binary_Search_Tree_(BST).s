	.file	"Deletion_in_Binary_Search_Tree_(BST).c"
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
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	inorder
	.def	inorder;	.scl	2;	.type	32;	.endef
	.seh_proc	inorder
inorder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L2
	movq	8(%rcx), %rcx
	call	inorder
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	inorder
	nop
.L2:
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
	je	.L8
	cmpl	%edx, (%rcx)
	jle	.L7
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
.L4:
	addq	$32, %rsp
	popq	%rbx
	ret
.L8:
	movl	%edx, %ecx
	call	newNode
	jmp	.L4
.L7:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	movq	%rbx, %rax
	jmp	.L4
	.seh_endproc
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
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L10
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	jg	.L20
	jl	.L21
	movq	8(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L22
	movq	16(%rcx), %rcx
	movq	%rbx, %rdx
	testq	%rcx, %rcx
	jne	.L14
	movq	%rbx, %rcx
	call	free
	movq	%rsi, %rbx
	jmp	.L10
.L20:
	movq	8(%rcx), %rcx
	call	deleteNode
	movq	%rax, 8(%rbx)
	jmp	.L10
.L21:
	movq	16(%rcx), %rcx
	call	deleteNode
	movq	%rax, 16(%rbx)
	jmp	.L10
.L22:
	movq	16(%rcx), %rsi
	call	free
	movq	%rsi, %rbx
	jmp	.L10
.L18:
	movq	%rcx, %rdx
	movq	%rax, %rcx
.L14:
	movq	8(%rcx), %rax
	testq	%rax, %rax
	jne	.L18
	cmpq	%rbx, %rdx
	je	.L15
	movq	16(%rcx), %rax
	movq	%rax, 8(%rdx)
.L16:
	movl	(%rcx), %eax
	movl	%eax, (%rbx)
	call	free
.L10:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L15:
	movq	16(%rcx), %rax
	movq	%rax, 16(%rdx)
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Original BST: \0"
.LC2:
	.ascii "\12\12Delete a Leaf Node: 20\0"
	.align 8
.LC3:
	.ascii "Modified BST tree after deleting Leaf Node:\0"
	.align 8
.LC4:
	.ascii "\12\12Delete Node with single child: 70\0"
	.align 8
.LC5:
	.ascii "Modified BST tree after deleting single child Node:\0"
	.align 8
.LC6:
	.ascii "\12\12Delete Node with both child: 50\0"
	.align 8
.LC7:
	.ascii "Modified BST tree after deleting both child Node:\0"
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
	movl	$50, %edx
	movl	$0, %ecx
	call	insert
	movl	$30, %edx
	movq	%rax, %rcx
	call	insert
	movl	$20, %edx
	movq	%rax, %rcx
	call	insert
	movl	$40, %edx
	movq	%rax, %rcx
	call	insert
	movl	$70, %edx
	movq	%rax, %rcx
	call	insert
	movl	$60, %edx
	movq	%rax, %rcx
	call	insert
	movq	%rax, %rbx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	inorder
	leaq	.LC2(%rip), %rcx
	call	puts
	movl	$20, %edx
	movq	%rbx, %rcx
	call	deleteNode
	movq	%rax, %rbx
	leaq	.LC3(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	inorder
	leaq	.LC4(%rip), %rcx
	call	puts
	movl	$70, %edx
	movq	%rbx, %rcx
	call	deleteNode
	movq	%rax, %rbx
	leaq	.LC5(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	inorder
	leaq	.LC6(%rip), %rcx
	call	puts
	movl	$50, %edx
	movq	%rbx, %rcx
	call	deleteNode
	movq	%rax, %rbx
	leaq	.LC7(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	inorder
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
