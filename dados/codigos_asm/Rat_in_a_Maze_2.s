	.file	"Rat_in_a_Maze_2.c"
	.text
	.globl	solve
	.def	solve;	.scl	2;	.type	32;	.endef
	.seh_proc	solve
solve:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
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
	subq	$120, %rsp
	.seh_stackalloc	120
	.seh_endprologue
	movl	%ecx, %esi
	movl	%edx, %r12d
	movq	%r8, 208(%rsp)
	movl	%r9d, %r14d
	movq	240(%rsp), %rbp
	movq	248(%rsp), %r13
	leal	-1(%r9), %eax
	cmpl	%edx, %eax
	jne	.L2
	cmpl	%ecx, %eax
	je	.L7
.L2:
	movl	$1431456836, 107(%rsp)
	movb	$0, 111(%rsp)
	movslq	%esi, %rax
	imulq	$400, %rax, %rax
	movl	$0, %ebx
	movslq	%r12d, %rdx
	leaq	(%rax,%rdx,4), %r15
	jmp	.L5
.L7:
	movq	264(%rsp), %rax
	movslq	(%rax), %rcx
	addq	224(%rsp), %rcx
	movq	232(%rsp), %rdx
	call	strcpy
	movq	$-1, %rcx
	movl	$0, %eax
	movq	232(%rsp), %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	movq	264(%rsp), %rdi
	movl	(%rdi), %edx
	leal	-1(%rdx,%rax), %eax
	leal	1(%rax), %edx
	movl	%edx, (%rdi)
	cltq
	movq	224(%rsp), %rdi
	movb	$32, (%rdi,%rax)
.L1:
	addq	$120, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L8:
	movq	%r15, %rax
	addq	256(%rsp), %rax
	movq	%rax, 88(%rsp)
	movl	$1, (%rax)
	movq	$-1, %rcx
	movq	232(%rsp), %rdi
	movl	$0, %eax
	repnz scasb
	notq	%rcx
	movzbl	107(%rsp,%rbx), %eax
	movq	232(%rsp), %r11
	movb	%al, -1(%r11,%rcx)
	movq	264(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	movq	256(%rsp), %rcx
	movq	%rcx, 64(%rsp)
	movq	%r13, 56(%rsp)
	movq	%rbp, 48(%rsp)
	movq	%r11, 40(%rsp)
	movq	224(%rsp), %rcx
	movq	%rcx, 32(%rsp)
	movl	%r14d, %r9d
	movq	208(%rsp), %r8
	movl	%r10d, %ecx
	call	solve
	movq	88(%rsp), %rdi
	movl	$0, (%rdi)
	movq	$-1, %rcx
	movq	232(%rsp), %rdi
	movl	$0, %eax
	repnz scasb
	notq	%rcx
	movq	232(%rsp), %rax
	movb	$0, -2(%rax,%rcx)
.L4:
	addq	$1, %rbx
	cmpq	$4, %rbx
	je	.L1
.L5:
	movl	%r12d, %edx
	addl	0(%r13,%rbx,4), %edx
	movl	%esi, %r10d
	addl	0(%rbp,%rbx,4), %r10d
	js	.L4
	testl	%edx, %edx
	js	.L4
	cmpl	%edx, %r10d
	movl	%edx, %eax
	cmovge	%r10d, %eax
	cmpl	%r14d, %eax
	jge	.L4
	movslq	%r10d, %rax
	imulq	$400, %rax, %rax
	movslq	%edx, %rcx
	movq	256(%rsp), %rdi
	leaq	(%rdi,%rcx,4), %rcx
	cmpl	$0, (%rcx,%rax)
	jne	.L4
	movslq	%edx, %rcx
	movq	208(%rsp), %rdi
	leaq	(%rdi,%rcx,4), %rcx
	cmpl	$1, (%rcx,%rax)
	jne	.L4
	jmp	.L8
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "-1\0"
	.text
	.globl	findPath
	.def	findPath;	.scl	2;	.type	32;	.endef
	.seh_proc	findPath
findPath:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	movl	$60136, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	60136
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	movl	$0, 50124(%rsp)
	movl	$1, 40096(%rsp)
	movl	$0, 40100(%rsp)
	movl	$0, 40104(%rsp)
	movl	$-1, 40108(%rsp)
	movl	$0, 40080(%rsp)
	movl	$-1, 40084(%rsp)
	movl	$1, 40088(%rsp)
	movl	$0, 40092(%rsp)
	leaq	80(%rsp), %rcx
	movl	$40000, %r8d
	movl	$0, %edx
	call	memset
	cmpl	$1, (%rbx)
	je	.L13
.L10:
	leaq	.LC0(%rip), %rcx
	call	puts
	nop
.L9:
	addq	$60136, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L13:
	leaq	50124(%rsp), %rax
	movq	%rax, 72(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 64(%rsp)
	leaq	40080(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	40096(%rsp), %rax
	movq	%rax, 48(%rsp)
	leaq	40112(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	50128(%rsp), %rax
	movq	%rax, 32(%rsp)
	movl	%esi, %r9d
	movq	%rbx, %r8
	movl	$0, %edx
	movl	$0, %ecx
	call	solve
	movl	50124(%rsp), %eax
	testl	%eax, %eax
	je	.L10
	subl	$1, %eax
	cltq
	movb	$0, 50128(%rsp,%rax)
	leaq	50128(%rsp), %rcx
	call	puts
	jmp	.L9
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	movl	$40032, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	40032
	.seh_endprologue
	call	__main
	leaq	32(%rsp), %rbx
	movl	$40000, %r8d
	movl	$0, %edx
	movq	%rbx, %rcx
	call	memset
	movl	$1, 32(%rsp)
	movl	$1, 432(%rsp)
	movl	$1, 436(%rsp)
	movl	$1, 444(%rsp)
	movl	$1, 832(%rsp)
	movl	$1, 836(%rsp)
	movl	$1, 1236(%rsp)
	movl	$1, 1240(%rsp)
	movl	$1, 1244(%rsp)
	movl	$4, %edx
	movq	%rbx, %rcx
	call	findPath
	movl	$0, %eax
	addq	$40032, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	strcpy;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
