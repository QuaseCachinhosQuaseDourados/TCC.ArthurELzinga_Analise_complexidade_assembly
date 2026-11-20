	.file	"Delete_Operation.c"
	.text
	.globl	findElement
	.def	findElement;	.scl	2;	.type	32;	.endef
	.seh_proc	findElement
findElement:
	.seh_endprologue
	movl	$-1, %eax
	testl	%edx, %edx
	jle	.L1
	cmpl	(%rcx), %r8d
	je	.L6
	leal	-1(%rdx), %r9d
	addq	$1, %r9
	movl	$1, %edx
.L3:
	movl	%edx, %eax
	cmpq	%r9, %rdx
	je	.L7
	addq	$1, %rdx
	cmpl	%r8d, -4(%rcx,%rdx,4)
	jne	.L3
	jmp	.L1
.L7:
	movl	$-1, %eax
.L1:
	ret
.L6:
	movl	$0, %eax
	jmp	.L1
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Element not found\0"
	.text
	.globl	deleteElement
	.def	deleteElement;	.scl	2;	.type	32;	.endef
	.seh_proc	deleteElement
deleteElement:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movl	%edx, %ebx
	call	findElement
	movl	%eax, %edx
	cmpl	$-1, %eax
	je	.L9
	leal	-1(%rbx), %eax
	cmpl	%eax, %edx
	jge	.L8
	movslq	%edx, %r8
	leaq	(%rsi,%r8,4), %rcx
	subl	$2, %ebx
	subl	%edx, %ebx
	addq	%r8, %rbx
	leaq	4(%rsi,%rbx,4), %r8
.L12:
	movl	4(%rcx), %edx
	movl	%edx, (%rcx)
	addq	$4, %rcx
	cmpq	%r8, %rcx
	jne	.L12
.L8:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L9:
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	%ebx, %eax
	jmp	.L8
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "Array before deletion\0"
.LC2:
	.ascii "%d  \0"
.LC3:
	.ascii "\12Array after deletion\0"
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
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$10, 32(%rsp)
	movl	$50, 36(%rsp)
	movl	$30, 40(%rsp)
	movl	$40, 44(%rsp)
	movl	$20, 48(%rsp)
	leaq	.LC1(%rip), %rcx
	call	puts
	leaq	32(%rsp), %rbx
	leaq	20(%rbx), %rbp
	movq	%rbx, %rsi
	leaq	.LC2(%rip), %rdi
.L15:
	movl	(%rsi), %edx
	movq	%rdi, %rcx
	call	printf
	addq	$4, %rsi
	cmpq	%rbp, %rsi
	jne	.L15
	leaq	32(%rsp), %rcx
	movl	$30, %r8d
	movl	$5, %edx
	call	deleteElement
	movl	%eax, %esi
	leaq	.LC3(%rip), %rcx
	call	puts
	testl	%esi, %esi
	jle	.L16
	leal	-1(%rsi), %eax
	leaq	4(%rbx,%rax,4), %rdi
	leaq	.LC2(%rip), %rsi
.L17:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L17
.L16:
	movl	$0, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
