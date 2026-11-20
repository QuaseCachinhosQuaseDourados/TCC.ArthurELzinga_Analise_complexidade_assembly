	.file	"How_to_Delete_in_a_Sorted_Array.c"
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
	.section .rdata,"dr"
.LC0:
	.ascii "Element not found\0"
	.text
	.globl	deleteElement
	.def	deleteElement;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteElement
deleteElement:
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
	movl	%edx, %ebx
	leal	-1(%rdx), %esi
	movl	%r8d, %r9d
	movl	%esi, %r8d
	movl	$0, %edx
	call	binarySearch
	cmpl	$-1, %eax
	je	.L7
	cmpl	%eax, %esi
	jle	.L6
	movslq	%eax, %rdx
	leaq	(%rdi,%rdx,4), %rcx
	subl	$2, %ebx
	subl	%eax, %ebx
	addq	%rdx, %rbx
	leaq	4(%rdi,%rbx,4), %rdx
.L10:
	movl	4(%rcx), %eax
	movl	%eax, (%rcx)
	addq	$4, %rcx
	cmpq	%rdx, %rcx
	jne	.L10
.L6:
	movl	%esi, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L7:
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	%ebx, %esi
	jmp	.L6
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Array before deletion\0"
.LC2:
	.ascii "%d  \0"
.LC3:
	.ascii "\12\12Array after deletion\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$20, 36(%rsp)
	movl	$30, 40(%rsp)
	movl	$40, 44(%rsp)
	movl	$50, 48(%rsp)
	leaq	.LC1(%rip), %rcx
	call	puts
	leaq	32(%rsp), %rbx
	leaq	20(%rbx), %rbp
	movq	%rbx, %rsi
	leaq	.LC2(%rip), %rdi
.L13:
	movl	(%rsi), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rsi
	cmpq	%rbp, %rsi
	jne	.L13
	leaq	32(%rsp), %rcx
	movl	$30, %r8d
	movl	$5, %edx
	call	deleteElement
	movl	%eax, %esi
	leaq	.LC3(%rip), %rcx
	call	puts
	testl	%esi, %esi
	jle	.L14
	leal	-1(%rsi), %eax
	leaq	4(%rbx,%rax,4), %rdi
	leaq	.LC2(%rip), %rsi
.L15:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L15
.L14:
	movl	$0, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
