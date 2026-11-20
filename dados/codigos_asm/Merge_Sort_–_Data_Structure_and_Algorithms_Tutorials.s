	.file	"Merge_Sort_\226_Data_Structure_and_Algorithms_Tutorials.c"
	.text
	.globl	merge
	.def	merge;	.scl	2;	.type	32;	.endef
	.seh_proc	merge
merge:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%r8d, %edi
	subl	%edx, %edi
	leal	1(%rdi), %esi
	subl	%r8d, %r9d
	movslq	%esi, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	movq	%rsp, %r12
	movq	%r12, %rbx
	movslq	%r9d, %rax
	leaq	15(,%rax,4), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	movq	%rsp, %r11
	testl	%esi, %esi
	jle	.L2
	movl	%edi, %eax
	leaq	4(,%rax,4), %r14
	movslq	%edx, %rax
	leaq	(%rcx,%rax,4), %r13
	movl	$0, %eax
.L3:
	movl	0(%r13,%rax), %r10d
	movl	%r10d, (%rbx,%rax)
	addq	$4, %rax
	cmpq	%r14, %rax
	jne	.L3
.L2:
	testl	%r9d, %r9d
	jle	.L4
	leal	-1(%r9), %r10d
	addq	$2, %r10
	movslq	%r8d, %r8
	leaq	(%rcx,%r8,4), %r13
	movl	$1, %eax
.L5:
	movl	0(%r13,%rax,4), %r8d
	movl	%r8d, -4(%r11,%rax,4)
	addq	$1, %rax
	cmpq	%r10, %rax
	jne	.L5
	testl	%esi, %esi
	jle	.L15
	addl	$1, %edx
	movslq	%edx, %r8
	movl	$0, %r10d
	movl	$0, %eax
	jmp	.L9
.L7:
	movl	%edx, -4(%rcx,%r8,4)
	addl	$1, %eax
.L8:
	movl	%r8d, %edx
	addq	$1, %r8
	cmpl	%esi, %r10d
	jge	.L18
	cmpl	%r9d, %eax
	jge	.L18
.L9:
	movslq	%r10d, %rdx
	movl	(%rbx,%rdx,4), %r13d
	movslq	%eax, %rdx
	movl	(%r11,%rdx,4), %edx
	cmpl	%edx, %r13d
	jg	.L7
	movl	%r13d, -4(%rcx,%r8,4)
	addl	$1, %r10d
	jmp	.L8
.L18:
	cmpl	%esi, %r10d
	jge	.L6
.L14:
	movl	%r10d, %r13d
	movl	%edi, %esi
	subl	%r10d, %esi
	movslq	%r10d, %r10
	leaq	(%r12,%r10,4), %r12
	movslq	%edx, %r8
	leaq	(%rcx,%r8,4), %rbx
	movl	$0, %r8d
	jmp	.L11
.L16:
	movq	%r10, %r8
.L11:
	movl	(%r12,%r8,4), %r10d
	movl	%r10d, (%rbx,%r8,4)
	leaq	1(%r8), %r10
	cmpq	%rsi, %r8
	jne	.L16
	leal	1(%rdi,%rdx), %edx
	subl	%r13d, %edx
.L6:
	cmpl	%r9d, %eax
	jge	.L1
	cltq
	movslq	%edx, %rdx
	subq	%rax, %rdx
	leaq	(%rcx,%rdx,4), %rcx
.L13:
	movl	(%r11,%rax,4), %edx
	movl	%edx, (%rcx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %r9d
	jg	.L13
.L1:
	movq	%rbp, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	ret
.L15:
	movl	$0, %eax
	jmp	.L6
.L4:
	movl	$0, %r10d
	movl	$0, %eax
	testl	%esi, %esi
	jg	.L14
	jmp	.L1
	.seh_endproc
	.globl	mergeSort
	.def	mergeSort;	.scl	2;	.type	32;	.endef
	.seh_proc	mergeSort
mergeSort:
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
	movq	%rcx, %rbp
	movl	%edx, %ebx
	movl	%r8d, %edi
	cmpl	%r8d, %edx
	jl	.L25
.L23:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L25:
	movl	%r8d, %eax
	subl	%edx, %eax
	movl	%eax, %esi
	shrl	$31, %esi
	addl	%eax, %esi
	sarl	%esi
	addl	%edx, %esi
	movl	%esi, %r8d
	call	mergeSort
	leal	1(%rsi), %edx
	movl	%edi, %r8d
	movq	%rbp, %rcx
	call	mergeSort
	movl	%edi, %r9d
	movl	%esi, %r8d
	movl	%ebx, %edx
	movq	%rbp, %rcx
	call	merge
	jmp	.L23
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
	jle	.L27
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L28:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L28
.L27:
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
	.ascii "Given array is \0"
.LC2:
	.ascii "\12Sorted array is \0"
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
	leaq	.LC1(%rip), %rcx
	call	puts
	leaq	32(%rsp), %rbx
	movl	$6, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$5, %r8d
	movl	$0, %edx
	movq	%rbx, %rcx
	call	mergeSort
	leaq	.LC2(%rip), %rcx
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
