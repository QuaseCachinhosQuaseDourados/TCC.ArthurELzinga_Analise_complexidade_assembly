	.file	"Dynamic_Programming_Approach_to_Find_and_Print_Nth_Fibonacci_Numbers.c"
	.text
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	leal	2(%rcx), %eax
	cltq
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	3(%rsp), %rax
	shrq	$2, %rax
	leaq	0(,%rax,4), %r9
	movl	$0, 0(,%rax,4)
	movl	$1, 4(,%rax,4)
	cmpl	$1, %ecx
	jle	.L2
	movq	%r9, %rax
	leal	-2(%rcx), %edx
	leaq	4(%r9,%rdx,4), %r8
.L3:
	movl	(%rax), %edx
	addl	4(%rax), %edx
	movl	%edx, 8(%rax)
	addq	$4, %rax
	cmpq	%r8, %rax
	jne	.L3
.L2:
	movslq	%ecx, %rcx
	movl	(%r9,%rcx,4), %eax
	movq	%rbp, %rsp
	popq	%rbp
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$9, %ecx
	call	fib
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
