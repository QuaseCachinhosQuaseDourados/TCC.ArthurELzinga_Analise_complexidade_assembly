	.file	"Majority_Element_Using_Hashing.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Majority found :- %d\12\0"
.LC1:
	.ascii "No Majority element\0"
	.text
	.globl	findMajority
	.def	findMajority;	.scl	2;	.type	32;	.endef
	.seh_proc	findMajority
findMajority:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%edx, %edx
	jle	.L2
	movl	%edx, %r11d
	shrl	$31, %r11d
	addl	%edx, %r11d
	sarl	%r11d
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %r10
	jmp	.L7
.L11:
	cmpl	%r8d, %r11d
	jl	.L10
	addq	$4, %rcx
	cmpq	%r10, %rcx
	je	.L2
.L7:
	movl	(%rcx), %edx
	movq	%rbx, %rax
	movl	$0, %r8d
.L4:
	cmpl	%edx, (%rax)
	sete	%r9b
	movzbl	%r9b, %r9d
	addl	%r9d, %r8d
	addq	$4, %rax
	cmpq	%r10, %rax
	jne	.L4
	jmp	.L11
.L10:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L1
.L2:
	leaq	.LC1(%rip), %rcx
	call	puts
	nop
.L1:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$2, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$2, 40(%rsp)
	movl	$2, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$5, 52(%rsp)
	movl	$2, 56(%rsp)
	movl	$3, 60(%rsp)
	movl	$3, 64(%rsp)
	leaq	32(%rsp), %rcx
	movl	$9, %edx
	call	findMajority
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
