	.file	"Find_the_Missing_Number.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	findMissing
	.def	findMissing;	.scl	2;	.type	32;	.endef
	.seh_proc	findMissing
findMissing:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leal	1(%rdx), %eax
	cltq
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %r8
	movq	%r8, %r9
	testl	%edx, %edx
	js	.L2
	movq	%r8, %rax
	movl	%edx, %r11d
	leaq	4(%r8,%r11,4), %r8
.L3:
	movl	$0, (%rax)
	addq	$4, %rax
	cmpq	%r8, %rax
	jne	.L3
	testl	%edx, %edx
	jle	.L8
	movl	$0, %r8d
.L5:
	movl	(%rcx,%r8,4), %eax
	subl	$1, %eax
	cltq
	movl	$1, (%r9,%rax,4)
	addq	$1, %r8
	cmpl	%r8d, %edx
	jg	.L5
.L8:
	movl	$0, %eax
	jmp	.L7
.L6:
	addq	$1, %rax
	cmpl	%eax, %edx
	jl	.L2
.L7:
	cmpl	$0, (%r9,%rax,4)
	jne	.L6
	leal	1(%rax), %r10d
	jmp	.L6
.L2:
	movl	%r10d, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
	movq	%rbp, %rsp
	popq	%rbp
	ret
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
