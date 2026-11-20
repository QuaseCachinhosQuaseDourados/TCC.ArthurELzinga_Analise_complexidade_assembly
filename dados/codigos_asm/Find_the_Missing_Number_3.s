	.file	"Find_the_Missing_Number_3.c"
	.text
	.globl	getMissingNo
	.def	getMissingNo;	.scl	2;	.type	32;	.endef
	.seh_proc	getMissingNo
getMissingNo:
	.seh_endprologue
	cmpl	$1, %edx
	jle	.L4
	leal	-2(%rdx), %r8d
	addq	$3, %r8
	movl	$2, %edx
	movl	$1, %eax
.L3:
	addl	%edx, %eax
	subl	-8(%rcx,%rdx,4), %eax
	addq	$1, %rdx
	cmpq	%r8, %rdx
	jne	.L3
.L1:
	ret
.L4:
	movl	$1, %eax
	jmp	.L1
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
