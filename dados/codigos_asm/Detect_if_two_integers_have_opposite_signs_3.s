	.file	"Detect_if_two_integers_have_opposite_signs_3.c"
	.text
	.globl	booloppositeSigns
	.def	booloppositeSigns;	.scl	2;	.type	32;	.endef
	.seh_proc	booloppositeSigns
booloppositeSigns:
	.seh_endprologue
	xorl	%edx, %ecx
	movl	%ecx, %eax
	sarl	$31, %eax
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
