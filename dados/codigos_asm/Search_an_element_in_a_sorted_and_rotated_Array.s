	.file	"Search_an_element_in_a_sorted_and_rotated_Array.c"
	.text
	.globl	findPivot
	.def	findPivot;	.scl	2;	.type	32;	.endef
	.seh_proc	findPivot
findPivot:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	%edx, %r8d
	jl	.L6
	movl	%edx, %eax
	je	.L1
	leal	(%r8,%rdx), %eax
	movl	%eax, %r9d
	shrl	$31, %r9d
	addl	%eax, %r9d
	sarl	%r9d
	movl	%r9d, %eax
	cmpl	%r9d, %r8d
	jle	.L3
	movslq	%r9d, %r10
	movl	4(%rcx,%r10,4), %r11d
	cmpl	%r11d, (%rcx,%r10,4)
	jg	.L1
.L3:
	cmpl	%r9d, %edx
	jge	.L4
	movslq	%r9d, %rax
	movl	-4(%rcx,%rax,4), %r11d
	cmpl	%r11d, (%rcx,%rax,4)
	jl	.L8
.L4:
	movslq	%edx, %r10
	movslq	%r9d, %rax
	movl	(%rcx,%rax,4), %eax
	cmpl	%eax, (%rcx,%r10,4)
	jge	.L9
	leal	1(%r9), %edx
	call	findPivot
.L1:
	addq	$40, %rsp
	ret
.L8:
	leal	-1(%r9), %eax
	jmp	.L1
.L9:
	leal	-1(%r9), %r8d
	call	findPivot
	jmp	.L1
.L6:
	movl	$-1, %eax
	jmp	.L1
	.seh_endproc
	.globl	binarySearch
	.def	binarySearch;	.scl	2;	.type	32;	.endef
	.seh_proc	binarySearch
binarySearch:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	%edx, %r8d
	jl	.L13
	leal	(%r8,%rdx), %eax
	movl	%eax, %r10d
	shrl	$31, %r10d
	addl	%eax, %r10d
	sarl	%r10d
	movl	%r10d, %eax
	movslq	%r10d, %r11
	movl	(%rcx,%r11,4), %r11d
	cmpl	%r9d, %r11d
	je	.L10
	jl	.L14
	leal	-1(%r10), %r8d
	call	binarySearch
.L10:
	addq	$40, %rsp
	ret
.L14:
	leal	1(%r10), %edx
	call	binarySearch
	jmp	.L10
.L13:
	movl	$-1, %eax
	jmp	.L10
	.seh_endproc
	.globl	pivotedBinarySearch
	.def	pivotedBinarySearch;	.scl	2;	.type	32;	.endef
	.seh_proc	pivotedBinarySearch
pivotedBinarySearch:
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
	movl	%r8d, %edi
	leal	-1(%rdx), %ebx
	movl	%ebx, %r8d
	movl	$0, %edx
	call	findPivot
	cmpl	$-1, %eax
	je	.L19
	movslq	%eax, %rdx
	cmpl	%edi, (%rsi,%rdx,4)
	je	.L15
	cmpl	%edi, (%rsi)
	jle	.L20
	leal	1(%rax), %edx
	movl	%edi, %r9d
	movl	%ebx, %r8d
	movq	%rsi, %rcx
	call	binarySearch
.L15:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L19:
	movl	%edi, %r9d
	movl	%ebx, %r8d
	movl	$0, %edx
	movq	%rsi, %rcx
	call	binarySearch
	jmp	.L15
.L20:
	movl	%edi, %r9d
	leal	-1(%rax), %r8d
	movl	$0, %edx
	movq	%rsi, %rcx
	call	binarySearch
	jmp	.L15
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Index of the element is : %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$5, 32(%rsp)
	movl	$6, 36(%rsp)
	movl	$7, 40(%rsp)
	movl	$8, 44(%rsp)
	movl	$9, 48(%rsp)
	movl	$10, 52(%rsp)
	movl	$1, 56(%rsp)
	movl	$2, 60(%rsp)
	movl	$3, 64(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %r8d
	movl	$9, %edx
	call	pivotedBinarySearch
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
