	.file	"Complete_Tutorial_on_LRU_Cache_with_Implementations.c"
	.text
	.globl	newQNode
	.def	newQNode;	.scl	2;	.type	32;	.endef
	.seh_proc	newQNode
newQNode:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$24, %ecx
	call	malloc
	movl	%ebx, 16(%rax)
	movq	$0, 8(%rax)
	movq	$0, (%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	createQueue
	.def	createQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	createQueue
createQueue:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$24, %ecx
	call	malloc
	movl	$0, (%rax)
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	movl	%ebx, 4(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	createHash
	.def	createHash;	.scl	2;	.type	32;	.endef
	.seh_proc	createHash
createHash:
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
	movl	%esi, (%rax)
	movslq	%esi, %rcx
	salq	$3, %rcx
	call	malloc
	movq	%rax, 8(%rbx)
	testl	%esi, %esi
	jle	.L3
	movl	$0, %eax
.L5:
	movq	8(%rbx), %rdx
	movq	$0, (%rdx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, (%rbx)
	jg	.L5
.L3:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	AreAllFramesFull
	.def	AreAllFramesFull;	.scl	2;	.type	32;	.endef
	.seh_proc	AreAllFramesFull
AreAllFramesFull:
	.seh_endprologue
	movl	4(%rcx), %eax
	cmpl	%eax, (%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	isQueueEmpty
	.def	isQueueEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	isQueueEmpty
isQueueEmpty:
	.seh_endprologue
	cmpq	$0, 16(%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	deQueue
	.def	deQueue;	.scl	2;	.type	32;	.endef
	.seh_proc	deQueue
deQueue:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movq	16(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L9
	cmpq	%rcx, 8(%rbx)
	je	.L13
.L11:
	movq	(%rcx), %rax
	movq	%rax, 16(%rbx)
	testq	%rax, %rax
	je	.L12
	movq	$0, 8(%rax)
.L12:
	call	free
	subl	$1, (%rbx)
.L9:
	addq	$32, %rsp
	popq	%rbx
	ret
.L13:
	movq	$0, 8(%rbx)
	jmp	.L11
	.seh_endproc
	.globl	Enqueue
	.def	Enqueue;	.scl	2;	.type	32;	.endef
	.seh_proc	Enqueue
Enqueue:
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
	movq	%rdx, %rdi
	movl	%r8d, %esi
	movl	4(%rcx), %eax
	cmpl	%eax, (%rcx)
	je	.L18
.L15:
	movl	%esi, %ecx
	call	newQNode
	movq	8(%rbx), %rdx
	movq	%rdx, 8(%rax)
	cmpq	$0, 16(%rbx)
	jne	.L16
	movq	%rax, 8(%rbx)
	movq	%rax, 16(%rbx)
.L17:
	movl	%esi, %esi
	movq	8(%rdi), %rdx
	movq	%rax, (%rdx,%rsi,8)
	addl	$1, (%rbx)
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L18:
	movq	16(%rcx), %rax
	movl	16(%rax), %edx
	movq	8(%rdi), %rax
	movq	$0, (%rax,%rdx,8)
	call	deQueue
	jmp	.L15
.L16:
	movq	%rax, (%rdx)
	movq	%rax, 8(%rbx)
	jmp	.L17
	.seh_endproc
	.globl	ReferencePage
	.def	ReferencePage;	.scl	2;	.type	32;	.endef
	.seh_proc	ReferencePage
ReferencePage:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%r8d, %r9d
	movq	8(%rdx), %rax
	movq	(%rax,%r9,8), %rax
	testq	%rax, %rax
	je	.L24
	cmpq	%rax, 8(%rcx)
	je	.L19
	movq	(%rax), %r8
	movq	8(%rax), %rdx
	movq	%rdx, 8(%r8)
	testq	%rdx, %rdx
	je	.L22
	movq	(%rax), %r8
	movq	%r8, (%rdx)
.L22:
	cmpq	%rax, 16(%rcx)
	je	.L25
.L23:
	movq	8(%rcx), %rdx
	movq	%rdx, 8(%rax)
	movq	$0, (%rax)
	movq	%rax, (%rdx)
	movq	%rax, 8(%rcx)
.L19:
	addq	$40, %rsp
	ret
.L24:
	call	Enqueue
	jmp	.L19
.L25:
	movq	(%rax), %rdx
	movq	%rdx, 16(%rcx)
	movq	$0, 8(%rdx)
	jmp	.L23
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
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
	movl	$4, %ecx
	call	createQueue
	movq	%rax, %rbx
	movl	$10, %ecx
	call	createHash
	movq	%rax, %rsi
	movl	$1, %r8d
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movl	$2, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movl	$3, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movl	$1, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movl	$4, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movl	$5, %r8d
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	ReferencePage
	movq	8(%rbx), %rax
	movl	16(%rax), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movq	8(%rax), %rax
	movl	16(%rax), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movl	16(%rax), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movl	16(%rax), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
