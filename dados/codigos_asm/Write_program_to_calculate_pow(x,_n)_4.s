	.file	"Write_program_to_calculate_pow(x,_n)_4.c"
	.text
	.globl	power
	.def	power;	.scl	2;	.type	32;	.endef
	.seh_proc	power
power:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	movaps	%xmm0, %xmm6
	movl	%edx, %ebx
	movss	.LC0(%rip), %xmm0
	testl	%edx, %edx
	jne	.L6
.L1:
	movaps	32(%rsp), %xmm6
	addq	$48, %rsp
	popq	%rbx
	ret
.L6:
	shrl	$31, %edx
	addl	%ebx, %edx
	sarl	%edx
	movaps	%xmm6, %xmm0
	call	power
	testb	$1, %bl
	je	.L7
	testl	%ebx, %ebx
	jle	.L4
	mulss	%xmm0, %xmm6
	mulss	%xmm6, %xmm0
	jmp	.L1
.L7:
	mulss	%xmm0, %xmm0
	jmp	.L1
.L4:
	mulss	%xmm0, %xmm0
	divss	%xmm6, %xmm0
	jmp	.L1
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "%f\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$-3, %edx
	movss	.LC1(%rip), %xmm0
	call	power
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rdx
	movapd	%xmm2, %xmm1
	leaq	.LC2(%rip), %rcx
	call	printf
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
	.long	1073741824
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
