	.file	"Level_Order_Traversal_using_Queue.c"
	.text
	.globl	createQueue
	.def	createQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	createQueue
createQueue:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movl	$4000, %ecx
	call	malloc
	movl	$0, (%rsi)
	movl	$0, (%rbx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	enQueue
	.def	enQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	enQueue
enQueue:
	.seh_endprologue
	movslq	(%rdx), %rax
	movq	%r8, (%rcx,%rax,8)
	addl	$1, (%rdx)
	ret
	.seh_endproc
	.globl	deQueue
	.def	deQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	deQueue
deQueue:
	.seh_endprologue
	movl	(%rdx), %eax
	addl	$1, %eax
	movl	%eax, (%rdx)
	cltq
	movq	-8(%rcx,%rax,8), %rax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printLevelOrder
	.def	printLevelOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	printLevelOrder
printLevelOrder:
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
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, %rbx
	movl	$4000, %ecx
	call	malloc
	movq	%rax, %rsi
	movl	$0, 44(%rsp)
	movl	$0, 40(%rsp)
	testq	%rbx, %rbx
	je	.L4
	leaq	.LC0(%rip), %r12
	leaq	44(%rsp), %rdi
	leaq	40(%rsp), %rbp
	jmp	.L8
.L10:
	movq	%rdi, %rdx
	movq	%rsi, %rcx
	call	enQueue
.L7:
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	call	deQueue
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L4
.L8:
	movl	(%rbx), %edx
	movq	%r12, %rcx
	call	printf
	movq	8(%rbx), %r8
	testq	%r8, %r8
	je	.L6
	movq	%rdi, %rdx
	movq	%rsi, %rcx
	call	enQueue
.L6:
	movq	16(%rbx), %r8
	testq	%r8, %r8
	jne	.L10
	jmp	.L7
.L4:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
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
	movl	$24, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Level Order traversal of binary tree is \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$1, %ecx
	call	newNode
	movq	%rax, %rbx
	movl	$2, %ecx
	call	newNode
	movq	%rax, 8(%rbx)
	movl	$3, %ecx
	call	newNode
	movq	%rax, 16(%rbx)
	movq	8(%rbx), %rsi
	movl	$4, %ecx
	call	newNode
	movq	%rax, 8(%rsi)
	movq	8(%rbx), %rsi
	movl	$5, %ecx
	call	newNode
	movq	%rax, 16(%rsi)
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	printLevelOrder
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
