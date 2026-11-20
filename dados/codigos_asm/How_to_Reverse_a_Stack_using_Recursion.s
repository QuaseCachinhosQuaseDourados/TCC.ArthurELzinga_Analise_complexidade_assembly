	.file	"How_to_Reverse_a_Stack_using_Recursion.c"
	.text
	.globl	boolisEmpty
	.def	boolisEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisEmpty
boolisEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Stack overflow \0"
	.text
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	movl	$16, %ecx
	call	malloc
	testq	%rax, %rax
	je	.L4
	movb	%sil, (%rax)
	movq	(%rbx), %rdx
	movq	%rdx, 8(%rax)
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L4:
	leaq	.LC0(%rip), %rcx
	call	puts
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L7
	movzbl	(%rdx), %ebx
	movq	8(%rdx), %rax
	movq	%rax, (%rcx)
	movq	%rdx, %rcx
	call	free
	movsbl	%bl, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L7:
	leaq	.LC0(%rip), %rcx
	call	puts
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.globl	insertAtBottom
	.def	insertAtBottom;	.scl	2;	.type	32;	.endef
	.seh_proc	insertAtBottom
insertAtBottom:
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
	movl	%edx, %esi
	movq	(%rcx), %rcx
	call	isEmpty
	testl	%eax, %eax
	je	.L9
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	push
	nop
.L8:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L9:
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edi
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	insertAtBottom
	movl	%edi, %edx
	movq	%rbx, %rcx
	call	push
	jmp	.L8
	.seh_endproc
	.globl	reverse
	.def	reverse;	.scl	2;	.type	32;	.endef
	.seh_proc	reverse
reverse:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	(%rcx), %rcx
	call	isEmpty
	testl	%eax, %eax
	je	.L13
.L11:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L13:
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %esi
	movq	%rbx, %rcx
	call	reverse
	movl	%esi, %edx
	movq	%rbx, %rcx
	call	insertAtBottom
	jmp	.L11
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii " %d \0"
	.text
	.globl	print
	.def	print;	.scl	2;	.type	32;	.endef
	.seh_proc	print
print:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	$10, %ecx
	call	putchar
	testq	%rbx, %rbx
	je	.L14
	leaq	.LC1(%rip), %rsi
.L16:
	movsbl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L16
.L14:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "\12 Original Stack \0"
.LC3:
	.ascii "\12 Reversed Stack \0"
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
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rbx
	movl	$4, %edx
	movq	%rbx, %rcx
	call	push
	movl	$3, %edx
	movq	%rbx, %rcx
	call	push
	movl	$2, %edx
	movq	%rbx, %rcx
	call	push
	movl	$1, %edx
	movq	%rbx, %rcx
	call	push
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	print
	movq	%rbx, %rcx
	call	reverse
	leaq	.LC3(%rip), %rcx
	call	printf
	movq	40(%rsp), %rcx
	call	print
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	isEmpty;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
