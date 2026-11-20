	.file	"Print_K_largest(or_smallest)_elements_in_an_array.c"
	.text
	.globl	cmpfunc
	.def	cmpfunc;	.scl	2;	.type	32;	.endef
	.seh_proc	cmpfunc
cmpfunc:
	.seh_endprologue
	movl	(%rdx), %eax
	subl	(%rcx), %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	kLargest
	.def	kLargest;	.scl	2;	.type	32;	.endef
	.seh_proc	kLargest
kLargest:
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
	movl	%r8d, %edi
	movslq	%edx, %rdx
	leaq	cmpfunc(%rip), %r9
	movl	$4, %r8d
	call	qsort
	testl	%edi, %edi
	jle	.L2
	movq	%rsi, %rbx
	leal	-1(%rdi), %eax
	leaq	4(%rsi,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L4:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L4
.L2:
	addq	$32, %rsp
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
	movl	$23, 36(%rsp)
	movl	$12, 40(%rsp)
	movl	$9, 44(%rsp)
	movl	$30, 48(%rsp)
	movl	$2, 52(%rsp)
	movl	$50, 56(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %r8d
	movl	$7, %edx
	call	kLargest
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	qsort;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
