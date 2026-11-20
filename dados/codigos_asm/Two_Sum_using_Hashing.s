	.file	"Two_Sum_using_Hashing.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Yes\0"
.LC1:
	.ascii "No\0"
	.text
	.globl	printPairs
	.def	printPairs;	.scl	2;	.type	32;	.endef
	.seh_proc	printPairs
printPairs:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	movl	$400032, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	400032
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %edi
	movl	%r8d, %esi
	leaq	32(%rsp), %rcx
	movl	$400000, %r8d
	movl	$0, %edx
	call	memset
	testl	%edi, %edi
	jle	.L2
	movl	(%rbx), %eax
	movl	%esi, %edx
	subl	%eax, %edx
	movslq	%edx, %rdx
	cmpl	$1, 32(%rsp,%rdx,4)
	je	.L3
	leaq	4(%rbx), %rcx
	leal	-1(%rdi), %edx
	leaq	(%rcx,%rdx,4), %r8
.L5:
	cltq
	movl	$1, 32(%rsp,%rax,4)
	cmpq	%r8, %rcx
	je	.L2
	movl	(%rcx), %eax
	addq	$4, %rcx
	movl	%esi, %edx
	subl	%eax, %edx
	movslq	%edx, %rdx
	cmpl	$1, 32(%rsp,%rdx,4)
	jne	.L5
.L3:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L1
.L2:
	leaq	.LC1(%rip), %rcx
	call	printf
	nop
.L1:
	addq	$400032, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
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
	movl	$4, 36(%rsp)
	movl	$45, 40(%rsp)
	movl	$6, 44(%rsp)
	movl	$10, 48(%rsp)
	movl	$8, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$16, %r8d
	movl	$6, %edx
	call	printPairs
	call	getchar
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
