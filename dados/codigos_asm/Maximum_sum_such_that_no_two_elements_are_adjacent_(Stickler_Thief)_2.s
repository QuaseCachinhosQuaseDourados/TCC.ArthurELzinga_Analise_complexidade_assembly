	.file	"Maximum_sum_such_that_no_two_elements_are_adjacent_(Stickler_Thief)_2.c"
	.text
	.globl	rec
	.def	rec;	.scl	2;	.type	32;	.endef
	.seh_proc	rec
rec:
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
	movq	%rcx, %r12
	movl	%edx, %ebx
	movq	%r8, %rbp
	movl	%r9d, %edi
	movl	$0, %eax
	cmpl	%r9d, %edx
	jge	.L1
	movslq	%edx, %rsi
	salq	$2, %rsi
	leaq	(%r8,%rsi), %r13
	movl	0(%r13), %eax
	cmpl	$-1, %eax
	je	.L6
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
.L6:
	leal	1(%rdx), %r15d
	movl	%r15d, %edx
	call	rec
	movl	%eax, 44(%rsp)
	addq	%r12, %rsi
	movl	(%rsi), %r14d
	addl	$2, %ebx
	movl	%edi, %r9d
	movq	%rbp, %r8
	movl	%ebx, %edx
	movq	%r12, %rcx
	call	rec
	addl	%eax, %r14d
	cmpl	%r14d, 44(%rsp)
	jle	.L3
	movl	%edi, %r9d
	movq	%rbp, %r8
	movl	%r15d, %edx
	movq	%r12, %rcx
	call	rec
.L4:
	movl	%eax, 0(%r13)
	jmp	.L1
.L3:
	movl	(%rsi), %esi
	movl	%edi, %r9d
	movq	%rbp, %r8
	movl	%ebx, %edx
	movq	%r12, %rcx
	call	rec
	addl	%esi, %eax
	jmp	.L4
	.seh_endproc
	.globl	findMaxSum
	.def	findMaxSum;	.scl	2;	.type	32;	.endef
	.seh_proc	findMaxSum
findMaxSum:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rdi
	movl	%edx, %ebx
	leal	1(%rdx), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	call	malloc
	movq	%rax, %rsi
	testl	%ebx, %ebx
	js	.L8
	movl	%ebx, %edx
	leaq	4(%rax,%rdx,4), %rdx
.L9:
	movl	$-1, (%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	jne	.L9
.L8:
	movl	%ebx, %r9d
	movq	%rsi, %r8
	movl	$0, %edx
	movq	%rdi, %rcx
	call	rec
	movl	%eax, %ebx
	movq	%rsi, %rcx
	call	free
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$5, 32(%rsp)
	movl	$5, 36(%rsp)
	movl	$10, 40(%rsp)
	movl	$100, 44(%rsp)
	movl	$10, 48(%rsp)
	movl	$5, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$6, %edx
	call	findMaxSum
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
