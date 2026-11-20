	.file	"Swap_two_nibbles_in_a_byte.c"
	.text
	.globl	swapNibbles
	.def	swapNibbles;	.scl	2;	.type	32;	.endef
	.seh_proc	swapNibbles
swapNibbles:
	.seh_endprologue
	movl	%ecx, %eax
	rolb	$4, %al
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%u\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$70, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
