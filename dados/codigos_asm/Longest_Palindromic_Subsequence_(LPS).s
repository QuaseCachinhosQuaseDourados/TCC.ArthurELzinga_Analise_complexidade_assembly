	.file	"Longest_Palindromic_Subsequence_(LPS).c"
	.text
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
	.globl	lps
	.def	lps;	.scl	2;	.type	32;	.endef
	.seh_proc	lps
lps:
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
	movl	%edx, %ebx
	movl	%r8d, %edi
	movl	$1, %eax
	cmpl	%r8d, %edx
	je	.L2
	movslq	%edx, %rdx
	movslq	%r8d, %rax
	movzbl	(%rcx,%rax), %eax
	cmpb	%al, (%rcx,%rdx)
	je	.L7
	leal	1(%rbx), %edx
	call	lps
	movl	%eax, %esi
	leal	-1(%rdi), %r8d
	movl	%ebx, %edx
	movq	%rbp, %rcx
	call	lps
	cmpl	%eax, %esi
	cmovge	%esi, %eax
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L7:
	leal	1(%rbx), %edx
	cmpl	%r8d, %edx
	je	.L6
	leal	-1(%r8), %r8d
	call	lps
	addl	$2, %eax
	jmp	.L2
.L6:
	movl	$2, %eax
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "The length of the LPS is %d\0"
	.text
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
	movabsq	$5931036557829293383, %rax
	movq	%rax, 34(%rsp)
	movl	$1262830919, 42(%rsp)
	movw	$83, 46(%rsp)
	leaq	34(%rsp), %r9
	movq	$-1, %rcx
	movl	$0, %eax
	movq	%r9, %rdi
	repnz scasb
	movq	%rcx, %rdx
	notq	%rdx
	leal	-2(%rdx), %r8d
	movl	$0, %edx
	movq	%r9, %rcx
	call	lps
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
