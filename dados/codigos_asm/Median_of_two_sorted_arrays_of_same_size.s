	.file	"Median_of_two_sorted_arrays_of_same_size.c"
	.text
	.globl	getMedian
	.def	getMedian;	.scl	2;	.type	32;	.endef
	.seh_proc	getMedian
getMedian:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%r8d, %r8d
	js	.L9
	je	.L10
	movl	$-1, %esi
	movl	$0, %r9d
	movl	$0, %r11d
	movl	$0, %r10d
	jmp	.L4
.L10:
	movl	$-1, %eax
.L3:
	movl	%eax, %esi
	movl	(%rdx), %eax
.L2:
	addl	%esi, %eax
	movl	%eax, %esi
	shrl	$31, %esi
	addl	%esi, %eax
	sarl	%eax
	popq	%rbx
	popq	%rsi
	ret
.L12:
	movl	%eax, %esi
	movl	(%rcx), %eax
	jmp	.L2
.L6:
	addl	$1, %r11d
	movl	%ebx, %eax
.L7:
	addl	$1, %r9d
	cmpl	%r9d, %r8d
	jl	.L2
	cmpl	%r8d, %r10d
	je	.L3
	cmpl	%r8d, %r11d
	je	.L12
	movl	%eax, %esi
.L4:
	movslq	%r10d, %rbx
	movl	(%rcx,%rbx,4), %eax
	movslq	%r11d, %rbx
	movl	(%rdx,%rbx,4), %ebx
	cmpl	%ebx, %eax
	jg	.L6
	addl	$1, %r10d
	jmp	.L7
.L9:
	movl	$-1, %eax
	movl	%eax, %esi
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Median is %d\0"
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
	call	getchar
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
