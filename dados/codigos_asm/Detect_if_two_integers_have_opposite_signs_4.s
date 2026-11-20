	.file	"Detect_if_two_integers_have_opposite_signs_4.c"
	.text
	.globl	booloppositeSigns
	.def	booloppositeSigns;	.scl	2;	.type	32;	.endef
	.seh_proc	booloppositeSigns
booloppositeSigns:
	.seh_endprologue
	movslq	%ecx, %rcx
	movslq	%edx, %rax
	imulq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$63, %rax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Signs are opposite\0"
.LC1:
	.ascii "Signs are not opposite\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$-100, %edx
	movl	$100, %ecx
	call	oppositeSigns
	cmpl	$1, %eax
	je	.L5
	leaq	.LC1(%rip), %rcx
	call	printf
.L4:
	movl	$0, %eax
	addq	$40, %rsp
	ret
.L5:
	leaq	.LC0(%rip), %rcx
	call	printf
	jmp	.L4
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	oppositeSigns;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
