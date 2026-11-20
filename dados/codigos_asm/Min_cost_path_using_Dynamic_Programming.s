	.file	"Min_cost_path_using_Dynamic_Programming.c"
	.text
	.globl	minCost
	.def	minCost;	.scl	2;	.type	32;	.endef
	.seh_proc	minCost
minCost:
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
	movl	(%rcx), %eax
	movl	%eax, (%rsp)
	testl	%edx, %edx
	jle	.L2
	movl	%eax, %r9d
	addl	12(%rcx), %r9d
	movl	%r9d, 12(%rsp)
	cmpl	$1, %edx
	jle	.L3
	addl	24(%rcx), %r9d
	movl	%r9d, 24(%rsp)
.L3:
	testl	%r8d, %r8d
	jle	.L13
.L12:
	addl	4(%rcx), %eax
	movl	%eax, 4(%rsp)
	cmpl	$1, %r8d
	jle	.L4
	addl	8(%rcx), %eax
	movl	%eax, 8(%rsp)
.L4:
	testl	%edx, %edx
	jle	.L5
.L13:
	leal	-1(%rdx), %eax
	leaq	(%rax,%rax,2), %rax
	leaq	24(,%rax,4), %r12
	movl	$12, %esi
	movq	%rsp, %r13
	jmp	.L6
.L7:
	cmpl	%r11d, %eax
	cmovg	%r11d, %eax
.L8:
	addl	0(%rbp,%r10,4), %eax
	movl	%eax, 4(%rdi)
	addq	$1, %r10
	addq	$4, %r9
	cmpl	%r10d, %r8d
	jl	.L11
.L9:
	movq	%r9, %rdi
	movl	(%r9), %eax
	movl	-8(%r9), %r11d
	movl	-12(%r9), %ebx
	cmpl	%ebx, %r11d
	jle	.L7
	cmpl	%ebx, %eax
	cmovg	%ebx, %eax
	jmp	.L8
.L11:
	addq	$12, %rsi
	cmpq	%r12, %rsi
	je	.L5
.L6:
	testl	%r8d, %r8d
	jle	.L11
	leaq	(%rcx,%rsi), %rbp
	leaq	0(%r13,%rsi), %r9
	movl	$1, %r10d
	jmp	.L9
.L2:
	testl	%r8d, %r8d
	jg	.L12
.L5:
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	leaq	(%rdx,%rdx,2), %rax
	addq	%rax, %r8
	movl	(%rsp,%r8,4), %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.globl	min
	.def	min;	.scl	2;	.type	32;	.endef
	.seh_proc	min
min:
	.seh_endprologue
	cmpl	%edx, %ecx
	jge	.L17
	cmpl	%r8d, %ecx
	movl	%r8d, %eax
	cmovle	%ecx, %eax
.L16:
	ret
.L17:
	cmpl	%r8d, %edx
	movl	%r8d, %eax
	cmovle	%edx, %eax
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii " %d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$8, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$1, 56(%rsp)
	movl	$5, 60(%rsp)
	movl	$3, 64(%rsp)
	leaq	32(%rsp), %rcx
	movl	$2, %r8d
	movl	$2, %edx
	call	minCost
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
