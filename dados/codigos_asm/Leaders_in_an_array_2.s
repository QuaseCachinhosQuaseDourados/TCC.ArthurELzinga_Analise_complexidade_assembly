	.file	"Leaders_in_an_array_2.c"
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
	movq	%rcx, %rbp
	movl	%edx, %ebx
	movslq	%edx, %rax
	movl	-4(%rcx,%rax,4), %edi
	movl	%edi, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	subl	$2, %ebx
	js	.L1
	movslq	%ebx, %rbx
	leaq	.LC0(%rip), %r12
	jmp	.L4
.L6:
	movl	%esi, %edx
	movq	%r12, %rcx
	call	printf
	movl	%esi, %edi
.L3:
	subq	$1, %rbx
	testl	%ebx, %ebx
	js	.L1
.L4:
	movl	0(%rbp,%rbx,4), %esi
	cmpl	%edi, %esi
	jle	.L3
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
