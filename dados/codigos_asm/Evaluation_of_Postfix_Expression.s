	.file	"Evaluation_of_Postfix_Expression.c"
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
	movzbl	(%rax,%rdx,4), %eax
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
	movsbl	%dl, %edx
	movl	%edx, (%r8,%rax,4)
	ret
	.seh_endproc
	.globl	evaluatePostfix
	.def	evaluatePostfix;	.scl	2;	.type	32;	.endef
	.seh_proc	evaluatePostfix
evaluatePostfix:
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
	je	.L21
	movzbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L20
.L12:
	movq	%rsi, %rcx
	call	pop
	movsbl	%al, %eax
.L10:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L13:
	movq	%rsi, %rcx
	call	pop
	movl	%eax, %edi
	movq	%rsi, %rcx
	call	pop
	movzbl	(%rbx), %ecx
	cmpb	$43, %cl
	je	.L15
	jle	.L23
	cmpb	$45, %cl
	je	.L18
	cmpb	$47, %cl
	jne	.L14
	movsbl	%al, %eax
	movsbl	%dil, %edi
	cltd
	idivl	%edi
	movsbl	%al, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L14
.L23:
	cmpb	$42, %cl
	jne	.L14
	imull	%edi, %eax
	movsbl	%al, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L14
.L15:
	addl	%edi, %eax
	movsbl	%al, %edx
	movq	%rsi, %rcx
	call	push
.L14:
	addq	$1, %rbx
	movzbl	(%rbx), %edx
	testb	%dl, %dl
	je	.L12
.L20:
	movsbl	%dl, %eax
	subl	$48, %eax
	cmpl	$9, %eax
	ja	.L13
	subl	$48, %edx
	movsbl	%dl, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L14
.L18:
	subl	%edi, %eax
	movsbl	%al, %edx
	movq	%rsi, %rcx
	call	push
	jmp	.L14
.L21:
	movl	$-1, %eax
	jmp	.L10
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "postfix evaluation: %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movabsq	$12729231506223922, %rax
	movq	%rax, 40(%rsp)
	leaq	40(%rsp), %rcx
	call	evaluatePostfix
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
