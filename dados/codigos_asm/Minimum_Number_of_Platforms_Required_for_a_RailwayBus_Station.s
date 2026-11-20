	.file	"Minimum_Number_of_Platforms_Required_for_a_RailwayBus_Station.c"
	.text
	.globl	findPlatform
	.def	findPlatform;	.scl	2;	.type	32;	.endef
	.seh_proc	findPlatform
findPlatform:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%r8d, %r8d
	jle	.L6
	movq	%rcx, %rbx
	movl	$0, %r11d
	movl	$1, %eax
	leal	-1(%r8), %esi
	movl	$0, %ebp
	jmp	.L3
.L4:
	leaq	1(%r9), %r10
	cmpq	%r9, %rsi
	je	.L8
	movq	%r10, %r9
.L5:
	cmpl	%r9d, %r11d
	je	.L4
	movl	(%rbx), %r10d
	cmpl	(%rcx,%r9,4), %r10d
	jl	.L4
	cmpl	(%rdx,%r9,4), %r10d
	jg	.L4
	addl	$1, %edi
	jmp	.L4
.L8:
	cmpl	%edi, %eax
	cmovl	%edi, %eax
	addl	$1, %r11d
	addq	$4, %rbx
	cmpl	%r11d, %r8d
	je	.L1
.L3:
	movq	%rbp, %r9
	movl	$1, %edi
	jmp	.L5
.L6:
	movl	$1, %eax
.L1:
	popq	%rbx
	popq	%rsi
	popq	%rdi
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
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$100, 52(%rsp)
	movl	$300, 56(%rsp)
	movl	$500, 60(%rsp)
	movl	$900, 40(%rsp)
	movl	$400, 44(%rsp)
	movl	$600, 48(%rsp)
	leaq	40(%rsp), %rdx
	leaq	52(%rsp), %rcx
	movl	$3, %r8d
	call	findPlatform
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
