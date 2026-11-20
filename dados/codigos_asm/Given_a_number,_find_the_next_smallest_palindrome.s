	.file	"Given_a_number,_find_the_next_smallest_palindrome.c"
	.text
	.globl	isPalindrome
	.def	isPalindrome;	.scl	2;	.type	32;	.endef
	.seh_proc	isPalindrome
isPalindrome:
	.seh_endprologue
	testl	%ecx, %ecx
	je	.L4
	movl	%ecx, %r8d
	movl	$0, %eax
	movl	$1717986919, %r10d
.L3:
	leal	(%rax,%rax,4), %r9d
	movl	%r8d, %eax
	imull	%r10d
	sarl	$2, %edx
	movl	%r8d, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %r8d
	leal	(%r8,%r9,2), %eax
	movl	%edx, %r8d
	testl	%edx, %edx
	jne	.L3
.L2:
	cmpl	%eax, %ecx
	sete	%al
	movzbl	%al, %eax
	ret
.L4:
	movl	%ecx, %eax
	jmp	.L2
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Next palindrome number is %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movl	$9687, %ebx
.L7:
	movl	%ebx, %ecx
	call	isPalindrome
	testl	%eax, %eax
	jne	.L9
	addl	$1, %ebx
	jmp	.L7
.L9:
	movl	%ebx, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
