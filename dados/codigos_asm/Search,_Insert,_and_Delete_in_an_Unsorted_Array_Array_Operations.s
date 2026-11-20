	.file	"Search,_Insert,_and_Delete_in_an_Unsorted_Array_Array_Operations.c"
	.text
	.globl	findElement
	.def	findElement;	.scl	2;	.type	32;	.endef
	.seh_proc	findElement
findElement:
	.seh_endprologue
	movl	$-1, %eax
	testl	%edx, %edx
	jle	.L1
	cmpl	(%rcx), %r8d
	je	.L6
	leal	-1(%rdx), %r9d
	addq	$1, %r9
	movl	$1, %edx
.L3:
	movl	%edx, %eax
	cmpq	%r9, %rdx
	je	.L7
	addq	$1, %rdx
	cmpl	%r8d, -4(%rcx,%rdx,4)
	jne	.L3
	jmp	.L1
.L7:
	movl	$-1, %eax
.L1:
	ret
.L6:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Element not found\0"
.LC1:
	.ascii "Element Found at Position: %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$12, 32(%rsp)
	movl	$34, 36(%rsp)
	movl	$10, 40(%rsp)
	movl	$6, 44(%rsp)
	movl	$40, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$40, %r8d
	movl	$5, %edx
	call	findElement
	cmpl	$-1, %eax
	je	.L11
	leal	1(%rax), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
.L10:
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L11:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L10
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
