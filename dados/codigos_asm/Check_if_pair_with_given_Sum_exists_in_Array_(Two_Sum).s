	.file	"Check_if_pair_with_given_Sum_exists_in_Array_(Two_Sum).c"
	.text
	.globl	chkPair
	.def	chkPair;	.scl	2;	.type	32;	.endef
	.seh_proc	chkPair
chkPair:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	$0, %r11d
	leal	-1(%rdx), %ebx
.L2:
	cmpl	%r11d, %ebx
	jle	.L10
	movl	%r11d, %eax
	leal	1(%r11), %r9d
	cmpl	%r9d, %edx
	jle	.L3
	movl	(%rcx,%r11,4), %r10d
	movl	%r10d, %r9d
	addl	4(%rcx,%r11,4), %r9d
	cmpl	%r9d, %r8d
	je	.L8
	addl	$2, %eax
	cltq
.L5:
	cmpl	%eax, %edx
	jle	.L3
	movl	%r10d, %r9d
	addl	(%rcx,%rax,4), %r9d
	addq	$1, %rax
	cmpl	%r8d, %r9d
	jne	.L5
	movl	$1, %eax
.L1:
	popq	%rbx
	ret
.L3:
	addq	$1, %r11
	jmp	.L2
.L10:
	movl	$0, %eax
	jmp	.L1
.L8:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Yes\0"
.LC1:
	.ascii "No\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$0, 32(%rsp)
	movl	$-1, 36(%rsp)
	movl	$2, 40(%rsp)
	movl	$-3, 44(%rsp)
	movl	$1, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$-2, %r8d
	movl	$5, %edx
	call	chkPair
	testl	%eax, %eax
	je	.L12
	leaq	.LC0(%rip), %rcx
	call	puts
.L13:
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L12:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L13
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
