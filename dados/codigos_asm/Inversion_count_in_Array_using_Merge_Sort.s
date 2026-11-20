	.file	"Inversion_count_in_Array_using_Merge_Sort.c"
	.text
	.globl	getInvCount
	.def	getInvCount;	.scl	2;	.type	32;	.endef
	.seh_proc	getInvCount
getInvCount:
	.seh_endprologue
	movl	$1, %r10d
	movl	$0, %eax
	leal	-1(%rdx), %r11d
	jmp	.L2
.L4:
	addq	$1, %r8
	cmpl	%r8d, %edx
	jle	.L3
.L5:
	cmpl	(%rcx,%r8,4), %r9d
	jle	.L4
	addl	$1, %eax
	jmp	.L4
.L3:
	addq	$1, %r10
.L2:
	leal	-1(%r10), %r8d
	cmpl	%r8d, %r11d
	jle	.L8
	cmpl	%r10d, %edx
	jle	.L3
	movl	-4(%rcx,%r10,4), %r9d
	movq	%r10, %r8
	jmp	.L5
.L8:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii " Number of inversions are %d \12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$20, 36(%rsp)
	movl	$6, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %edx
	call	getInvCount
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
