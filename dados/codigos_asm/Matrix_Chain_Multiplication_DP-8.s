	.file	"Matrix_Chain_Multiplication_DP-8.c"
	.text
	.globl	MatrixChainOrder
	.def	MatrixChainOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	MatrixChainOrder
MatrixChainOrder:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rdi
	movl	%edx, %ebp
	movl	%r8d, %r12d
	movl	$0, %esi
	cmpl	%r8d, %edx
	je	.L1
	movl	$2147483647, %esi
	jge	.L1
	movslq	%edx, %rbx
	leaq	-4(%rcx,%rbx,4), %r15
	movslq	%r8d, %rax
	leaq	(%rcx,%rax,4), %r14
	leal	-1(%r8), %eax
	subl	%edx, %eax
	leaq	1(%rbx,%rax), %r13
.L3:
	movl	%ebx, %r8d
	movl	%ebp, %edx
	movq	%rdi, %rcx
	call	MatrixChainOrder
	movl	%eax, 44(%rsp)
	leal	1(%rbx), %edx
	movl	%r12d, %r8d
	movq	%rdi, %rcx
	call	MatrixChainOrder
	movl	(%r15), %edx
	imull	(%rdi,%rbx,4), %edx
	imull	(%r14), %edx
	addl	44(%rsp), %eax
	addl	%edx, %eax
	cmpl	%eax, %esi
	cmovg	%eax, %esi
	addq	$1, %rbx
	cmpq	%r13, %rbx
	jne	.L3
.L1:
	movl	%esi, %eax
	addq	$56, %rsp
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
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Minimum number of multiplications is %d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$3, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$4, %r8d
	movl	$1, %edx
	call	MatrixChainOrder
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
