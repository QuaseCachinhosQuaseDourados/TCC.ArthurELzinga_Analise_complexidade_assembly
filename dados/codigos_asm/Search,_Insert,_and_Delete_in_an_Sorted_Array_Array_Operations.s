	.file	"Search,_Insert,_and_Delete_in_an_Sorted_Array_Array_Operations.c"
	.text
	.globl	binarySearch
	.def	binarySearch;	.scl	2;	.type	32;	.endef
	.seh_proc	binarySearch
binarySearch:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	%edx, %r8d
	jl	.L4
	leal	(%r8,%rdx), %eax
	movl	%eax, %r10d
	shrl	$31, %r10d
	addl	%eax, %r10d
	sarl	%r10d
	movl	%r10d, %eax
	movslq	%r10d, %r11
	movl	(%rcx,%r11,4), %r11d
	cmpl	%r9d, %r11d
	je	.L1
	jl	.L5
	leal	-1(%r10), %r8d
	call	binarySearch
.L1:
	addq	$40, %rsp
	ret
.L5:
	leal	1(%r10), %edx
	call	binarySearch
	jmp	.L1
.L4:
	movl	$-1, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Index: %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$5, 32(%rsp)
	movl	$6, 36(%rsp)
	movl	$7, 40(%rsp)
	movl	$8, 44(%rsp)
	movl	$9, 48(%rsp)
	movl	$10, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$10, %r9d
	movl	$5, %r8d
	movl	$0, %edx
	call	binarySearch
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
