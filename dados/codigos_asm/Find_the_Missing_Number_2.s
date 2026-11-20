	.file	"Find_the_Missing_Number_2.c"
	.text
	.globl	getMissingNo
	.def	getMissingNo;	.scl	2;	.type	32;	.endef
	.seh_proc	getMissingNo
getMissingNo:
	.seh_endprologue
	leal	1(%rdx), %eax
	leal	2(%rdx), %r8d
	imull	%eax, %r8d
	movl	%r8d, %eax
	shrl	$31, %eax
	addl	%r8d, %eax
	sarl	%eax
	testl	%edx, %edx
	jle	.L1
	movq	%rcx, %r8
	leal	-1(%rdx), %edx
	leaq	4(%rcx,%rdx,4), %rdx
.L3:
	subl	(%r8), %eax
	addq	$4, %r8
	cmpq	%rdx, %r8
	jne	.L3
.L1:
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
