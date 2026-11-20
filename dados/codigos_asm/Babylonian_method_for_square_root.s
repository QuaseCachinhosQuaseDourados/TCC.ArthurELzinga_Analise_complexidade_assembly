	.file	"Babylonian_method_for_square_root.c"
	.text
	.globl	squareRoot
	.def	squareRoot;	.scl	2;	.type	32;	.endef
	.seh_proc	squareRoot
squareRoot:
	.seh_endprologue
	movaps	%xmm0, %xmm3
	movaps	%xmm0, %xmm2
	subss	.LC0(%rip), %xmm2
	movss	.LC0(%rip), %xmm1
	movss	.LC2(%rip), %xmm4
	comiss	.LC1(%rip), %xmm2
	jbe	.L1
.L4:
	addss	%xmm1, %xmm0
	mulss	%xmm4, %xmm0
	movaps	%xmm3, %xmm1
	divss	%xmm0, %xmm1
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	comiss	.LC1(%rip), %xmm2
	ja	.L4
.L1:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC4:
	.ascii "Square root of %d is %f\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movss	.LC3(%rip), %xmm0
	call	squareRoot
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movq	%xmm1, %r8
	movapd	%xmm1, %xmm2
	movl	$50, %edx
	leaq	.LC4(%rip), %rcx
	call	printf
	call	getchar
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1065353216
	.align 4
.LC1:
	.long	897988541
	.align 4
.LC2:
	.long	1056964608
	.align 4
.LC3:
	.long	1112014848
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
