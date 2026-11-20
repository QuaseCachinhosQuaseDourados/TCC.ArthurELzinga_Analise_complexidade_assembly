	.file	"Turn_off_the_rightmost_set_bit.c"
	.text
	.globl	fun
	.def	fun;	.scl	2;	.type	32;	.endef
	.seh_proc	fun
fun:
	.seh_endprologue
	leal	-1(%rcx), %eax
	andl	%ecx, %eax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "The number after unsetting the\0"
.LC1:
	.ascii " rightmost set bit %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$6, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
