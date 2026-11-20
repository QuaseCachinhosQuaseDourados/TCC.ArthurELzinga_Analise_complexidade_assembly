	.file	"Find_whether_an_array_is_subset_of_another_array_using_Sorting_and_Merging.c"
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
	.globl	isSubset
	.def	isSubset;	.scl	2;	.type	32;	.endef
	.seh_proc	isSubset
isSubset:
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
	movq	%rdx, %rdi
	movl	%r8d, %esi
	movl	%r9d, %ebx
	movl	$0, %eax
	cmpl	%r9d, %r8d
	jge	.L37
.L26:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L37:
	leal	-1(%r8), %r8d
	movl	$0, %edx
	call	mergeSort
	leal	-1(%rbx), %r8d
	movl	$0, %edx
	movq	%rdi, %rcx
	call	mergeSort
	movl	$0, %eax
	movl	$0, %r8d
	jmp	.L28
.L29:
	je	.L38
	jg	.L35
.L28:
	cmpl	%ebx, %r8d
	jge	.L36
	cmpl	%esi, %eax
	jge	.L36
	movslq	%eax, %rdx
	movl	0(%rbp,%rdx,4), %ecx
	movslq	%r8d, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %ecx
	jge	.L29
	addl	$1, %eax
	jmp	.L28
.L38:
	addl	$1, %eax
	addl	$1, %r8d
	jmp	.L28
.L36:
	cmpl	%ebx, %r8d
	setge	%al
	movzbl	%al, %eax
	jmp	.L26
.L35:
	movl	$0, %eax
	jmp	.L26
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "arr2[] is subset of arr1[] \0"
	.align 8
.LC1:
	.ascii "arr2[] is not a subset of arr1[] \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$11, 48(%rsp)
	movl	$1, 52(%rsp)
	movl	$13, 56(%rsp)
	movl	$21, 60(%rsp)
	movl	$3, 64(%rsp)
	movl	$7, 68(%rsp)
	movl	$11, 32(%rsp)
	movl	$3, 36(%rsp)
	movl	$7, 40(%rsp)
	movl	$1, 44(%rsp)
	leaq	32(%rsp), %rdx
	leaq	48(%rsp), %rcx
	movl	$4, %r9d
	movl	$6, %r8d
	call	isSubset
	testl	%eax, %eax
	je	.L40
	leaq	.LC0(%rip), %rcx
	call	printf
.L41:
	movl	$0, %eax
	addq	$88, %rsp
	ret
.L40:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L41
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
