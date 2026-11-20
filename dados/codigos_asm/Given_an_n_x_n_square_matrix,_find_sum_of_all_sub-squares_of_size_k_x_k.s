	.file	"Given_an_n_x_n_square_matrix,_find_sum_of_all_sub-squares_of_size_k_x_k.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printSumSimple
	.def	printSumSimple;	.scl	2;	.type	32;	.endef
	.seh_proc	printSumSimple
printSumSimple:
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
	cmpl	$5, %edx
	jg	.L1
	movl	$6, %r15d
	subl	%edx, %r15d
	movl	%edx, 44(%rsp)
	movq	%rcx, %r14
	leal	-1(%rdx), %eax
	leaq	(%rax,%rax,4), %rax
	leaq	20(%rcx,%rax,4), %rbp
	movl	%edx, %r12d
	movl	$0, %r13d
	jmp	.L3
.L7:
	addq	$20, %r9
	cmpq	%rbp, %r9
	je	.L5
.L9:
	movq	%r9, %rcx
	movq	%rdi, %rax
	cmpl	%esi, %ebx
	jge	.L7
.L4:
	addl	(%rcx,%rax,4), %edx
	addq	$1, %rax
	cmpl	%eax, %r8d
	jg	.L4
	jmp	.L7
.L5:
	leaq	.LC0(%rip), %rcx
	call	printf
	addl	$1, %ebx
	addq	$1, %rdi
	addl	$1, %esi
	cmpl	%r15d, %ebx
	je	.L8
.L10:
	movq	%r14, %r9
	movl	$0, %edx
	movl	%esi, %r8d
	cmpl	%r12d, %r13d
	jl	.L9
	jmp	.L5
.L8:
	movl	$10, %ecx
	call	putchar
	addl	$1, %r13d
	addl	$1, %r12d
	addq	$20, %rbp
	addq	$20, %r14
	cmpl	%r15d, %r13d
	je	.L1
.L3:
	movl	44(%rsp), %esi
	movl	$0, %edi
	movl	$0, %ebx
	jmp	.L10
.L1:
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
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$152, %rsp
	.seh_stackalloc	152
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$1, 36(%rsp)
	movl	$1, 40(%rsp)
	movl	$1, 44(%rsp)
	movl	$1, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$2, 56(%rsp)
	movl	$2, 60(%rsp)
	movl	$2, 64(%rsp)
	movl	$2, 68(%rsp)
	movl	$3, 72(%rsp)
	movl	$3, 76(%rsp)
	movl	$3, 80(%rsp)
	movl	$3, 84(%rsp)
	movl	$3, 88(%rsp)
	movl	$4, 92(%rsp)
	movl	$4, 96(%rsp)
	movl	$4, 100(%rsp)
	movl	$4, 104(%rsp)
	movl	$4, 108(%rsp)
	movl	$5, 112(%rsp)
	movl	$5, 116(%rsp)
	movl	$5, 120(%rsp)
	movl	$5, 124(%rsp)
	movl	$5, 128(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %edx
	call	printSumSimple
	movl	$0, %eax
	addq	$152, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
