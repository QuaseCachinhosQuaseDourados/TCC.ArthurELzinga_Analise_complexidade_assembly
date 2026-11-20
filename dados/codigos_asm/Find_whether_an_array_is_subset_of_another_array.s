	.file	"Find_whether_an_array_is_subset_of_another_array.c"
	.text
	.globl	isSubset
	.def	isSubset;	.scl	2;	.type	32;	.endef
	.seh_proc	isSubset
isSubset:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%r9d, %r9d
	jle	.L8
	movq	%rdx, %r11
	leal	-1(%r9), %eax
	leaq	4(%rdx,%rax,4), %rbx
	leal	-1(%r8), %r10d
	addq	$1, %r10
	movl	$0, %esi
	jmp	.L3
.L11:
	movl	%esi, %r9d
.L6:
	cmpl	%r9d, %r8d
	je	.L9
.L4:
	addq	$4, %r11
	cmpq	%rbx, %r11
	je	.L10
.L3:
	testl	%r8d, %r8d
	jle	.L11
	movl	(%r11), %edx
	cmpl	(%rcx), %edx
	je	.L4
	movl	$1, %eax
.L7:
	movl	%eax, %r9d
	cmpq	%rax, %r10
	je	.L6
	addq	$1, %rax
	cmpl	%edx, -4(%rcx,%rax,4)
	jne	.L7
	jmp	.L4
.L8:
	movl	$1, %eax
	jmp	.L1
.L9:
	movl	$0, %eax
.L1:
	popq	%rbx
	popq	%rsi
	ret
.L10:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "arr2[] is subset of arr1[] \0"
	.align 8
.LC1:
	.ascii "arr2[] is not a subset of arr1[]\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$11, 48(%rsp)
	movl	$1, 52(%rsp)
	movl	$13, 56(%rsp)
	movl	$21, 60(%rsp)
	movl	$3, 64(%rsp)
	movl	$7, 68(%rsp)
	movl	$11, 32(%rsp)
	movl	$3, 36(%rsp)
	movl	$7, 40(%rsp)
	movl	$1, 44(%rsp)
	leaq	32(%rsp), %rdx
	leaq	48(%rsp), %rcx
	movl	$4, %r9d
	movl	$6, %r8d
	call	isSubset
	testl	%eax, %eax
	je	.L13
	leaq	.LC0(%rip), %rcx
	call	printf
.L14:
	call	getchar
	movl	$0, %eax
	addq	$88, %rsp
	ret
.L13:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L14
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
