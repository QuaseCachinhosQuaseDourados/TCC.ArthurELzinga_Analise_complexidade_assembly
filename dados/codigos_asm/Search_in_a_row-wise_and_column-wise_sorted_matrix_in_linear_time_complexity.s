	.file	"Search_in_a_row-wise_and_column-wise_sorted_matrix_in_linear_time_complexity.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Element found at %d, %d\0"
.LC1:
	.ascii "n Element not found\0"
	.text
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$-1, %eax
	testl	%edx, %edx
	je	.L1
	leal	(%rdx,%rax), %r9d
	movslq	%edx, %rax
	salq	$4, %rax
	leaq	-16(%rcx,%rax), %rax
	movslq	%r9d, %r10
	cmpl	%r8d, (%rax,%r10,4)
	jl	.L10
	cmpl	%r8d, (%rcx)
	jg	.L10
	movl	$0, %r10d
	jmp	.L3
.L12:
	movl	%r9d, %r8d
	movl	%r10d, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L1
.L5:
	addl	$1, %r10d
.L3:
	cmpl	%edx, %r10d
	jge	.L11
	testl	%r9d, %r9d
	js	.L11
	movslq	%r10d, %rax
	salq	$4, %rax
	addq	%rcx, %rax
	movslq	%r9d, %r11
	movl	(%rax,%r11,4), %eax
	cmpl	%r8d, %eax
	je	.L12
	jle	.L5
	subl	$1, %r9d
	jmp	.L3
.L11:
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L1
.L10:
	movl	$-1, %eax
.L1:
	addq	$40, %rsp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$20, 36(%rsp)
	movl	$30, 40(%rsp)
	movl	$40, 44(%rsp)
	movl	$15, 48(%rsp)
	movl	$25, 52(%rsp)
	movl	$35, 56(%rsp)
	movl	$45, 60(%rsp)
	movl	$27, 64(%rsp)
	movl	$29, 68(%rsp)
	movl	$37, 72(%rsp)
	movl	$48, 76(%rsp)
	movl	$32, 80(%rsp)
	movl	$33, 84(%rsp)
	movl	$39, 88(%rsp)
	movl	$50, 92(%rsp)
	leaq	32(%rsp), %rcx
	movl	$29, %r8d
	movl	$4, %edx
	call	search
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
