	.file	"Find_the_Missing_Number_4.c"
	.text
	.globl	getMissingNo
	.def	getMissingNo;	.scl	2;	.type	32;	.endef
	.seh_proc	getMissingNo
getMissingNo:
	.seh_endprologue
	movl	(%rcx), %eax
	cmpl	$1, %edx
	jle	.L2
	leaq	4(%rcx), %r8
	leal	-2(%rdx), %r9d
	leaq	8(%rcx,%r9,4), %rcx
.L3:
	xorl	(%r8), %eax
	addq	$4, %r8
	cmpq	%rcx, %r8
	jne	.L3
	movl	$1, %r8d
	movl	$2, %ecx
	jmp	.L4
.L2:
	testl	%edx, %edx
	setg	%r8b
	movzbl	%r8b, %r8d
	leal	1(%r8,%r8), %r8d
	jmp	.L6
.L8:
	movl	%r9d, %ecx
.L4:
	xorl	%ecx, %r8d
	leal	1(%rcx), %r9d
	cmpl	%ecx, %edx
	jge	.L8
.L6:
	xorl	%r8d, %eax
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$5, 44(%rsp)
	leaq	32(%rsp), %rcx
	movl	$4, %edx
	call	getMissingNo
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
