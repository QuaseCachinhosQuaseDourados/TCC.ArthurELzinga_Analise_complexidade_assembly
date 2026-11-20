	.file	"Queue_using_Stacks.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Stack overflow \0"
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
	movl	%edx, %esi
	movl	$16, %ecx
	call	malloc
	testq	%rax, %rax
	je	.L3
	movl	%esi, (%rax)
	movq	(%rbx), %rdx
	movq	%rdx, 8(%rax)
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L3:
	leaq	.LC0(%rip), %rcx
	call	puts
	call	getchar
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.globl	enQueue
	.def	enQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	enQueue
enQueue:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	push
	nop
	addq	$40, %rsp
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
	testq	%rax, %rax
	je	.L7
	movl	(%rax), %ebx
	movq	8(%rax), %rdx
	movq	%rdx, (%rcx)
	movq	%rax, %rcx
	call	free
.L5:
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L7:
	movl	$-1, %ebx
	jmp	.L5
	.seh_endproc
	.globl	deQueue
	.def	deQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	deQueue
deQueue:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	cmpq	$0, (%rcx)
	je	.L16
	leaq	8(%rcx), %rsi
	cmpq	$0, 8(%rcx)
	je	.L12
.L11:
	leaq	8(%rbx), %rcx
	call	pop
.L8:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L16:
	cmpq	$0, 8(%rcx)
	jne	.L11
	movl	$-1, %eax
	jmp	.L8
.L12:
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edx
	movq	%rsi, %rcx
	call	push
	cmpq	$0, (%rbx)
	jne	.L12
	jmp	.L11
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "%d \0"
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
	movl	$16, %ecx
	call	malloc
	movq	%rax, %rbx
	movq	$0, (%rax)
	movq	$0, 8(%rax)
	movl	$1, %edx
	movq	%rax, %rcx
	call	push
	movl	$2, %edx
	movq	%rbx, %rcx
	call	push
	movl	$3, %edx
	movq	%rbx, %rcx
	call	push
	movq	%rbx, %rcx
	call	deQueue
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	deQueue
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	deQueue
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
