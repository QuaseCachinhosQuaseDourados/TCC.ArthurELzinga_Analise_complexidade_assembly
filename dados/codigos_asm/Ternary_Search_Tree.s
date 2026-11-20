	.file	"Ternary_Search_Tree.c"
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
	movl	$32, %ecx
	call	malloc
	movb	%bl, (%rax)
	andb	$-2, 4(%rax)
	movq	$0, 24(%rax)
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
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	cmpq	$0, (%rcx)
	je	.L8
.L3:
	movzbl	(%rbx), %edx
	movq	(%rsi), %rcx
	movzbl	(%rcx), %eax
	cmpb	%al, %dl
	jl	.L9
	jg	.L10
	cmpb	$0, 1(%rbx)
	jne	.L11
	orb	$1, 4(%rcx)
	jmp	.L2
.L8:
	movsbl	(%rdx), %ecx
	call	newNode
	movq	%rax, (%rsi)
	jmp	.L3
.L9:
	addq	$8, %rcx
	movq	%rbx, %rdx
	call	insert
	nop
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L10:
	addq	$24, %rcx
	movq	%rbx, %rdx
	call	insert
	jmp	.L2
.L11:
	leaq	1(%rbx), %rdx
	addq	$16, %rcx
	call	insert
	jmp	.L2
	.seh_endproc
	.globl	traverseTSTUtil
	.def	traverseTSTUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	traverseTSTUtil
traverseTSTUtil:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movl	%r8d, %edi
	testq	%rcx, %rcx
	je	.L12
	movq	8(%rcx), %rcx
	call	traverseTSTUtil
	movslq	%edi, %rax
	movzbl	(%rbx), %edx
	movb	%dl, (%rsi,%rax)
	testb	$1, 4(%rbx)
	jne	.L15
.L14:
	movq	16(%rbx), %rcx
	leal	1(%rdi), %r8d
	movq	%rsi, %rdx
	call	traverseTSTUtil
	movq	24(%rbx), %rcx
	movl	%edi, %r8d
	movq	%rsi, %rdx
	call	traverseTSTUtil
	nop
.L12:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L15:
	movb	$0, 1(%rsi,%rax)
	movq	%rsi, %rcx
	call	puts
	jmp	.L14
	.seh_endproc
	.globl	traverseTST
	.def	traverseTST;	.scl	2;	.type	32;	.endef
	.seh_proc	traverseTST
traverseTST:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	leaq	32(%rsp), %rdx
	movl	$0, %r8d
	call	traverseTSTUtil
	nop
	addq	$104, %rsp
	ret
	.seh_endproc
	.globl	searchTST
	.def	searchTST;	.scl	2;	.type	32;	.endef
	.seh_proc	searchTST
searchTST:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L22
	movzbl	(%rdx), %r8d
	movzbl	(%rcx), %eax
	cmpb	%al, %r8b
	jl	.L23
	jg	.L24
	cmpb	$0, 1(%rdx)
	jne	.L21
	movzbl	4(%rcx), %eax
	andl	$1, %eax
.L17:
	addq	$40, %rsp
	ret
.L23:
	movq	8(%rcx), %rcx
	call	searchTST
	jmp	.L17
.L24:
	movq	24(%rcx), %rcx
	call	searchTST
	jmp	.L17
.L21:
	addq	$1, %rdx
	movq	16(%rcx), %rcx
	call	searchTST
	jmp	.L17
.L22:
	movl	$0, %eax
	jmp	.L17
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "cat\0"
.LC1:
	.ascii "cats\0"
.LC2:
	.ascii "up\0"
.LC3:
	.ascii "bug\0"
	.align 8
.LC4:
	.ascii "Following is traversal of ternary search tree\0"
	.align 8
.LC5:
	.ascii "\12Following are search results for cats, bu and cat respectively\0"
.LC6:
	.ascii "Found\0"
.LC7:
	.ascii "Not Found\0"
.LC8:
	.ascii "bu\0"
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
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rbx
	leaq	.LC0(%rip), %rdx
	movq	%rbx, %rcx
	call	insert
	leaq	.LC1(%rip), %rdx
	movq	%rbx, %rcx
	call	insert
	leaq	.LC2(%rip), %rdx
	movq	%rbx, %rcx
	call	insert
	leaq	.LC3(%rip), %rdx
	movq	%rbx, %rcx
	call	insert
	leaq	.LC4(%rip), %rcx
	call	puts
	movq	40(%rsp), %rcx
	call	traverseTST
	leaq	.LC5(%rip), %rcx
	call	puts
	leaq	.LC1(%rip), %rdx
	movq	40(%rsp), %rcx
	call	searchTST
	testl	%eax, %eax
	je	.L26
	leaq	.LC6(%rip), %rcx
	call	puts
.L27:
	leaq	.LC8(%rip), %rdx
	movq	40(%rsp), %rcx
	call	searchTST
	testl	%eax, %eax
	je	.L28
	leaq	.LC6(%rip), %rcx
	call	puts
.L29:
	leaq	.LC0(%rip), %rdx
	movq	40(%rsp), %rcx
	call	searchTST
	testl	%eax, %eax
	je	.L30
	leaq	.LC6(%rip), %rcx
	call	puts
.L31:
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
.L26:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L27
.L28:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L29
.L30:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L31
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
