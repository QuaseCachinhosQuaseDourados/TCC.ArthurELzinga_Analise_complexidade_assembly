	.file	"Write_an_Efficient_Method_to_Check_if_a_Number_is_Multiple_of_3_2.c"
	.text
	.globl	isMultipleOf3
	.def	isMultipleOf3;	.scl	2;	.type	32;	.endef
	.seh_proc	isMultipleOf3
isMultipleOf3:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$1, %eax
	testl	%ecx, %ecx
	je	.L1
	movl	%ecx, %eax
	sarl	$31, %eax
	xorl	%eax, %ecx
	subl	%eax, %ecx
	movl	$0, %eax
	cmpl	$1, %ecx
	je	.L1
	movslq	%ecx, %rax
	leaq	dp(%rip), %rdx
	movl	(%rdx,%rax,4), %eax
	cmpl	$-1, %eax
	jne	.L1
	movl	$0, %eax
	movl	$0, %edx
.L5:
	movl	%ecx, %r8d
	andl	$1, %r8d
	cmpl	$1, %r8d
	sbbl	$-1, %edx
	movl	%ecx, %r8d
	andl	$2, %r8d
	cmpl	$1, %r8d
	sbbl	$-1, %eax
	sarl	$2, %ecx
	testl	%ecx, %ecx
	jne	.L5
	movl	%edx, %ecx
	subl	%eax, %ecx
	subl	%edx, %eax
	testl	%ecx, %ecx
	cmovs	%eax, %ecx
	call	isMultipleOf3
	movl	%eax, dp(%rip)
.L1:
	addq	$40, %rsp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d is multiple of 3\0"
.LC1:
	.ascii "%d is not a multiple of 3\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$4004, %r8d
	movl	$-1, %edx
	leaq	dp(%rip), %rcx
	call	memset
	movl	$24, %ecx
	call	isMultipleOf3
	testl	%eax, %eax
	je	.L11
	movl	$24, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
.L12:
	movl	$0, %eax
	addq	$40, %rsp
	ret
.L11:
	movl	$24, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L12
	.seh_endproc
.lcomm dp,4004,32
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
