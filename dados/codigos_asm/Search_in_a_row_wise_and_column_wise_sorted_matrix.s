	.file	"Search_in_a_row_wise_and_column_wise_sorted_matrix.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Element found at (%d, %d)\12\0"
.LC1:
	.ascii "Element not found\0"
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
	jle	.L3
	movl	$0, %r11d
.L4:
	movq	%rcx, %r10
	cmpl	(%rcx), %r8d
	je	.L9
	movl	$1, %eax
.L5:
	movl	%eax, %r9d
	cmpl	%eax, %edx
	jle	.L11
	addq	$1, %rax
	cmpl	%r8d, -4(%r10,%rax,4)
	jne	.L5
.L7:
	movl	%r9d, %r8d
	movl	%r11d, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$1, %eax
.L1:
	addq	$40, %rsp
	ret
.L9:
	movl	$0, %r9d
	jmp	.L7
.L11:
	addl	$1, %r11d
	addq	$16, %rcx
	cmpl	%r11d, %edx
	jne	.L4
.L3:
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L1
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
