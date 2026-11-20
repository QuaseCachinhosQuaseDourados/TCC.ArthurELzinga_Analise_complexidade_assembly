	.file	"Search_an_element_in_a_sorted_and_rotated_Array_2.c"
	.text
	.globl	search
	.def	search;	.scl	2;	.type	32;	.endef
	.seh_proc	search
search:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	%r8d, %edx
	jg	.L6
	leal	(%rdx,%r8), %eax
	movl	%eax, %r10d
	shrl	$31, %r10d
	addl	%eax, %r10d
	sarl	%r10d
	movl	%r10d, %eax
	movslq	%r10d, %r11
	movl	(%rcx,%r11,4), %r11d
	cmpl	%r9d, %r11d
	je	.L1
	movslq	%edx, %rax
	movl	(%rcx,%rax,4), %eax
	cmpl	%eax, %r11d
	jl	.L3
	cmpl	%r9d, %r11d
	jl	.L4
	cmpl	%r9d, %eax
	jle	.L7
.L4:
	leal	1(%r10), %edx
	call	search
	jmp	.L1
.L7:
	leal	-1(%r10), %r8d
	call	search
	jmp	.L1
.L3:
	cmpl	%r9d, %r11d
	jg	.L5
	movslq	%r8d, %rax
	cmpl	%r9d, (%rcx,%rax,4)
	jge	.L8
.L5:
	leal	-1(%r10), %r8d
	call	search
.L1:
	addq	$40, %rsp
	ret
.L8:
	leal	1(%r10), %edx
	call	search
	jmp	.L1
.L6:
	movl	$-1, %eax
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Index: %d\12\0"
.LC1:
	.ascii "Key not found\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movl	$4, 32(%rsp)
	movl	$5, 36(%rsp)
	movl	$6, 40(%rsp)
	movl	$7, 44(%rsp)
	movl	$8, 48(%rsp)
	movl	$9, 52(%rsp)
	movl	$1, 56(%rsp)
	movl	$2, 60(%rsp)
	movl	$3, 64(%rsp)
	leaq	32(%rsp), %rcx
	movl	$3, %r9d
	movl	$8, %r8d
	movl	$0, %edx
	call	search
	cmpl	$-1, %eax
	je	.L10
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
.L11:
	movl	$0, %eax
	addq	$88, %rsp
	ret
.L10:
	leaq	.LC1(%rip), %rcx
	call	printf
	jmp	.L11
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
