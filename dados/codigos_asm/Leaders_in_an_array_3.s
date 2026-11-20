	.file	"Leaders_in_an_array_3.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printLeaders
	.def	printLeaders;	.scl	2;	.type	32;	.endef
	.seh_proc	printLeaders
printLeaders:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rdi
	movl	%edx, %ebx
	movslq	%edx, %rbp
	salq	$2, %rbp
	movq	%rbp, %rcx
	call	malloc
	movq	%rax, %rsi
	movl	-4(%rdi,%rbp), %eax
	movl	%eax, (%rsi)
	subl	$2, %ebx
	js	.L7
	movslq	%ebx, %rdx
	movl	$0, %ecx
	jmp	.L4
.L3:
	subq	$1, %rdx
	testl	%edx, %edx
	js	.L10
.L4:
	movl	(%rdi,%rdx,4), %r8d
	movslq	%ecx, %rax
	leaq	0(,%rax,4), %r9
	cmpl	(%rsi,%rax,4), %r8d
	jl	.L3
	addl	$1, %ecx
	movl	%r8d, 4(%rsi,%r9)
	jmp	.L3
.L10:
	cmpl	$-1, %ecx
	je	.L5
.L2:
	movslq	%ecx, %rax
	salq	$2, %rax
	leaq	(%rsi,%rax), %rbx
	leaq	-4(%rsi,%rax), %rdi
	movl	%ecx, %ecx
	salq	$2, %rcx
	subq	%rcx, %rdi
	leaq	.LC0(%rip), %rbp
.L6:
	movl	(%rbx), %edx
	movq	%rbp, %rcx
	call	printf
	subq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L6
.L5:
	movq	%rsi, %rcx
	call	free
	nop
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L7:
	movl	$0, %ecx
	jmp	.L2
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
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
