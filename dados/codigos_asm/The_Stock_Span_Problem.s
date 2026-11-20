	.file	"The_Stock_Span_Problem.c"
	.text
	.globl	calculateSpan
	.def	calculateSpan;	.scl	2;	.type	32;	.endef
	.seh_proc	calculateSpan
calculateSpan:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	$1, (%r8)
	cmpl	$1, %edx
	jle	.L1
	leaq	4(%r8), %r11
	leaq	4(%rcx), %r9
	leal	-2(%rdx), %ebx
	movl	$0, %r10d
	jmp	.L5
.L3:
	leaq	1(%r10), %rax
	addq	$4, %r11
	addq	$4, %r9
	cmpq	%rbx, %r10
	je	.L1
	movq	%rax, %r10
.L5:
	movq	%r11, %rdx
	movl	$1, (%r11)
	testl	%r10d, %r10d
	js	.L3
	movq	%r9, %r8
	movl	-4(%r9), %eax
	cmpl	%eax, (%r9)
	jl	.L3
	leaq	-1(%r10), %rax
.L4:
	addl	$1, (%rdx)
	testl	%eax, %eax
	js	.L3
	subq	$1, %rax
	movl	4(%rcx,%rax,4), %esi
	cmpl	%esi, (%r8)
	jge	.L4
	jmp	.L3
.L1:
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printArray
	.def	printArray;	.scl	2;	.type	32;	.endef
	.seh_proc	printArray
printArray:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%edx, %edx
	jle	.L8
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L10:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L10
.L8:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$4, 36(%rsp)
	movl	$5, 40(%rsp)
	movl	$90, 44(%rsp)
	movl	$120, 48(%rsp)
	movl	$80, 52(%rsp)
	leaq	64(%rsp), %rbx
	leaq	32(%rsp), %rcx
	movq	%rbx, %r8
	movl	$6, %edx
	call	calculateSpan
	movl	$6, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$0, %eax
	addq	$96, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
