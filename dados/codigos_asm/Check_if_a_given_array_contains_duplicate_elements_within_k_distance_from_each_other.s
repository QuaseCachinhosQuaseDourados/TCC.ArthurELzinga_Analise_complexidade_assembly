	.file	"Check_if_a_given_array_contains_duplicate_elements_within_k_distance_from_each_other.c"
	.text
	.globl	boolcheckDuplicatesWithinK
	.def	boolcheckDuplicatesWithinK;	.scl	2;	.type	32;	.endef
	.seh_proc	boolcheckDuplicatesWithinK
boolcheckDuplicatesWithinK:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%edx, %edx
	jle	.L9
	movq	%rcx, %rbx
	movl	%r8d, %edi
	movl	$1, %esi
	movl	$1, %eax
	subl	%r8d, %eax
	movl	%eax, %ebp
.L3:
	testl	%r8d, %r8d
	jle	.L4
	cmpl	%esi, %edx
	jle	.L4
	movl	(%rbx), %r10d
	cmpl	4(%rbx), %r10d
	je	.L10
	leal	1(%rsi), %eax
	cltq
	leal	1(%rdi), %r11d
.L5:
	movl	%r11d, %r9d
	subl	%eax, %r9d
	testl	%r9d, %r9d
	jle	.L8
	cmpl	%eax, %edx
	jle	.L8
	addq	$1, %rax
	cmpl	%r10d, -4(%rcx,%rax,4)
	jne	.L5
	movl	$1, %eax
.L1:
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L8:
	addl	$1, %esi
	addl	$1, %edi
	addq	$4, %rbx
	jmp	.L3
.L4:
	leal	0(%rbp,%rdi), %eax
	cmpl	%eax, %edx
	jg	.L8
	movl	$0, %eax
	jmp	.L1
.L9:
	movl	$0, %eax
	jmp	.L1
.L10:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Yes\0"
.LC1:
	.ascii "No\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$5, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$3, 48(%rsp)
	movl	$5, 52(%rsp)
	movl	$6, 56(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %r8d
	movl	$7, %edx
	call	checkDuplicatesWithinK
	testl	%eax, %eax
	je	.L13
	leaq	.LC0(%rip), %rcx
	call	printf
.L14:
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L13:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L14
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	checkDuplicatesWithinK;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
