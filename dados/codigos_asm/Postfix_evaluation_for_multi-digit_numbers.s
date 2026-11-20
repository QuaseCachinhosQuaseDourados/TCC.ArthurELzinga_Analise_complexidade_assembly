	.file	"Postfix_evaluation_for_multi-digit_numbers.c"
	.text
	.globl	createStack
	.def	createStack;	.scl	2;	.type	32;	.endef
	.seh_proc	createStack
createStack:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %esi
	movl	$16, %ecx
	call	malloc
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L1
	movl	$-1, (%rax)
	movl	%esi, 4(%rax)
	movl	%esi, %ecx
	salq	$2, %rcx
	call	malloc
	movq	%rax, 8(%rbx)
	testq	%rax, %rax
	movl	$0, %eax
	cmove	%rax, %rbx
.L1:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	isEmpty
	.def	isEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	isEmpty
isEmpty:
	.seh_endprologue
	cmpl	$-1, (%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	peek
	.def	peek;	.scl	2;	.type	32;	.endef
	.seh_proc	peek
peek:
	.seh_endprologue
	movslq	(%rcx), %rdx
	movq	8(%rcx), %rax
	movl	(%rax,%rdx,4), %eax
	ret
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	.seh_endprologue
	movl	(%rcx), %edx
	movl	$36, %eax
	cmpl	$-1, %edx
	jne	.L8
.L5:
	ret
.L8:
	movq	8(%rcx), %rax
	leal	-1(%rdx), %r8d
	movl	%r8d, (%rcx)
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	jmp	.L5
	.seh_endproc
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	.seh_endprologue
	movq	8(%rcx), %r8
	movl	(%rcx), %eax
	addl	$1, %eax
	movl	%eax, (%rcx)
	cltq
	movl	%edx, (%r8,%rax,4)
	ret
	.seh_endproc
	.globl	evaluatePostfix
	.def	evaluatePostfix;	.scl	2;	.type	32;	.endef
	.seh_proc	evaluatePostfix
evaluatePostfix:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	$-1, %rcx
	movl	$0, %eax
	movq	%rbx, %rdi
	repnz scasb
	movq	%rcx, %rsi
	notq	%rsi
	movq	%rsi, %rcx
	subq	$1, %rcx
	call	createStack
	movq	%rax, %rsi
	testq	%rax, %rax
	je	.L23
	movzbl	(%rbx), %eax
	testb	%al, %al
	je	.L12
	movq	%rbx, %r12
	movl	$0, %ebp
	movl	$0, %edi
	jmp	.L22
.L27:
	movslq	%ebp, %rax
	movzbl	(%rbx,%rax), %eax
	movsbl	%al, %edx
	subl	$48, %edx
	cmpl	$9, %edx
	ja	.L24
	leal	1(%rbp), %ecx
	movslq	%ecx, %rcx
	movl	%edi, %edx
.L16:
	leal	(%rdx,%rdx,4), %edx
	movsbl	%al, %eax
	leal	-48(%rax,%rdx,2), %edx
	movl	%ecx, %ebp
	movzbl	(%rbx,%rcx), %eax
	addq	$1, %rcx
	movsbl	%al, %r8d
	subl	$48, %r8d
	cmpl	$9, %r8d
	jbe	.L16
.L15:
	subl	$1, %ebp
	movq	%rsi, %rcx
	call	push
.L13:
	addl	$1, %ebp
	movslq	%ebp, %r12
	addq	%rbx, %r12
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.L12
.L22:
	cmpb	$32, %al
	je	.L13
	movsbl	%al, %eax
	subl	$48, %eax
	cmpl	$9, %eax
	jbe	.L27
	movq	%rsi, %rcx
	call	pop
	movl	%eax, %r13d
	movq	%rsi, %rcx
	call	pop
	movzbl	(%r12), %ecx
	cmpb	$43, %cl
	je	.L17
	jle	.L28
	cmpb	$45, %cl
	je	.L20
	cmpb	$47, %cl
	jne	.L13
	cltd
	idivl	%r13d
	movl	%eax, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L13
.L24:
	movl	%edi, %edx
	jmp	.L15
.L28:
	cmpb	$42, %cl
	jne	.L13
	movl	%r13d, %edx
	imull	%eax, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L13
.L17:
	leal	0(%r13,%rax), %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L13
.L20:
	subl	%r13d, %eax
	movl	%eax, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L13
.L12:
	movq	%rsi, %rcx
	call	pop
.L10:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L23:
	movl	$-1, %eax
	jmp	.L10
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
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movabsq	$2319406799942332465, %rax
	movq	%rax, 32(%rsp)
	movabsq	$2320796569755066411, %rax
	movq	%rax, 40(%rsp)
	movl	$540483626, 48(%rsp)
	movw	$43, 52(%rsp)
	leaq	32(%rsp), %rcx
	call	evaluatePostfix
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
