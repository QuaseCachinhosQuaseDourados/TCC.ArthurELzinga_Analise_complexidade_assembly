	.file	"Find_Next_Greater_Element_using_Stack.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Error: stack overflown\0"
	.text
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	(%rcx), %eax
	cmpl	$99, %eax
	je	.L3
	addl	$1, %eax
	movl	%eax, (%rcx)
	cltq
	movl	%edx, 4(%rcx,%rax,4)
	addq	$40, %rsp
	ret
.L3:
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.globl	boolisEmpty
	.def	boolisEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisEmpty
boolisEmpty:
	.seh_endprologue
	cmpl	$-1, (%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Error: stack underflow n\0"
	.text
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	(%rcx), %edx
	cmpl	$-1, %edx
	je	.L7
	movslq	%edx, %rax
	movl	4(%rcx,%rax,4), %eax
	subl	$1, %edx
	movl	%edx, (%rcx)
	addq	$40, %rsp
	ret
.L7:
	leaq	.LC1(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "n %d --> %d\0"
	.text
	.globl	printNGE
	.def	printNGE;	.scl	2;	.type	32;	.endef
	.seh_proc	printNGE
printNGE:
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
	subq	$456, %rsp
	.seh_stackalloc	456
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	movl	$-1, 32(%rsp)
	leaq	32(%rsp), %rcx
	movl	(%rbx), %edx
	call	push
	cmpl	$1, %esi
	jle	.L9
	leaq	4(%rbx), %rbp
	leal	-2(%rsi), %eax
	leaq	8(%rbx,%rax,4), %r13
	leaq	32(%rsp), %rbx
	leaq	.LC2(%rip), %r12
	jmp	.L13
.L11:
	cmpl	%edi, %esi
	jl	.L18
.L10:
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	push
	addq	$4, %rbp
	cmpq	%r13, %rbp
	je	.L9
.L13:
	movl	0(%rbp), %esi
	movq	%rbx, %rcx
	call	isEmpty
	testl	%eax, %eax
	jne	.L10
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edi
	cmpl	%eax, %esi
	jle	.L11
.L12:
	movl	%esi, %r8d
	movl	%edi, %edx
	movq	%r12, %rcx
	call	printf
	movq	%rbx, %rcx
	call	isEmpty
	cmpl	$1, %eax
	je	.L11
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edi
	cmpl	%eax, %esi
	jg	.L12
	jmp	.L11
.L18:
	movl	%edi, %edx
	movq	%rbx, %rcx
	call	push
	jmp	.L10
.L9:
	leaq	32(%rsp), %rbx
	movl	$-1, %edi
	leaq	.LC2(%rip), %rsi
.L14:
	movq	%rbx, %rcx
	call	isEmpty
	testl	%eax, %eax
	jne	.L19
	movq	%rbx, %rcx
	call	pop
	movl	%edi, %r8d
	movl	%eax, %edx
	movq	%rsi, %rcx
	call	printf
	jmp	.L14
.L19:
	addq	$456, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$11, 32(%rsp)
	movl	$13, 36(%rsp)
	movl	$21, 40(%rsp)
	movl	$3, 44(%rsp)
	leaq	32(%rsp), %rcx
	movl	$4, %edx
	call	printNGE
	call	getchar
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	isEmpty;	.scl	2;	.type	32;	.endef
