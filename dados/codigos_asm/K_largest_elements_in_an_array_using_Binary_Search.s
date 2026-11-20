	.file	"K_largest_elements_in_an_array_using_Binary_Search.c"
	.text
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
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
	movl	(%rsi), %r11d
	cmpl	%edx, %r8d
	jle	.L6
	movslq	%edx, %r9
	movl	%edx, %eax
	jmp	.L5
.L8:
	movslq	%eax, %rdx
	leaq	(%rcx,%rdx,4), %rdx
	movl	(%rdx), %ebx
	movl	%r10d, (%rdx)
	movl	%ebx, (%rcx,%r9,4)
	addl	$1, %eax
.L4:
	addq	$1, %r9
	cmpl	%r9d, %r8d
	jle	.L3
.L5:
	movl	(%rcx,%r9,4), %r10d
	cmpl	%r11d, %r10d
	jg	.L4
	jmp	.L8
.L6:
	movl	%edx, %eax
.L3:
	movslq	%eax, %rdx
	leaq	(%rcx,%rdx,4), %rdx
	movl	(%rdx), %ecx
	movl	(%rsi), %r8d
	movl	%r8d, (%rdx)
	movl	%ecx, (%rsi)
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	KthLargest
	.def	KthLargest;	.scl	2;	.type	32;	.endef
	.seh_proc	KthLargest
KthLargest:
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
	movq	%rcx, %rdi
	movl	%edx, %ebx
	movl	%r8d, %ebp
	movl	%r9d, %esi
	call	partition
	movl	%eax, %ecx
	subl	%ebx, %ecx
	leal	-1(%rsi), %edx
	cmpl	%edx, %ecx
	je	.L9
	jge	.L11
	subl	%eax, %esi
	leal	1(%rax), %edx
	movl	128(%rsp), %eax
	movl	%eax, 32(%rsp)
	leal	-1(%rbx,%rsi), %r9d
	movl	%ebp, %r8d
	movq	%rdi, %rcx
	call	KthLargest
	nop
.L9:
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L11:
	movl	128(%rsp), %edx
	movl	%edx, 32(%rsp)
	movl	%esi, %r9d
	leal	-1(%rax), %r8d
	movl	%ebx, %edx
	movq	%rdi, %rcx
	call	KthLargest
	jmp	.L9
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d largest elements are: \0"
.LC1:
	.ascii "%d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	call	__main
	movl	$11, 48(%rsp)
	movl	$3, 52(%rsp)
	movl	$2, 56(%rsp)
	movl	$1, 60(%rsp)
	movl	$15, 64(%rsp)
	movl	$5, 68(%rsp)
	movl	$4, 72(%rsp)
	movl	$45, 76(%rsp)
	movl	$88, 80(%rsp)
	movl	$96, 84(%rsp)
	movl	$50, 88(%rsp)
	movl	$45, 92(%rsp)
	leaq	48(%rsp), %rcx
	movl	$12, 32(%rsp)
	movl	$3, %r9d
	movl	$11, %r8d
	movl	$0, %edx
	call	KthLargest
	movl	$3, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	92(%rsp), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	88(%rsp), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	84(%rsp), %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$10, %ecx
	call	putchar
	movl	$0, %eax
	addq	$104, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
