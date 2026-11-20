	.file	"Activity_Selection_Problem_Greedy_Algo-1.c"
	.text
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Following activities are selected\0"
.LC1:
	.ascii "%d \0"
	.text
	.globl	printMaxActivities
	.def	printMaxActivities;	.scl	2;	.type	32;	.endef
	.seh_proc	printMaxActivities
printMaxActivities:
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
	movq	%rcx, %rdi
	movq	%rdx, %rbp
	movl	%r8d, %ebx
	leaq	.LC0(%rip), %rcx
	call	puts
	movl	$0, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	cmpl	$1, %ebx
	jle	.L1
	leal	-2(%rbx), %esi
	addq	$2, %rsi
	movl	$1, %ebx
	movl	$0, %edx
	leaq	.LC1(%rip), %r12
	jmp	.L4
.L6:
	movl	%ebx, %edx
	movq	%r12, %rcx
	call	printf
	movl	%ebx, %edx
.L3:
	addq	$1, %rbx
	cmpq	%rsi, %rbx
	je	.L1
.L4:
	movslq	%edx, %rax
	movl	0(%rbp,%rax,4), %eax
	cmpl	%eax, (%rdi,%rbx,4)
	jl	.L3
	jmp	.L6
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$1, 64(%rsp)
	movl	$3, 68(%rsp)
	movl	$0, 72(%rsp)
	movl	$5, 76(%rsp)
	movl	$8, 80(%rsp)
	movl	$5, 84(%rsp)
	movl	$2, 32(%rsp)
	movl	$4, 36(%rsp)
	movl	$6, 40(%rsp)
	movl	$7, 44(%rsp)
	movl	$9, 48(%rsp)
	movl	$9, 52(%rsp)
	leaq	32(%rsp), %rdx
	leaq	64(%rsp), %rcx
	movl	$6, %r8d
	call	printMaxActivities
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
