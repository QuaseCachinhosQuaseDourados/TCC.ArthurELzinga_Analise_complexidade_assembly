	.file	"Count_Inversions_in_an_array_using_Merge_Sort.c"
	.text
	.globl	merge
	.def	merge;	.scl	2;	.type	32;	.endef
	.seh_proc	merge
merge:
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
	.seh_endprologue
	movl	88(%rsp), %esi
	movl	%r8d, %edi
	movslq	%r8d, %rbx
	leaq	(%rdx,%rbx,4), %rbp
	movl	%r9d, %r11d
	movl	%r8d, %r10d
	movl	$0, %eax
	jmp	.L2
.L3:
	addl	$1, %r11d
	movl	%r12d, 0(%rbp)
	movl	%r9d, %r12d
	subl	%r10d, %r12d
	addl	%r12d, %eax
.L4:
	addl	$1, %edi
	addq	$4, %rbp
.L2:
	movl	%edi, %r12d
	cmpl	%r9d, %r10d
	jge	.L13
	cmpl	%esi, %r11d
	jg	.L13
	movslq	%r10d, %r12
	movl	(%rcx,%r12,4), %r13d
	movslq	%r11d, %r12
	movl	(%rcx,%r12,4), %r12d
	cmpl	%r12d, %r13d
	jg	.L3
	addl	$1, %r10d
	movl	%r13d, 0(%rbp)
	jmp	.L4
.L13:
	cmpl	%r9d, %r10d
	jge	.L7
	movslq	%r10d, %r10
	movslq	%r12d, %r12
	subq	%r10, %r12
	leaq	(%rdx,%r12,4), %rdi
.L8:
	movl	(%rcx,%r10,4), %r11d
	movl	%r11d, (%rdi,%r10,4)
	addq	$1, %r10
	cmpl	%r10d, %r9d
	jg	.L8
.L9:
	cmpl	%esi, %r8d
	jg	.L1
.L12:
	movl	(%rdx,%rbx,4), %r8d
	movl	%r8d, (%rcx,%rbx,4)
	addq	$1, %rbx
	cmpl	%ebx, %esi
	jge	.L12
.L1:
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L7:
	cmpl	%esi, %r11d
	jg	.L9
	movslq	%r11d, %r9
	movslq	%r12d, %r12
	subq	%r9, %r12
	leaq	(%rdx,%r12,4), %r11
.L10:
	movl	(%rcx,%r9,4), %r10d
	movl	%r10d, (%r11,%r9,4)
	addq	$1, %r9
	cmpl	%r9d, %esi
	jge	.L10
	jmp	.L9
	.seh_endproc
	.globl	_mergeSort
	.def	_mergeSort;	.scl	2;	.type	32;	.endef
	.seh_proc	_mergeSort
_mergeSort:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %r12
	movq	%rdx, %r13
	movl	%r8d, %edi
	movl	%r9d, %ebp
	movl	$0, %eax
	cmpl	%r8d, %r9d
	jg	.L20
.L17:
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L20:
	leal	(%r9,%r8), %eax
	movl	%eax, %esi
	shrl	$31, %esi
	addl	%eax, %esi
	sarl	%esi
	movl	%esi, %r9d
	call	_mergeSort
	movl	%eax, %ebx
	addl	$1, %esi
	movl	%ebp, %r9d
	movl	%esi, %r8d
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	_mergeSort
	addl	%eax, %ebx
	movl	%ebp, 32(%rsp)
	movl	%esi, %r9d
	movl	%edi, %r8d
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	merge
	addl	%ebx, %eax
	jmp	.L17
	.seh_endproc
	.globl	mergeSort
	.def	mergeSort;	.scl	2;	.type	32;	.endef
	.seh_proc	mergeSort
mergeSort:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, %ebx
	movslq	%edx, %rcx
	salq	$2, %rcx
	call	malloc
	leal	-1(%rbx), %r9d
	movl	$0, %r8d
	movq	%rax, %rdx
	movq	%rsi, %rcx
	call	_mergeSort
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii " Number of inversions are %d \12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$20, 36(%rsp)
	movl	$6, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %edx
	call	mergeSort
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
