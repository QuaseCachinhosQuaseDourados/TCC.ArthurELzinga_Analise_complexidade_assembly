	.file	"N_Queen_Problem.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Q \0"
.LC1:
	.ascii ". \0"
	.text
	.globl	printSolution
	.def	printSolution;	.scl	2;	.type	32;	.endef
	.seh_proc	printSolution
printSolution:
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
	leaq	16(%rcx), %rsi
	leaq	80(%rcx), %r12
	leaq	.LC1(%rip), %rbp
	leaq	.LC0(%rip), %rdi
	jmp	.L2
.L3:
	movq	%rbp, %rcx
	call	printf
.L4:
	addq	$4, %rbx
	cmpq	%rsi, %rbx
	je	.L8
.L5:
	cmpl	$0, (%rbx)
	je	.L3
	movq	%rdi, %rcx
	call	printf
	jmp	.L4
.L8:
	movl	$10, %ecx
	call	putchar
	addq	$16, %rsi
	cmpq	%r12, %rsi
	je	.L1
.L2:
	leaq	-16(%rsi), %rbx
	jmp	.L5
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	boolisSafe
	.def	boolisSafe;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisSafe
boolisSafe:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%r8d, %r8d
	jle	.L10
	movslq	%edx, %r10
	salq	$4, %r10
	addq	%rcx, %r10
	movl	(%r10), %eax
	testl	%eax, %eax
	jne	.L23
	movq	%r10, %r9
	leal	-1(%r8), %r11d
	leaq	(%r10,%r11,4), %r10
.L12:
	cmpq	%r10, %r9
	je	.L10
	addq	$4, %r9
	cmpl	$0, (%r9)
	je	.L12
.L9:
	popq	%rbx
	ret
.L10:
	movl	%r8d, %eax
	notl	%eax
	shrl	$31, %eax
	testl	%edx, %edx
	js	.L14
	testb	%al, %al
	je	.L14
	movslq	%edx, %r9
	movq	%r9, %rax
	salq	$4, %rax
	addq	%rcx, %rax
	movslq	%r8d, %r10
	movl	(%rax,%r10,4), %eax
	testl	%eax, %eax
	jne	.L24
	leaq	(%r10,%r9,4), %r9
	leaq	(%rcx,%r9,4), %r10
	movl	%edx, %r9d
	movl	%r8d, %r11d
	subl	%edx, %r11d
.L15:
	subl	$1, %r9d
	movl	%r11d, %ebx
	addl	%r9d, %ebx
	js	.L18
	testl	%r9d, %r9d
	js	.L18
	subq	$20, %r10
	cmpl	$0, (%r10)
	je	.L15
	jmp	.L9
.L14:
	cmpl	$3, %edx
	jg	.L25
	testb	%al, %al
	je	.L25
	movslq	%edx, %r9
	salq	$4, %r9
	addq	%rcx, %r9
	movslq	%r8d, %r10
	movl	$0, %eax
	cmpl	$0, (%r9,%r10,4)
	jne	.L9
	jmp	.L19
.L28:
	movl	$1, %eax
	jmp	.L9
.L23:
	movl	$0, %eax
	jmp	.L9
.L24:
	movl	$0, %eax
	jmp	.L9
.L25:
	movl	$1, %eax
	jmp	.L9
.L18:
	cmpl	$3, %edx
	jg	.L29
.L19:
	movslq	%edx, %r9
	movslq	%r8d, %rax
	leaq	(%rax,%r9,4), %rax
	leaq	(%rcx,%rax,4), %r9
	movl	%r8d, %eax
.L20:
	subl	$1, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	addl	%r8d, %ecx
	cmpl	$3, %ecx
	jg	.L28
	testl	%eax, %eax
	js	.L28
	addq	$12, %r9
	cmpl	$0, (%r9)
	je	.L20
	movl	$0, %eax
	jmp	.L9
.L29:
	movl	$1, %eax
	jmp	.L9
	.seh_endproc
	.globl	boolsolveNQUtil
	.def	boolsolveNQUtil;	.scl	2;	.type	32;	.endef
	.seh_proc	boolsolveNQUtil
boolsolveNQUtil:
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
	movq	%rcx, %rbp
	movl	%edx, %edi
	movl	$1, %eax
	cmpl	$3, %edx
	jg	.L30
	movslq	%edx, %rax
	leaq	(%rcx,%rax,4), %rsi
	movl	$0, %ebx
	leal	1(%rdx), %r12d
	jmp	.L33
.L32:
	addl	$1, %ebx
	addq	$16, %rsi
	cmpl	$4, %ebx
	je	.L37
.L33:
	movl	%edi, %r8d
	movl	%ebx, %edx
	movq	%rbp, %rcx
	call	isSafe
	testl	%eax, %eax
	je	.L32
	movl	$1, (%rsi)
	movl	%r12d, %edx
	movq	%rbp, %rcx
	call	solveNQUtil
	testl	%eax, %eax
	jne	.L35
	movl	$0, (%rsi)
	jmp	.L32
.L37:
	movl	$0, %eax
.L30:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L35:
	movl	$1, %eax
	jmp	.L30
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "Solution do es not exist\0"
	.text
	.globl	boolsolveNQ
	.def	boolsolveNQ;	.scl	2;	.type	32;	.endef
	.seh_proc	boolsolveNQ
boolsolveNQ:
	pushq	%rdi
	.seh_pushreg	%rdi
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	leaq	32(%rsp), %rdi
	movl	$8, %ecx
	movl	$0, %eax
	rep stosq
	leaq	32(%rsp), %rcx
	movl	$0, %edx
	call	solveNQUtil
	movl	%eax, %edi
	testl	%eax, %eax
	je	.L41
	leaq	32(%rsp), %rcx
	call	printSolution
	movl	$1, %edi
.L38:
	movl	%edi, %eax
	addq	$96, %rsp
	popq	%rdi
	ret
.L41:
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L38
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	call	solveNQ
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	isSafe;	.scl	2;	.type	32;	.endef
	.def	solveNQUtil;	.scl	2;	.type	32;	.endef
	.def	solveNQ;	.scl	2;	.type	32;	.endef
