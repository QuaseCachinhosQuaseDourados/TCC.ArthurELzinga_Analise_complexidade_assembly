	.file	"Searching_in_Binary_Search_Tree_(BST).c"
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
	call	newNode
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
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L12
	movl	(%rcx), %r8d
	movq	%rcx, %rax
	cmpl	%edx, %r8d
	je	.L9
	jl	.L14
	movq	8(%rcx), %rcx
	call	search
.L9:
	addq	$40, %rsp
	ret
.L14:
	movq	16(%rcx), %rcx
	call	search
	jmp	.L9
.L12:
	movq	%rcx, %rax
	jmp	.L9
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d not found\12\0"
.LC1:
	.ascii "%d found\12\0"
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
	movq	%rax, %rbx
	movl	$30, %edx
	movq	%rax, %rcx
	call	insert
	movl	$20, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$40, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$70, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$60, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$80, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$6, %edx
	movq	%rbx, %rcx
	call	search
	testq	%rax, %rax
	je	.L20
	movl	$6, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L17:
	movl	$60, %edx
	movq	%rbx, %rcx
	call	search
	testq	%rax, %rax
	je	.L21
	movl	$60, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L19:
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L20:
	movl	$6, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L17
.L21:
	movl	$60, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L19
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
