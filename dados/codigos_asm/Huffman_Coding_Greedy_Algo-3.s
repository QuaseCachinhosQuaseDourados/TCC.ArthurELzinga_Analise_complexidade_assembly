	.file	"Huffman_Coding_Greedy_Algo-3.c"
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
	movl	%edx, %ebx
	movl	$24, %ecx
	call	malloc
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	movb	%sil, (%rax)
	movl	%ebx, 4(%rax)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	createMinHeap
	.def	createMinHeap;	.scl	2;	.type	32;	.endef
	.seh_proc	createMinHeap
createMinHeap:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$16, %ecx
	call	malloc
	movq	%rax, %rsi
	movl	$0, (%rax)
	movl	%ebx, 4(%rax)
	movl	%ebx, %ecx
	salq	$3, %rcx
	call	malloc
	movq	%rax, 8(%rsi)
	movq	%rsi, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	swapMinHeapNode
	.def	swapMinHeapNode;	.scl	2;	.type	32;	.endef
	.seh_proc	swapMinHeapNode
swapMinHeapNode:
	.seh_endprologue
	movq	(%rcx), %rax
	movq	(%rdx), %r8
	movq	%r8, (%rcx)
	movq	%rax, (%rdx)
	ret
	.seh_endproc
	.globl	minHeapify
	.def	minHeapify;	.scl	2;	.type	32;	.endef
	.seh_proc	minHeapify
minHeapify:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leal	(%rdx,%rdx), %r8d
	leal	1(%r8), %eax
	addl	$2, %r8d
	movl	(%rcx), %r9d
	cmpl	%eax, %r9d
	jbe	.L8
	movq	8(%rcx), %r10
	movslq	%eax, %r11
	movq	(%r10,%r11,8), %r11
	movslq	%edx, %rbx
	movq	(%r10,%rbx,8), %r10
	movl	4(%r11), %r11d
	cmpl	4(%r10), %r11d
	cmovnb	%edx, %eax
	jmp	.L5
.L8:
	movl	%edx, %eax
.L5:
	cmpl	%r8d, %r9d
	jbe	.L6
	movq	8(%rcx), %r9
	movslq	%r8d, %r10
	movq	(%r9,%r10,8), %r10
	movslq	%eax, %r11
	movq	(%r9,%r11,8), %r9
	movl	4(%r10), %r10d
	cmpl	4(%r9), %r10d
	cmovb	%r8d, %eax
.L6:
	cmpl	%edx, %eax
	jne	.L10
.L4:
	addq	$32, %rsp
	popq	%rbx
	ret
.L10:
	movq	8(%rcx), %r8
	movslq	%edx, %rdx
	leaq	(%r8,%rdx,8), %rdx
	movslq	%eax, %r9
	leaq	(%r8,%r9,8), %r8
	movq	(%r8), %r9
	movq	(%rdx), %r10
	movq	%r10, (%r8)
	movq	%r9, (%rdx)
	movl	%eax, %edx
	call	minHeapify
	jmp	.L4
	.seh_endproc
	.globl	isSizeOne
	.def	isSizeOne;	.scl	2;	.type	32;	.endef
	.seh_proc	isSizeOne
isSizeOne:
	.seh_endprologue
	cmpl	$1, (%rcx)
	sete	%al
	movzbl	%al, %eax
	ret
	.seh_endproc
	.globl	extractMin
	.def	extractMin;	.scl	2;	.type	32;	.endef
	.seh_proc	extractMin
extractMin:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	8(%rcx), %rax
	movq	(%rax), %rbx
	movl	(%rcx), %edx
	leal	-1(%rdx), %edx
	movq	(%rax,%rdx,8), %rdx
	movq	%rdx, (%rax)
	subl	$1, (%rcx)
	movl	$0, %edx
	call	minHeapify
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	insertMinHeap
	.def	insertMinHeap;	.scl	2;	.type	32;	.endef
	.seh_proc	insertMinHeap
insertMinHeap:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	(%rcx), %ebx
	leal	1(%rbx), %eax
	movl	%eax, (%rcx)
	movl	%ebx, %r9d
	testl	%ebx, %ebx
	je	.L16
	movq	8(%rcx), %r11
	leal	-1(%rbx), %r8d
	movl	%r8d, %eax
	shrl	$31, %eax
	addl	%r8d, %eax
	sarl	%eax
	movl	%eax, %r8d
	cltq
	movq	(%r11,%rax,8), %r10
	movl	4(%r10), %eax
	cmpl	%eax, 4(%rdx)
	jb	.L15
	movl	%ebx, %r8d
	jmp	.L14
.L18:
	movl	%eax, %r8d
.L15:
	movslq	%r9d, %r9
	movq	%r10, (%r11,%r9,8)
	testl	%r8d, %r8d
	je	.L14
	movq	8(%rcx), %r11
	leal	-1(%r8), %r9d
	movl	%r9d, %eax
	shrl	$31, %eax
	addl	%r9d, %eax
	sarl	%eax
	movslq	%eax, %r9
	movq	(%r11,%r9,8), %r10
	movl	%r8d, %r9d
	movl	4(%r10), %ebx
	cmpl	%ebx, 4(%rdx)
	jb	.L18
.L14:
	movslq	%r8d, %r8
	movq	8(%rcx), %rax
	movq	%rdx, (%rax,%r8,8)
	popq	%rbx
	ret
.L16:
	movl	%ebx, %r8d
	jmp	.L14
	.seh_endproc
	.globl	buildMinHeap
	.def	buildMinHeap;	.scl	2;	.type	32;	.endef
	.seh_proc	buildMinHeap
buildMinHeap:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movl	(%rcx), %eax
	subl	$2, %eax
	movl	%eax, %ebx
	shrl	$31, %ebx
	addl	%eax, %ebx
	sarl	%ebx
	cmpl	$-1, %eax
	jl	.L19
.L21:
	movl	%ebx, %edx
	movq	%rsi, %rcx
	call	minHeapify
	subl	$1, %ebx
	jns	.L21
.L19:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	printArr
	.def	printArr;	.scl	2;	.type	32;	.endef
	.seh_proc	printArr
printArr:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%edx, %edx
	jle	.L24
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L25:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L25
.L24:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	isLeaf
	.def	isLeaf;	.scl	2;	.type	32;	.endef
	.seh_proc	isLeaf
isLeaf:
	.seh_endprologue
	movl	$0, %eax
	cmpq	$0, 8(%rcx)
	je	.L30
.L27:
	ret
.L30:
	cmpq	$0, 16(%rcx)
	sete	%al
	movzbl	%al, %eax
	jmp	.L27
	.seh_endproc
	.globl	createAndBuildMinHeap
	.def	createAndBuildMinHeap;	.scl	2;	.type	32;	.endef
	.seh_proc	createAndBuildMinHeap
createAndBuildMinHeap:
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
	movq	%rcx, %rbp
	movq	%rdx, %r12
	movl	%r8d, %r14d
	movl	%r8d, %ecx
	call	createMinHeap
	movq	%rax, %rdi
	testl	%r14d, %r14d
	jle	.L32
	leal	-1(%r14), %r13d
	movl	$0, %ebx
	jmp	.L33
.L34:
	movq	%rax, %rbx
.L33:
	movq	8(%rdi), %rax
	leaq	(%rax,%rbx,8), %rsi
	movl	(%r12,%rbx,4), %edx
	movsbl	0(%rbp,%rbx), %ecx
	call	newNode
	movq	%rax, (%rsi)
	leaq	1(%rbx), %rax
	cmpq	%r13, %rbx
	jne	.L34
.L32:
	movl	%r14d, (%rdi)
	movq	%rdi, %rcx
	call	buildMinHeap
	movq	%rdi, %rax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
	.seh_endproc
	.globl	buildHuffmanTree
	.def	buildHuffmanTree;	.scl	2;	.type	32;	.endef
	.seh_proc	buildHuffmanTree
buildHuffmanTree:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	createAndBuildMinHeap
	movq	%rax, %rbx
	cmpl	$1, (%rax)
	je	.L36
.L37:
	movq	%rbx, %rcx
	call	extractMin
	movq	%rax, %rdi
	movq	%rbx, %rcx
	call	extractMin
	movq	%rax, %rsi
	movl	4(%rax), %edx
	addl	4(%rdi), %edx
	movl	$36, %ecx
	call	newNode
	movq	%rdi, 8(%rax)
	movq	%rsi, 16(%rax)
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	insertMinHeap
	cmpl	$1, (%rbx)
	jne	.L37
.L36:
	movq	%rbx, %rcx
	call	extractMin
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "%c: \0"
	.text
	.globl	printCodes
	.def	printCodes;	.scl	2;	.type	32;	.endef
	.seh_proc	printCodes
printCodes:
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
	movq	%rdx, %rsi
	movl	%r8d, %edi
	cmpq	$0, 8(%rcx)
	je	.L40
	movslq	%r8d, %rax
	movl	$0, (%rdx,%rax,4)
	movq	8(%rcx), %rcx
	leal	1(%r8), %r8d
	call	printCodes
.L40:
	cmpq	$0, 16(%rbx)
	je	.L41
	movslq	%edi, %rax
	movl	$1, (%rsi,%rax,4)
	movq	16(%rbx), %rcx
	leal	1(%rdi), %r8d
	movq	%rsi, %rdx
	call	printCodes
.L41:
	movq	%rbx, %rcx
	call	isLeaf
	testl	%eax, %eax
	jne	.L43
.L39:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L43:
	movsbl	(%rbx), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	%edi, %edx
	movq	%rsi, %rcx
	call	printArr
	jmp	.L39
	.seh_endproc
	.globl	HuffmanCodes
	.def	HuffmanCodes;	.scl	2;	.type	32;	.endef
	.seh_proc	HuffmanCodes
HuffmanCodes:
	subq	$440, %rsp
	.seh_stackalloc	440
	.seh_endprologue
	call	buildHuffmanTree
	leaq	32(%rsp), %rdx
	movl	$0, %r8d
	movq	%rax, %rcx
	call	printCodes
	nop
	addq	$440, %rsp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movb	$97, 58(%rsp)
	movb	$98, 59(%rsp)
	movb	$99, 60(%rsp)
	movb	$100, 61(%rsp)
	movb	$101, 62(%rsp)
	movb	$102, 63(%rsp)
	movl	$5, 32(%rsp)
	movl	$9, 36(%rsp)
	movl	$12, 40(%rsp)
	movl	$13, 44(%rsp)
	movl	$16, 48(%rsp)
	movl	$45, 52(%rsp)
	leaq	32(%rsp), %rdx
	leaq	58(%rsp), %rcx
	movl	$6, %r8d
	call	HuffmanCodes
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
