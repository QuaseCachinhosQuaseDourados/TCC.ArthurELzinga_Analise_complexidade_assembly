	.file	"Majority_Element.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d\12\0"
.LC1:
	.ascii "No Majority Element\0"
	.text
	.globl	findMajority
	.def	findMajority;	.scl	2;	.type	32;	.endef
	.seh_proc	findMajority
findMajority:
	pushq	%r13
	.seh_pushreg	%r13
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testl	%edx, %edx
	jle	.L9
	leal	-1(%rdx), %ebp
	movq	%rcx, %r12
	leaq	4(%rcx,%rbp,4), %r11
	movl	$0, %ebx
	movl	$-1, %r13d
	movl	$0, %esi
	jmp	.L3
.L6:
	leaq	1(%rbx), %rax
	cmpq	%rbp, %rbx
	je	.L2
	movq	%rax, %rbx
.L3:
	movl	%ebx, %edi
	movl	(%rcx,%rbx,4), %r10d
	movq	%r12, %rax
	movl	$0, %r8d
.L5:
	cmpl	(%rax), %r10d
	sete	%r9b
	movzbl	%r9b, %r9d
	addl	%r9d, %r8d
	addq	$4, %rax
	cmpq	%r11, %rax
	jne	.L5
	cmpl	%esi, %r8d
	jle	.L6
	movl	%edi, %r13d
	movl	%r8d, %esi
	jmp	.L6
.L9:
	movl	$-1, %r13d
	movl	$0, %esi
.L2:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	cmpl	%esi, %eax
	jge	.L7
	movslq	%r13d, %r13
	movl	(%rcx,%r13,4), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L7:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L1
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
	movl	$1, 36(%rsp)
	movl	$2, 40(%rsp)
	movl	$1, 44(%rsp)
	movl	$3, 48(%rsp)
	movl	$5, 52(%rsp)
	movl	$1, 56(%rsp)
	leaq	32(%rsp), %rcx
	movl	$7, %edx
	call	findMajority
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
