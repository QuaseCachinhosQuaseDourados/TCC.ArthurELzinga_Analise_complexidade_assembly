	.file	"Given_an_n_x_n_square_matrix,_find_sum_of_all_sub-squares_of_size_k_x_k_2.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printSumTricky
	.def	printSumTricky;	.scl	2;	.type	32;	.endef
	.seh_proc	printSumTricky
printSumTricky:
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
	subq	$168, %rsp
	.seh_stackalloc	168
	.seh_endprologue
	movl	%edx, %ebp
	cmpl	$5, %edx
	jg	.L1
	movl	$4, %eax
	subl	%edx, %eax
	leaq	5(%rax,%rax,4), %r9
	salq	$2, %r9
	movq	%rcx, %r12
	leal	-1(%rdx), %eax
	leaq	(%rax,%rax,4), %rax
	leaq	20(%rcx,%rax,4), %r8
	movl	$6, %esi
	subl	%edx, %esi
	movslq	%edx, %r14
	leaq	(%r14,%r14,4), %rax
	leaq	(%rcx,%rax,4), %rbx
	movl	$0, %r10d
	leaq	48(%rsp), %rdi
	leaq	20(%rdi), %r11
	jmp	.L3
.L7:
	addl	(%rbx,%rdx), %eax
	subl	(%rcx,%rdx), %eax
	movl	%eax, (%r11,%rdx)
	addq	$20, %rdx
	cmpq	%r9, %rdx
	jne	.L7
.L6:
	addq	$4, %r10
	addq	$4, %r9
	addq	$4, %r8
	cmpq	$20, %r10
	je	.L8
.L3:
	leaq	(%r10,%r12), %rdx
	movl	$0, %eax
	testl	%ebp, %ebp
	jle	.L10
.L5:
	addl	(%rdx), %eax
	addq	$20, %rdx
	cmpq	%r8, %rdx
	jne	.L5
.L10:
	movl	%eax, (%r10,%rdi)
	cmpl	$1, %esi
	jle	.L6
	movq	%r10, %rdx
	jmp	.L7
.L8:
	movl	$6, %r15d
	subl	%ebp, %r15d
	leaq	48(%rsp), %rdi
	leal	-2(%r15), %eax
	leaq	4(%rdi,%rax,4), %r12
	leal	-1(%r15), %eax
	leaq	(%rax,%rax,4), %rax
	leaq	20(%rdi,%rax,4), %rax
	movq	%rax, 40(%rsp)
	leaq	.LC0(%rip), %r13
	jmp	.L11
.L13:
	movl	$10, %ecx
	call	putchar
	addq	$20, %rdi
	addq	$20, %r12
	cmpq	40(%rsp), %rdi
	je	.L1
.L11:
	movl	$0, %eax
	movl	$0, %ebx
	testl	%ebp, %ebp
	jle	.L16
.L12:
	addl	(%rdi,%rax,4), %ebx
	addq	$1, %rax
	cmpl	%eax, %ebp
	jg	.L12
.L16:
	movl	%ebx, %edx
	movq	%r13, %rcx
	call	printf
	cmpl	$1, %r15d
	jle	.L13
	movq	%rdi, %rsi
.L14:
	addl	(%rsi,%r14,4), %ebx
	subl	(%rsi), %ebx
	movl	%ebx, %edx
	movq	%r13, %rcx
	call	printf
	addq	$4, %rsi
	cmpq	%rsi, %r12
	jne	.L14
	jmp	.L13
.L1:
	addq	$168, %rsp
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
	call	printSumTricky
	movl	$0, %eax
	addq	$152, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
