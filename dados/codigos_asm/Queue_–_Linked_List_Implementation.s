	.file	"Queue_\226_Linked_List_Implementation.c"
	.text
	.globl	newNode
	.def	newNode;	.scl	2;	.type	32;	.endef
	.seh_proc	newNode
newNode:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$16, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	createQueue
	.def	createQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	createQueue
createQueue:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$16, %ecx
	call	malloc
	movq	$0, 8(%rax)
	movq	$0, (%rax)
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	enQueue
	.def	enQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	enQueue
enQueue:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %ecx
	call	newNode
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L6
	movq	%rax, 8(%rdx)
	movq	%rax, 8(%rbx)
.L3:
	addq	$32, %rsp
	popq	%rbx
	ret
.L6:
	movq	%rax, 8(%rbx)
	movq	%rax, (%rbx)
	jmp	.L3
	.seh_endproc
	.globl	deQueue
	.def	deQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	deQueue
deQueue:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	(%rcx), %rax
	testq	%rax, %rax
	je	.L7
	movq	8(%rax), %rdx
	movq	%rdx, (%rcx)
	testq	%rdx, %rdx
	je	.L10
.L9:
	movq	%rax, %rcx
	call	free
	nop
.L7:
	addq	$40, %rsp
	ret
.L10:
	movq	$0, 8(%rcx)
	jmp	.L9
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Queue Front : %d \12\0"
.LC1:
	.ascii "Queue Rear : %d\0"
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
	call	createQueue
	movq	%rax, %rbx
	movl	$10, %edx
	movq	%rax, %rcx
	call	enQueue
	movl	$20, %edx
	movq	%rbx, %rcx
	call	enQueue
	movq	%rbx, %rcx
	call	deQueue
	movq	%rbx, %rcx
	call	deQueue
	movl	$30, %edx
	movq	%rbx, %rcx
	call	enQueue
	movl	$40, %edx
	movq	%rbx, %rcx
	call	enQueue
	movl	$50, %edx
	movq	%rbx, %rcx
	call	enQueue
	movq	%rbx, %rcx
	call	deQueue
	movq	(%rbx), %rax
	movl	$-1, %edx
	testq	%rax, %rax
	je	.L12
	movl	(%rax), %edx
.L12:
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movl	$-1, %edx
	testq	%rax, %rax
	je	.L13
	movl	(%rax), %edx
.L13:
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
