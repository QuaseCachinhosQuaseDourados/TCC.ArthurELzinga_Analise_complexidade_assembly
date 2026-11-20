	.file	"Nth_Power_of_Matrix_Approach_to_Find_and_Print_Nth_Fibonacci_Numbers.c"
	.text
	.globl	multiply
	.def	multiply;	.scl	2;	.type	32;	.endef
	.seh_proc	multiply
multiply:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	(%rcx), %r9d
	movl	(%rdx), %r8d
	movl	4(%rcx), %r11d
	movl	8(%rdx), %r10d
	movl	4(%rdx), %eax
	movl	12(%rdx), %edx
	movl	8(%rcx), %esi
	movl	12(%rcx), %ebx
	movl	%r9d, %edi
	imull	%r8d, %edi
	movl	%r11d, %ebp
	imull	%r10d, %ebp
	addl	%ebp, %edi
	movl	%edi, (%rcx)
	imull	%eax, %r9d
	imull	%edx, %r11d
	addl	%r11d, %r9d
	movl	%r9d, 4(%rcx)
	imull	%esi, %r8d
	imull	%ebx, %r10d
	addl	%r10d, %r8d
	movl	%r8d, 8(%rcx)
	imull	%esi, %eax
	imull	%ebx, %edx
	addl	%edx, %eax
	movl	%eax, 12(%rcx)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	power
	.def	power;	.scl	2;	.type	32;	.endef
	.seh_proc	power
power:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, %ebx
	cmpl	$1, %edx
	jbe	.L2
	movl	$1, 32(%rsp)
	movl	$1, 36(%rsp)
	movl	$1, 40(%rsp)
	movl	$0, 44(%rsp)
	shrl	$31, %edx
	addl	%ebx, %edx
	sarl	%edx
	call	power
	movq	%rsi, %rdx
	movq	%rsi, %rcx
	call	multiply
	testb	$1, %bl
	jne	.L6
.L2:
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L6:
	leaq	32(%rsp), %rdx
	movq	%rsi, %rcx
	call	multiply
	jmp	.L2
	.seh_endproc
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movl	%ecx, %eax
	movl	$1, 32(%rsp)
	movl	$1, 36(%rsp)
	movl	$1, 40(%rsp)
	movl	$0, 44(%rsp)
	testl	%ecx, %ecx
	jne	.L9
.L8:
	addq	$56, %rsp
	ret
.L9:
	leal	-1(%rcx), %edx
	leaq	32(%rsp), %rcx
	call	power
	movl	32(%rsp), %eax
	jmp	.L8
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
