	.file	"Maximum_width_of_a_Binary_Tree_2.c"
	.text
	.globl	getMaxWidthRecur
	.def	getMaxWidthRecur;	.scl	2;	.type	32;	.endef
	.seh_proc	getMaxWidthRecur
getMaxWidthRecur:
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
	movq	%rdx, %rsi
	testq	%rcx, %rcx
	je	.L1
	movslq	%r8d, %rax
	addl	$1, (%rdx,%rax,4)
	leal	1(%r8), %ebx
	movq	8(%rcx), %rcx
	movl	%ebx, %r8d
	call	getMaxWidthRecur
	movq	16(%rdi), %rcx
	movl	%ebx, %r8d
	movq	%rsi, %rdx
	call	getMaxWidthRecur
	nop
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
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
	je	.L3
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
.L3:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
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
	.globl	getMax
	.def	getMax;	.scl	2;	.type	32;	.endef
	.seh_proc	getMax
getMax:
	.seh_endprologue
	movl	(%rcx), %eax
	testl	%edx, %edx
	jle	.L8
	movq	%rcx, %r8
	leal	-1(%rdx), %edx
	leaq	4(%rcx,%rdx,4), %rcx
.L10:
	movl	(%r8), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	addq	$4, %r8
	cmpq	%rcx, %r8
	jne	.L10
.L8:
	ret
	.seh_endproc
	.globl	getMaxWidth
	.def	getMaxWidth;	.scl	2;	.type	32;	.endef
	.seh_proc	getMaxWidth
getMaxWidth:
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
	movl	%eax, %esi
	movslq	%eax, %rdx
	movl	$4, %ecx
	call	calloc
	movq	%rax, %rbx
	movl	$0, %r8d
	movq	%rax, %rdx
	movq	%rdi, %rcx
	call	getMaxWidthRecur
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	getMax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Maximum width is %d \12\0"
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
	movq	16(%rbx), %rsi
	movl	$8, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	16(%rbx), %rax
	movq	16(%rax), %rsi
	movl	$6, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	16(%rbx), %rax
	movq	16(%rax), %rsi
	movl	$7, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	movq	%rbx, %rcx
	call	getMaxWidth
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	calloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
