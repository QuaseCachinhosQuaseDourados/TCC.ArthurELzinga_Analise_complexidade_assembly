	.file	"Detect_if_two_integers_have_opposite_signs_2.c"
	.text
	.globl	booloppositeSigns
	.def	booloppositeSigns;	.scl	2;	.type	32;	.endef
	.seh_proc	booloppositeSigns
booloppositeSigns:
	.seh_endprologue
	movl	%edx, %eax
	shrl	$31, %eax
	notl	%edx
	shrl	$31, %edx
	testl	%ecx, %ecx
	cmovs	%edx, %eax
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
