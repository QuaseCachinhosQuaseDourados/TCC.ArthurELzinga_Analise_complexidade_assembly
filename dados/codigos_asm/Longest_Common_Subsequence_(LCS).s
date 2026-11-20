	.file	"Longest_Common_Subsequence_(LCS).c"
	.text
	.globl	lcs
	.def	lcs;	.scl	2;	.type	32;	.endef
	.seh_proc	lcs
lcs:
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbp
	movl	%r8d, %edi
	movl	%r9d, %r12d
	movslq	%r8d, %rax
	movzbl	(%rcx,%rax), %edx
	movl	$0, %eax
	testb	%dl, %dl
	je	.L1
	movslq	%r9d, %rax
	movzbl	0(%rbp,%rax), %ecx
	movl	$0, %eax
	testb	%cl, %cl
	je	.L1
	cmpb	%cl, %dl
	je	.L6
	leal	1(%r8), %r8d
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	call	lcs
	movl	%eax, %ebx
	leal	1(%r12), %r9d
	movl	%edi, %r8d
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	call	lcs
	cmpl	%eax, %ebx
	cmovge	%ebx, %eax
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L6:
	leal	1(%r9), %r9d
	leal	1(%r8), %r8d
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	call	lcs
	addl	$1, %eax
	jmp	.L1
	.seh_endproc
	.globl	max
	.def	max;	.scl	2;	.type	32;	.endef
	.seh_proc	max
max:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovge	%edx, %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Length of LCS is %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movw	$17474, 45(%rsp)
	movb	$0, 47(%rsp)
	movl	$1145258561, 40(%rsp)
	movb	$0, 44(%rsp)
	leaq	40(%rsp), %rdx
	leaq	45(%rsp), %rcx
	movl	$0, %r9d
	movl	$0, %r8d
	call	lcs
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
