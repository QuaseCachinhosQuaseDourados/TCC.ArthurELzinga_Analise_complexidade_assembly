	.file	"Maximum_sum_such_that_no_two_elements_are_adjacent_(Stickler_Thief).c"
	.text
	.globl	rec
	.def	rec;	.scl	2;	.type	32;	.endef
	.seh_proc	rec
rec:
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
	movq	%rcx, %rbp
	movl	%edx, %esi
	movl	%r8d, %edi
	movl	$0, %eax
	cmpl	%r8d, %edx
	jl	.L4
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L4:
	leal	2(%rdx), %edx
	call	rec
	movslq	%esi, %rdx
	addl	0(%rbp,%rdx,4), %eax
	movl	%eax, %ebx
	leal	1(%rsi), %edx
	movl	%edi, %r8d
	movq	%rbp, %rcx
	call	rec
	cmpl	%eax, %ebx
	cmovge	%ebx, %eax
	jmp	.L1
	.seh_endproc
	.globl	findMaxSum
	.def	findMaxSum;	.scl	2;	.type	32;	.endef
	.seh_proc	findMaxSum
findMaxSum:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%edx, %r8d
	movl	$0, %edx
	call	rec
	addq	$40, %rsp
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
