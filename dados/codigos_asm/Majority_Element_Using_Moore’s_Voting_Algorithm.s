	.file	"Majority_Element_Using_Moore\222s_Voting_Algorithm.c"
	.text
	.globl	findCandidate
	.def	findCandidate;	.scl	2;	.type	32;	.endef
	.seh_proc	findCandidate
findCandidate:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	cmpl	$1, %edx
	jle	.L7
	leal	-2(%rdx), %r11d
	addq	$2, %r11
	movl	$1, %eax
	movl	$1, %edx
	movl	$0, %r9d
	jmp	.L6
.L9:
	addl	$1, %edx
	jmp	.L4
.L5:
	addq	$1, %rax
	cmpq	%r11, %rax
	je	.L2
.L6:
	movl	%eax, %r10d
	movslq	%r9d, %r8
	movl	(%rcx,%rax,4), %ebx
	cmpl	%ebx, (%rcx,%r8,4)
	je	.L9
	subl	$1, %edx
.L4:
	testl	%edx, %edx
	jne	.L5
	movl	%r10d, %r9d
	movl	$1, %edx
	jmp	.L5
.L7:
	movl	$0, %r9d
.L2:
	movslq	%r9d, %r9
	movl	(%rcx,%r9,4), %eax
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii " %d \0"
.LC1:
	.ascii "No Majority Element\0"
	.text
	.globl	printMajority
	.def	printMajority;	.scl	2;	.type	32;	.endef
	.seh_proc	printMajority
printMajority:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	call	findCandidate
	movl	%eax, %edi
	movl	%eax, %r8d
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	isMajority
	testl	%eax, %eax
	je	.L11
	movl	%edi, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
.L10:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L11:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L10
	.seh_endproc
	.globl	boolisMajority
	.def	boolisMajority;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisMajority
boolisMajority:
	.seh_endprologue
	testl	%edx, %edx
	jle	.L17
	movq	%rcx, %rax
	leal	-1(%rdx), %r9d
	leaq	4(%rcx,%r9,4), %r10
	movl	$0, %ecx
.L16:
	cmpl	%r8d, (%rax)
	sete	%r9b
	movzbl	%r9b, %r9d
	addl	%r9d, %ecx
	addq	$4, %rax
	cmpq	%r10, %rax
	jne	.L16
.L14:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	cmpl	%ecx, %eax
	setl	%al
	movzbl	%al, %eax
	ret
.L17:
	movl	$0, %ecx
	jmp	.L14
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
	movl	$1, 44(%rsp)
	movl	$2, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %edx
	call	printMajority
	call	getchar
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	isMajority;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
