	.file	"Write_a_program_to_reverse_an_array_or_string.c"
	.text
	.globl	rvereseArray
	.def	rvereseArray;	.scl	2;	.type	32;	.endef
	.seh_proc	rvereseArray
rvereseArray:
	.seh_endprologue
	cmpl	%r8d, %edx
	jge	.L1
	movslq	%edx, %rdx
	movslq	%r8d, %r8
.L3:
	movl	(%rcx,%rdx,4), %eax
	movl	(%rcx,%r8,4), %r9d
	movl	%r9d, (%rcx,%rdx,4)
	movl	%eax, (%rcx,%r8,4)
	addq	$1, %rdx
	subq	$1, %r8
	cmpl	%r8d, %edx
	jl	.L3
.L1:
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printArray
	.def	printArray;	.scl	2;	.type	32;	.endef
	.seh_proc	printArray
printArray:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%edx, %edx
	jle	.L6
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L7:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L7
.L6:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Reversed array is \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	leaq	32(%rsp), %rbx
	movl	$6, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$5, %r8d
	movl	$0, %edx
	movq	%rbx, %rcx
	call	rvereseArray
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$6, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
