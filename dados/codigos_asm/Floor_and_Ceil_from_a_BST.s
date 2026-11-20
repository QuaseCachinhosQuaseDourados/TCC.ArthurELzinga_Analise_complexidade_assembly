	.file	"Floor_and_Ceil_from_a_BST.c"
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
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	Ceil
	.def	Ceil;	.scl	2;	.type	32;	.endef
	.seh_proc	Ceil
Ceil:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%edx, %ebx
	testq	%rcx, %rcx
	je	.L5
	movl	(%rcx), %esi
	movl	%edx, %eax
	cmpl	%edx, %esi
	je	.L2
	jl	.L7
	movq	8(%rcx), %rcx
	call	Ceil
	cmpl	%eax, %ebx
	cmovg	%esi, %eax
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L7:
	movq	16(%rcx), %rcx
	call	Ceil
	jmp	.L2
.L5:
	movl	$-1, %eax
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d %d\12\0"
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
	movl	$8, %ecx
	call	newNode
	movq	%rax, %rsi
	movl	$4, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movl	$12, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	8(%rsi), %rbx
	movl	$2, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movq	8(%rsi), %rbx
	movl	$6, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	16(%rsi), %rbx
	movl	$10, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movq	16(%rsi), %rbx
	movl	$14, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movl	$0, %ebx
	leaq	.LC0(%rip), %rdi
.L9:
	movl	%ebx, %edx
	movq	%rsi, %rcx
	call	Ceil
	movl	%eax, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	printf
	addl	$1, %ebx
	cmpl	$16, %ebx
	jne	.L9
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
