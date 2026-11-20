	.file	"Block_swap_algorithm_for_array_rotation_2.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
.LC1:
	.ascii "\12 \0"
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
	jle	.L2
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L3:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L3
.L2:
	leaq	.LC1(%rip), %rcx
	call	printf
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
	.seh_endprologue
	testl	%r9d, %r9d
	jle	.L5
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,4), %rax
	leal	-1(%r9), %r9d
	addq	%rdx, %r9
	leaq	4(%rcx,%r9,4), %r9
	movslq	%r8d, %r8
	subq	%rdx, %r8
.L7:
	movl	(%rax), %edx
	movl	(%rax,%r8,4), %ecx
	movl	%ecx, (%rax)
	movl	%edx, (%rax,%r8,4)
	addq	$4, %rax
	cmpq	%r9, %rax
	jne	.L7
.L5:
	ret
	.seh_endproc
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
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
	movl	%edx, %edi
	testl	%edx, %edx
	je	.L9
	cmpl	%r8d, %edx
	je	.L9
	jle	.L11
	movl	%edx, %eax
	cltd
	idivl	%r8d
	movl	%edx, %edi
.L11:
	movl	%r8d, %ebx
	subl	%edi, %ebx
	cmpl	%ebx, %edi
	je	.L12
	movl	%edi, %esi
	jmp	.L15
.L13:
	movl	%edi, %edx
	subl	%esi, %edx
	movl	%ebx, %r9d
	movl	%edi, %r8d
	movq	%rbp, %rcx
	call	swap
	subl	%ebx, %esi
.L14:
	cmpl	%ebx, %esi
	je	.L12
.L15:
	cmpl	%ebx, %esi
	jge	.L13
	leal	(%rdi,%rbx), %r8d
	movl	%edi, %edx
	subl	%esi, %edx
	movl	%esi, %r9d
	subl	%esi, %r8d
	movq	%rbp, %rcx
	call	swap
	subl	%esi, %ebx
	jmp	.L14
.L12:
	movl	%edi, %edx
	subl	%ebx, %edx
	movl	%ebx, %r9d
	movl	%edi, %r8d
	movq	%rbp, %rcx
	call	swap
	nop
.L9:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
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
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	movl	$7, 56(%rsp)
	leaq	32(%rsp), %rbx
	movl	$7, %r8d
	movl	$2, %edx
	movq	%rbx, %rcx
	call	leftRotate
	movl	$7, %edx
	movq	%rbx, %rcx
	call	printArray
	call	getchar
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
