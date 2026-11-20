	.file	"Overlapping_Subproblems_Property_in_Dynamic_Programming_DP-1.c"
	.text
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	movl	%ecx, %eax
	cmpl	$1, %ecx
	jle	.L1
	leal	-1(%rcx), %ecx
	call	fib
	movl	%eax, %esi
	leal	-2(%rbx), %ecx
	call	fib
	addl	%esi, %eax
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
