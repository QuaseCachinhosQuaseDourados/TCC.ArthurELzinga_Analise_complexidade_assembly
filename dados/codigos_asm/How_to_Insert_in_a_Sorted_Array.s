	.file	"How_to_Insert_in_a_Sorted_Array.c"
	.text
	.globl	insertSorted
	.def	insertSorted;	.scl	2;	.type	32;	.endef
	.seh_proc	insertSorted
insertSorted:
	.seh_endprologue
	movl	%edx, %eax
	cmpl	%r9d, %edx
	jge	.L1
	movl	%edx, %r9d
	subl	$1, %r9d
	js	.L3
	movslq	%r9d, %rax
	leaq	0(,%rax,4), %r11
	movl	(%rcx,%rax,4), %r10d
	cmpl	%r10d, %r8d
	jge	.L3
	leaq	4(%rcx,%r11), %rax
.L4:
	movl	%r10d, (%rax)
	subl	$1, %r9d
	cmpl	$-1, %r9d
	je	.L6
	subq	$4, %rax
	movl	-4(%rax), %r10d
	cmpl	%r8d, %r10d
	jg	.L4
	jmp	.L3
.L6:
	movl	$-1, %r9d
.L3:
	movslq	%r9d, %r9
	movl	%r8d, 4(%rcx,%r9,4)
	leal	1(%rdx), %eax
.L1:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\12Before Insertion: \0"
.LC1:
	.ascii "%d  \0"
.LC2:
	.ascii "\12After Insertion: \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$120, %rsp
	.seh_stackalloc	120
	.seh_endprologue
	call	__main
	leaq	56(%rsp), %rdi
	movl	$7, %ecx
	movl	$0, %eax
	rep stosq
	movl	$12, 32(%rsp)
	movl	$16, 36(%rsp)
	movl	$20, 40(%rsp)
	movl	$40, 44(%rsp)
	movl	$50, 48(%rsp)
	movl	$70, 52(%rsp)
	leaq	.LC0(%rip), %rcx
	call	printf
	leaq	32(%rsp), %rbx
	leaq	24(%rbx), %rbp
	movq	%rbx, %rsi
	leaq	.LC1(%rip), %rdi
.L9:
	movl	(%rsi), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rsi
	cmpq	%rbp, %rsi
	jne	.L9
	leaq	32(%rsp), %rcx
	movl	$20, %r9d
	movl	$26, %r8d
	movl	$6, %edx
	call	insertSorted
	movl	%eax, %esi
	leaq	.LC2(%rip), %rcx
	call	printf
	testl	%esi, %esi
	jle	.L10
	leal	-1(%rsi), %eax
	leaq	4(%rbx,%rax,4), %rdi
	leaq	.LC1(%rip), %rsi
.L11:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L11
.L10:
	movl	$0, %eax
	addq	$120, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
