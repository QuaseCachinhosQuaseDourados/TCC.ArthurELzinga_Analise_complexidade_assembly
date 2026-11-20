	.file	"Find_the_first_circular_tour_that_visits_all_petrol_pumps.c"
	.text
	.globl	printTour
	.def	printTour;	.scl	2;	.type	32;	.endef
	.seh_proc	printTour
printTour:
	.seh_endprologue
	movl	%edx, %r10d
	movl	(%rcx), %r9d
	subl	4(%rcx), %r9d
	movl	$1, %r11d
	movl	$0, %r8d
.L7:
	testl	%r9d, %r9d
	jns	.L9
	cmpl	%r11d, %r8d
	je	.L9
	movslq	%r8d, %rdx
	subl	(%rcx,%rdx,8), %r9d
	addl	4(%rcx,%rdx,8), %r9d
	leal	1(%r8), %eax
	cltd
	idivl	%r10d
	movl	%edx, %r8d
	testl	%edx, %edx
	jne	.L7
	movl	$-1, %r8d
.L1:
	movl	%r8d, %eax
	ret
.L9:
	movslq	%r11d, %rax
	addl	(%rcx,%rax,8), %r9d
	subl	4(%rcx,%rax,8), %r9d
	leal	1(%r11), %eax
	cltd
	idivl	%r10d
	movl	%edx, %r11d
	cmpl	%edx, %r8d
	jne	.L7
	testl	%r9d, %r9d
	js	.L7
	jmp	.L1
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
	je	.L13
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L12:
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L13:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L12
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
