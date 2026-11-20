	.file	"Minimum_Number_of_Platforms_Required_for_a_RailwayBus_Station_using_Heap.c"
	.text
	.globl	compare
	.def	compare;	.scl	2;	.type	32;	.endef
	.seh_proc	compare
compare:
	.seh_endprologue
	movl	(%rcx), %eax
	cmpl	(%rdx), %eax
	setg	%al
	movzbl	%al, %eax
	leal	-1(%rax,%rax), %eax
	ret
	.seh_endproc
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	movl	%r8d, %ebx
	movslq	%r8d, %rbp
	leaq	compare(%rip), %r9
	movl	$4, %r8d
	movq	%rbp, %rdx
	call	qsort
	leaq	compare(%rip), %r9
	movl	$4, %r8d
	movq	%rbp, %rdx
	movq	%rdi, %rcx
	call	qsort
	cmpl	$1, %ebx
	jle	.L9
	movl	$0, %r8d
	movl	$1, %ecx
	movl	$1, %eax
	movl	$1, %edx
	jmp	.L8
.L6:
	subl	$1, %edx
	addl	$1, %r8d
.L7:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	cmpl	%r8d, %ecx
	movl	%r8d, %r9d
	cmovge	%ecx, %r9d
	cmpl	%r9d, %ebx
	jle	.L4
.L8:
	movslq	%ecx, %r9
	movslq	%r8d, %r10
	movl	(%rdi,%r10,4), %r11d
	cmpl	%r11d, (%rsi,%r9,4)
	jg	.L6
	addl	$1, %edx
	addl	$1, %ecx
	jmp	.L7
.L9:
	movl	$1, %eax
.L4:
	addq	$40, %rsp
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
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$900, 64(%rsp)
	movl	$940, 68(%rsp)
	movl	$950, 72(%rsp)
	movl	$1100, 76(%rsp)
	movl	$1500, 80(%rsp)
	movl	$1800, 84(%rsp)
	movl	$910, 32(%rsp)
	movl	$1200, 36(%rsp)
	movl	$1120, 40(%rsp)
	movl	$1130, 44(%rsp)
	movl	$1900, 48(%rsp)
	movl	$2000, 52(%rsp)
	leaq	32(%rsp), %rdx
	leaq	64(%rsp), %rcx
	movl	$6, %r8d
	call	findPlatform
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	qsort;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
