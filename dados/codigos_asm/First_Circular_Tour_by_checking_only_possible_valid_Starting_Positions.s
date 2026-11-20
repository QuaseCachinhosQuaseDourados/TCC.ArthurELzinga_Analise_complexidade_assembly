	.file	"First_Circular_Tour_by_checking_only_possible_valid_Starting_Positions.c"
	.text
	.globl	printTour
	.def	printTour;	.scl	2;	.type	32;	.endef
	.seh_proc	printTour
printTour:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L2
	movl	4(%rcx), %eax
	cmpl	%eax, (%rcx)
	jge	.L17
	leal	-1(%rdx), %r10d
	addq	$1, %r10
	movl	$1, %r8d
.L4:
	movl	%r8d, %eax
	cmpq	%r10, %r8
	je	.L2
	movl	(%rcx,%r8,8), %r9d
	addq	$1, %r8
	cmpl	-4(%rcx,%r8,8), %r9d
	jl	.L4
.L16:
	movl	%eax, %r8d
	movl	$0, %r9d
.L7:
	movslq	%r8d, %r10
	salq	$3, %r10
	leaq	(%rcx,%r10), %r11
	addl	(%r11), %r9d
	subl	4(%r11), %r9d
	js	.L22
	addl	$1, %r8d
	cmpl	%r8d, %edx
	jg	.L7
	jmp	.L6
.L2:
	cmpl	%eax, %edx
	jg	.L16
	movl	$0, %r9d
.L6:
	testl	%eax, %eax
	jle	.L1
	movl	%r9d, %edx
	addl	(%rcx), %edx
	subl	4(%rcx), %edx
	js	.L20
	addq	$8, %rcx
	leal	-1(%rax), %r8d
	leaq	(%rcx,%r8,8), %r8
.L14:
	cmpq	%r8, %rcx
	je	.L1
	addl	(%rcx), %edx
	subl	4(%rcx), %edx
	addq	$8, %rcx
	testl	%edx, %edx
	jns	.L14
	movl	$-1, %eax
	jmp	.L1
.L22:
	leal	1(%r8), %eax
	cmpl	%eax, %edx
	jle	.L19
	leaq	8(%rcx,%r10), %r9
	movl	4(%r9), %r11d
	cmpl	%r11d, (%r9)
	jge	.L10
	addl	$2, %r8d
	movslq	%r8d, %r8
.L11:
	movl	%r8d, %eax
	cmpl	%r8d, %edx
	jle	.L23
	movl	(%rcx,%r8,8), %r9d
	addq	$1, %r8
	cmpl	-4(%rcx,%r8,8), %r9d
	jl	.L11
.L10:
	movl	%eax, %r8d
	movl	$0, %r9d
	jmp	.L7
.L23:
	movl	$-1, %eax
.L1:
	ret
.L19:
	movl	$-1, %eax
	jmp	.L1
.L20:
	movl	$-1, %eax
	jmp	.L1
.L17:
	movl	$0, %eax
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "No solution\0"
.LC1:
	.ascii "Start = %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$6, 32(%rsp)
	movl	$4, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$6, 44(%rsp)
	movl	$7, 48(%rsp)
	movl	$3, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %edx
	call	printTour
	cmpl	$-1, %eax
	je	.L27
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L26:
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L27:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L26
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
