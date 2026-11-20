	.file	"Merge_an_array_of_size_n_into_another_array_of_size_m+n.c"
	.text
	.globl	moveToEnd
	.def	moveToEnd;	.scl	2;	.type	32;	.endef
	.seh_proc	moveToEnd
moveToEnd:
	.seh_endprologue
	subl	$1, %edx
	js	.L1
	movslq	%edx, %rax
	jmp	.L4
.L6:
	movslq	%edx, %r9
	movl	%r8d, (%rcx,%r9,4)
	subl	$1, %edx
.L3:
	subq	$1, %rax
	testl	%eax, %eax
	js	.L1
.L4:
	movl	(%rcx,%rax,4), %r8d
	cmpl	$-1, %r8d
	jne	.L6
	jmp	.L3
.L1:
	ret
	.seh_endproc
	.globl	merge
	.def	merge;	.scl	2;	.type	32;	.endef
	.seh_proc	merge
merge:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	%r9d, %r11d
	movl	$0, %eax
	movl	$0, %r10d
	addl	%r9d, %r8d
	jmp	.L8
.L9:
	movslq	%r11d, %rbx
	movl	(%rcx,%rbx,4), %ebx
	movl	%ebx, (%rcx,%rax,4)
	addl	$1, %r11d
.L11:
	addq	$1, %rax
.L8:
	cmpl	%eax, %r8d
	jle	.L13
	cmpl	%r9d, %r10d
	je	.L9
	cmpl	%r11d, %r8d
	jle	.L10
	movslq	%r11d, %rbx
	movslq	%r10d, %rsi
	movl	(%rdx,%rsi,4), %esi
	cmpl	%esi, (%rcx,%rbx,4)
	jle	.L9
.L10:
	movslq	%r10d, %rbx
	movl	(%rdx,%rbx,4), %ebx
	movl	%ebx, (%rcx,%rax,4)
	addl	$1, %r10d
	jmp	.L11
.L13:
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
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
	jle	.L15
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L16:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L16
.L15:
	movl	$10, %ecx
	call	putchar
	nop
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	call	__main
	movl	$2, 48(%rsp)
	movl	$8, 52(%rsp)
	movl	$-1, 56(%rsp)
	movl	$-1, 60(%rsp)
	movl	$-1, 64(%rsp)
	movl	$13, 68(%rsp)
	movl	$-1, 72(%rsp)
	movl	$15, 76(%rsp)
	movl	$20, 80(%rsp)
	movl	$5, 32(%rsp)
	movl	$7, 36(%rsp)
	movl	$9, 40(%rsp)
	movl	$25, 44(%rsp)
	leaq	48(%rsp), %rbx
	movl	$9, %edx
	movq	%rbx, %rcx
	call	moveToEnd
	leaq	32(%rsp), %rdx
	movl	$4, %r9d
	movl	$5, %r8d
	movq	%rbx, %rcx
	call	merge
	movl	$9, %edx
	movq	%rbx, %rcx
	call	printArray
	movl	$0, %eax
	addq	$96, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
