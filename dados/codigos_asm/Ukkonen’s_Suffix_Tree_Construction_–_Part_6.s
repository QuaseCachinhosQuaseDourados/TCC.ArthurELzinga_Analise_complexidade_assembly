	.file	"Ukkonen\222s_Suffix_Tree_Construction_\226_Part_6.c"
	.text
	.globl	newNode
	.def	newNode;	.scl	2;	.type	32;	.endef
	.seh_proc	newNode
newNode:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %esi
	movq	%rdx, %rbx
	addl	$1, count(%rip)
	movl	$2080, %ecx
	call	malloc
	movq	%rax, %rdx
	leaq	2048(%rax), %rcx
.L2:
	movq	$0, (%rdx)
	addq	$8, %rdx
	cmpq	%rcx, %rdx
	jne	.L2
	movq	root(%rip), %rdx
	movq	%rdx, 2048(%rax)
	movl	%esi, 2056(%rax)
	movq	%rbx, 2064(%rax)
	movl	$-1, 2072(%rax)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	edgeLength
	.def	edgeLength;	.scl	2;	.type	32;	.endef
	.seh_proc	edgeLength
edgeLength:
	.seh_endprologue
	movq	2064(%rcx), %rax
	movl	(%rax), %eax
	subl	2056(%rcx), %eax
	addl	$1, %eax
	ret
	.seh_endproc
	.globl	walkDown
	.def	walkDown;	.scl	2;	.type	32;	.endef
	.seh_proc	walkDown
walkDown:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	call	edgeLength
	movl	%eax, %edx
	movl	activeLength(%rip), %ebx
	movl	$0, %eax
	cmpl	%ebx, %edx
	jle	.L8
.L5:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L8:
	addl	activeEdge(%rip), %edx
	movslq	%edx, %rdx
	leaq	text(%rip), %rax
	movsbl	(%rax,%rdx), %eax
	subl	$32, %eax
	movl	%eax, activeEdge(%rip)
	movq	%rsi, %rcx
	call	edgeLength
	subl	%eax, %ebx
	movl	%ebx, activeLength(%rip)
	movq	%rsi, activeNode(%rip)
	movl	$1, %eax
	jmp	.L5
	.seh_endproc
	.globl	extendSuffixTree
	.def	extendSuffixTree;	.scl	2;	.type	32;	.endef
	.seh_proc	extendSuffixTree
extendSuffixTree:
	pushq	%r14
	.seh_pushreg	%r14
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %r12d
	movl	%ecx, leafEnd(%rip)
	addl	$1, remainingSuffixCount(%rip)
	movq	$0, lastNewNode(%rip)
	leaq	text(%rip), %rdi
	movslq	%ecx, %rbp
	leaq	leafEnd(%rip), %r13
	jmp	.L10
.L22:
	movq	%r13, %rdx
	movl	%r12d, %ecx
	call	newNode
	movq	%rax, (%rsi)
	movq	lastNewNode(%rip), %rax
	testq	%rax, %rax
	je	.L13
	movq	activeNode(%rip), %rdx
	movq	%rdx, 2048(%rax)
	movq	$0, lastNewNode(%rip)
	jmp	.L13
.L23:
	movq	lastNewNode(%rip), %rdx
	testq	%rdx, %rdx
	je	.L16
	movq	activeNode(%rip), %rcx
	cmpq	root(%rip), %rcx
	je	.L16
	movq	%rcx, 2048(%rdx)
	movq	$0, lastNewNode(%rip)
.L16:
	addl	$1, %eax
	movl	%eax, activeLength(%rip)
.L9:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L18:
	movq	%r14, lastNewNode(%rip)
.L13:
	movl	remainingSuffixCount(%rip), %eax
	subl	$1, %eax
	movl	%eax, remainingSuffixCount(%rip)
	movq	activeNode(%rip), %rdx
	cmpq	root(%rip), %rdx
	je	.L21
	movq	2048(%rdx), %rax
	movq	%rax, activeNode(%rip)
.L10:
	cmpl	$0, remainingSuffixCount(%rip)
	jle	.L9
	cmpl	$0, activeLength(%rip)
	jne	.L11
	movsbl	(%rdi,%rbp), %eax
	subl	$32, %eax
	movl	%eax, activeEdge(%rip)
.L11:
	movslq	activeEdge(%rip), %rdx
	movq	activeNode(%rip), %rax
	leaq	(%rax,%rdx,8), %rsi
	movq	(%rsi), %rbx
	testq	%rbx, %rbx
	je	.L22
	movq	%rbx, %rcx
	call	walkDown
	testl	%eax, %eax
	jne	.L10
	movl	activeLength(%rip), %eax
	movl	%eax, %esi
	addl	2056(%rbx), %esi
	movslq	%esi, %rdx
	movzbl	(%rdi,%rbp), %ecx
	cmpb	%cl, (%rdi,%rdx)
	je	.L23
	movl	$4, %ecx
	call	malloc
	movq	%rax, splitEnd(%rip)
	subl	$1, %esi
	movl	%esi, (%rax)
	movl	2056(%rbx), %ecx
	movq	%rax, %rdx
	call	newNode
	movq	%rax, %r14
	movslq	activeEdge(%rip), %rdx
	movq	activeNode(%rip), %rax
	movq	%r14, (%rax,%rdx,8)
	movsbl	(%rdi,%rbp), %esi
	subl	$32, %esi
	movq	%r13, %rdx
	movl	%r12d, %ecx
	call	newNode
	movslq	%esi, %rsi
	movq	%rax, (%r14,%rsi,8)
	movl	activeLength(%rip), %eax
	addl	%eax, 2056(%rbx)
	movslq	activeEdge(%rip), %rax
	movq	%rbx, (%r14,%rax,8)
	movq	lastNewNode(%rip), %rax
	testq	%rax, %rax
	je	.L18
	movq	%r14, 2048(%rax)
	jmp	.L18
.L21:
	movl	activeLength(%rip), %edx
	testl	%edx, %edx
	jle	.L10
	subl	$1, %edx
	movl	%edx, activeLength(%rip)
	movl	%r12d, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	addl	$1, %eax
	cltq
	movsbl	(%rdi,%rax), %eax
	subl	$32, %eax
	movl	%eax, activeEdge(%rip)
	jmp	.L10
	.seh_endproc
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
	cmpl	%edx, %ecx
	jg	.L24
	movslq	%ecx, %rsi
	leaq	text(%rip), %rbx
	addq	%rsi, %rbx
	leaq	1+text(%rip), %rax
	addq	%rsi, %rax
	subl	%ecx, %edx
	leaq	(%rax,%rdx), %rsi
.L26:
	movsbl	(%rbx), %ecx
	call	putchar
	addq	$1, %rbx
	cmpq	%rsi, %rbx
	jne	.L26
.L24:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii " [%d]\12\0"
	.text
	.globl	setSuffixIndexByDFS
	.def	setSuffixIndexByDFS;	.scl	2;	.type	32;	.endef
	.seh_proc	setSuffixIndexByDFS
setSuffixIndexByDFS:
	pushq	%r14
	.seh_pushreg	%r14
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %r13
	movl	%edx, %ebp
	testq	%rcx, %rcx
	je	.L28
	movl	2056(%rcx), %ecx
	cmpl	$-1, %ecx
	jne	.L35
.L30:
	movq	%r13, %rbx
	leaq	2048(%r13), %rdi
	movl	$1, %eax
	movl	$0, %r12d
	leaq	.LC0(%rip), %r14
	jmp	.L33
.L35:
	movq	2064(%r13), %rax
	movl	(%rax), %edx
	call	print
	jmp	.L30
.L37:
	movl	2072(%r13), %edx
	movq	%r14, %rcx
	call	printf
.L32:
	movq	(%rsi), %rsi
	movq	%rsi, %rcx
	call	edgeLength
	leal	(%rax,%rbp), %edx
	movq	%rsi, %rcx
	call	setSuffixIndexByDFS
	movl	%r12d, %eax
.L31:
	addq	$8, %rbx
	cmpq	%rbx, %rdi
	je	.L36
.L33:
	movq	%rbx, %rsi
	cmpq	$0, (%rbx)
	je	.L31
	cmpl	$1, %eax
	jne	.L32
	cmpl	$-1, 2056(%r13)
	je	.L32
	jmp	.L37
.L36:
	cmpl	$1, %eax
	je	.L38
.L28:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L38:
	movl	size(%rip), %edx
	subl	%ebp, %edx
	movl	%edx, 2072(%r13)
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L28
	.seh_endproc
	.globl	freeSuffixTreeByPostOrder
	.def	freeSuffixTreeByPostOrder;	.scl	2;	.type	32;	.endef
	.seh_proc	freeSuffixTreeByPostOrder
freeSuffixTreeByPostOrder:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rdi
	testq	%rcx, %rcx
	je	.L39
	movq	%rcx, %rbx
	leaq	2048(%rcx), %rsi
	jmp	.L42
.L41:
	addq	$8, %rbx
	cmpq	%rsi, %rbx
	je	.L45
.L42:
	movq	(%rbx), %rcx
	testq	%rcx, %rcx
	je	.L41
	call	freeSuffixTreeByPostOrder
	jmp	.L41
.L45:
	cmpl	$-1, 2072(%rdi)
	je	.L46
.L43:
	movq	%rdi, %rcx
	call	free
	nop
.L39:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L46:
	movq	2064(%rdi), %rcx
	call	free
	jmp	.L43
	.seh_endproc
	.globl	buildSuffixTree
	.def	buildSuffixTree;	.scl	2;	.type	32;	.endef
	.seh_proc	buildSuffixTree
buildSuffixTree:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	$-1, %rbx
	leaq	text(%rip), %rdi
	movl	$0, %eax
	movq	%rbx, %rcx
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	addq	%rbx, %rax
	movl	%eax, size(%rip)
	movl	$4, %ecx
	call	malloc
	movq	%rax, rootEnd(%rip)
	movl	%ebx, (%rax)
	movq	%rax, %rdx
	movl	%ebx, %ecx
	call	newNode
	movq	%rax, root(%rip)
	movq	%rax, activeNode(%rip)
	cmpl	$0, size(%rip)
	jle	.L48
	movl	$0, %ebx
.L49:
	movl	%ebx, %ecx
	call	extendSuffixTree
	addl	$1, %ebx
	cmpl	%ebx, size(%rip)
	jg	.L49
.L48:
	movl	$0, %edx
	movq	root(%rip), %rcx
	call	setSuffixIndexByDFS
	movq	root(%rip), %rcx
	call	freeSuffixTreeByPostOrder
	nop
	addq	$40, %rsp
	popq	%rbx
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Number of nodes in suffix tree are %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$1667392097, text(%rip)
	movb	$0, 4+text(%rip)
	call	buildSuffixTree
	movl	count(%rip), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	size
	.data
	.align 4
size:
	.long	-1
	.globl	splitEnd
	.bss
	.align 8
splitEnd:
	.space 8
	.globl	rootEnd
	.align 8
rootEnd:
	.space 8
	.globl	leafEnd
	.data
	.align 4
leafEnd:
	.long	-1
	.globl	remainingSuffixCount
	.bss
	.align 4
remainingSuffixCount:
	.space 4
	.globl	activeLength
	.align 4
activeLength:
	.space 4
	.globl	activeEdge
	.data
	.align 4
activeEdge:
	.long	-1
	.globl	count
	.bss
	.align 4
count:
	.space 4
	.globl	activeNode
	.align 8
activeNode:
	.space 8
	.globl	lastNewNode
	.align 8
lastNewNode:
	.space 8
	.globl	root
	.align 8
root:
	.space 8
	.comm	text, 100, 5
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
