	.file	"Rotate_bits_of_a_number_2.c"
	.text
	.globl	leftRotate
	.def	leftRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	leftRotate
leftRotate:
	.seh_endprologue
	movl	%ecx, %eax
	movl	%edx, %ecx
	rolw	%cl, %ax
	ret
	.seh_endproc
	.globl	rightRotate
	.def	rightRotate;	.scl	2;	.type	32;	.endef
	.seh_proc	rightRotate
rightRotate:
	.seh_endprologue
	movl	%ecx, %eax
	movl	%edx, %ecx
	rorw	%cl, %ax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$112, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$7, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
