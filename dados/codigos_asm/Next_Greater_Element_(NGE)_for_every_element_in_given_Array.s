	.file	"Next_Greater_Element_(NGE)_for_every_element_in_given_Array.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d -- %dn\0"
	.text
	.globl	printNGE
	.def	printNGE;	.scl	2;	.type	32;	.endef
	.seh_proc	printNGE
printNGE:
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
	movq	%rcx, %rbx
	movl	%edx, %esi
	testl	%edx, %edx
	jle	.L1
	leal	-1(%rdx), %r14d
	movl	%r14d, %ebp
	movl	$0, %edi
	movl	$-1, %r13d
	leaq	.LC0(%rip), %r12
	jmp	.L7
.L8:
	movl	%r13d, %r8d
.L4:
	movq	%r12, %rcx
	call	printf
	addq	$1, %rdi
.L7:
	cmpq	%rbp, %rdi
	je	.L3
	movl	(%rbx,%rdi,4), %edx
	movl	4(%rbx,%rdi,4), %r8d
	cmpl	%r8d, %edx
	jl	.L4
	leal	2(%rdi), %eax
	cltq
.L5:
	cmpl	%eax, %esi
	jle	.L8
	addq	$1, %rax
	movl	-4(%rbx,%rax,4), %r8d
	cmpl	%edx, %r8d
	jle	.L5
	jmp	.L4
.L3:
	movslq	%r14d, %r14
	movl	(%rbx,%r14,4), %edx
	movl	$-1, %r8d
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
.L1:
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
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$11, 32(%rsp)
	movl	$13, 36(%rsp)
	movl	$21, 40(%rsp)
	movl	$3, 44(%rsp)
	leaq	32(%rsp), %rcx
	movl	$4, %edx
	call	printNGE
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
