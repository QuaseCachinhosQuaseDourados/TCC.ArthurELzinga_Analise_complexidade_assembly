	.file	"Two_Sum_Using_remainders_of_the_elements_less_than_x.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Yes\0"
.LC1:
	.ascii "No\0"
	.text
	.globl	printPairs
	.def	printPairs;	.scl	2;	.type	32;	.endef
	.seh_proc	printPairs
printPairs:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%r8d, %ebx
	movslq	%r8d, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %rsi
	movq	%rsi, %r9
	testl	%r8d, %r8d
	jle	.L2
	movq	%rsi, %rax
	leal	-1(%r8), %r8d
	leaq	4(%rsi,%r8,4), %r8
.L3:
	movl	$0, (%rax)
	addq	$4, %rax
	cmpq	%r8, %rax
	jne	.L3
.L2:
	testl	%edx, %edx
	jle	.L4
	movq	%rcx, %r8
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rcx
	jmp	.L6
.L5:
	addq	$4, %r8
	cmpq	%rcx, %r8
	je	.L4
.L6:
	movl	(%r8), %eax
	cmpl	%ebx, %eax
	jge	.L5
	cltd
	idivl	%ebx
	movslq	%edx, %rdx
	addl	$1, (%r9,%rdx,4)
	jmp	.L5
.L4:
	movl	%ebx, %r12d
	shrl	$31, %r12d
	addl	%ebx, %r12d
	sarl	%r12d
	movl	%r12d, %ecx
	cmpl	$3, %ebx
	jle	.L7
	movl	$1, %eax
	jmp	.L10
.L8:
	addq	$1, %rax
	cmpl	%eax, %ecx
	jle	.L7
.L10:
	movl	%eax, %edi
	cmpl	$0, (%r9,%rax,4)
	jle	.L8
	movl	%ebx, %edx
	subl	%eax, %edx
	movslq	%edx, %rdx
	cmpl	$0, (%r9,%rdx,4)
	jle	.L8
	leaq	.LC0(%rip), %rcx
	call	puts
	cmpl	%edi, %r12d
	jle	.L7
.L1:
	movq	%rbp, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%rbp
	ret
.L7:
	testb	$1, %bl
	jne	.L11
	movslq	%r12d, %r12
	cmpl	$1, (%rsi,%r12,4)
	jle	.L12
	leaq	.LC0(%rip), %rcx
	call	puts
	jmp	.L1
.L12:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L1
.L11:
	movslq	%r12d, %r12
	cmpl	$0, (%rsi,%r12,4)
	jle	.L13
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	subl	%eax, %ebx
	movslq	%ebx, %rbx
	cmpl	$0, (%rsi,%rbx,4)
	jg	.L17
.L13:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L1
.L17:
	leaq	.LC0(%rip), %rcx
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
	movl	$4, 36(%rsp)
	movl	$45, 40(%rsp)
	movl	$6, 44(%rsp)
	movl	$10, 48(%rsp)
	movl	$8, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$16, %r8d
	movl	$6, %edx
	call	printPairs
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
