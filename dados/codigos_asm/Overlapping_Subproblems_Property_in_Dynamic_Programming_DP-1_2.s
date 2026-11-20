	.file	"Overlapping_Subproblems_Property_in_Dynamic_Programming_DP-1_2.c"
	.text
	.globl	_initialize
	.def	_initialize;	.scl	2;	.type	32;	.endef
	.seh_proc	_initialize
_initialize:
	.seh_endprologue
	leaq	lookup(%rip), %rax
	leaq	400+lookup(%rip), %rdx
.L2:
	movl	$-1, (%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	jne	.L2
	ret
	.seh_endproc
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	movslq	%ecx, %rdx
	leaq	lookup(%rip), %rax
	cmpl	$-1, (%rax,%rdx,4)
	je	.L7
.L5:
	movslq	%ebx, %rbx
	leaq	lookup(%rip), %rax
	movl	(%rax,%rbx,4), %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L7:
	cmpl	$1, %ecx
	jg	.L6
	movl	%ecx, (%rax,%rdx,4)
	jmp	.L5
.L6:
	leal	-1(%rcx), %ecx
	call	fib
	movl	%eax, %esi
	leal	-2(%rbx), %ecx
	call	fib
	movslq	%ebx, %rdx
	addl	%eax, %esi
	leaq	lookup(%rip), %rax
	movl	%esi, (%rax,%rdx,4)
	jmp	.L5
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Fibonacci number is %d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	call	_initialize
	movl	$40, %ecx
	call	fib
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.comm	lookup, 400, 5
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
