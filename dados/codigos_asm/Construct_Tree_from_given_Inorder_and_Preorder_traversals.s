	.file	"Construct_Tree_from_given_Inorder_and_Preorder_traversals.c"
	.text
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
	.seh_endprologue
	movl	%r9d, %r10d
	cmpl	%r8d, %edx
	jg	.L1
	movslq	%edx, %rax
	cmpb	(%rcx,%rax), %r9b
	je	.L10
	addl	$1, %edx
	movslq	%edx, %rdx
.L5:
	movl	%edx, %eax
	cmpl	%edx, %r8d
	jl	.L1
	addq	$1, %rdx
	cmpb	%r10b, -1(%rcx,%rdx)
	jne	.L5
.L1:
	ret
.L10:
	movl	%edx, %eax
	jmp	.L1
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
	movb	%bl, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	buildTree
	.def	buildTree;	.scl	2;	.type	32;	.endef
	.seh_proc	buildTree
buildTree:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
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
	movq	%rcx, %r12
	movq	%rdx, %rbp
	movl	%r8d, %edi
	movl	%r9d, %esi
	movl	$0, %ebx
	cmpl	%r9d, %r8d
	jg	.L12
	movl	preIndex.4141(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, preIndex.4141(%rip)
	cltq
	movsbl	0(%rbp,%rax), %ecx
	call	newNode
	movq	%rax, %rbx
	cmpl	%esi, %edi
	je	.L12
	movsbl	(%rax), %r9d
	movl	%esi, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	search
	movl	%eax, %r13d
	leal	-1(%rax), %r9d
	movl	%edi, %r8d
	movq	%rbp, %rdx
	movq	%r12, %rcx
	call	buildTree
	movq	%rax, 8(%rbx)
	movl	%esi, %r9d
	leal	1(%r13), %r8d
	movq	%rbp, %rdx
	movq	%r12, %rcx
	call	buildTree
	movq	%rax, 16(%rbx)
.L12:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%c \0"
	.text
	.globl	printInorder
	.def	printInorder;	.scl	2;	.type	32;	.endef
	.seh_proc	printInorder
printInorder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L15
	movq	8(%rcx), %rcx
	call	printInorder
	movsbl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	printInorder
	nop
.L15:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Inorder traversal of the const ructed tree is \0"
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
	movb	$68, 42(%rsp)
	movb	$66, 43(%rsp)
	movb	$69, 44(%rsp)
	movb	$65, 45(%rsp)
	movb	$70, 46(%rsp)
	movb	$67, 47(%rsp)
	movb	$65, 36(%rsp)
	movb	$66, 37(%rsp)
	movb	$68, 38(%rsp)
	movb	$69, 39(%rsp)
	movb	$67, 40(%rsp)
	movb	$70, 41(%rsp)
	leaq	36(%rsp), %rdx
	leaq	42(%rsp), %rcx
	movl	$5, %r9d
	movl	$0, %r8d
	call	buildTree
	movq	%rax, %rbx
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	printInorder
	call	getchar
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
.lcomm preIndex.4141,4,4
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
