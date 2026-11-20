	.file	"Find_the_Missing_Number_5.c"
	.text
	.globl	getMissingNo
	.def	getMissingNo;	.scl	2;	.type	32;	.endef
	.seh_proc	getMissingNo
getMissingNo:
	.seh_endprologue
	movl	%edx, %eax
	testl	%edx, %edx
	jle	.L12
	movl	$0, %r8d
	jmp	.L5
.L3:
	addl	$1, %r8d
.L4:
	cmpl	%eax, %r8d
	jge	.L17
.L5:
	movslq	%r8d, %rdx
	leaq	(%rcx,%rdx,4), %rdx
	movl	(%rdx), %r9d
	cmpl	%eax, %r9d
	jge	.L3
	leal	-1(%r9), %r10d
	movslq	%r10d, %r10
	leaq	(%rcx,%r10,4), %r10
	movl	(%r10), %r11d
	cmpl	%r11d, %r9d
	je	.L3
	movl	%r11d, (%rdx)
	movl	%r9d, (%r10)
	jmp	.L4
.L18:
	movl	$0, %r11d
	jmp	.L9
.L17:
	cmpl	$1, (%rcx)
	jne	.L18
	leal	-1(%rax), %r10d
	addq	$1, %r10
	movl	$1, %r8d
.L7:
	movl	%r8d, %r11d
	cmpq	%r10, %r8
	je	.L12
	movl	(%rcx,%r8,4), %edx
	leal	-1(%rdx), %r9d
	addq	$1, %r8
	leal	-1(%r8), %edx
	cmpl	%edx, %r9d
	je	.L7
.L9:
	leal	1(%r11), %eax
.L12:
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
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
