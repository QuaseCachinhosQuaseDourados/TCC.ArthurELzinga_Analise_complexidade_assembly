	.file	"Sliding_Window_Maximum_(Maximum_of_all_subarrays_of_size_K).c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printKMax
	.def	printKMax;	.scl	2;	.type	32;	.endef
	.seh_proc	printKMax
printKMax:
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
	movl	%r8d, %edi
	subl	%r8d, %edx
	js	.L1
	movq	%rcx, %rsi
	addq	$4, %rcx
	leal	-2(%r8), %eax
	leaq	(%rcx,%rax,4), %rbx
	movl	%edx, %edx
	leaq	(%rcx,%rdx,4), %r12
	leaq	.LC0(%rip), %rbp
	jmp	.L5
.L3:
	movq	%rbp, %rcx
	call	printf
	addq	$4, %rsi
	addq	$4, %rbx
	cmpq	%r12, %rsi
	je	.L1
.L5:
	movl	(%rsi), %edx
	cmpl	$1, %edi
	jle	.L3
	movq	%rsi, %rax
.L4:
	movl	4(%rax), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	addq	$4, %rax
	cmpq	%rbx, %rax
	jne	.L4
	jmp	.L3
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	movl	$7, 56(%rsp)
	movl	$8, 60(%rsp)
	movl	$9, 64(%rsp)
	movl	$10, 68(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %r8d
	movl	$10, %edx
	call	printKMax
	movl	$0, %eax
	addq	$88, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
