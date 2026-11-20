	.file	"Permutations_of_given_String.c"
	.text
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
	.seh_endprologue
	movzbl	(%rcx), %eax
	movzbl	(%rdx), %r8d
	movb	%r8b, (%rcx)
	movb	%al, (%rdx)
	ret
	.seh_endproc
	.globl	permute
	.def	permute;	.scl	2;	.type	32;	.endef
	.seh_proc	permute
permute:
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
	movq	%rcx, %r12
	movl	%r8d, %ebp
	cmpl	%r8d, %edx
	je	.L3
	jg	.L2
	movslq	%edx, %rax
	leaq	(%rcx,%rax), %rsi
	movq	%rsi, %rbx
	leaq	1(%rcx,%rax), %r13
	movl	%r8d, %eax
	subl	%edx, %eax
	addq	%rax, %r13
	leal	1(%rdx), %edi
.L6:
	movzbl	(%rsi), %eax
	movzbl	(%rbx), %edx
	movb	%dl, (%rsi)
	movb	%al, (%rbx)
	movl	%ebp, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	permute
	movzbl	(%rsi), %eax
	movzbl	(%rbx), %edx
	movb	%dl, (%rsi)
	movb	%al, (%rbx)
	addq	$1, %rbx
	cmpq	%r13, %rbx
	jne	.L6
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L3:
	call	puts
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movl	$4407873, 44(%rsp)
	leaq	44(%rsp), %r9
	movq	$-1, %rcx
	movl	$0, %eax
	movq	%r9, %rdi
	repnz scasb
	movq	%rcx, %rdx
	notq	%rdx
	leal	-2(%rdx), %r8d
	movl	$0, %edx
	movq	%r9, %rcx
	call	permute
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
