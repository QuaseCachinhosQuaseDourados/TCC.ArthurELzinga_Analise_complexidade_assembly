	.file	"Two_Sum_using_Sorting_and_Two-Pointers_technique.c"
	.text
	.globl	exchange
	.def	exchange;	.scl	2;	.type	32;	.endef
	.seh_proc	exchange
exchange:
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
	movl	(%rsi), %r10d
	leal	-1(%rdx), %eax
	cmpl	%edx, %r8d
	jle	.L3
	movslq	%edx, %rdx
	jmp	.L5
.L7:
	addl	$1, %eax
	movslq	%eax, %r11
	leaq	(%rcx,%r11,4), %r11
	movl	(%r11), %ebx
	movl	%r9d, (%r11)
	movl	%ebx, (%rcx,%rdx,4)
.L4:
	addq	$1, %rdx
	cmpl	%edx, %r8d
	jle	.L3
.L5:
	movl	(%rcx,%rdx,4), %r9d
	cmpl	%r10d, %r9d
	jg	.L4
	jmp	.L7
.L3:
	movslq	%eax, %rdx
	leaq	4(%rcx,%rdx,4), %rdx
	movl	(%rdx), %ecx
	movl	(%rsi), %r8d
	movl	%r8d, (%rdx)
	movl	%ecx, (%rsi)
	addl	$1, %eax
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	quickSort
	.def	quickSort;	.scl	2;	.type	32;	.endef
	.seh_proc	quickSort
quickSort:
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
	movq	%rcx, %rdi
	movl	%edx, %esi
	movl	%r8d, %ebx
	cmpl	%r8d, %edx
	jl	.L10
.L8:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
.L10:
	call	partition
	movl	%eax, %ebp
	leal	-1(%rax), %r8d
	movl	%esi, %edx
	movq	%rdi, %rcx
	call	quickSort
	leal	1(%rbp), %edx
	movl	%ebx, %r8d
	movq	%rdi, %rcx
	call	quickSort
	jmp	.L8
	.seh_endproc
	.globl	boolhasArrayTwoCandidates
	.def	boolhasArrayTwoCandidates;	.scl	2;	.type	32;	.endef
	.seh_proc	boolhasArrayTwoCandidates
boolhasArrayTwoCandidates:
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
	movl	%r8d, %edi
	leal	-1(%rdx), %ebx
	movl	%ebx, %r8d
	movl	$0, %edx
	call	quickSort
	testl	%ebx, %ebx
	jle	.L17
	movslq	%ebx, %rdx
	movl	(%rsi), %eax
	addl	(%rsi,%rdx,4), %eax
	cmpl	%eax, %edi
	je	.L18
	movl	$0, %edx
	jmp	.L13
.L14:
	subl	$1, %ebx
.L15:
	cmpl	%edx, %ebx
	jle	.L20
	movslq	%edx, %rcx
	movslq	%ebx, %rax
	movl	(%rsi,%rax,4), %eax
	addl	(%rsi,%rcx,4), %eax
	cmpl	%edi, %eax
	je	.L19
.L13:
	cmpl	%eax, %edi
	jle	.L14
	addl	$1, %edx
	jmp	.L15
.L20:
	movl	$0, %eax
.L11:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L17:
	movl	$0, %eax
	jmp	.L11
.L18:
	movl	$1, %eax
	jmp	.L11
.L19:
	movl	$1, %eax
	jmp	.L11
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Yes\0"
.LC1:
	.ascii "No\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$4, 36(%rsp)
	movl	$45, 40(%rsp)
	movl	$6, 44(%rsp)
	movl	$10, 48(%rsp)
	movl	$-8, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$16, %r8d
	movl	$6, %edx
	call	hasArrayTwoCandidates
	testl	%eax, %eax
	je	.L22
	leaq	.LC0(%rip), %rcx
	call	printf
.L23:
	call	getchar
	movl	$0, %eax
	addq	$72, %rsp
	ret
.L22:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L23
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	hasArrayTwoCandidates;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
