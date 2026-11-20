	.file	"Convert_Infix_expression_to_Postfix_expression.c"
	.text
	.globl	precedence
	.def	precedence;	.scl	2;	.type	32;	.endef
	.seh_proc	precedence
precedence:
	.seh_endprologue
	cmpb	$45, %cl
	je	.L4
	jle	.L9
	movl	$2, %eax
	cmpb	$47, %cl
	je	.L1
	cmpb	$94, %cl
	sete	%al
	movzbl	%al, %eax
	leal	-1(,%rax,4), %eax
	jmp	.L1
.L9:
	movl	$2, %eax
	cmpb	$42, %cl
	je	.L1
	cmpb	$43, %cl
	sete	%al
	movzbl	%al, %eax
	leal	-1(%rax,%rax), %eax
.L1:
	ret
.L4:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.globl	isOperator
	.def	isOperator;	.scl	2;	.type	32;	.endef
	.seh_proc	isOperator
isOperator:
	.seh_endprologue
	subl	$42, %ecx
	movl	$1, %eax
	cmpb	$52, %cl
	ja	.L11
	movabsq	$4503599627370539, %rax
	shrq	%cl, %rax
	xorq	$1, %rax
	andl	$1, %eax
.L11:
	xorl	$1, %eax
	movzbl	%al, %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Invalid Expression\0"
	.text
	.globl	infixToPostfix
	.def	infixToPostfix;	.scl	2;	.type	32;	.endef
	.seh_proc	infixToPostfix
infixToPostfix:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
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
	subq	$168, %rsp
	.seh_stackalloc	168
	.seh_endprologue
	movq	%rcx, %rbp
	movq	$-1, %rcx
	movl	$0, %eax
	movq	%rbp, %rdi
	repnz scasb
	movq	%rcx, %rsi
	notq	%rsi
	leaq	-1(%rsi), %rbx
	leal	2(%rbx), %ecx
	movslq	%ecx, %rcx
	call	malloc
	movq	%rax, %r13
	testl	%ebx, %ebx
	jle	.L28
	movq	%rbp, %rsi
	leal	-1(%rbx), %eax
	leaq	1(%rbp,%rax), %rax
	movq	%rax, 32(%rsp)
	movl	$-1, %ebp
	movl	$0, %edi
	jmp	.L24
.L16:
	cmpb	$40, %bl
	je	.L33
	cmpb	$41, %bl
	je	.L34
	movl	%r12d, %ecx
	call	isOperator
	testl	%eax, %eax
	jne	.L35
.L15:
	addq	$1, %rsi
	cmpq	32(%rsp), %rsi
	je	.L36
.L24:
	movzbl	(%rsi), %ebx
	cmpb	$32, %bl
	je	.L15
	cmpb	$9, %bl
	je	.L15
	movsbl	%bl, %r12d
	movl	%r12d, %ecx
	call	isalnum
	testl	%eax, %eax
	je	.L16
	movslq	%edi, %rax
	movb	%bl, 0(%r13,%rax)
	leal	1(%rdi), %edi
	jmp	.L15
.L33:
	addl	$1, %ebp
	movslq	%ebp, %rax
	movb	$40, 48(%rsp,%rax)
	jmp	.L15
.L34:
	testl	%ebp, %ebp
	js	.L19
	movslq	%ebp, %rax
	movzbl	48(%rsp,%rax), %ecx
	cmpb	$40, %cl
	je	.L19
	subl	$1, %ebp
	movslq	%ebp, %rax
	addl	$1, %edi
	movslq	%edi, %rdx
.L20:
	movl	%eax, %ebp
	movl	%edx, %edi
	movb	%cl, -1(%r13,%rdx)
	testl	%eax, %eax
	js	.L19
	movzbl	48(%rsp,%rax), %ecx
	subq	$1, %rax
	addq	$1, %rdx
	cmpb	$40, %cl
	jne	.L20
.L19:
	subl	$1, %ebp
	jmp	.L15
.L35:
	testl	%ebp, %ebp
	js	.L21
	movl	%r12d, %ecx
	call	precedence
	movl	%eax, 44(%rsp)
	movslq	%edi, %r14
	movslq	%ebp, %r12
.L22:
	movl	%r12d, %ebp
	movl	%r14d, %edi
	movzbl	48(%rsp,%r12), %r15d
	movsbl	%r15b, %ecx
	call	precedence
	cmpl	44(%rsp), %eax
	jl	.L21
	leal	-1(%r12), %ebp
	leal	1(%r14), %edi
	movb	%r15b, 0(%r13,%r14)
	addq	$1, %r14
	subq	$1, %r12
	testl	%r12d, %r12d
	jns	.L22
.L21:
	addl	$1, %ebp
	movslq	%ebp, %rax
	movb	%bl, 48(%rsp,%rax)
	jmp	.L15
.L36:
	testl	%ebp, %ebp
	js	.L14
	movslq	%ebp, %rax
	movzbl	48(%rsp,%rax), %edx
	cmpb	$40, %dl
	je	.L29
	leal	1(%rdi), %eax
	cltq
	movslq	%ebp, %rcx
	leaq	48(%rsp,%rcx), %rcx
	movslq	%edi, %rdi
	movl	%ebp, %ebp
	leaq	1(%rdi,%rbp), %r8
.L26:
	movl	%eax, %edi
	movb	%dl, -1(%r13,%rax)
	cmpq	%rax, %r8
	je	.L14
	movzbl	-1(%rcx), %edx
	addq	$1, %rax
	subq	$1, %rcx
	cmpb	$40, %dl
	jne	.L26
	leaq	.LC0(%rip), %r13
	jmp	.L13
.L28:
	movl	$0, %edi
.L14:
	movslq	%edi, %rdi
	movb	$0, 0(%r13,%rdi)
.L13:
	movq	%r13, %rax
	addq	$168, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L29:
	leaq	.LC0(%rip), %r13
	jmp	.L13
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	subq	$144, %rsp
	.seh_stackalloc	144
	.seh_endprologue
	call	__main
	movabsq	$7232327075764513633, %rax
	movq	%rax, 32(%rsp)
	movabsq	$7434147933469631789, %rax
	movq	%rax, 40(%rsp)
	movabsq	$451729254442, %rax
	movq	%rax, 48(%rsp)
	leaq	56(%rsp), %rdi
	movl	$9, %ecx
	movl	$0, %eax
	rep stosq
	movl	$0, (%rdi)
	leaq	32(%rsp), %rcx
	call	infixToPostfix
	movq	%rax, %rdi
	movq	%rax, %rcx
	call	puts
	movq	%rdi, %rcx
	call	free
	movl	$0, %eax
	addq	$144, %rsp
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	isalnum;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
