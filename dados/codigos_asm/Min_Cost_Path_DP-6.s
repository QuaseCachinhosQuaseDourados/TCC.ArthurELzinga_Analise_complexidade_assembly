	.file	"Min_Cost_Path_DP-6.c"
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rdi
	movl	%edx, %ebx
	movl	%r8d, %esi
	testl	%r8d, %r8d
	js	.L6
	testl	%edx, %edx
	js	.L6
	movl	%r8d, %eax
	orl	%edx, %eax
	jne	.L3
	movl	(%rcx), %eax
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L3:
	movslq	%edx, %rax
	leaq	(%rax,%rax,2), %rax
	leaq	(%rcx,%rax,4), %rax
	movslq	%r8d, %rdx
	movl	(%rax,%rdx,4), %ebp
	leal	-1(%r8), %r13d
	movl	%r13d, %r8d
	movl	%ebx, %edx
	call	minCost
	movl	%eax, %r12d
	subl	$1, %ebx
	movl	%esi, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	minCost
	movl	%eax, %esi
	movl	%r13d, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	minCost
	cmpl	%eax, %esi
	jle	.L4
	cmpl	%eax, %r12d
	cmovle	%r12d, %eax
.L5:
	addl	%ebp, %eax
	jmp	.L1
.L4:
	cmpl	%esi, %r12d
	movl	%esi, %eax
	cmovle	%r12d, %eax
	jmp	.L5
.L6:
	movl	$2147483647, %eax
	jmp	.L1
	.seh_endproc
	.globl	min
	.def	min;	.scl	2;	.type	32;	.endef
	.seh_proc	min
min:
	.seh_endprologue
	cmpl	%edx, %ecx
	jge	.L8
	cmpl	%r8d, %ecx
	movl	%r8d, %eax
	cmovle	%ecx, %eax
.L7:
	ret
.L8:
	cmpl	%r8d, %edx
	movl	%r8d, %eax
	cmovle	%edx, %eax
	jmp	.L7
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
