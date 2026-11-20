	.file	"Rabin-Karp_Algorithm_for_Pattern_Searching.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Pattern found at index %d \12\0"
	.text
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
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
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	movq	%rcx, %r13
	movq	%rdx, %r14
	movl	%r8d, %ebp
	movq	$-1, %r8
	movl	$0, %eax
	movq	%r8, %rcx
	movq	%r13, %rdi
	repnz scasb
	notq	%rcx
	leaq	(%rcx,%r8), %rsi
	movq	%rsi, 48(%rsp)
	movl	%esi, 60(%rsp)
	movq	%r8, %rcx
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	addq	%rax, %r8
	cmpl	$1, %esi
	jle	.L13
	leal	-1(%rsi), %r9d
	movl	$1, %r12d
	movl	$0, %ecx
	movl	%r12d, %edx
.L3:
	movl	%edx, %eax
	sall	$8, %eax
	cltd
	idivl	%ebp
	addl	$1, %ecx
	cmpl	%r9d, %ecx
	jne	.L3
	movl	%edx, %r12d
.L2:
	movq	48(%rsp), %rax
	testl	%eax, %eax
	jle	.L14
	leal	-1(%rax), %r9d
	movl	$0, %ecx
	movl	$0, %ebx
	movl	$0, %esi
	jmp	.L5
.L13:
	movl	$1, %r12d
	jmp	.L2
.L15:
	movq	%rax, %rcx
.L5:
	movl	%esi, %eax
	sall	$8, %eax
	movsbl	0(%r13,%rcx), %edx
	addl	%edx, %eax
	cltd
	idivl	%ebp
	movl	%edx, %esi
	movl	%ebx, %eax
	sall	$8, %eax
	movsbl	(%r14,%rcx), %edx
	addl	%edx, %eax
	cltd
	idivl	%ebp
	movl	%edx, %ebx
	leaq	1(%rcx), %rax
	cmpq	%r9, %rcx
	jne	.L15
.L4:
	movl	%r8d, %eax
	movq	48(%rsp), %rdx
	subl	%edx, %eax
	movl	%eax, 44(%rsp)
	js	.L1
	movl	%eax, %ecx
	movl	$0, %edi
	leal	-1(%rdx), %eax
	leaq	1(%rax), %r15
	movl	%r12d, 56(%rsp)
	movq	%rcx, %r12
	jmp	.L12
.L14:
	movl	$0, %ebx
	movl	$0, %esi
	jmp	.L4
.L20:
	cmpl	$0, 60(%rsp)
	jle	.L16
	movzbl	0(%r13), %eax
	cmpb	%al, (%r14,%rdi)
	jne	.L7
	movl	$1, %eax
	leaq	(%r14,%rdi), %r8
.L9:
	movl	%eax, %ecx
	cmpq	%rax, %r15
	je	.L8
	movzbl	(%r8,%rax), %ecx
	addq	$1, %rax
	cmpb	-1(%r13,%rax), %cl
	je	.L9
	jmp	.L7
.L16:
	movl	$0, %ecx
.L8:
	cmpl	%ecx, 60(%rsp)
	jne	.L7
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L7
.L11:
	leaq	1(%rdi), %rax
	cmpq	%rdi, %r12
	je	.L1
	movq	%rax, %rdi
.L12:
	movl	%edi, 40(%rsp)
	movl	%edi, %edx
	cmpl	%ebx, %esi
	je	.L20
.L7:
	cmpl	%edi, 44(%rsp)
	jle	.L11
	movsbl	(%r14,%rdi), %eax
	imull	56(%rsp), %eax
	subl	%eax, %ebx
	sall	$8, %ebx
	movl	40(%rsp), %eax
	addl	48(%rsp), %eax
	cltq
	movsbl	(%r14,%rax), %eax
	addl	%ebx, %eax
	cltd
	idivl	%ebp
	leal	(%rdx,%rbp), %ebx
	testl	%edx, %edx
	cmovns	%edx, %ebx
	jmp	.L11
.L1:
	addq	$72, %rsp
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
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movabsq	$5712288719483258183, %rax
	movq	%rax, 48(%rsp)
	movabsq	$23445183954100306, %rax
	movq	%rax, 56(%rsp)
	movl	$1262830919, 43(%rsp)
	movb	$0, 47(%rsp)
	leaq	48(%rsp), %rdx
	leaq	43(%rsp), %rcx
	movl	$101, %r8d
	call	search
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
