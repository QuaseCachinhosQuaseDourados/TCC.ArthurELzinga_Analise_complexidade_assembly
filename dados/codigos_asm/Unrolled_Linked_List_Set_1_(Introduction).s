	.file	"Unrolled_Linked_List_Set_1_(Introduction).c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
	.text
	.globl	printUnrolledList
	.def	printUnrolledList;	.scl	2;	.type	32;	.endef
	.seh_proc	printUnrolledList
printUnrolledList:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	leaq	.LC0(%rip), %rdi
	testq	%rcx, %rcx
	jne	.L2
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L4:
	movl	4(%rsi,%rbx,4), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$1, %rbx
	cmpl	%ebx, (%rsi)
	jg	.L4
.L5:
	movq	24(%rsi), %rsi
	testq	%rsi, %rsi
	je	.L1
.L2:
	movl	$0, %ebx
	cmpl	$0, (%rsi)
	jg	.L4
	jmp	.L5
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$32, %ecx
	call	malloc
	movq	%rax, %rbx
	movl	$32, %ecx
	call	malloc
	movq	%rax, %rsi
	movl	$32, %ecx
	call	malloc
	movl	$3, (%rbx)
	movl	$1, 4(%rbx)
	movl	$2, 8(%rbx)
	movl	$3, 12(%rbx)
	movq	%rsi, 24(%rbx)
	movl	$3, (%rsi)
	movl	$4, 4(%rsi)
	movl	$5, 8(%rsi)
	movl	$6, 12(%rsi)
	movq	%rax, 24(%rsi)
	movl	$3, (%rax)
	movl	$7, 4(%rax)
	movl	$8, 8(%rax)
	movl	$9, 12(%rax)
	movq	$0, 24(%rax)
	movq	%rbx, %rcx
	call	printUnrolledList
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
