	.file	"Min_cost_path_using_Dynamic_Programming(Space_optimized).c"
	.text
	.globl	min
	.def	min;	.scl	2;	.type	32;	.endef
	.seh_proc	min
min:
	.seh_endprologue
	cmpl	%edx, %ecx
	movl	%edx, %eax
	cmovle	%ecx, %eax
	ret
	.seh_endproc
	.globl	minCost
	.def	minCost;	.scl	2;	.type	32;	.endef
	.seh_proc	minCost
minCost:
	.seh_endprologue
	movl	(%rcx), %r9d
	movl	%r9d, %edx
	addl	12(%rcx), %edx
	movl	%edx, 12(%rcx)
	addl	%edx, 24(%rcx)
	addl	%r9d, 4(%rcx)
	movl	4(%rcx), %r10d
	addl	%r10d, 8(%rcx)
	cmpl	%edx, %r10d
	movl	%edx, %eax
	cmovle	%r10d, %eax
	cmpl	%r9d, %eax
	cmovg	%r9d, %eax
	addl	16(%rcx), %eax
	movl	%eax, 16(%rcx)
	cmpl	%eax, 8(%rcx)
	movl	%eax, %r8d
	cmovle	8(%rcx), %r8d
	cmpl	%r10d, %r8d
	cmovg	%r10d, %r8d
	addl	%r8d, 20(%rcx)
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	cmpl	%edx, 24(%rcx)
	cmovle	24(%rcx), %edx
	addl	28(%rcx), %edx
	movl	%edx, 28(%rcx)
	cmpl	%eax, 20(%rcx)
	cmovle	20(%rcx), %eax
	cmpl	%edx, %eax
	cmovg	%edx, %eax
	addl	%eax, 32(%rcx)
	movl	32(%rcx), %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d \12\0"
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
