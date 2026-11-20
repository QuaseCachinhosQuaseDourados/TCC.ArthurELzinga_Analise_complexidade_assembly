	.file	"01_Knapsack_Problem_2.c"
	.text
	.globl	max
	.def	max;	.scl	2;	.type	32;	.endef
	.seh_proc	max
max:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovge	%edx, %eax
	ret
	.seh_endproc
	.globl	knapSack
	.def	knapSack;	.scl	2;	.type	32;	.endef
	.seh_proc	knapSack
knapSack:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, 0(%rbp)
	movl	%r9d, 24(%rbp)
	movl	%ecx, %eax
	addl	$1, %eax
	movslq	%eax, %r9
	leaq	0(,%r9,4), %r12
	movl	24(%rbp), %eax
	leal	1(%rax), %ecx
	movslq	%ecx, %rax
	imulq	%r9, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	movq	%rsp, %rax
	movq	%rax, -120(%rbp)
	movq	%rax, -96(%rbp)
	cmpl	$0, 24(%rbp)
	js	.L3
	movq	%rax, %rdi
	movq	%r12, %rbx
	shrq	$2, %rbx
	movq	%rbx, -112(%rbp)
	movq	%rax, %r13
	subq	%r12, %r13
	movl	24(%rbp), %ebx
	movq	%rbx, -104(%rbp)
	movq	%rax, %r15
	movq	%r13, %r14
	movq	%rax, -88(%rbp)
	movl	$0, %r9d
	movl	0(%rbp), %ebx
	jmp	.L4
.L13:
	movl	$0, (%rdi,%rax,4)
.L7:
	leaq	1(%rax), %rcx
	cmpq	%rax, %rbx
	je	.L11
	movq	%rcx, %rax
.L9:
	movl	%eax, %ecx
	testl	%r9d, %r9d
	je	.L13
	testl	%eax, %eax
	je	.L13
	movl	-4(%rdx,%r9,4), %r11d
	cmpl	%r11d, %eax
	jl	.L8
	subl	%r11d, %ecx
	movslq	%ecx, %rcx
	addq	%rsi, %rcx
	movl	-4(%r8,%r9,4), %r10d
	movq	-96(%rbp), %r11
	addl	(%r11,%rcx,4), %r10d
	movl	%r10d, %ecx
	movl	0(%r13,%rax,4), %r10d
	cmpl	%r10d, %ecx
	cmovl	%r10d, %ecx
	movq	-88(%rbp), %r11
	movl	%ecx, (%r11,%rax,4)
	jmp	.L7
.L8:
	movl	(%r14,%rax,4), %ecx
	movl	%ecx, (%r15,%rax,4)
	jmp	.L7
.L11:
	leaq	1(%r9), %rax
	addq	%r12, %rdi
	addq	%r12, %r13
	addq	%r12, -88(%rbp)
	addq	%r12, %r14
	addq	%r12, %r15
	cmpq	-104(%rbp), %r9
	je	.L3
	movq	%rax, %r9
.L4:
	movl	$0, %eax
	cmpl	$0, 0(%rbp)
	js	.L11
	leal	-1(%r9), %esi
	movslq	%esi, %rsi
	imulq	-112(%rbp), %rsi
	jmp	.L9
.L3:
	movslq	0(%rbp), %rax
	movslq	24(%rbp), %rdx
	shrq	$2, %r12
	imulq	%rdx, %r12
	addq	%r12, %rax
	movq	-120(%rbp), %rdx
	movl	(%rdx,%rax,4), %eax
	leaq	-72(%rbp), %rsp
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
.LC0:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$60, 52(%rsp)
	movl	$100, 56(%rsp)
	movl	$120, 60(%rsp)
	movl	$10, 40(%rsp)
	movl	$20, 44(%rsp)
	movl	$30, 48(%rsp)
	leaq	40(%rsp), %rdx
	movl	$3, %r9d
	leaq	52(%rsp), %r8
	movl	$50, %ecx
	call	knapSack
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
