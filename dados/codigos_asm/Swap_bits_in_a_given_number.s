	.file	"Swap_bits_in_a_given_number.c"
	.text
	.globl	swapBits
	.def	swapBits;	.scl	2;	.type	32;	.endef
	.seh_proc	swapBits
swapBits:
	.seh_endprologue
	movl	%ecx, %eax
	movl	%ecx, %r10d
	movl	%edx, %ecx
	shrl	%cl, %r10d
	movl	%eax, %r11d
	movl	%r8d, %ecx
	shrl	%cl, %r11d
	xorl	%r11d, %r10d
	movl	$-1, %r11d
	movl	%r9d, %ecx
	sall	%cl, %r11d
	movl	%r11d, %r9d
	notl	%r9d
	andl	%r10d, %r9d
	movl	%r9d, %r10d
	movl	%edx, %ecx
	sall	%cl, %r10d
	movl	%r8d, %ecx
	sall	%cl, %r9d
	orl	%r10d, %r9d
	xorl	%r9d, %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\12Result = %d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$7, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
