	.file	"Find_whether_an_array_is_subset_of_another_array_using_Sorting_and_Binary_Search.c"
	.text
	.globl	binarySearch
	.def	binarySearch;	.scl	2;	.type	32;	.endef
	.seh_proc	binarySearch
binarySearch:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	%edx, %r8d
	jl	.L6
	leal	(%r8,%rdx), %eax
	movl	%eax, %r10d
	shrl	$31, %r10d
	addl	%eax, %r10d
	sarl	%r10d
	movl	%r10d, %eax
	je	.L3
	movslq	%r10d, %r11
	cmpl	%r9d, -4(%rcx,%r11,4)
	jge	.L4
.L3:
	movslq	%r10d, %r11
	cmpl	%r9d, (%rcx,%r11,4)
	je	.L1
.L4:
	movslq	%r10d, %rax
	cmpl	%r9d, (%rcx,%rax,4)
	jge	.L5
	leal	1(%r10), %edx
	call	binarySearch
.L1:
	addq	$40, %rsp
	ret
.L5:
	leal	-1(%r10), %r8d
	call	binarySearch
	jmp	.L1
.L6:
	movl	$-1, %eax
	jmp	.L1
	.seh_endproc
	.globl	exchange
	.def	exchange;	.scl	2;	.type	32;	.endef
	.seh_proc	exchange
exchange:
	.seh_endprologue
	movl	(%rcx), %eax
	movl	(%rdx), %r8d
	movl	%r8d, (%rcx)
	movl	%eax, (%rdx)
	ret
	.seh_endproc
	.globl	partition
	.def	partition;	.scl	2;	.type	32;	.endef
	.seh_proc	partition
partition:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movslq	%r8d, %rax
	leaq	(%rcx,%rax,4), %rsi
	movl	(%rsi), %r10d
	leal	-1(%rdx), %eax
	cmpl	%edx, %r8d
	jle	.L9
	movslq	%edx, %rdx
	jmp	.L11
.L13:
	addl	$1, %eax
	movslq	%eax, %r11
	leaq	(%rcx,%r11,4), %r11
	movl	(%r11), %ebx
	movl	%r9d, (%r11)
	movl	%ebx, (%rcx,%rdx,4)
.L10:
	addq	$1, %rdx
	cmpl	%edx, %r8d
	jle	.L9
.L11:
	movl	(%rcx,%rdx,4), %r9d
	cmpl	%r10d, %r9d
	jg	.L10
	jmp	.L13
.L9:
	movslq	%eax, %rdx
	leaq	4(%rcx,%rdx,4), %rdx
	movl	(%rdx), %ecx
	movl	(%rsi), %r8d
	movl	%r8d, (%rdx)
	movl	%ecx, (%rsi)
	addl	$1, %eax
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	quickSort
	.def	quickSort;	.scl	2;	.type	32;	.endef
	.seh_proc	quickSort
quickSort:
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
	movq	%rcx, %rdi
	movl	%edx, %esi
	movl	%r8d, %ebx
	cmpl	%r8d, %edx
	jl	.L16
.L14:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L16:
	call	partition
	movl	%eax, %ebp
	leal	-1(%rax), %r8d
	movl	%esi, %edx
	movq	%rdi, %rcx
	call	quickSort
	leal	1(%rbp), %edx
	movl	%ebx, %r8d
	movq	%rdi, %rcx
	call	quickSort
	jmp	.L14
	.seh_endproc
	.globl	boolisSubset
	.def	boolisSubset;	.scl	2;	.type	32;	.endef
	.seh_proc	boolisSubset
boolisSubset:
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
	movq	%rcx, %rdi
	movq	%rdx, %r12
	movl	%r9d, %ebp
	leal	-1(%r8), %esi
	movl	%esi, %r8d
	movl	$0, %edx
	call	quickSort
	testl	%ebp, %ebp
	jle	.L20
	movq	%r12, %rbx
	leal	-1(%rbp), %eax
	leaq	4(%r12,%rax,4), %rbp
.L19:
	movl	(%rbx), %r9d
	movl	%esi, %r8d
	movl	$0, %edx
	movq	%rdi, %rcx
	call	binarySearch
	cmpl	$-1, %eax
	je	.L21
	addq	$4, %rbx
	cmpq	%rbp, %rbx
	jne	.L19
	movl	$1, %eax
	jmp	.L17
.L20:
	movl	$1, %eax
	jmp	.L17
.L21:
	movl	$0, %eax
.L17:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
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
	je	.L24
	leaq	.LC0(%rip), %rcx
	call	printf
.L25:
	movl	$0, %eax
	addq	$88, %rsp
	ret
.L24:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L25
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	isSubset;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
