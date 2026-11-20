	.file	"Maximum_width_of_a_Binary_Tree.c"
	.text
	.globl	getWidth
	.def	getWidth;	.scl	2;	.type	32;	.endef
	.seh_proc	getWidth
getWidth:
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
	testq	%rcx, %rcx
	je	.L4
	movl	%edx, %eax
	cmpl	$1, %edx
	je	.L1
	jg	.L6
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L6:
	leal	-1(%rdx), %ebx
	movq	8(%rcx), %rcx
	movl	%ebx, %edx
	call	getWidth
	movl	%eax, %esi
	movq	16(%rdi), %rcx
	movl	%ebx, %edx
	call	getWidth
	addl	%esi, %eax
	jmp	.L1
.L4:
	movl	$0, %eax
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
	je	.L7
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
.L7:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	getMaxWidth
	.def	getMaxWidth;	.scl	2;	.type	32;	.endef
	.seh_proc	getMaxWidth
getMaxWidth:
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
	movq	%rcx, %rbp
	call	height
	testl	%eax, %eax
	jle	.L14
	leal	1(%rax), %edi
	movl	$1, %ebx
	movl	$0, %esi
.L13:
	movl	%ebx, %edx
	movq	%rbp, %rcx
	call	getWidth
	cmpl	%eax, %esi
	cmovl	%eax, %esi
	addl	$1, %ebx
	cmpl	%ebx, %edi
	jne	.L13
.L11:
	movl	%esi, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L14:
	movl	$0, %esi
	jmp	.L11
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
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
