	.file	"How_to_Reverse_a_String_using_Stack.c"
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
	movl	%esi, 4(%rax)
	movl	$-1, (%rax)
	movl	%esi, %ecx
	call	malloc
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	isFull
	.def	isFull;	.scl	2;	.type	32;	.endef
	.seh_proc	isFull
isFull:
	.seh_endprologue
	movl	4(%rcx), %eax
	subl	$1, %eax
	cmpl	(%rcx), %eax
	sete	%al
	movzbl	%al, %eax
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
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	.seh_endprologue
	movl	(%rcx), %eax
	movl	4(%rcx), %r9d
	leal	-1(%r9), %r8d
	cmpl	%r8d, %eax
	je	.L4
	movq	8(%rcx), %r8
	addl	$1, %eax
	movl	%eax, (%rcx)
	cltq
	movb	%dl, (%r8,%rax)
.L4:
	ret
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	.seh_endprologue
	movl	(%rcx), %edx
	movl	$0, %eax
	cmpl	$-1, %edx
	je	.L6
	movq	8(%rcx), %rax
	leal	-1(%rdx), %r8d
	movl	%r8d, (%rcx)
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx), %eax
.L6:
	ret
	.seh_endproc
	.globl	reverse
	.def	reverse;	.scl	2;	.type	32;	.endef
	.seh_proc	reverse
reverse:
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
	movq	%rcx, %rbx
	movq	$-1, %rcx
	movl	$0, %eax
	movq	%rbx, %rdi
	repnz scasb
	notq	%rcx
	leaq	-1(%rcx), %rdi
	movl	%edi, %ecx
	call	createStack
	movq	%rax, %rbp
	testl	%edi, %edi
	jle	.L9
	movq	%rbx, %rsi
	leal	-1(%rdi), %eax
	leaq	1(%rbx,%rax), %r12
.L11:
	movsbl	(%rbx), %edx
	movq	%rbp, %rcx
	call	push
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L11
.L12:
	movq	%rbp, %rcx
	call	pop
	movb	%al, (%rsi)
	addq	$1, %rsi
	cmpq	%r12, %rsi
	jne	.L12
.L9:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Reversed string is %s\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movabsq	$7599069502422476103, %rax
	movq	%rax, 38(%rsp)
	movw	$122, 46(%rsp)
	leaq	38(%rsp), %rbx
	movq	%rbx, %rcx
	call	reverse
	movq	%rbx, %rdx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
