	.file	"Algorithm_to_Solve_Sudoku_Sudoku_Solver.c"
	.text
	.section .rdata,"dr"
.LC1:
	.ascii "%d \0"
	.text
	.globl	print
	.def	print;	.scl	2;	.type	32;	.endef
	.seh_proc	print
print:
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
	leaq	36(%rcx), %rsi
	leaq	360(%rcx), %rbp
	leaq	.LC1(%rip), %rdi
.L2:
	leaq	-36(%rsi), %rbx
.L3:
	movl	(%rbx), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rsi, %rbx
	jne	.L3
	movl	$10, %ecx
	call	putchar
	addq	$36, %rsi
	cmpq	%rbp, %rsi
	jne	.L2
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	isSafe
	.def	isSafe;	.scl	2;	.type	32;	.endef
	.seh_proc	isSafe
isSafe:
	.seh_endprologue
	movl	%edx, %r10d
	movslq	%edx, %rax
	leaq	(%rax,%rax,8), %rax
	leaq	(%rcx,%rax,4), %rdx
	cmpl	(%rdx), %r9d
	je	.L12
	leaq	4(%rdx), %rax
	addq	$36, %rdx
.L8:
	cmpl	%r9d, (%rax)
	je	.L13
	addq	$4, %rax
	cmpq	%rdx, %rax
	jne	.L8
	movslq	%r8d, %rax
	cmpl	(%rcx,%rax,4), %r9d
	je	.L14
	movq	%rax, %rdx
	salq	$2, %rdx
	leaq	(%rcx,%rdx), %rax
	leaq	288(%rcx,%rdx), %rdx
.L9:
	cmpl	%r9d, 36(%rax)
	je	.L15
	addq	$36, %rax
	cmpq	%rdx, %rax
	jne	.L9
	movl	$1431655766, %r11d
	movl	%r10d, %eax
	imull	%r11d
	sarl	$31, %r10d
	subl	%r10d, %edx
	leal	(%rdx,%rdx,2), %eax
	cltq
	leaq	(%rax,%rax,8), %r10
	movl	%r8d, %eax
	imull	%r11d
	sarl	$31, %r8d
	subl	%r8d, %edx
	leal	(%rdx,%rdx,2), %edx
	movslq	%edx, %rdx
	addq	%r10, %rdx
	salq	$2, %rdx
	leaq	(%rcx,%rdx), %rax
	leaq	108(%rcx,%rdx), %rcx
.L10:
	movq	%rax, %rdx
	cmpl	(%rax), %r9d
	je	.L21
	cmpl	4(%rax), %r9d
	je	.L16
	cmpl	%r9d, 8(%rdx)
	je	.L17
	addq	$36, %rax
	cmpq	%rcx, %rax
	jne	.L10
	movl	$1, %eax
	jmp	.L6
.L21:
	movl	$0, %eax
	jmp	.L6
.L12:
	movl	$0, %eax
	jmp	.L6
.L13:
	movl	$0, %eax
.L6:
	ret
.L14:
	movl	$0, %eax
	jmp	.L6
.L15:
	movl	$0, %eax
	jmp	.L6
.L16:
	movl	$0, %eax
	jmp	.L6
.L17:
	movl	$0, %eax
	jmp	.L6
	.seh_endproc
	.globl	solveSudoku
	.def	solveSudoku;	.scl	2;	.type	32;	.endef
	.seh_proc	solveSudoku
solveSudoku:
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
	movl	%edx, %edi
	movl	%r8d, %esi
	cmpl	$8, %edx
	jne	.L30
	movl	$1, %eax
	cmpl	$9, %r8d
	je	.L22
.L30:
	cmpl	$9, %esi
	je	.L33
.L25:
	movslq	%edi, %rax
	leaq	(%rax,%rax,8), %rdx
	movslq	%esi, %rax
	salq	$2, %rax
	leaq	(%rax,%rdx,4), %rbp
	addq	%r12, %rbp
	movl	$1, %ebx
	leal	1(%rsi), %r13d
	cmpl	$0, 0(%rbp)
	jle	.L26
	movl	%r13d, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	solveSudoku
	jmp	.L22
.L33:
	addl	$1, %edi
	movl	$0, %esi
	jmp	.L25
.L27:
	movl	$0, 0(%rbp)
	addl	$1, %ebx
	cmpl	$10, %ebx
	je	.L34
.L26:
	movl	%ebx, %r9d
	movl	%esi, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	isSafe
	cmpl	$1, %eax
	jne	.L27
	movl	%ebx, 0(%rbp)
	movl	%r13d, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	solveSudoku
	cmpl	$1, %eax
	jne	.L27
	jmp	.L22
.L34:
	movl	$0, %eax
.L22:
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
	.section .rdata,"dr"
.LC2:
	.ascii "No solution exists\0"
	.data
	.align 32
.LC0:
	.long	3
	.long	0
	.long	6
	.long	5
	.long	0
	.long	8
	.long	4
	.long	0
	.long	0
	.long	5
	.long	2
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	8
	.long	7
	.long	0
	.long	0
	.long	0
	.long	0
	.long	3
	.long	1
	.long	0
	.long	0
	.long	3
	.long	0
	.long	1
	.long	0
	.long	0
	.long	8
	.long	0
	.long	9
	.long	0
	.long	0
	.long	8
	.long	6
	.long	3
	.long	0
	.long	0
	.long	5
	.long	0
	.long	5
	.long	0
	.long	0
	.long	9
	.long	0
	.long	6
	.long	0
	.long	0
	.long	1
	.long	3
	.long	0
	.long	0
	.long	0
	.long	0
	.long	2
	.long	5
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	7
	.long	4
	.long	0
	.long	0
	.long	5
	.long	2
	.long	0
	.long	6
	.long	3
	.long	0
	.long	0
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$368, %rsp
	.seh_stackalloc	368
	.seh_endprologue
	call	__main
	leaq	32(%rsp), %rbx
	movl	$324, %r8d
	leaq	.LC0(%rip), %rdx
	movq	%rbx, %rcx
	call	memcpy
	movl	$0, %r8d
	movl	$0, %edx
	movq	%rbx, %rcx
	call	solveSudoku
	cmpl	$1, %eax
	je	.L38
	leaq	.LC2(%rip), %rcx
	call	printf
.L37:
	movl	$0, %eax
	addq	$368, %rsp
	popq	%rbx
	ret
.L38:
	leaq	32(%rsp), %rcx
	call	print
	jmp	.L37
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
