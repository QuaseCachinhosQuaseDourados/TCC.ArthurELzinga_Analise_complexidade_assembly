	.file	"Search,_Insert,_and_Delete_in_an_Unsorted_Array_Array_Operations_2.c"
	.text
	.globl	insertElement
	.def	insertElement;	.scl	2;	.type	32;	.endef
	.seh_proc	insertElement
insertElement:
	.seh_endprologue
	leal	-1(%rdx), %eax
	cmpl	%r9d, %eax
	jl	.L2
	cltq
	leaq	0(,%rax,4), %r10
	leaq	(%rcx,%r10), %rax
	leaq	-4(%rcx,%r10), %r10
	movl	%r9d, %r11d
	notl	%r11d
	leal	(%r11,%rdx), %edx
	salq	$2, %rdx
	subq	%rdx, %r10
.L3:
	movl	(%rax), %edx
	movl	%edx, 4(%rax)
	subq	$4, %rax
	cmpq	%r10, %rax
	jne	.L3
.L2:
	movslq	%r9d, %r9
	movl	%r8d, (%rcx,%r9,4)
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Before insertion : \0"
.LC1:
	.ascii "%d \0"
.LC2:
	.ascii "After insertion : \0"
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
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movq	$0, 52(%rsp)
	movq	$0, 60(%rsp)
	movq	$0, 68(%rsp)
	movq	$0, 76(%rsp)
	movq	$0, 84(%rsp)
	movl	$2, 32(%rsp)
	movl	$4, 36(%rsp)
	movl	$1, 40(%rsp)
	movl	$8, 44(%rsp)
	movl	$5, 48(%rsp)
	leaq	.LC0(%rip), %rcx
	call	printf
	leaq	32(%rsp), %rbx
	leaq	20(%rbx), %rbp
	movq	%rbx, %rsi
	leaq	.LC1(%rip), %rdi
.L6:
	movl	(%rsi), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rsi
	cmpq	%rbp, %rsi
	jne	.L6
	movl	$10, %ecx
	call	putchar
	leaq	32(%rsp), %rcx
	movl	$2, %r9d
	movl	$10, %r8d
	movl	$5, %edx
	call	insertElement
	leaq	.LC2(%rip), %rcx
	call	printf
	leaq	24(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
.L7:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L7
	movl	$0, %eax
	addq	$104, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
