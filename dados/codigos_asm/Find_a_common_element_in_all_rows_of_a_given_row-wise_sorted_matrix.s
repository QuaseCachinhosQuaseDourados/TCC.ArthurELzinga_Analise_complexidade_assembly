	.file	"Find_a_common_element_in_all_rows_of_a_given_row-wise_sorted_matrix.c"
	.text
	.globl	findCommon
	.def	findCommon;	.scl	2;	.type	32;	.endef
	.seh_proc	findCommon
findCommon:
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
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	$4, (%rsp)
	movl	$4, 4(%rsp)
	movl	$4, 8(%rsp)
	movl	$4, 12(%rsp)
	movl	$0, %r9d
	leaq	80(%rcx), %rsi
	jmp	.L2
.L5:
	addl	$1, %ebx
.L7:
	addq	$4, %rax
	addq	$20, %r8
	cmpq	%r8, %rsi
	je	.L14
.L8:
	movl	(%rax), %edx
	movslq	%edx, %r11
	movslq	(%rsp,%r12,4), %r10
	movl	0(%rbp,%r10,4), %r10d
	cmpl	%r10d, (%r8,%r11,4)
	jle	.L5
	testl	%edx, %edx
	je	.L10
	subl	$1, %edx
	movl	%edx, (%rax)
	jmp	.L7
.L14:
	cmpl	$4, %ebx
	je	.L15
.L2:
	movslq	%r9d, %rax
	cmpl	$0, (%rsp,%rax,4)
	js	.L16
	movq	%rcx, %r8
	movq	%rcx, %r10
	movl	$0, %eax
.L4:
	movslq	(%rsp,%rax,4), %rbx
	movslq	%r9d, %rdx
	leaq	(%rdx,%rdx,4), %r11
	leaq	(%rcx,%r11,4), %r11
	movslq	(%rsp,%rdx,4), %rdx
	movl	(%r10,%rbx,4), %ebx
	cmpl	(%r11,%rdx,4), %ebx
	cmovl	%eax, %r9d
	addq	$1, %rax
	addq	$20, %r10
	cmpq	$4, %rax
	jne	.L4
	movslq	%r9d, %rax
	leaq	(%rax,%rax,4), %rax
	leaq	(%rcx,%rax,4), %rbp
	movq	%rsp, %rax
	movl	$0, %ebx
	movslq	%r9d, %r12
	jmp	.L8
.L15:
	movslq	%r9d, %r9
	movslq	(%rsp,%r9,4), %rax
	movl	0(%rbp,%rax,4), %eax
	jmp	.L1
.L16:
	movl	$-1, %eax
	jmp	.L1
.L10:
	movl	$-1, %eax
.L1:
	addq	$16, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "No common element\0"
.LC1:
	.ascii "Common element is %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$120, %rsp
	.seh_stackalloc	120
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$4, 56(%rsp)
	movl	$5, 60(%rsp)
	movl	$8, 64(%rsp)
	movl	$10, 68(%rsp)
	movl	$3, 72(%rsp)
	movl	$5, 76(%rsp)
	movl	$7, 80(%rsp)
	movl	$9, 84(%rsp)
	movl	$11, 88(%rsp)
	movl	$1, 92(%rsp)
	movl	$3, 96(%rsp)
	movl	$5, 100(%rsp)
	movl	$7, 104(%rsp)
	movl	$9, 108(%rsp)
	leaq	32(%rsp), %rcx
	call	findCommon
	cmpl	$-1, %eax
	je	.L20
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L19:
	movl	$0, %eax
	addq	$120, %rsp
	ret
.L20:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L19
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
