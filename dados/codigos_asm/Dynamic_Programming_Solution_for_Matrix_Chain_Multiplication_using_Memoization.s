	.file	"Dynamic_Programming_Solution_for_Matrix_Chain_Multiplication_using_Memoization.c"
	.text
	.globl	MatrixChainOrder
	.def	MatrixChainOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	MatrixChainOrder
MatrixChainOrder:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, 40(%rbp)
	movslq	%edx, %rax
	leaq	0(,%rax,4), %rdi
	movq	%rdi, -112(%rbp)
	imulq	%rax, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	movq	%rsp, %r9
	movq	%r9, -120(%rbp)
	cmpl	$1, %edx
	jle	.L2
	shrq	$2, %rdi
	movq	%rdi, %rcx
	movl	$1, %eax
	addq	$1, %rcx
	movl	%edx, %r8d
.L3:
	movslq	%eax, %rdx
	imulq	%rcx, %rdx
	movl	$0, (%r9,%rdx,4)
	addl	$1, %eax
	cmpl	%eax, %r8d
	jne	.L3
.L2:
	cmpl	$2, 40(%rbp)
	jle	.L4
	movq	-112(%rbp), %rdi
	movq	%rdi, %r15
	shrq	$2, %r15
	leaq	8(%rsi), %rax
	movq	%rax, -72(%rbp)
	movl	40(%rbp), %ebx
	movl	%ebx, -96(%rbp)
	leal	-3(%rbx), %eax
	addq	$4, %rax
	movq	%rax, -88(%rbp)
	leaq	0(,%r15,4), %rax
	movq	%rax, -64(%rbp)
	movq	-120(%rbp), %rax
	addq	%rdi, %rax
	movq	%rax, -104(%rbp)
	movq	$3, -80(%rbp)
	leal	1(%rbx), %eax
	movl	%eax, -92(%rbp)
	jmp	.L5
.L7:
	addq	$1, %rdx
	cmpq	%r11, %rdx
	je	.L6
.L8:
	movslq	%edx, %rax
	imulq	%r15, %rax
	addq	%r10, %rax
	movl	(%r9,%rax,4), %eax
	addl	-4(%rbx,%rdx,4), %eax
	movl	%eax, %ecx
	movl	%r12d, %eax
	imull	-4(%rsi,%rdx,4), %eax
	imull	%edi, %eax
	addl	%ecx, %eax
	cmpl	%eax, (%r9,%r8,4)
	jle	.L7
	movl	%eax, (%r9,%r8,4)
	jmp	.L7
.L6:
	addq	$1, %r13
	addl	$1, %r14d
	addq	$1, %r11
	addq	-64(%rbp), %rbx
	cmpq	-56(%rbp), %r13
	je	.L11
.L9:
	movslq	%r14d, %rax
	movslq	%r13d, %rdx
	imulq	%r15, %rdx
	addq	%rdx, %rax
	movl	$2147483647, (%r9,%rax,4)
	cmpl	%r13d, %r14d
	jle	.L6
	movl	-4(%rsi,%r13,4), %r12d
	movq	-72(%rbp), %rax
	movl	-4(%rax,%r13,4), %edi
	leaq	1(%r13), %rdx
	movslq	%r14d, %r10
	movslq	%r13d, %r8
	imulq	%r15, %r8
	addq	%r10, %r8
	jmp	.L8
.L11:
	addq	$1, -80(%rbp)
	movq	-80(%rbp), %rax
	addq	$4, -72(%rbp)
	cmpq	-88(%rbp), %rax
	je	.L4
.L5:
	movl	-92(%rbp), %eax
	subl	-80(%rbp), %eax
	testl	%eax, %eax
	jle	.L11
	movq	-80(%rbp), %r11
	leal	-1(%r11), %r14d
	movl	-96(%rbp), %eax
	subl	%r11d, %eax
	addq	$2, %rax
	movq	%rax, -56(%rbp)
	movq	-104(%rbp), %rbx
	movl	$1, %r13d
	jmp	.L9
.L4:
	movl	40(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	-112(%rbp), %rdx
	shrq	$2, %rdx
	addq	%rdx, %rax
	movq	-120(%rbp), %rdi
	movl	(%rdi,%rax,4), %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	leaq	32(%rsp), %rcx
	movl	$4, %edx
	call	MatrixChainOrder
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
