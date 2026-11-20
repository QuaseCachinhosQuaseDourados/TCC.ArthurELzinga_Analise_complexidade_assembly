	.file	"Maximum_sum_such_that_no_two_elements_are_adjacent_(Stickler_Thief)_3.c"
	.text
	.globl	findMaxSum
	.def	findMaxSum;	.scl	2;	.type	32;	.endef
	.seh_proc	findMaxSum
findMaxSum:
	.seh_endprologue
	movl	(%rcx), %eax
	cmpl	$1, %edx
	jle	.L4
	leaq	4(%rcx), %r8
	leal	-2(%rdx), %edx
	leaq	8(%rcx,%rdx,4), %r9
	movl	$0, %edx
.L3:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	addl	(%r8), %eax
	addq	$4, %r8
	movl	%ecx, %edx
	cmpq	%r9, %r8
	jne	.L3
.L2:
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	ret
.L4:
	movl	$0, %ecx
	jmp	.L2
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
	.def	printf;	.scl	2;	.type	32;	.endef
