	.file	"Naive_algorithm_for_Pattern_Searching.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Pattern found at index %d \12\0"
	.text
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	$-1, %r9
	movl	$0, %eax
	movq	%r9, %rcx
	movq	%rbx, %rdi
	repnz scasb
	notq	%rcx
	leaq	(%rcx,%r9), %r8
	movl	%r8d, %r12d
	movq	%r9, %rcx
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	(%rax,%r9), %r13
	subl	%r8d, %r13d
	js	.L1
	movq	%rdx, %rdi
	addl	$1, %r13d
	movl	$0, %ebp
	leal	-1(%r8), %esi
	addq	$1, %rsi
	jmp	.L3
.L8:
	movl	$0, %edx
.L6:
	cmpl	%edx, %r12d
	je	.L9
.L4:
	addl	$1, %ebp
	addq	$1, %rdi
	cmpl	%r13d, %ebp
	je	.L1
.L3:
	testl	%r12d, %r12d
	jle	.L8
	movq	%rdi, %r8
	movzbl	(%rbx), %eax
	cmpb	%al, (%rdi)
	jne	.L4
	movl	$1, %eax
.L7:
	movl	%eax, %edx
	cmpq	%rax, %rsi
	je	.L6
	movzbl	(%r8,%rax), %ecx
	addq	$1, %rax
	cmpb	-1(%rbx,%rax), %cl
	je	.L7
	jmp	.L4
.L9:
	movl	%ebp, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L4
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movabsq	$4702113433498304833, %rax
	movq	%rax, 48(%rsp)
	movabsq	$4774168828529688900, %rax
	movq	%rax, 56(%rsp)
	movw	$16705, 64(%rsp)
	movb	$0, 66(%rsp)
	movl	$1094861121, 43(%rsp)
	movb	$0, 47(%rsp)
	leaq	48(%rsp), %rdx
	leaq	43(%rsp), %rcx
	call	search
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
