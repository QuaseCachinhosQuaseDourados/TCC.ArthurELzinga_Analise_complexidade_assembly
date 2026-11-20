	.file	"The_stock_span_problem_using_stack.c"
	.text
	.globl	initialiseStack
	.def	initialiseStack;	.scl	2;	.type	32;	.endef
	.seh_proc	initialiseStack
initialiseStack:
	.seh_endprologue
	movl	$-1, 24(%rcx)
	ret
	.seh_endproc
	.globl	IsStackfull
	.def	IsStackfull;	.scl	2;	.type	32;	.endef
	.seh_proc	IsStackfull
IsStackfull:
	.seh_endprologue
	cmpl	$5, 24(%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	IsStackempty
	.def	IsStackempty;	.scl	2;	.type	32;	.endef
	.seh_proc	IsStackempty
IsStackempty:
	.seh_endprologue
	cmpl	$-1, 24(%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	.seh_endprologue
	cmpl	$5, 24(%rdx)
	je	.L4
	movl	24(%rdx), %eax
	addl	$1, %eax
	movslq	%eax, %r8
	movl	%ecx, (%rdx,%r8,4)
	movl	%eax, 24(%rdx)
.L4:
	ret
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	.seh_endprologue
	cmpl	$-1, 24(%rcx)
	je	.L8
	movl	24(%rcx), %edx
	movslq	%edx, %rax
	movl	(%rcx,%rax,4), %eax
	subl	$1, %edx
	movl	%edx, 24(%rcx)
.L6:
	ret
.L8:
	movl	$-2147483648, %eax
	jmp	.L6
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
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
	subq	$168, %rsp
	.seh_stackalloc	168
	.seh_endprologue
	call	__main
	movl	$10, 128(%rsp)
	movl	$4, 132(%rsp)
	movl	$5, 136(%rsp)
	movl	$90, 140(%rsp)
	movl	$120, 144(%rsp)
	movl	$80, 148(%rsp)
	movq	$0, 100(%rsp)
	movq	$0, 108(%rsp)
	movl	$0, 116(%rsp)
	movl	$-1, 88(%rsp)
	movl	$-1, 56(%rsp)
	movl	$1, 96(%rsp)
	leaq	64(%rsp), %rdx
	movl	$10, %ecx
	call	push
	leaq	128(%rsp), %r13
	leaq	96(%rsp), %r12
	leaq	20(%r13), %r15
	movq	%r12, %r14
	leaq	64(%rsp), %rsi
	leaq	32(%rsp), %rdi
	jmp	.L10
.L17:
	movl	$1, %ebx
.L11:
	cmpl	$-1, 56(%rsp)
	je	.L14
.L13:
	movq	%rdi, %rcx
	call	pop
	movq	%rsi, %rdx
	movl	%eax, %ecx
	call	push
	cmpl	$-1, 56(%rsp)
	jne	.L13
.L14:
	movl	4(%r13), %ecx
	movq	%rsi, %rdx
	call	push
	movl	%ebx, 4(%r14)
	addq	$4, %r13
	addq	$4, %r14
	cmpq	%r15, %r13
	je	.L15
.L10:
	movl	88(%rsp), %eax
	cmpl	$-1, %eax
	je	.L17
	movl	4(%r13), %ebp
	cltq
	movl	$1, %ebx
	cmpl	%ebp, 64(%rsp,%rax,4)
	jg	.L11
.L12:
	movq	%rsi, %rcx
	call	pop
	movq	%rdi, %rdx
	movl	%eax, %ecx
	call	push
	addl	$1, %ebx
	movl	88(%rsp), %eax
	cmpl	$-1, %eax
	je	.L11
	cltq
	cmpl	%ebp, 64(%rsp,%rax,4)
	jle	.L12
	jmp	.L11
.L15:
	leaq	24(%r12), %rsi
	leaq	.LC0(%rip), %rbx
.L16:
	movl	(%r12), %edx
	movq	%rbx, %rcx
	call	printf
	addq	$4, %r12
	cmpq	%r12, %rsi
	jne	.L16
	movl	$0, %eax
	addq	$168, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
