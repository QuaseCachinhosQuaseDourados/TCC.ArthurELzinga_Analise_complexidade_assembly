	.file	"Longest_Increasing_Subsequence_(LIS).c"
	.text
	.globl	_lis
	.def	_lis;	.scl	2;	.type	32;	.endef
	.seh_proc	_lis
_lis:
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
	movq	%rcx, %rdi
	movq	%r8, %rbp
	movl	%edx, %esi
	cmpl	$1, %edx
	je	.L1
	movl	$1, %esi
	jle	.L3
	movslq	%edx, %rax
	leaq	-4(%rcx,%rax,4), %r12
	leal	-2(%rdx), %r13d
	addq	$2, %r13
	movl	$1, %ebx
	jmp	.L5
.L4:
	addq	$1, %rbx
	cmpq	%r13, %rbx
	je	.L3
.L5:
	movq	%rbp, %r8
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	_lis
	movl	(%r12), %ecx
	cmpl	%ecx, -4(%rdi,%rbx,4)
	jge	.L4
	cmpl	%esi, %eax
	setge	%dl
	addl	$1, %eax
	testb	%dl, %dl
	cmovne	%eax, %esi
	jmp	.L4
.L3:
	cmpl	%esi, 0(%rbp)
	jge	.L1
	movl	%esi, 0(%rbp)
.L1:
	movl	%esi, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.globl	lis
	.def	lis;	.scl	2;	.type	32;	.endef
	.seh_proc	lis
lis:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movl	$1, 44(%rsp)
	leaq	44(%rsp), %r8
	call	_lis
	movl	44(%rsp), %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Length of lis is %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$22, 36(%rsp)
	movl	$9, 40(%rsp)
	movl	$33, 44(%rsp)
	movl	$21, 48(%rsp)
	movl	$50, 52(%rsp)
	movl	$41, 56(%rsp)
	movl	$60, 60(%rsp)
	leaq	32(%rsp), %rcx
	movl	$8, %edx
	call	lis
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
