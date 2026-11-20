	.file	"C_Program_for_Red_Black_Tree_Insertion.c"
	.text
	.globl	bst
	.def	bst;	.scl	2;	.type	32;	.endef
	.seh_proc	bst
bst:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L4
	movl	(%rdx), %ecx
	movl	(%rbx), %eax
	cmpl	%eax, %ecx
	jl	.L5
	jg	.L6
.L2:
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
.L5:
	movq	24(%rbx), %rcx
	call	bst
	movq	%rax, 24(%rbx)
	movq	%rbx, 8(%rax)
	jmp	.L2
.L6:
	movq	16(%rbx), %rcx
	call	bst
	movq	%rax, 16(%rbx)
	movq	%rbx, 8(%rax)
	jmp	.L2
.L4:
	movq	%rdx, %rbx
	jmp	.L2
	.seh_endproc
	.globl	rightrotate
	.def	rightrotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightrotate
rightrotate:
	.seh_endprologue
	movq	24(%rcx), %rax
	movq	16(%rax), %rdx
	movq	%rdx, 24(%rcx)
	testq	%rdx, %rdx
	je	.L8
	movq	%rcx, 8(%rdx)
.L8:
	movq	8(%rcx), %rdx
	movq	%rdx, 8(%rax)
	testq	%rdx, %rdx
	je	.L12
	cmpq	%rcx, 24(%rdx)
	je	.L13
	movq	%rax, 16(%rdx)
.L10:
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rcx)
	ret
.L12:
	movq	%rax, root(%rip)
	jmp	.L10
.L13:
	movq	%rax, 24(%rdx)
	jmp	.L10
	.seh_endproc
	.globl	leftrotate
	.def	leftrotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftrotate
leftrotate:
	.seh_endprologue
	movq	16(%rcx), %rax
	movq	24(%rax), %rdx
	movq	%rdx, 16(%rcx)
	testq	%rdx, %rdx
	je	.L15
	movq	%rcx, 8(%rdx)
.L15:
	movq	8(%rcx), %rdx
	movq	%rdx, 8(%rax)
	testq	%rdx, %rdx
	je	.L19
	cmpq	%rcx, 24(%rdx)
	je	.L20
	movq	%rax, 16(%rdx)
.L17:
	movq	%rcx, 24(%rax)
	movq	%rax, 8(%rcx)
	ret
.L19:
	movq	%rax, root(%rip)
	jmp	.L17
.L20:
	movq	%rax, 24(%rdx)
	jmp	.L17
	.seh_endproc
	.globl	fixup
	.def	fixup;	.scl	2;	.type	32;	.endef
	.seh_proc	fixup
fixup:
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
	cmpq	%rcx, %rdx
	je	.L21
	cmpl	$0, 4(%rdx)
	je	.L21
	movq	8(%rdx), %rbx
	cmpl	$1, 4(%rbx)
	je	.L29
.L21:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L34:
	movq	16(%rsi), %rax
	testq	%rax, %rax
	je	.L24
	cmpl	$1, 4(%rax)
	je	.L31
.L24:
	cmpq	%rdx, 16(%rbx)
	je	.L32
.L26:
	movq	%rsi, %rcx
	call	rightrotate
	movl	4(%rbx), %eax
	movl	4(%rsi), %edx
	movl	%edx, 4(%rbx)
	movl	%eax, 4(%rsi)
	movq	%rbx, %rdx
	jmp	.L25
.L31:
	movl	$1, 4(%rsi)
	movl	$0, 4(%rbx)
	movl	$0, 4(%rax)
	movq	%rsi, %rdx
	jmp	.L25
.L32:
	movq	%rbx, %rcx
	call	leftrotate
	movq	8(%rbx), %rbx
	jmp	.L26
.L27:
	cmpq	%rdx, 24(%rbx)
	je	.L33
.L28:
	movq	%rsi, %rcx
	call	leftrotate
	movl	4(%rbx), %eax
	movl	4(%rsi), %edx
	movl	%edx, 4(%rbx)
	movl	%eax, 4(%rsi)
	movq	%rbx, %rdx
.L25:
	cmpq	%rdx, %rdi
	je	.L21
	cmpl	$0, 4(%rdx)
	je	.L21
	movq	8(%rdx), %rbx
	cmpl	$1, 4(%rbx)
	jne	.L21
.L29:
	movq	8(%rbx), %rsi
	movq	24(%rsi), %rax
	cmpq	%rbx, %rax
	je	.L34
	testq	%rax, %rax
	je	.L27
	cmpl	$1, 4(%rax)
	jne	.L27
	movl	$1, 4(%rsi)
	movl	$0, 4(%rbx)
	movl	$0, 4(%rax)
	movq	%rsi, %rdx
	jmp	.L25
.L33:
	movq	%rbx, %rcx
	call	rightrotate
	movq	8(%rbx), %rbx
	jmp	.L28
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
	je	.L35
	movq	24(%rcx), %rcx
	call	inorder
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	inorder
	nop
.L35:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Inorder Traversal of Created Tree\0"
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
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movl	$7, 32(%rsp)
	movl	$6, 36(%rsp)
	movl	$5, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$3, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$1, 56(%rsp)
	leaq	32(%rsp), %rsi
	leaq	60(%rsp), %rdi
.L38:
	movl	$32, %ecx
	call	malloc
	movq	%rax, %rbx
	movq	$0, 16(%rax)
	movq	$0, 24(%rax)
	movq	$0, 8(%rax)
	movl	(%rsi), %eax
	movl	%eax, (%rbx)
	movl	$1, 4(%rbx)
	movq	%rbx, %rdx
	movq	root(%rip), %rcx
	call	bst
	movq	%rax, root(%rip)
	movq	%rbx, %rdx
	movq	%rax, %rcx
	call	fixup
	movq	root(%rip), %rax
	movl	$0, 4(%rax)
	addq	$4, %rsi
	cmpq	%rdi, %rsi
	jne	.L38
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	root(%rip), %rcx
	call	inorder
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	root
	.bss
	.align 8
root:
	.space 8
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
