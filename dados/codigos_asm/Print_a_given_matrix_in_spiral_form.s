	.file	"Print_a_given_matrix_in_spiral_form.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	spiralPrint
	.def	spiralPrint;	.scl	2;	.type	32;	.endef
	.seh_proc	spiralPrint
spiralPrint:
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
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	movl	%ecx, 160(%rsp)
	movq	%r8, 176(%rsp)
	movl	%edx, 68(%rsp)
	movslq	%edx, %rax
	movq	%rax, 56(%rsp)
	leaq	12(%r8,%rax,4), %rax
	movq	%rax, 40(%rsp)
	movl	%edx, %ebp
	movl	$0, %esi
	movl	$0, %r15d
	movl	$0, 36(%rsp)
	leaq	.LC0(%rip), %rbx
	movq	%r8, %rax
	subq	$32, %rax
	movq	%rax, 72(%rsp)
	movl	%ecx, %r13d
	jmp	.L2
.L13:
	movslq	%r13d, %rax
	salq	$4, %rax
	movq	176(%rsp), %rcx
	leaq	-16(%rcx,%rax), %r12
	movslq	%edi, %rdi
.L7:
	movl	(%r12,%rdi,4), %edx
	movq	%rbx, %rcx
	call	printf
	subq	$1, %rdi
	cmpl	%edi, %r15d
	jle	.L7
.L14:
	subl	$1, %r13d
.L15:
	cmpl	64(%rsp), %r15d
	jl	.L21
.L8:
	addq	$1, %rsi
	subl	$1, %ebp
	addq	$12, 40(%rsp)
	movl	%r14d, 36(%rsp)
.L2:
	movl	%ebp, %r14d
	cmpl	36(%rsp), %r13d
	jle	.L1
	cmpl	%ebp, %r15d
	jge	.L1
	movq	%rsi, %r12
	salq	$4, %r12
	addq	176(%rsp), %r12
	movslq	%r15d, %rax
	movq	%rax, 48(%rsp)
	movq	%rax, %rdi
.L3:
	movl	(%r12,%rdi,4), %edx
	movq	%rbx, %rcx
	call	printf
	addq	$1, %rdi
	cmpl	%edi, %r14d
	jg	.L3
	movl	36(%rsp), %eax
	leal	1(%rax), %r14d
	cmpl	%r14d, %r13d
	jle	.L4
	leal	-2(%r13), %eax
	subl	%esi, %eax
	addq	%rsi, %rax
	movq	56(%rsp), %rdx
	subq	%rsi, %rdx
	leaq	(%rdx,%rax,4), %rax
	movq	176(%rsp), %rcx
	leaq	28(%rcx,%rax,4), %r12
	movq	40(%rsp), %rdi
.L5:
	movl	(%rdi), %edx
	movq	%rbx, %rcx
	call	printf
	addq	$16, %rdi
	cmpq	%r12, %rdi
	jne	.L5
	movl	68(%rsp), %eax
	subl	%r14d, %eax
	movl	%eax, 64(%rsp)
	leal	-2(%rbp), %edi
	cmpl	%edi, %r15d
	jle	.L13
	jmp	.L14
.L21:
	cmpl	%r14d, %r13d
	jle	.L9
	movslq	%r13d, %rax
	movq	48(%rsp), %rcx
	leaq	(%rcx,%rax,4), %r12
	salq	$2, %r12
	movq	176(%rsp), %rax
	leaq	-16(%rax,%r12), %rdi
	addq	72(%rsp), %r12
	movl	$-2, %eax
	subl	36(%rsp), %eax
	leal	(%rax,%r13), %eax
	salq	$4, %rax
	subq	%rax, %r12
.L10:
	movl	(%rdi), %edx
	movq	%rbx, %rcx
	call	printf
	subq	$16, %rdi
	cmpq	%r12, %rdi
	jne	.L10
.L9:
	addl	$1, %r15d
	jmp	.L8
.L4:
	movl	68(%rsp), %eax
	subl	%r14d, %eax
	movl	%eax, 64(%rsp)
	jmp	.L15
.L1:
	addq	$88, %rsp
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
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	movl	$7, 56(%rsp)
	movl	$8, 60(%rsp)
	movl	$9, 64(%rsp)
	movl	$10, 68(%rsp)
	movl	$11, 72(%rsp)
	movl	$12, 76(%rsp)
	movl	$13, 80(%rsp)
	movl	$14, 84(%rsp)
	movl	$15, 88(%rsp)
	movl	$16, 92(%rsp)
	leaq	32(%rsp), %r8
	movl	$4, %edx
	movl	$4, %ecx
	call	spiralPrint
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
