	.file	"Merge_two_BSTs_with_limited_extra_space.c"
	.text
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movl	$16, %ecx
	call	malloc
	movq	%rsi, (%rax)
	movq	(%rbx), %rdx
	movq	%rdx, 8(%rax)
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	(%rcx), %rax
	movq	8(%rax), %rdx
	movq	%rdx, (%rcx)
	movq	(%rax), %rbx
	movq	%rax, %rcx
	call	free
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	isEmpty
	.def	isEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	isEmpty
isEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	sete	%al
	movzbl	%al, %eax
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
	je	.L5
	movq	8(%rcx), %rcx
	call	inorder
	movl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	16(%rbx), %rcx
	call	inorder
	nop
.L5:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	merge
	.def	merge;	.scl	2;	.type	32;	.endef
	.seh_proc	merge
merge:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	movq	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	testq	%rcx, %rcx
	je	.L26
	leaq	.LC0(%rip), %r12
	leaq	40(%rsp), %rdi
	testq	%rdx, %rdx
	je	.L27
.L10:
	testq	%rsi, %rsi
	je	.L28
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	push
	movq	8(%rsi), %rsi
	testq	%rbx, %rbx
	je	.L10
.L22:
	leaq	32(%rsp), %rcx
	movq	%rbx, %rdx
	call	push
	movq	8(%rbx), %rbx
	jmp	.L10
.L26:
	movq	%rdx, %rcx
	call	inorder
	nop
.L7:
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L27:
	call	inorder
	jmp	.L7
.L30:
	cmpq	$0, 32(%rsp)
	je	.L7
	leaq	32(%rsp), %rbx
.L14:
	movq	%rbx, %rcx
	call	pop
	movq	$0, 8(%rax)
	movq	%rax, %rcx
	call	inorder
	cmpq	$0, 32(%rsp)
	jne	.L14
	jmp	.L7
.L31:
	leaq	40(%rsp), %rbx
.L16:
	movq	%rbx, %rcx
	call	pop
	movq	$0, 8(%rax)
	movq	%rax, %rcx
	call	inorder
	cmpq	$0, 40(%rsp)
	jne	.L16
	jmp	.L7
.L17:
	movq	%r12, %rcx
	call	printf
	movq	16(%rbx), %rbx
	movq	%rbp, %rdx
	movq	%rdi, %rcx
	call	push
	jmp	.L18
.L28:
	leaq	32(%rsp), %r13
.L18:
	movq	40(%rsp), %rax
	movq	%rax, %rdx
	orq	%rbx, %rdx
	je	.L29
	testq	%rbx, %rbx
	jne	.L22
.L11:
	testq	%rax, %rax
	je	.L30
	cmpq	$0, 32(%rsp)
	je	.L31
	movq	%rdi, %rcx
	call	pop
	movq	%rax, %rbp
	movq	%r13, %rcx
	call	pop
	movq	%rax, %rbx
	movl	0(%rbp), %eax
	movl	(%rbx), %edx
	cmpl	%edx, %eax
	jge	.L17
	movl	%eax, %edx
	movq	%r12, %rcx
	call	printf
	movq	16(%rbp), %rbp
	leaq	32(%rsp), %rcx
	movq	%rbx, %rdx
	call	push
	movq	%rsi, %rbx
	movq	%rbp, %rsi
	jmp	.L10
.L29:
	cmpq	$0, 32(%rsp)
	jne	.L11
	jmp	.L7
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
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
	movl	$3, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$1, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$5, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movl	$4, %ecx
	call	newNode
	movq	%rax, %rsi
	movl	$2, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movl	$6, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	merge
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
