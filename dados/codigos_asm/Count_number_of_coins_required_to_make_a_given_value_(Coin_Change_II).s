	.file	"Count_number_of_coins_required_to_make_a_given_value_(Coin_Change_II).c"
	.text
	.globl	count
	.def	count;	.scl	2;	.type	32;	.endef
	.seh_proc	count
count:
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
	movl	%r8d, %esi
	movl	$1, %eax
	testl	%r8d, %r8d
	je	.L1
	testl	%edx, %edx
	jle	.L4
	testl	%r8d, %r8d
	js	.L4
	leal	-1(%rdx), %edx
	call	count
	movl	%eax, %ebx
	movslq	%edi, %rax
	subl	-4(%rbp,%rax,4), %esi
	movl	%esi, %r8d
	movl	%edi, %edx
	movq	%rbp, %rcx
	call	count
	addl	%ebx, %eax
	jmp	.L1
.L4:
	movl	$0, %eax
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	movl	$1, 36(%rsp)
	movl	$2, 40(%rsp)
	movl	$3, 44(%rsp)
	leaq	36(%rsp), %rcx
	movl	$5, %r8d
	movl	$3, %edx
	call	count
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
