	.file	"Median_of_two_sorted_arrays_of_same_size_2.c"
	.text
	.globl	compare
	.def	compare;	.scl	2;	.type	32;	.endef
	.seh_proc	compare
compare:
	.seh_endprologue
	movl	(%rcx), %eax
	cmpl	(%rdx), %eax
	setg	%al
	movzbl	%al, %eax
	leal	-1(%rax,%rax), %eax
	ret
	.seh_endproc
	.globl	getMedian
	.def	getMedian;	.scl	2;	.type	32;	.endef
	.seh_proc	getMedian
getMedian:
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
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	leal	-1(%r8), %ebx
	movslq	%ebx, %rbx
	leaq	0(,%rbx,4), %rax
	leaq	(%rcx,%rax), %rbp
	movl	0(%rbp), %r10d
	movl	(%rdx), %r11d
	cmpl	%r11d, %r10d
	jle	.L5
	testl	%r8d, %r8d
	jle	.L5
	leaq	4(%rcx,%rax), %r12
	movq	%rdx, %rax
	movl	$0, %ecx
	movl	$0, %r9d
.L6:
	movl	%r11d, 0(%rbp,%rcx)
	movl	%r10d, (%rax)
	addl	$1, %r9d
	movl	-8(%r12,%rcx), %r10d
	addq	$4, %rax
	movl	(%rax), %r11d
	cmpl	%r11d, %r10d
	jle	.L5
	subq	$4, %rcx
	movl	%r9d, %edx
	notl	%edx
	addl	%r8d, %edx
	js	.L5
	cmpl	%r9d, %r8d
	jg	.L6
.L5:
	movslq	%r8d, %rbp
	leaq	compare(%rip), %r9
	movl	$4, %r8d
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	call	qsort
	leaq	compare(%rip), %r9
	movl	$4, %r8d
	movq	%rbp, %rdx
	movq	%rdi, %rcx
	call	qsort
	movl	(%rdi), %eax
	addl	(%rsi,%rbx,4), %eax
	movl	%eax, %edx
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Median is %d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$1, 64(%rsp)
	movl	$12, 68(%rsp)
	movl	$15, 72(%rsp)
	movl	$26, 76(%rsp)
	movl	$38, 80(%rsp)
	movl	$2, 32(%rsp)
	movl	$13, 36(%rsp)
	movl	$17, 40(%rsp)
	movl	$30, 44(%rsp)
	movl	$45, 48(%rsp)
	leaq	32(%rsp), %rdx
	leaq	64(%rsp), %rcx
	movl	$5, %r8d
	call	getMedian
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	qsort;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
