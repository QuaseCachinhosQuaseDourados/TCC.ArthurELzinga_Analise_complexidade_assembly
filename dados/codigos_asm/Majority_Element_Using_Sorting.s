	.file	"Majority_Element_Using_Sorting.c"
	.text
	.globl	countOccurrences
	.def	countOccurrences;	.scl	2;	.type	32;	.endef
	.seh_proc	countOccurrences
countOccurrences:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L5
	movq	%rcx, %r9
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rcx
	movl	$0, %eax
.L4:
	cmpl	%r8d, (%r9)
	sete	%dl
	movzbl	%dl, %edx
	addl	%edx, %eax
	addq	$4, %r9
	cmpq	%rcx, %r9
	jne	.L4
.L1:
	ret
.L5:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.globl	findMajorityUtil
	.def	findMajorityUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	findMajorityUtil
findMajorityUtil:
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
	movq	%rcx, %rdi
	movl	%edx, %ebp
	movl	%r8d, %ebx
	cmpl	%r8d, %edx
	je	.L12
	leal	(%rdx,%r8), %edx
	movl	%edx, %esi
	shrl	$31, %esi
	addl	%edx, %esi
	sarl	%esi
	movl	%esi, %r8d
	movl	%ebp, %edx
	call	findMajorityUtil
	movl	%eax, %r12d
	leal	1(%rsi), %edx
	movl	%ebx, %r8d
	movq	%rdi, %rcx
	call	findMajorityUtil
	movl	%eax, %esi
	cmpl	%eax, %r12d
	je	.L7
	subl	%ebp, %ebx
	addl	$1, %ebx
	movl	%r12d, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	countOccurrences
	movl	%eax, %ebp
	movl	%esi, %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	countOccurrences
	movl	%ebx, %edx
	shrl	$31, %edx
	addl	%edx, %ebx
	sarl	%ebx
	cmpl	%ebp, %ebx
	jl	.L10
	cmpl	%eax, %ebx
	movl	$-1, %eax
	cmovge	%eax, %esi
	jmp	.L7
.L12:
	movslq	%edx, %rbp
	movl	(%rcx,%rbp,4), %esi
.L7:
	movl	%esi, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L10:
	movl	%r12d, %esi
	jmp	.L7
	.seh_endproc
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	leal	-1(%rdx), %r8d
	movl	$0, %edx
	call	findMajorityUtil
	cmpl	$-1, %eax
	je	.L14
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
.L13:
	addq	$40, %rsp
	ret
.L14:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L13
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
	movl	$3, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$3, 44(%rsp)
	movl	$2, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %edx
	call	findMajority
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
