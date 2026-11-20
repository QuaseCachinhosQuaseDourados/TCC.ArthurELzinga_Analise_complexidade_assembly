	.file	"Find_the_Missing_Number_6.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	findMissing
	.def	findMissing;	.scl	2;	.type	32;	.endef
	.seh_proc	findMissing
findMissing:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testl	%edx, %edx
	jle	.L2
	movq	%rcx, %r8
	leal	-1(%rdx), %r10d
	leaq	4(%rcx,%r10,4), %r11
	jmp	.L4
.L3:
	addq	$4, %r8
	cmpq	%r11, %r8
	je	.L13
.L4:
	movl	(%r8), %r9d
	sarl	$31, %r9d
	movl	%r9d, %eax
	xorl	(%r8), %eax
	subl	%r9d, %eax
	subl	$1, %eax
	cmpl	%edx, %eax
	je	.L3
	cltq
	negl	(%rcx,%rax,4)
	jmp	.L3
.L13:
	addl	$1, %edx
	leaq	2(%r10), %r8
	movl	$1, %eax
.L7:
	cmpl	$0, -4(%rcx,%rax,4)
	cmovg	%eax, %edx
	addq	$1, %rax
	cmpq	%r8, %rax
	jne	.L7
.L8:
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
	addq	$40, %rsp
	ret
.L2:
	addl	$1, %edx
	jmp	.L8
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$3, 36(%rsp)
	movl	$7, 40(%rsp)
	movl	$5, 44(%rsp)
	movl	$6, 48(%rsp)
	movl	$2, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$6, %edx
	call	findMissing
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
