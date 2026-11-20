	.file	"Little_and_Big_Endian_Mystery.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %.2x\0"
	.text
	.globl	show_mem_rep
	.def	show_mem_rep;	.scl	2;	.type	32;	.endef
	.seh_proc	show_mem_rep
show_mem_rep:
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
	leaq	1(%rcx,%rax), %rdi
	leaq	.LC0(%rip), %rsi
.L3:
	movsbl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L3
.L2:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$19088743, 44(%rsp)
	leaq	44(%rsp), %rcx
	movl	$4, %edx
	call	show_mem_rep
	call	getchar
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
