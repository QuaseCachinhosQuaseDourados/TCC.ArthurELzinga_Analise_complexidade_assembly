	.file	"Program_for_array_left_rotation_by_d_positions..c"
	.text
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
	jle	.L1
	movq	%rcx, %rbx
	leal	-1(%rdx), %eax
	leaq	4(%rcx,%rax,4), %rdi
	leaq	.LC0(%rip), %rsi
.L3:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	addq	$4, %rbx
	cmpq	%rdi, %rbx
	jne	.L3
.L1:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	gcd
	.def	gcd;	.scl	2;	.type	32;	.endef
	.seh_proc	gcd
gcd:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %eax
	movl	%edx, %ecx
	testl	%edx, %edx
	jne	.L7
.L6:
	addq	$40, %rsp
	ret
.L7:
	cltd
	idivl	%ecx
	call	gcd
	jmp	.L6
	.seh_endproc
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
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
	movl	%edx, %eax
	movl	%r8d, %ebx
	cltd
	idivl	%r8d
	movl	%edx, %ecx
	movl	%edx, %edi
	movl	%r8d, %edx
	call	gcd
	testl	%eax, %eax
	jle	.L8
	leal	-1(%rax), %r10d
	movl	$0, %r8d
	jmp	.L13
.L11:
	movslq	%edx, %rdx
	movl	%r9d, (%rsi,%rdx,4)
	leaq	1(%r8), %rax
	cmpq	%r10, %r8
	je	.L8
	movq	%rax, %r8
.L13:
	movl	%r8d, %edx
	movl	(%rsi,%r8,4), %r9d
.L12:
	leal	(%rdx,%rdi), %eax
	movl	%eax, %ecx
	subl	%ebx, %ecx
	cmpl	%eax, %ebx
	cmovle	%ecx, %eax
	cmpl	%r8d, %eax
	je	.L11
	movslq	%eax, %rcx
	movl	(%rsi,%rcx,4), %ecx
	movslq	%edx, %rdx
	movl	%ecx, (%rsi,%rdx,4)
	movl	%eax, %edx
	jmp	.L12
.L8:
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
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movl	$1, 32(%rsp)
	movl	$2, 36(%rsp)
	movl	$3, 40(%rsp)
	movl	$4, 44(%rsp)
	movl	$5, 48(%rsp)
	movl	$6, 52(%rsp)
	movl	$7, 56(%rsp)
	leaq	32(%rsp), %rbx
	movl	$7, %r8d
	movl	$2, %edx
	movq	%rbx, %rcx
	call	leftRotate
	movl	$7, %edx
	movq	%rbx, %rcx
	call	printArray
	call	getchar
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
