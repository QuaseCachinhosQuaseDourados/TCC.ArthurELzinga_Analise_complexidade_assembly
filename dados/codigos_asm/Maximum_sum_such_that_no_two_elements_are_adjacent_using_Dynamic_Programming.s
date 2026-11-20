	.file	"Maximum_sum_such_that_no_two_elements_are_adjacent_using_Dynamic_Programming.c"
	.text
	.globl	findMaxSum
	.def	findMaxSum;	.scl	2;	.type	32;	.endef
	.seh_proc	findMaxSum
findMaxSum:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movslq	%edx, %rax
	leaq	15(,%rax,8), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	3(%rsp), %rax
	shrq	$2, %rax
	leaq	0(,%rax,4), %r11
	cmpl	$1, %edx
	je	.L7
	movl	$0, 0(,%rax,4)
	movl	(%rcx), %r8d
	movl	%r8d, 4(,%rax,4)
	jle	.L4
	movq	%r11, %rax
	addq	$4, %rcx
	leal	-2(%rdx), %r8d
	leaq	8(%r11,%r8,8), %r10
.L5:
	movl	(%rax), %r8d
	movl	%r8d, %r9d
	addl	(%rcx), %r9d
	movl	%r9d, 12(%rax)
	cmpl	%r8d, 4(%rax)
	cmovge	4(%rax), %r8d
	movl	%r8d, 8(%rax)
	addq	$8, %rax
	addq	$4, %rcx
	cmpq	%r10, %rax
	jne	.L5
.L4:
	subl	$1, %edx
	movslq	%edx, %rdx
	movl	(%r11,%rdx,8), %eax
	cmpl	%eax, 4(%r11,%rdx,8)
	cmovge	4(%r11,%rdx,8), %eax
.L1:
	movq	%rbp, %rsp
	popq	%rbp
	ret
.L7:
	movl	(%rcx), %eax
	jmp	.L1
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
	.def	printf;	.scl	2;	.type	32;	.endef
