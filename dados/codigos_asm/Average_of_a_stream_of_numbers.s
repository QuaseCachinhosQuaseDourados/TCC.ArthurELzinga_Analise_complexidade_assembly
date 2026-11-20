	.file	"Average_of_a_stream_of_numbers.c"
	.text
	.globl	getAvg
	.def	getAvg;	.scl	2;	.type	32;	.endef
	.seh_proc	getAvg
getAvg:
	.seh_endprologue
	addl	sum.3222(%rip), %ecx
	movl	%ecx, sum.3222(%rip)
	movl	n.3223(%rip), %eax
	addl	$1, %eax
	movl	%eax, n.3223(%rip)
	pxor	%xmm0, %xmm0
	cvtsi2ss	%ecx, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2ss	%eax, %xmm1
	divss	%xmm1, %xmm0
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Average of %d numbers is %f \12\0"
	.text
	.globl	streamAvg
	.def	streamAvg;	.scl	2;	.type	32;	.endef
	.seh_proc	streamAvg
streamAvg:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rdi
	testl	%edx, %edx
	jle	.L2
	leal	-1(%rdx), %esi
	addq	$2, %rsi
	movl	$1, %ebx
	leaq	.LC0(%rip), %rbp
.L4:
	cvttss2si	-4(%rdi,%rbx,4), %ecx
	call	getAvg
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movq	%xmm1, %r8
	movapd	%xmm1, %xmm2
	movl	%ebx, %edx
	movq	%rbp, %rcx
	call	printf
	addq	$1, %rbx
	cmpq	%rsi, %rbx
	jne	.L4
.L2:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	movl	$0x41200000, 32(%rsp)
	movl	$0x41a00000, 36(%rsp)
	movl	$0x41f00000, 40(%rsp)
	movl	$0x42200000, 44(%rsp)
	movl	$0x42480000, 48(%rsp)
	movl	$0x42700000, 52(%rsp)
	leaq	32(%rsp), %rcx
	movl	$6, %edx
	call	streamAvg
	movl	$0, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
.lcomm n.3223,4,4
.lcomm sum.3222,4,4
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
