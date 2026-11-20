	.file	"Leaders_in_an_array.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printLeaders
	.def	printLeaders;	.scl	2;	.type	32;	.endef
	.seh_proc	printLeaders
printLeaders:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, %ebx
	movl	$1, %edi
	leaq	.LC0(%rip), %r12
	testl	%edx, %edx
	jg	.L2
	jmp	.L1
.L4:
	je	.L10
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L14:
	cmpl	%eax, %ebx
	jne	.L5
.L10:
	movl	-4(%rsi,%rdi,4), %edx
	movq	%r12, %rcx
	call	printf
.L7:
	cmpl	%ebx, %ebp
	jge	.L1
.L5:
	addq	$1, %rdi
.L2:
	movl	%edi, %ebp
	cmpl	%ebx, %edi
	jge	.L4
	movl	-4(%rsi,%rdi,4), %edx
	cmpl	(%rsi,%rdi,4), %edx
	jle	.L5
	leal	1(%rdi), %eax
	cltq
.L6:
	cmpl	%eax, %ebx
	jle	.L14
	addq	$1, %rax
	cmpl	%edx, -4(%rsi,%rax,4)
	jl	.L6
	jmp	.L7
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
	movl	$16, 32(%rsp)
	movl	$17, 36(%rsp)
	movl	$4, 40(%rsp)
	movl	$3, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$2, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$6, %edx
	call	printLeaders
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
