	.file	"Heap_Sort_\226_Data_Structures_and_Algorithms_Tutorials.c"
	.text
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
	.seh_endprologue
	movl	(%rcx), %eax
	movl	(%rdx), %r8d
	movl	%r8d, (%rcx)
	movl	%eax, (%rdx)
	ret
	.seh_endproc
	.globl	heapify
	.def	heapify;	.scl	2;	.type	32;	.endef
	.seh_proc	heapify
heapify:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	leal	(%r8,%r8), %eax
	leal	1(%rax), %r9d
	addl	$2, %eax
	cmpl	%edx, %r9d
	jge	.L3
	movslq	%r9d, %r10
	movslq	%r8d, %r11
	movl	(%rcx,%r11,4), %r11d
	cmpl	%r11d, (%rcx,%r10,4)
	jle	.L3
	cmpl	%edx, %eax
	jge	.L6
	movslq	%eax, %r11
	movl	(%rcx,%r11,4), %r11d
	cmpl	(%rcx,%r10,4), %r11d
	cmovle	%r9d, %eax
	jmp	.L4
.L6:
	movl	%r9d, %eax
	jmp	.L4
.L3:
	cmpl	%edx, %eax
	jge	.L2
	movslq	%eax, %r9
	movslq	%r8d, %r10
	movl	(%rcx,%r10,4), %r11d
	cmpl	%r11d, (%rcx,%r9,4)
	jle	.L2
.L4:
	cmpl	%r8d, %eax
	je	.L2
	movslq	%eax, %r9
	leaq	(%rcx,%r9,4), %r9
	movslq	%r8d, %r8
	leaq	(%rcx,%r8,4), %r8
	movl	(%r8), %r10d
	movl	(%r9), %r11d
	movl	%r11d, (%r8)
	movl	%r10d, (%r9)
	movl	%eax, %r8d
	call	heapify
	nop
.L2:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	heapSort
	.def	heapSort;	.scl	2;	.type	32;	.endef
	.seh_proc	heapSort
heapSort:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, %ebx
	movl	%edx, %edi
	shrl	$31, %edi
	addl	%edx, %edi
	sarl	%edi
	subl	$1, %edi
	js	.L9
.L10:
	movl	%edi, %r8d
	movl	%ebx, %edx
	movq	%rsi, %rcx
	call	heapify
	subl	$1, %edi
	cmpl	$-1, %edi
	jne	.L10
.L9:
	subl	$1, %ebx
	js	.L8
	movslq	%ebx, %rbx
.L12:
	movl	(%rsi), %eax
	movl	(%rsi,%rbx,4), %edx
	movl	%edx, (%rsi)
	movl	%eax, (%rsi,%rbx,4)
	movl	$0, %r8d
	movl	%ebx, %edx
	movq	%rsi, %rcx
	call	heapify
	subq	$1, %rbx
	testl	%ebx, %ebx
	jns	.L12
.L8:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printArray
	.def	printArray;	.scl	2;	.type	32;	.endef
	.seh_proc	printArray
printArray:
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
	jle	.L16
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L17:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L17
.L16:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Sorted array is\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movl	$12, 32(%rsp)
	movl	$11, 36(%rsp)
	movl	$13, 40(%rsp)
	movl	$5, 44(%rsp)
	movl	$6, 48(%rsp)
	movl	$7, 52(%rsp)
	leaq	32(%rsp), %rbx
	movl	$6, %edx
	movq	%rbx, %rcx
	call	heapSort
	leaq	.LC1(%rip), %rcx
	call	puts
	movl	$6, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
