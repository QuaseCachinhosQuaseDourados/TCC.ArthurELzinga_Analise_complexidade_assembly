	.file	"Sort_a_nearly_sorted_(or_K_sorted)_array.c"
	.text
	.globl	insertionSort
	.def	insertionSort;	.scl	2;	.type	32;	.endef
	.seh_proc	insertionSort
insertionSort:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	cmpl	$1, %edx
	jle	.L1
	leaq	4(%rcx), %r11
	leal	-2(%rdx), %ebx
	movl	$0, %r10d
	jmp	.L5
.L6:
	movl	$-1, %edx
.L3:
	movslq	%edx, %rdx
	movl	%r9d, 4(%rcx,%rdx,4)
	leaq	1(%r10), %rax
	addq	$4, %r11
	cmpq	%rbx, %r10
	je	.L1
	movq	%rax, %r10
.L5:
	movl	(%r11), %r9d
	movl	%r10d, %edx
	testl	%r10d, %r10d
	js	.L3
	movl	-4(%r11), %r8d
	cmpl	%r8d, %r9d
	jge	.L3
	movq	%r11, %rax
.L4:
	movl	%r8d, (%rax)
	subl	$1, %edx
	cmpl	$-1, %edx
	je	.L6
	subq	$4, %rax
	movl	-4(%rax), %r8d
	cmpl	%r9d, %r8d
	jg	.L4
	jmp	.L3
.L1:
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
