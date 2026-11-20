	.file	"Find_the_Number_Occurring_Odd_Number_of_Times_using_Hashing.c"
	.text
	.globl	getOddOccurrence
	.def	getOddOccurrence;	.scl	2;	.type	32;	.endef
	.seh_proc	getOddOccurrence
getOddOccurrence:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L4
	movq	%rcx, %r8
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdx
	movl	$0, %eax
.L3:
	xorl	(%r8), %eax
	addq	$4, %r8
	cmpq	%rdx, %r8
	jne	.L3
.L1:
	ret
.L4:
	movl	$0, %eax
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
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$2, 32(%rsp)
	movl	$3, 36(%rsp)
	movl	$5, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$4, 56(%rsp)
	movl	$3, 60(%rsp)
	movl	$5, 64(%rsp)
	movl	$2, 68(%rsp)
	movl	$4, 72(%rsp)
	movl	$4, 76(%rsp)
	movl	$2, 80(%rsp)
	leaq	32(%rsp), %rcx
	movl	$13, %edx
	call	getOddOccurrence
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
