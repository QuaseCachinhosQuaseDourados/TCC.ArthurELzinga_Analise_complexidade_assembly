	.file	"Rotate_bits_of_a_number.c"
	.text
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
	.seh_endprologue
	movl	%ecx, %r8d
	movl	$32, %ecx
	subl	%edx, %ecx
	movl	%r8d, %eax
	sarl	%cl, %eax
	movl	%edx, %ecx
	sall	%cl, %r8d
	orl	%r8d, %eax
	ret
	.seh_endproc
	.globl	rightRotate
	.def	rightRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightRotate
rightRotate:
	.seh_endprologue
	movl	%ecx, %r8d
	movl	$32, %ecx
	subl	%edx, %ecx
	movl	%r8d, %eax
	sall	%cl, %eax
	movl	%edx, %ecx
	sarl	%cl, %r8d
	orl	%r8d, %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Left Rotation of %d by %d is \0"
.LC1:
	.ascii "%d\0"
	.align 8
.LC2:
	.ascii "\12Right Rotation of %d by %d is \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$2, %r8d
	movl	$16, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$64, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$2, %r8d
	movl	$16, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	$4, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
