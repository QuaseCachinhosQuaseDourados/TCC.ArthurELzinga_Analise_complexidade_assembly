	.file	"Introduction_and_Array_Implementation_of_Queue.c"
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
	movl	%ecx, %ebx
	movl	$24, %ecx
	call	malloc
	movq	%rax, %rsi
	movl	%ebx, 12(%rax)
	movl	$0, 8(%rax)
	movl	$0, (%rax)
	leal	-1(%rbx), %eax
	movl	%eax, 4(%rsi)
	movl	%ebx, %ecx
	salq	$2, %rcx
	call	malloc
	movq	%rax, 16(%rsi)
	movq	%rsi, %rax
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
	movl	12(%rcx), %eax
	cmpl	%eax, 8(%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	isEmpty
	.def	isEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	isEmpty
isEmpty:
	.seh_endprologue
	cmpl	$0, 8(%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d enqueued to queue\12\0"
	.text
	.globl	enqueue
	.def	enqueue;	.scl	2;	.type	32;	.endef
	.seh_proc	enqueue
enqueue:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%edx, %r9d
	movl	12(%rcx), %r8d
	cmpl	%r8d, 8(%rcx)
	jne	.L6
.L4:
	addq	$40, %rsp
	ret
.L6:
	movl	4(%rcx), %eax
	addl	$1, %eax
	movl	$0, %edx
	divl	%r8d
	movl	%edx, 4(%rcx)
	movslq	%edx, %rax
	movq	16(%rcx), %rdx
	movl	%r9d, (%rdx,%rax,4)
	addl	$1, 8(%rcx)
	movl	%r9d, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L4
	.seh_endproc
	.globl	dequeue
	.def	dequeue;	.scl	2;	.type	32;	.endef
	.seh_proc	dequeue
dequeue:
	.seh_endprologue
	movl	8(%rcx), %r8d
	testl	%r8d, %r8d
	je	.L9
	movl	(%rcx), %eax
	movslq	%eax, %r9
	movq	16(%rcx), %rdx
	movl	(%rdx,%r9,4), %r9d
	addl	$1, %eax
	movl	$0, %edx
	divl	12(%rcx)
	movl	%edx, (%rcx)
	subl	$1, %r8d
	movl	%r8d, 8(%rcx)
.L7:
	movl	%r9d, %eax
	ret
.L9:
	movl	$-2147483648, %r9d
	jmp	.L7
	.seh_endproc
	.globl	front
	.def	front;	.scl	2;	.type	32;	.endef
	.seh_proc	front
front:
	.seh_endprologue
	cmpl	$0, 8(%rcx)
	je	.L12
	movslq	(%rcx), %rdx
	movq	16(%rcx), %rax
	movl	(%rax,%rdx,4), %eax
.L10:
	ret
.L12:
	movl	$-2147483648, %eax
	jmp	.L10
	.seh_endproc
	.globl	rear
	.def	rear;	.scl	2;	.type	32;	.endef
	.seh_proc	rear
rear:
	.seh_endprologue
	cmpl	$0, 8(%rcx)
	je	.L15
	movslq	4(%rcx), %rdx
	movq	16(%rcx), %rax
	movl	(%rax,%rdx,4), %eax
.L13:
	ret
.L15:
	movl	$-2147483648, %eax
	jmp	.L13
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "%d dequeued from queue\12\12\0"
.LC2:
	.ascii "Front item is %d\12\0"
.LC3:
	.ascii "Rear item is %d\12\0"
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
	movl	$1000, %ecx
	call	createQueue
	movq	%rax, %rbx
	movl	$10, %edx
	movq	%rax, %rcx
	call	enqueue
	movl	$20, %edx
	movq	%rbx, %rcx
	call	enqueue
	movl	$30, %edx
	movq	%rbx, %rcx
	call	enqueue
	movl	$40, %edx
	movq	%rbx, %rcx
	call	enqueue
	movq	%rbx, %rcx
	call	dequeue
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	front
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	%rbx, %rcx
	call	rear
	movl	%eax, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
