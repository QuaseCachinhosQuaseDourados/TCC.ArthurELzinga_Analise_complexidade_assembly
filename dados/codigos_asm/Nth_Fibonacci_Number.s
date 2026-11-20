	.file	"Nth_Fibonacci_Number.c"
	.text
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	.seh_endprologue
	movl	%ecx, %eax
	testl	%ecx, %ecx
	je	.L1
	cmpl	$1, %ecx
	jle	.L5
	addl	$1, %ecx
	movl	$2, %r8d
	movl	$1, %edx
	movl	$0, %r9d
.L3:
	leal	(%r9,%rdx), %eax
	addl	$1, %r8d
	movl	%edx, %r9d
	movl	%eax, %edx
	cmpl	%r8d, %ecx
	jne	.L3
.L1:
	ret
.L5:
	movl	$1, %eax
	jmp	.L1
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
