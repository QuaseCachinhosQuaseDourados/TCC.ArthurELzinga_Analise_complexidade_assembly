	.file	"Maximum_sum_rectangle_in_a_2D_matrix_DP-27_2.c"
	.text
	.globl	kadane
	.def	kadane;	.scl	2;	.type	32;	.endef
	.seh_proc	kadane
kadane:
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
	.seh_endprologue
	movl	$-1, (%r8)
	testl	%r9d, %r9d
	jle	.L2
	leal	-1(%r9), %edi
	movl	$0, %r10d
	movl	$0, %ebp
	movl	$-2147483648, %eax
	movl	$0, %ebx
	movl	$0, %r12d
	jmp	.L5
.L12:
	leal	1(%r10), %ebp
	movl	%r12d, %ebx
.L4:
	leaq	1(%r10), %r11
	cmpq	%rdi, %r10
	je	.L11
	movq	%r11, %r10
.L5:
	addl	(%rcx,%r10,4), %ebx
	js	.L12
	cmpl	%eax, %ebx
	jle	.L4
	movl	%ebp, (%rdx)
	movl	%r10d, (%r8)
	movl	%ebx, %eax
	jmp	.L4
.L11:
	cmpl	$-1, (%r8)
	je	.L2
.L1:
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L2:
	movl	(%rcx), %eax
	movl	$0, (%r8)
	movl	$0, (%rdx)
	cmpl	$1, %r9d
	jle	.L1
	leal	-2(%r9), %r11d
	addq	$2, %r11
	movl	$1, %r9d
	jmp	.L8
.L7:
	addq	$1, %r9
	cmpq	%r9, %r11
	je	.L1
.L8:
	movl	(%rcx,%r9,4), %r10d
	cmpl	%eax, %r10d
	jle	.L7
	movl	%r9d, (%r8)
	movl	%r9d, (%rdx)
	movl	%r10d, %eax
	jmp	.L7
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "(Top, Left) (%d, %d)\12\0"
.LC1:
	.ascii "(Bottom, Right) (%d, %d)\12\0"
.LC2:
	.ascii "Max sum is: %d\12\0"
	.text
	.globl	findMaxSum
	.def	findMaxSum;	.scl	2;	.type	32;	.endef
	.seh_proc	findMaxSum
findMaxSum:
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
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	movq	%rcx, 56(%rsp)
	movl	$0, %r12d
	movl	$-2147483648, %ebp
	leaq	72(%rsp), %r15
	leaq	76(%rsp), %r14
	leaq	96(%rsp), %rbx
	jmp	.L18
.L17:
	addl	$1, %esi
	addq	$4, %rdi
	cmpl	$5, %esi
	je	.L15
.L14:
	leaq	80(%rsp), %rax
	movq	%rdi, %rdx
.L16:
	movl	(%rdx), %ecx
	addl	%ecx, (%rax)
	addq	$4, %rax
	addq	$20, %rdx
	cmpq	%rbx, %rax
	jne	.L16
	movl	$4, %r9d
	movq	%r15, %r8
	movq	%r14, %rdx
	movq	%r13, %rcx
	call	kadane
	cmpl	%ebp, %eax
	jle	.L17
	movl	76(%rsp), %ecx
	movl	%ecx, 48(%rsp)
	movl	72(%rsp), %ecx
	movl	%ecx, 52(%rsp)
	movl	%esi, 44(%rsp)
	movl	%r12d, 40(%rsp)
	movl	%eax, %ebp
	jmp	.L17
.L15:
	addl	$1, %r12d
	addq	$4, 56(%rsp)
	cmpl	$5, %r12d
	je	.L25
.L18:
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	56(%rsp), %rdi
	movl	%r12d, %esi
	leaq	80(%rsp), %r13
	cmpl	$4, %r12d
	jle	.L14
	jmp	.L15
.L25:
	movl	40(%rsp), %r8d
	movl	48(%rsp), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	44(%rsp), %r8d
	movl	52(%rsp), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	%ebp, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	nop
	addq	$104, %rsp
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
	subq	$120, %rsp
	.seh_stackalloc	120
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$-1, 40(%rsp)
	movl	$-4, 44(%rsp)
	movl	$-20, 48(%rsp)
	movl	$-8, 52(%rsp)
	movl	$-3, 56(%rsp)
	movl	$4, 60(%rsp)
	movl	$2, 64(%rsp)
	movl	$1, 68(%rsp)
	movl	$3, 72(%rsp)
	movl	$8, 76(%rsp)
	movl	$10, 80(%rsp)
	movl	$1, 84(%rsp)
	movl	$3, 88(%rsp)
	movl	$-4, 92(%rsp)
	movl	$-1, 96(%rsp)
	movl	$1, 100(%rsp)
	movl	$7, 104(%rsp)
	movl	$-6, 108(%rsp)
	leaq	32(%rsp), %rcx
	call	findMaxSum
	movl	$0, %eax
	addq	$120, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
