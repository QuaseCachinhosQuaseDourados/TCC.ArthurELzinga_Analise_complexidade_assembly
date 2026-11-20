	.file	"Design_a_stack_with_operations_on_middle_element.c"
	.text
	.globl	createMyStack
	.def	createMyStack;	.scl	2;	.type	32;	.endef
	.seh_proc	createMyStack
createMyStack:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$24, %ecx
	call	malloc
	movl	$0, 16(%rax)
	addq	$40, %rsp
	ret
	.seh_endproc
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
	movl	$24, %ecx
	call	malloc
	movl	%esi, 8(%rax)
	movq	$0, (%rax)
	movq	(%rbx), %rcx
	movq	%rcx, 16(%rax)
	movl	16(%rbx), %esi
	leal	1(%rsi), %edx
	movl	%edx, 16(%rbx)
	cmpl	$1, %edx
	je	.L5
	movq	%rax, (%rcx)
	testb	$1, 16(%rbx)
	je	.L4
	movq	8(%rbx), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, 8(%rbx)
	jmp	.L4
.L5:
	movq	%rax, 8(%rbx)
.L4:
	movq	%rax, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Stack is empty\0"
	.text
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rax
	cmpl	$0, 16(%rcx)
	je	.L11
	movq	(%rcx), %rcx
	movl	8(%rcx), %ebx
	movq	16(%rcx), %rdx
	movq	%rdx, (%rax)
	testq	%rdx, %rdx
	je	.L9
	movq	$0, (%rdx)
.L9:
	movl	16(%rax), %edx
	subl	$1, %edx
	movl	%edx, 16(%rax)
	testb	$1, %dl
	jne	.L10
	movq	8(%rax), %rdx
	movq	16(%rdx), %rdx
	movq	%rdx, 8(%rax)
.L10:
	call	free
.L6:
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.L11:
	leaq	.LC0(%rip), %rcx
	call	puts
	movl	$-1, %ebx
	jmp	.L6
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Stack is empty now\0"
	.text
	.globl	findMiddle
	.def	findMiddle;	.scl	2;	.type	32;	.endef
	.seh_proc	findMiddle
findMiddle:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	$0, 16(%rcx)
	je	.L15
	movq	8(%rcx), %rax
	movl	8(%rax), %eax
.L12:
	addq	$40, %rsp
	ret
.L15:
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$-1, %eax
	jmp	.L12
	.seh_endproc
	.globl	deleteMiddle
	.def	deleteMiddle;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteMiddle
deleteMiddle:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	16(%rcx), %eax
	testl	%eax, %eax
	je	.L20
	subl	$1, %eax
	movl	%eax, 16(%rcx)
	movq	8(%rcx), %rax
	movq	16(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	movq	8(%rcx), %rax
	movq	(%rax), %rdx
	movq	16(%rax), %rax
	movq	%rax, 16(%rdx)
	testb	$1, 16(%rcx)
	je	.L19
	movq	8(%rcx), %rax
	movq	16(%rax), %rax
	movq	%rax, 8(%rcx)
.L16:
	addq	$40, %rsp
	ret
.L20:
	leaq	.LC1(%rip), %rcx
	call	puts
	jmp	.L16
.L19:
	movq	8(%rcx), %rax
	movq	(%rax), %rax
	movq	%rax, 8(%rcx)
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "Popped : %d\12\0"
.LC3:
	.ascii "Middle Element : %d\12\0"
.LC4:
	.ascii "New Middle Element : %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	call	createMyStack
	movq	%rax, %rbx
	movl	$11, %edx
	movq	%rax, %rcx
	call	push
	movl	$22, %edx
	movq	%rbx, %rcx
	call	push
	movl	$33, %edx
	movq	%rbx, %rcx
	call	push
	movl	$44, %edx
	movq	%rbx, %rcx
	call	push
	movl	$55, %edx
	movq	%rbx, %rcx
	call	push
	movl	$66, %edx
	movq	%rbx, %rcx
	call	push
	movl	$77, %edx
	movq	%rbx, %rcx
	call	push
	movl	$88, %edx
	movq	%rbx, %rcx
	call	push
	movl	$99, %edx
	movq	%rbx, %rcx
	call	push
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	pop
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	findMiddle
	movl	%eax, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	deleteMiddle
	movq	%rbx, %rcx
	call	findMiddle
	movl	%eax, %edx
	leaq	.LC4(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
