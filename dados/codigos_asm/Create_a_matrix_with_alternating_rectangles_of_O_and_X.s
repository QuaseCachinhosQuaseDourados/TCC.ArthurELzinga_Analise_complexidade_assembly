	.file	"Create_a_matrix_with_alternating_rectangles_of_O_and_X.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%c \0"
	.text
	.globl	fill0X
	.def	fill0X;	.scl	2;	.type	32;	.endef
	.seh_proc	fill0X
fill0X:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$72, %rsp
	.seh_stackalloc	72
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	%edx, 24(%rbp)
	movslq	%edx, %rbx
	movslq	%ecx, %rax
	imulq	%rbx, %rax
	addq	$15, %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %r10
	movq	%r10, -88(%rbp)
	movq	%r10, -72(%rbp)
	movl	%edx, %edi
	leal	-1(%rdx), %r13d
	movl	%r13d, -76(%rbp)
	movl	%ecx, %r8d
	movl	$0, %r12d
	movl	$88, %ecx
	movl	$0, %r11d
	movl	$0, %esi
	movl	$88, %r15d
	movl	$48, %r14d
	jmp	.L2
.L19:
	cltq
	leal	-1(%r8), %edx
	movslq	%edx, %rdx
	imulq	%rbx, %rdx
	addq	-72(%rbp), %rdx
.L7:
	movb	%cl, (%rdx,%rax)
	subq	$1, %rax
	cmpl	%eax, %r11d
	jle	.L7
.L20:
	subl	$1, %r8d
.L21:
	cmpl	%r9d, %r11d
	jl	.L31
.L8:
	cmpb	$48, %cl
	movl	%r14d, %ecx
	cmove	%r15d, %ecx
	addl	$1, %r12d
	subl	$1, %edi
	subl	$1, %r13d
	addq	%rbx, %r10
.L2:
	movl	%edi, %edx
	cmpl	%esi, %r8d
	jle	.L23
	cmpl	%edi, %r11d
	jge	.L23
	movslq	%r11d, %rax
.L3:
	movb	%cl, (%r10,%rax)
	addq	$1, %rax
	cmpl	%eax, %edx
	jg	.L3
	addl	$1, %esi
	cmpl	%esi, %r8d
	jle	.L4
	movl	%esi, %eax
	movslq	%r13d, %r9
	addq	-72(%rbp), %r9
.L5:
	movslq	%eax, %rdx
	imulq	%rbx, %rdx
	movb	%cl, (%r9,%rdx)
	addl	$1, %eax
	cmpl	%eax, %r8d
	jne	.L5
	leal	-1(%rdi), %r9d
	leal	-2(%rdi), %eax
	cmpl	%eax, %r11d
	jle	.L19
	jmp	.L20
.L31:
	leal	-1(%r8), %eax
	cmpl	%eax, %esi
	jg	.L9
	movslq	%r11d, %r9
	addq	-72(%rbp), %r9
.L10:
	movslq	%eax, %rdx
	imulq	%rbx, %rdx
	movb	%cl, (%r9,%rdx)
	subl	$1, %eax
	cmpl	%r12d, %eax
	jne	.L10
.L9:
	addl	$1, %r11d
	jmp	.L8
.L23:
	cmpl	$0, 16(%rbp)
	jle	.L1
	movl	-76(%rbp), %r14d
	movq	-88(%rbp), %rax
	leaq	1(%rax,%r14), %rdi
	movl	$0, %r13d
	notq	%r14
	leaq	.LC0(%rip), %r12
	movl	24(%rbp), %r15d
	jmp	.L15
.L16:
	movsbl	(%rsi), %edx
	movq	%r12, %rcx
	call	printf
	addq	$1, %rsi
	cmpq	%rsi, %rdi
	jne	.L16
.L18:
	movl	$10, %ecx
	call	putchar
	addl	$1, %r13d
	addq	%rbx, %rdi
	cmpl	%r13d, 16(%rbp)
	je	.L1
.L15:
	leaq	(%r14,%rdi), %rsi
	testl	%r15d, %r15d
	jg	.L16
	jmp	.L18
.L4:
	leal	-1(%rdi), %r9d
	jmp	.L21
.L1:
	leaq	-56(%rbp), %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Output for m = 5, n = 6\0"
.LC2:
	.ascii "\12Output for m = 4, n = 4\0"
.LC3:
	.ascii "\12Output for m = 3, n = 4\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$6, %edx
	movl	$5, %ecx
	call	fill0X
	leaq	.LC2(%rip), %rcx
	call	puts
	movl	$4, %edx
	movl	$4, %ecx
	call	fill0X
	leaq	.LC3(%rip), %rcx
	call	puts
	movl	$4, %edx
	movl	$3, %ecx
	call	fill0X
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
