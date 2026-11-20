	.file	"01_Knapsack_Problem.c"
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %esi
	movq	%rdx, %r13
	movq	%r8, %rbp
	testl	%r9d, %r9d
	je	.L5
	testl	%ecx, %ecx
	je	.L5
	movslq	%r9d, %rdi
	salq	$2, %rdi
	movl	-4(%rdx,%rdi), %r14d
	cmpl	%ecx, %r14d
	jle	.L4
	subl	$1, %r9d
	call	knapSack
	jmp	.L2
.L4:
	leal	-1(%r9), %ebx
	movl	%ebx, %r9d
	call	knapSack
	movl	%eax, %r12d
	movl	%esi, %ecx
	subl	%r14d, %ecx
	movl	%ebx, %r9d
	movq	%rbp, %r8
	movq	%r13, %rdx
	call	knapSack
	addl	-4(%rbp,%rdi), %eax
	cmpl	%r12d, %eax
	cmovl	%r12d, %eax
	jmp	.L2
.L5:
	movl	$0, %eax
.L2:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
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
