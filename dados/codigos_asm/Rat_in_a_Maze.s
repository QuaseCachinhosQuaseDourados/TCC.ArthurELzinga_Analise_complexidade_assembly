	.file	"Rat_in_a_Maze.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %d \0"
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
	leaq	16(%rcx), %rsi
	leaq	80(%rcx), %rbp
	leaq	.LC0(%rip), %rdi
.L2:
	leaq	-16(%rsi), %rbx
.L3:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rsi, %rbx
	jne	.L3
	movl	$10, %ecx
	call	putchar
	addq	$16, %rsi
	cmpq	%rbp, %rsi
	jne	.L2
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	boolisSafe
	.def	boolisSafe;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisSafe
boolisSafe:
	.seh_endprologue
	cmpl	$3, %edx
	ja	.L8
	cmpl	$3, %r8d
	jbe	.L9
.L8:
	movl	$0, %eax
.L6:
	ret
.L9:
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rcx, %rdx
	movslq	%r8d, %r8
	cmpl	$1, (%rdx,%r8,4)
	sete	%al
	movzbl	%al, %eax
	jmp	.L6
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Solution do esn't exist\0"
	.text
	.globl	boolsolveMaze
	.def	boolsolveMaze;	.scl	2;	.type	32;	.endef
	.seh_proc	boolsolveMaze
boolsolveMaze:
	pushq	%rdi
	.seh_pushreg	%rdi
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	movq	%rcx, %r10
	leaq	32(%rsp), %rdi
	movl	$8, %ecx
	movl	$0, %eax
	rep stosq
	leaq	32(%rsp), %r9
	movl	$0, %r8d
	movl	$0, %edx
	movq	%r10, %rcx
	call	solveMazeUtil
	movl	%eax, %edi
	testl	%eax, %eax
	je	.L13
	leaq	32(%rsp), %rcx
	call	printSolution
	movl	$1, %edi
.L10:
	movl	%edi, %eax
	addq	$96, %rsp
	popq	%rdi
	ret
.L13:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L10
	.seh_endproc
	.globl	boolsolveMazeUtil
	.def	boolsolveMazeUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	boolsolveMazeUtil
boolsolveMazeUtil:
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
	movq	%rcx, %rdi
	movl	%edx, %ebx
	movl	%r8d, %esi
	movq	%r9, %rbp
	cmpl	$3, %edx
	jne	.L15
	cmpl	$3, %r8d
	jne	.L15
	movl	60(%rcx), %edx
	cmpl	$1, %edx
	je	.L19
.L15:
	movl	%esi, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	isSafe
	movl	$0, %edx
	cmpl	$1, %eax
	je	.L20
.L14:
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L19:
	movl	$1, 60(%r9)
	jmp	.L14
.L20:
	movslq	%esi, %rdx
	movslq	%ebx, %rax
	salq	$4, %rax
	leaq	(%rax,%rdx,4), %r12
	addq	%rbp, %r12
	movl	$0, %edx
	cmpl	$1, (%r12)
	je	.L14
	movl	$1, (%r12)
	leal	1(%rbx), %edx
	movq	%rbp, %r9
	movl	%esi, %r8d
	movq	%rdi, %rcx
	call	solveMazeUtil
	movl	%eax, %edx
	cmpl	$1, %eax
	je	.L14
	movq	%rbp, %r9
	leal	1(%rsi), %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	solveMazeUtil
	movl	%eax, %edx
	cmpl	$1, %eax
	je	.L14
	movl	$0, (%r12)
	movl	$0, %edx
	jmp	.L14
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$0, 36(%rsp)
	movl	$0, 40(%rsp)
	movl	$0, 44(%rsp)
	movl	$1, 48(%rsp)
	movl	$1, 52(%rsp)
	movl	$0, 56(%rsp)
	movl	$1, 60(%rsp)
	movl	$0, 64(%rsp)
	movl	$1, 68(%rsp)
	movl	$0, 72(%rsp)
	movl	$0, 76(%rsp)
	movl	$1, 80(%rsp)
	movl	$1, 84(%rsp)
	movl	$1, 88(%rsp)
	movl	$1, 92(%rsp)
	leaq	32(%rsp), %rcx
	call	solveMaze
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	solveMazeUtil;	.scl	2;	.type	32;	.endef
	.def	isSafe;	.scl	2;	.type	32;	.endef
	.def	solveMaze;	.scl	2;	.type	32;	.endef
