	.file	"Merge_Sort_for_Doubly_Linked_List.c"
	.text
	.globl	merge
	.def	merge;	.scl	2;	.type	32;	.endef
	.seh_proc	merge
merge:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	testq	%rcx, %rcx
	je	.L4
	testq	%rdx, %rdx
	je	.L5
	movl	(%rdx), %eax
	cmpl	%eax, (%rcx)
	jge	.L3
	movq	8(%rcx), %rcx
	call	merge
	movq	%rax, 8(%rsi)
	movq	%rsi, 16(%rax)
	movq	$0, 16(%rsi)
	movq	%rsi, %rax
.L1:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L3:
	movq	8(%rdx), %rdx
	call	merge
	movq	%rax, 8(%rbx)
	movq	%rbx, 16(%rax)
	movq	$0, 16(%rbx)
	movq	%rbx, %rax
	jmp	.L1
.L4:
	movq	%rdx, %rax
	jmp	.L1
.L5:
	movq	%rcx, %rax
	jmp	.L1
	.seh_endproc
	.globl	insert
	.def	insert;	.scl	2;	.type	32;	.endef
	.seh_proc	insert
insert:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%edx, %esi
	movl	$24, %ecx
	call	malloc
	movl	%esi, (%rax)
	movq	$0, 16(%rax)
	movq	$0, 8(%rax)
	movq	(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L9
	movq	%rdx, 8(%rax)
	movq	%rax, 16(%rdx)
	movq	%rax, (%rbx)
.L6:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L9:
	movq	%rax, (%rbx)
	jmp	.L6
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Forward Traversal using next pointer\0"
.LC1:
	.ascii "%d \0"
	.align 8
.LC2:
	.ascii "\12Backward Traversal using prev pointer\0"
	.text
	.globl	print
	.def	print;	.scl	2;	.type	32;	.endef
	.seh_proc	print
print:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	leaq	.LC0(%rip), %rcx
	call	puts
	testq	%rbx, %rbx
	je	.L11
	leaq	.LC1(%rip), %rsi
	jmp	.L12
.L16:
	movq	%rax, %rbx
.L12:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	8(%rbx), %rax
	testq	%rax, %rax
	jne	.L16
	leaq	.LC2(%rip), %rcx
	call	puts
	leaq	.LC1(%rip), %rsi
.L14:
	movl	(%rbx), %edx
	movq	%rsi, %rcx
	call	printf
	movq	16(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L14
.L10:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L11:
	leaq	.LC2(%rip), %rcx
	call	puts
	jmp	.L10
	.seh_endproc
	.globl	swap
	.def	swap;	.scl	2;	.type	32;	.endef
	.seh_proc	swap
swap:
	.seh_endprologue
	movl	(%rcx), %eax
	movl	(%rdx), %r8d
	movl	%r8d, (%rcx)
	movl	%eax, (%rdx)
	ret
	.seh_endproc
	.globl	split
	.def	split;	.scl	2;	.type	32;	.endef
	.seh_proc	split
split:
	.seh_endprologue
	movq	8(%rcx), %rax
	testq	%rax, %rax
	je	.L21
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L21
.L22:
	movq	8(%rcx), %rcx
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L21
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L22
.L21:
	movq	8(%rcx), %rax
	movq	$0, 8(%rcx)
	ret
	.seh_endproc
	.globl	mergeSort
	.def	mergeSort;	.scl	2;	.type	32;	.endef
	.seh_proc	mergeSort
mergeSort:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L26
	movq	%rcx, %rax
	cmpq	$0, 8(%rcx)
	je	.L24
	call	split
	movq	%rax, %rsi
	movq	%rbx, %rcx
	call	mergeSort
	movq	%rax, %rbx
	movq	%rsi, %rcx
	call	mergeSort
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	merge
.L24:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L26:
	movq	%rcx, %rax
	jmp	.L24
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC3:
	.ascii "\12\12Linked List after sorting\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %rbx
	movl	$5, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$20, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$4, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$3, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$30, %edx
	movq	%rbx, %rcx
	call	insert
	movl	$10, %edx
	movq	%rbx, %rcx
	call	insert
	movq	40(%rsp), %rcx
	call	mergeSort
	movq	%rax, 40(%rsp)
	leaq	.LC3(%rip), %rcx
	call	puts
	movq	40(%rsp), %rcx
	call	print
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
