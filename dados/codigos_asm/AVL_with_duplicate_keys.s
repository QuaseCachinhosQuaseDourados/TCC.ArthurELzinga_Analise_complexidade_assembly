	.file	"AVL_with_duplicate_keys.c"
	.text
	.globl	height
	.def	height;	.scl	2;	.type	32;	.endef
	.seh_proc	height
height:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L3
	movl	24(%rcx), %eax
.L1:
	ret
.L3:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.globl	max
	.def	max;	.scl	2;	.type	32;	.endef
	.seh_proc	max
max:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovge	%edx, %eax
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
	movl	$32, %ecx
	call	malloc
	movl	%ebx, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	movl	$1, 24(%rax)
	movl	$1, 28(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	rightRotate
	.def	rightRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightRotate
rightRotate:
	.seh_endprologue
	movq	8(%rcx), %rax
	movq	16(%rax), %r8
	movq	%rcx, 16(%rax)
	movq	%r8, 8(%rcx)
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L11
	movl	24(%rdx), %r9d
.L7:
	testq	%r8, %r8
	je	.L12
	movl	24(%r8), %edx
.L8:
	cmpl	%r9d, %edx
	cmovl	%r9d, %edx
	addl	$1, %edx
	movl	%edx, 24(%rcx)
	movq	16(%rax), %rdx
	testq	%rdx, %rdx
	je	.L13
	movl	24(%rdx), %ecx
.L9:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	je	.L14
	movl	24(%rdx), %edx
.L10:
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, 24(%rax)
	ret
.L11:
	movl	$0, %r9d
	jmp	.L7
.L12:
	movl	$0, %edx
	jmp	.L8
.L13:
	movl	$0, %ecx
	jmp	.L9
.L14:
	movl	$0, %edx
	jmp	.L10
	.seh_endproc
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
	.seh_endprologue
	movq	16(%rcx), %rax
	movq	8(%rax), %rdx
	movq	%rcx, 8(%rax)
	movq	%rdx, 16(%rcx)
	testq	%rdx, %rdx
	je	.L20
	movl	24(%rdx), %r8d
.L16:
	movq	8(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L21
	movl	24(%rdx), %edx
.L17:
	cmpl	%r8d, %edx
	cmovl	%r8d, %edx
	addl	$1, %edx
	movl	%edx, 24(%rcx)
	movq	16(%rax), %rdx
	testq	%rdx, %rdx
	je	.L22
	movl	24(%rdx), %ecx
.L18:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	je	.L23
	movl	24(%rdx), %edx
.L19:
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, 24(%rax)
	ret
.L20:
	movl	$0, %r8d
	jmp	.L16
.L21:
	movl	$0, %edx
	jmp	.L17
.L22:
	movl	$0, %ecx
	jmp	.L18
.L23:
	movl	$0, %edx
	jmp	.L19
	.seh_endproc
	.globl	getBalance
	.def	getBalance;	.scl	2;	.type	32;	.endef
	.seh_proc	getBalance
getBalance:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L28
	movq	8(%rcx), %rax
	testq	%rax, %rax
	je	.L29
	movl	24(%rax), %eax
.L26:
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L30
	movl	24(%rdx), %edx
.L27:
	subl	%edx, %eax
.L24:
	ret
.L29:
	movl	$0, %eax
	jmp	.L26
.L30:
	movl	$0, %edx
	jmp	.L27
.L28:
	movl	$0, %eax
	jmp	.L24
	.seh_endproc
	.globl	insert
	.def	insert;	.scl	2;	.type	32;	.endef
	.seh_proc	insert
insert:
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
	movl	%edx, %esi
	testq	%rcx, %rcx
	je	.L44
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	je	.L45
	jle	.L35
	movq	8(%rcx), %rcx
	call	insert
	movq	%rax, 8(%rbx)
.L36:
	movq	16(%rbx), %rbp
	testq	%rbp, %rbp
	je	.L42
	movl	24(%rbp), %edx
.L37:
	movq	8(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L43
	movl	24(%rdi), %eax
.L38:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	movq	%rbx, %rcx
	call	getBalance
	cmpl	$1, %eax
	jle	.L39
	cmpl	%esi, (%rdi)
	jg	.L46
	cmpl	%esi, (%rdi)
	jge	.L33
	movq	%rdi, %rcx
	call	leftRotate
	movq	%rax, 8(%rbx)
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rbx
	jmp	.L33
.L44:
	movl	%edx, %ecx
	call	newNode
	movq	%rax, %rbx
	jmp	.L33
.L45:
	addl	$1, 28(%rcx)
	jmp	.L33
.L35:
	movq	16(%rcx), %rcx
	call	insert
	movq	%rax, 16(%rbx)
	jmp	.L36
.L42:
	movl	$0, %edx
	jmp	.L37
.L43:
	movl	$0, %eax
	jmp	.L38
.L46:
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rbx
	jmp	.L33
.L39:
	cmpl	$-1, %eax
	jl	.L47
.L33:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L47:
	movl	0(%rbp), %eax
	cmpl	%esi, %eax
	jl	.L48
	jle	.L33
	movq	%rbp, %rcx
	call	rightRotate
	movq	%rax, 16(%rbx)
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rbx
	jmp	.L33
.L48:
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rbx
	jmp	.L33
	.seh_endproc
	.globl	minValueNode
	.def	minValueNode;	.scl	2;	.type	32;	.endef
	.seh_proc	minValueNode
minValueNode:
	.seh_endprologue
	movq	%rcx, %rax
	jmp	.L50
.L51:
	movq	%rdx, %rax
.L50:
	movq	8(%rax), %rdx
	testq	%rdx, %rdx
	jne	.L51
	ret
	.seh_endproc
	.globl	deleteNode
	.def	deleteNode;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteNode
deleteNode:
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
	testq	%rcx, %rcx
	je	.L68
	movl	(%rcx), %eax
	cmpl	%edx, %eax
	jg	.L73
	jl	.L74
	movl	28(%rcx), %eax
	cmpl	$1, %eax
	jg	.L75
	movq	8(%rcx), %rsi
	testq	%rsi, %rsi
	je	.L58
	movq	16(%rcx), %rdx
	testq	%rdx, %rdx
	jne	.L60
.L59:
	movq	(%rsi), %rax
	movq	%rax, (%rbx)
	movq	8(%rsi), %rax
	movq	%rax, 8(%rbx)
	movq	16(%rsi), %rax
	movq	%rax, 16(%rbx)
	movq	24(%rsi), %rax
	movq	%rax, 24(%rbx)
	movq	%rsi, %rcx
	call	free
	jmp	.L62
.L73:
	movq	8(%rcx), %rcx
	call	deleteNode
	movq	%rax, 8(%rbx)
.L62:
	movq	16(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L70
	movl	24(%rdi), %edx
.L63:
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L71
	movl	24(%rsi), %eax
.L64:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	addl	$1, %eax
	movl	%eax, 24(%rbx)
	movq	%rbx, %rcx
	call	getBalance
	cmpl	$1, %eax
	jle	.L65
	movq	%rsi, %rcx
	call	getBalance
	testl	%eax, %eax
	jns	.L76
	movq	%rsi, %rcx
	call	leftRotate
	movq	%rax, 8(%rbx)
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rsi
.L52:
	movq	%rsi, %rax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L74:
	movq	16(%rcx), %rcx
	call	deleteNode
	movq	%rax, 16(%rbx)
	jmp	.L62
.L75:
	subl	$1, %eax
	movl	%eax, 28(%rcx)
	movl	$0, %esi
	jmp	.L52
.L58:
	movq	16(%rcx), %rsi
	testq	%rsi, %rsi
	jne	.L59
	call	free
	jmp	.L52
.L69:
	movq	%rax, %rdx
.L60:
	movq	8(%rdx), %rax
	testq	%rax, %rax
	jne	.L69
	movl	(%rdx), %eax
	movl	%eax, (%rbx)
	movl	28(%rdx), %eax
	movl	%eax, 28(%rbx)
	movl	$1, 28(%rdx)
	movq	16(%rbx), %rcx
	movl	(%rdx), %edx
	call	deleteNode
	movq	%rax, 16(%rbx)
	jmp	.L62
.L70:
	movl	$0, %edx
	jmp	.L63
.L71:
	movl	$0, %eax
	jmp	.L64
.L76:
	movq	%rbx, %rcx
	call	rightRotate
	movq	%rax, %rsi
	jmp	.L52
.L65:
	movq	%rbx, %rsi
	cmpl	$-1, %eax
	jge	.L52
	movq	%rdi, %rcx
	call	getBalance
	testl	%eax, %eax
	jle	.L77
	movq	%rdi, %rcx
	call	rightRotate
	movq	%rax, 16(%rbx)
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rsi
	jmp	.L52
.L77:
	movq	%rbx, %rcx
	call	leftRotate
	movq	%rax, %rsi
	jmp	.L52
.L68:
	movq	%rcx, %rsi
	jmp	.L52
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d(%d) \0"
	.text
	.globl	preOrder
	.def	preOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	preOrder
preOrder:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L78
	movl	28(%rcx), %r8d
	movl	(%rcx), %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movq	8(%rbx), %rcx
	call	preOrder
	movq	16(%rbx), %rcx
	call	preOrder
	nop
.L78:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Pre order traversal of the const ructed AVL tree is \0"
	.align 8
.LC2:
	.ascii "\12Pre order traversal after deletion of 9 \0"
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
	movl	$9, %edx
	movl	$0, %ecx
	call	insert
	movl	$5, %edx
	movq	%rax, %rcx
	call	insert
	movl	$10, %edx
	movq	%rax, %rcx
	call	insert
	movl	$5, %edx
	movq	%rax, %rcx
	call	insert
	movl	$9, %edx
	movq	%rax, %rcx
	call	insert
	movl	$7, %edx
	movq	%rax, %rcx
	call	insert
	movl	$17, %edx
	movq	%rax, %rcx
	call	insert
	movq	%rax, %rbx
	leaq	.LC1(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	preOrder
	movl	$9, %edx
	movq	%rbx, %rcx
	call	deleteNode
	movq	%rax, %rbx
	leaq	.LC2(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	call	preOrder
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
