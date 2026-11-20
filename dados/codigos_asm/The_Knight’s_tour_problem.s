	.file	"The_Knight\222s_tour_problem.c"
	.text
	.globl	isSafe
	.def	isSafe;	.scl	2;	.type	32;	.endef
	.seh_proc	isSafe
isSafe:
	.seh_endprologue
	cmpl	$7, %ecx
	ja	.L3
	cmpl	$7, %edx
	jbe	.L4
.L3:
	movl	$0, %eax
.L1:
	ret
.L4:
	movslq	%ecx, %rcx
	salq	$5, %rcx
	addq	%r8, %rcx
	movslq	%edx, %rdx
	cmpl	$-1, (%rcx,%rdx,4)
	sete	%al
	movzbl	%al, %eax
	jmp	.L1
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii " %2d \0"
	.text
	.globl	printSolution
	.def	printSolution;	.scl	2;	.type	32;	.endef
	.seh_proc	printSolution
printSolution:
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
	leaq	32(%rcx), %rsi
	leaq	288(%rcx), %rbp
	leaq	.LC0(%rip), %rdi
.L6:
	leaq	-32(%rsi), %rbx
.L7:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rsi, %rbx
	jne	.L7
	movl	$10, %ecx
	call	putchar
	addq	$32, %rsi
	cmpq	%rbp, %rsi
	jne	.L6
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	solveKTUtil
	.def	solveKTUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	solveKTUtil
solveKTUtil:
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
	movl	%ecx, %r14d
	movl	%edx, %r15d
	movl	%r8d, 160(%rsp)
	movq	%r9, %rbp
	movq	176(%rsp), %r12
	movq	184(%rsp), %r13
	movl	$1, %eax
	cmpl	$64, %r8d
	je	.L10
	movl	$0, %ebx
	movl	%r8d, %eax
	addl	$1, %eax
	movl	%eax, 60(%rsp)
	jmp	.L13
.L12:
	addq	$4, %rbx
	cmpq	$32, %rbx
	je	.L16
.L13:
	movl	%r14d, %esi
	addl	(%r12,%rbx), %esi
	movl	%r15d, %edi
	addl	0(%r13,%rbx), %edi
	movq	%rbp, %r8
	movl	%edi, %edx
	movl	%esi, %ecx
	call	isSafe
	testl	%eax, %eax
	je	.L12
	movslq	%edi, %rdx
	movslq	%esi, %rax
	salq	$5, %rax
	leaq	(%rax,%rdx,4), %rax
	addq	%rbp, %rax
	movq	%rax, 48(%rsp)
	movl	160(%rsp), %ecx
	movl	%ecx, (%rax)
	movq	%r13, 40(%rsp)
	movq	%r12, 32(%rsp)
	movq	%rbp, %r9
	movl	60(%rsp), %r8d
	movl	%edi, %edx
	movl	%esi, %ecx
	call	solveKTUtil
	cmpl	$1, %eax
	je	.L10
	movq	48(%rsp), %rax
	movl	$-1, (%rax)
	jmp	.L12
.L16:
	movl	$0, %eax
.L10:
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
	.section .rdata,"dr"
.LC1:
	.ascii "Solution do es not exist\0"
	.text
	.globl	solveKT
	.def	solveKT;	.scl	2;	.type	32;	.endef
	.seh_proc	solveKT
solveKT:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$368, %rsp
	.seh_stackalloc	368
	.seh_endprologue
	leaq	112(%rsp), %rax
	leaq	368(%rsp), %rdx
.L18:
	movl	$-1, (%rax)
	movl	$-1, 4(%rax)
	movl	$-1, 8(%rax)
	movl	$-1, 12(%rax)
	movl	$-1, 16(%rax)
	movl	$-1, 20(%rax)
	movl	$-1, 24(%rax)
	movl	$-1, 28(%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L18
	movl	$2, 80(%rsp)
	movl	$1, 84(%rsp)
	movl	$-1, 88(%rsp)
	movl	$-2, 92(%rsp)
	movl	$-2, 96(%rsp)
	movl	$-1, 100(%rsp)
	movl	$1, 104(%rsp)
	movl	$2, 108(%rsp)
	movl	$1, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$2, 56(%rsp)
	movl	$1, 60(%rsp)
	movl	$-1, 64(%rsp)
	movl	$-2, 68(%rsp)
	movl	$-2, 72(%rsp)
	movl	$-1, 76(%rsp)
	movl	$0, 112(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	112(%rsp), %r9
	movl	$1, %r8d
	movl	$0, %edx
	movl	$0, %ecx
	call	solveKTUtil
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L22
	leaq	112(%rsp), %rcx
	call	printSolution
	movl	$1, %ebx
.L17:
	movl	%ebx, %eax
	addq	$368, %rsp
	popq	%rbx
	ret
.L22:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L17
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	call	solveKT
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
