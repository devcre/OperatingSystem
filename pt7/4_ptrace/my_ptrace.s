	.file	"my_ptrace.c"
	.text
.Ltext0:
	.comm	regs,216,32
	.section	.rodata
.LC0:
	.string	"ls"
.LC1:
	.string	"/bin/ls"
.LC2:
	.string	"Fork failed."
.LC3:
	.string	"[SYSCALL]:%-20s\t%5lld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.file 1 "my_ptrace.c"
	.loc 1 18 0
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	.loc 1 18 0
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	.loc 1 19 0
	call	fork
	movl	%eax, -28(%rbp)
	.loc 1 20 0
	cmpl	$0, -28(%rbp)
	jne	.L2
	.loc 1 22 0
	movl	$0, %ecx
	movl	$0, %edx
	movl	$0, %esi
	movl	$0, %edi
	movl	$0, %eax
	call	ptrace
	.loc 1 23 0
	movl	$0, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	execl
	jmp	.L3
.L2:
	.loc 1 25 0
	cmpl	$0, -28(%rbp)
	jns	.L5
	.loc 1 26 0
	movl	$.LC2, %edi
	call	puts
	jmp	.L3
.L7:
.LBB2:
.LBB3:
	.loc 1 32 0
	movl	-28(%rbp), %eax
	movl	$regs, %ecx
	movl	$0, %edx
	movl	%eax, %esi
	movl	$12, %edi
	movl	$0, %eax
	call	ptrace
	.loc 1 33 0
	movq	regs+120(%rip), %rbx
	.loc 1 33 0
	movq	regs+120(%rip), %rax
	.loc 1 33 0
	movq	%rax, %rdi
	call	get_syscode
	movq	%rax, %rdx
	movq	stderr(%rip), %rax
	movq	%rbx, %rcx
	movl	$.LC3, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	.loc 1 35 0
	movl	-28(%rbp), %eax
	movl	$0, %ecx
	movl	$0, %edx
	movl	%eax, %esi
	movl	$24, %edi
	movl	$0, %eax
	call	ptrace
.L5:
	.loc 1 30 0
	leaq	-32(%rbp), %rcx
	movl	-28(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	waitpid
	testl	%eax, %eax
	je	.L3
	.loc 1 30 0 discriminator 1
	movl	-32(%rbp), %eax
	movl	%eax, -48(%rbp)
	.loc 1 30 0 discriminator 1
	movl	-48(%rbp), %eax
	andl	$127, %eax
	.loc 1 30 0 discriminator 1
	testl	%eax, %eax
	jne	.L7
.L3:
.LBE3:
.LBE2:
	.loc 1 38 0
	movl	$0, %eax
	.loc 1 39 0
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L9
	call	__stack_chk_fail
.L9:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC4:
	.string	"SYS_read"
.LC5:
	.string	"SYS_write"
.LC6:
	.string	"SYS_open"
.LC7:
	.string	"SYS_close"
.LC8:
	.string	"SYS_fstat"
.LC9:
	.string	"SYS_mmap"
.LC10:
	.string	"SYS_mprotect"
.LC11:
	.string	"SYS_munmap"
.LC12:
	.string	"SYS_brk"
.LC13:
	.string	"SYS_rt_sigaction"
.LC14:
	.string	"SYS_rt_sigprocmask"
.LC15:
	.string	"SYS_rt_sigreturn"
.LC16:
	.string	"SYS_ioctl"
.LC17:
	.string	"SYS_getpid"
.LC18:
	.string	"SYS_pread64"
.LC19:
	.string	"SYS_access"
.LC20:
	.string	"SYS_pipe"
.LC21:
	.string	"SYS_execve"
.LC22:
	.string	"SYS_getdents"
.LC23:
	.string	"SYS_statfs"
.LC24:
	.string	"SYS_exit_group"
.LC25:
	.string	"SYS_openat"
.LC26:
	.string	"SYS_mkdirat"
.LC27:
	.string	"SYS_prlimit64"
.LC28:
	.string	"SYS_arch_prctl"
.LC29:
	.string	"SYS_set_tid_address"
.LC30:
	.string	"SYS_set_robust_list"
	.align 8
.LC31:
	.string	"Not registered in the function list."
	.text
	.globl	get_syscode
	.type	get_syscode, @function
get_syscode:
.LFB3:
	.loc 1 41 0
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	.loc 1 42 0
	movq	-8(%rbp), %rax
	cmpq	$17, %rax
	je	.L12
	cmpq	$17, %rax
	jg	.L13
	cmpq	$10, %rax
	je	.L14
	cmpq	$10, %rax
	jg	.L15
	cmpq	$2, %rax
	je	.L16
	cmpq	$2, %rax
	jg	.L17
	testq	%rax, %rax
	je	.L18
	cmpq	$1, %rax
	je	.L19
	jmp	.L11
.L17:
	cmpq	$5, %rax
	je	.L20
	cmpq	$9, %rax
	je	.L21
	cmpq	$3, %rax
	je	.L22
	jmp	.L11
.L15:
	cmpq	$13, %rax
	je	.L23
	cmpq	$13, %rax
	jg	.L24
	cmpq	$11, %rax
	je	.L25
	cmpq	$12, %rax
	je	.L26
	jmp	.L11
.L24:
	cmpq	$15, %rax
	je	.L27
	cmpq	$15, %rax
	jg	.L28
	jmp	.L47
.L13:
	cmpq	$158, %rax
	je	.L30
	cmpq	$158, %rax
	jg	.L31
	cmpq	$39, %rax
	je	.L32
	cmpq	$39, %rax
	jg	.L33
	cmpq	$21, %rax
	je	.L34
	cmpq	$22, %rax
	je	.L35
	jmp	.L11
.L33:
	cmpq	$78, %rax
	je	.L36
	cmpq	$137, %rax
	je	.L37
	cmpq	$59, %rax
	je	.L38
	jmp	.L11
.L31:
	cmpq	$257, %rax
	je	.L39
	cmpq	$257, %rax
	jg	.L40
	cmpq	$218, %rax
	je	.L41
	cmpq	$231, %rax
	je	.L42
	jmp	.L11
.L40:
	cmpq	$273, %rax
	je	.L43
	cmpq	$302, %rax
	je	.L44
	cmpq	$258, %rax
	je	.L45
	jmp	.L11
.L18:
	.loc 1 43 0
	movl	$.LC4, %eax
	jmp	.L46
.L19:
	.loc 1 44 0
	movl	$.LC5, %eax
	jmp	.L46
.L16:
	.loc 1 45 0
	movl	$.LC6, %eax
	jmp	.L46
.L22:
	.loc 1 46 0
	movl	$.LC7, %eax
	jmp	.L46
.L20:
	.loc 1 47 0
	movl	$.LC8, %eax
	jmp	.L46
.L21:
	.loc 1 48 0
	movl	$.LC9, %eax
	jmp	.L46
.L14:
	.loc 1 49 0
	movl	$.LC10, %eax
	jmp	.L46
.L25:
	.loc 1 50 0
	movl	$.LC11, %eax
	jmp	.L46
.L26:
	.loc 1 51 0
	movl	$.LC12, %eax
	jmp	.L46
.L23:
	.loc 1 52 0
	movl	$.LC13, %eax
	jmp	.L46
.L47:
	.loc 1 53 0
	movl	$.LC14, %eax
	jmp	.L46
.L27:
	.loc 1 54 0
	movl	$.LC15, %eax
	jmp	.L46
.L28:
	.loc 1 55 0
	movl	$.LC16, %eax
	jmp	.L46
.L32:
	.loc 1 56 0
	movl	$.LC17, %eax
	jmp	.L46
.L12:
	.loc 1 57 0
	movl	$.LC18, %eax
	jmp	.L46
.L34:
	.loc 1 58 0
	movl	$.LC19, %eax
	jmp	.L46
.L35:
	.loc 1 59 0
	movl	$.LC20, %eax
	jmp	.L46
.L38:
	.loc 1 60 0
	movl	$.LC21, %eax
	jmp	.L46
.L36:
	.loc 1 61 0
	movl	$.LC22, %eax
	jmp	.L46
.L37:
	.loc 1 62 0
	movl	$.LC23, %eax
	jmp	.L46
.L42:
	.loc 1 63 0
	movl	$.LC24, %eax
	jmp	.L46
.L39:
	.loc 1 64 0
	movl	$.LC25, %eax
	jmp	.L46
.L45:
	.loc 1 65 0
	movl	$.LC26, %eax
	jmp	.L46
.L44:
	.loc 1 66 0
	movl	$.LC27, %eax
	jmp	.L46
.L30:
	.loc 1 67 0
	movl	$.LC28, %eax
	jmp	.L46
.L41:
	.loc 1 68 0
	movl	$.LC29, %eax
	jmp	.L46
.L43:
	.loc 1 69 0
	movl	$.LC30, %eax
	jmp	.L46
.L11:
	.loc 1 71 0
	movl	$.LC31, %eax
.L46:
	.loc 1 73 0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	get_syscode, .-get_syscode
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/5/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/libio.h"
	.file 5 "/usr/include/x86_64-linux-gnu/sys/types.h"
	.file 6 "/usr/include/x86_64-linux-gnu/sys/user.h"
	.file 7 "/usr/include/stdio.h"
	.file 8 "/usr/include/x86_64-linux-gnu/sys/ptrace.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x587
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF91
	.byte	0xc
	.long	.LASF92
	.long	.LASF93
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x2
	.byte	0xd8
	.long	0x38
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0x83
	.long	0x69
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x84
	.long	0x69
	.uleb128 0x2
	.long	.LASF10
	.byte	0x3
	.byte	0x85
	.long	0x62
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF11
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0xa0
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x7
	.long	.LASF42
	.byte	0xd8
	.byte	0x4
	.byte	0xf1
	.long	0x224
	.uleb128 0x8
	.long	.LASF13
	.byte	0x4
	.byte	0xf2
	.long	0x62
	.byte	0
	.uleb128 0x8
	.long	.LASF14
	.byte	0x4
	.byte	0xf7
	.long	0x9a
	.byte	0x8
	.uleb128 0x8
	.long	.LASF15
	.byte	0x4
	.byte	0xf8
	.long	0x9a
	.byte	0x10
	.uleb128 0x8
	.long	.LASF16
	.byte	0x4
	.byte	0xf9
	.long	0x9a
	.byte	0x18
	.uleb128 0x8
	.long	.LASF17
	.byte	0x4
	.byte	0xfa
	.long	0x9a
	.byte	0x20
	.uleb128 0x8
	.long	.LASF18
	.byte	0x4
	.byte	0xfb
	.long	0x9a
	.byte	0x28
	.uleb128 0x8
	.long	.LASF19
	.byte	0x4
	.byte	0xfc
	.long	0x9a
	.byte	0x30
	.uleb128 0x8
	.long	.LASF20
	.byte	0x4
	.byte	0xfd
	.long	0x9a
	.byte	0x38
	.uleb128 0x8
	.long	.LASF21
	.byte	0x4
	.byte	0xfe
	.long	0x9a
	.byte	0x40
	.uleb128 0x9
	.long	.LASF22
	.byte	0x4
	.value	0x100
	.long	0x9a
	.byte	0x48
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.value	0x101
	.long	0x9a
	.byte	0x50
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.value	0x102
	.long	0x9a
	.byte	0x58
	.uleb128 0x9
	.long	.LASF25
	.byte	0x4
	.value	0x104
	.long	0x25c
	.byte	0x60
	.uleb128 0x9
	.long	.LASF26
	.byte	0x4
	.value	0x106
	.long	0x262
	.byte	0x68
	.uleb128 0x9
	.long	.LASF27
	.byte	0x4
	.value	0x108
	.long	0x62
	.byte	0x70
	.uleb128 0x9
	.long	.LASF28
	.byte	0x4
	.value	0x10c
	.long	0x62
	.byte	0x74
	.uleb128 0x9
	.long	.LASF29
	.byte	0x4
	.value	0x10e
	.long	0x70
	.byte	0x78
	.uleb128 0x9
	.long	.LASF30
	.byte	0x4
	.value	0x112
	.long	0x46
	.byte	0x80
	.uleb128 0x9
	.long	.LASF31
	.byte	0x4
	.value	0x113
	.long	0x54
	.byte	0x82
	.uleb128 0x9
	.long	.LASF32
	.byte	0x4
	.value	0x114
	.long	0x268
	.byte	0x83
	.uleb128 0x9
	.long	.LASF33
	.byte	0x4
	.value	0x118
	.long	0x278
	.byte	0x88
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.value	0x121
	.long	0x7b
	.byte	0x90
	.uleb128 0x9
	.long	.LASF35
	.byte	0x4
	.value	0x129
	.long	0x98
	.byte	0x98
	.uleb128 0x9
	.long	.LASF36
	.byte	0x4
	.value	0x12a
	.long	0x98
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF37
	.byte	0x4
	.value	0x12b
	.long	0x98
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF38
	.byte	0x4
	.value	0x12c
	.long	0x98
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF39
	.byte	0x4
	.value	0x12e
	.long	0x2d
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF40
	.byte	0x4
	.value	0x12f
	.long	0x62
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF41
	.byte	0x4
	.value	0x131
	.long	0x27e
	.byte	0xc4
	.byte	0
	.uleb128 0xa
	.long	.LASF94
	.byte	0x4
	.byte	0x96
	.uleb128 0x7
	.long	.LASF43
	.byte	0x18
	.byte	0x4
	.byte	0x9c
	.long	0x25c
	.uleb128 0x8
	.long	.LASF44
	.byte	0x4
	.byte	0x9d
	.long	0x25c
	.byte	0
	.uleb128 0x8
	.long	.LASF45
	.byte	0x4
	.byte	0x9e
	.long	0x262
	.byte	0x8
	.uleb128 0x8
	.long	.LASF46
	.byte	0x4
	.byte	0xa2
	.long	0x62
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x22b
	.uleb128 0x6
	.byte	0x8
	.long	0xa7
	.uleb128 0xb
	.long	0xa0
	.long	0x278
	.uleb128 0xc
	.long	0x91
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x224
	.uleb128 0xb
	.long	0xa0
	.long	0x28e
	.uleb128 0xc
	.long	0x91
	.byte	0x13
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x294
	.uleb128 0xd
	.long	0xa0
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF47
	.uleb128 0x2
	.long	.LASF48
	.byte	0x5
	.byte	0x62
	.long	0x86
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF49
	.uleb128 0xe
	.long	.LASF95
	.byte	0x4
	.long	0x4d
	.byte	0x8
	.byte	0x1c
	.long	0x390
	.uleb128 0xf
	.long	.LASF50
	.byte	0
	.uleb128 0xf
	.long	.LASF51
	.byte	0x1
	.uleb128 0xf
	.long	.LASF52
	.byte	0x2
	.uleb128 0xf
	.long	.LASF53
	.byte	0x3
	.uleb128 0xf
	.long	.LASF54
	.byte	0x4
	.uleb128 0xf
	.long	.LASF55
	.byte	0x5
	.uleb128 0xf
	.long	.LASF56
	.byte	0x6
	.uleb128 0xf
	.long	.LASF57
	.byte	0x7
	.uleb128 0xf
	.long	.LASF58
	.byte	0x8
	.uleb128 0xf
	.long	.LASF59
	.byte	0x9
	.uleb128 0xf
	.long	.LASF60
	.byte	0xc
	.uleb128 0xf
	.long	.LASF61
	.byte	0xd
	.uleb128 0xf
	.long	.LASF62
	.byte	0xe
	.uleb128 0xf
	.long	.LASF63
	.byte	0xf
	.uleb128 0xf
	.long	.LASF64
	.byte	0x10
	.uleb128 0xf
	.long	.LASF65
	.byte	0x11
	.uleb128 0xf
	.long	.LASF66
	.byte	0x12
	.uleb128 0xf
	.long	.LASF67
	.byte	0x13
	.uleb128 0xf
	.long	.LASF68
	.byte	0x18
	.uleb128 0x10
	.long	.LASF69
	.value	0x4200
	.uleb128 0x10
	.long	.LASF70
	.value	0x4201
	.uleb128 0x10
	.long	.LASF71
	.value	0x4202
	.uleb128 0x10
	.long	.LASF72
	.value	0x4203
	.uleb128 0x10
	.long	.LASF73
	.value	0x4204
	.uleb128 0x10
	.long	.LASF74
	.value	0x4205
	.uleb128 0x10
	.long	.LASF75
	.value	0x4206
	.uleb128 0x10
	.long	.LASF76
	.value	0x4207
	.uleb128 0x10
	.long	.LASF77
	.value	0x4208
	.uleb128 0x10
	.long	.LASF78
	.value	0x4209
	.uleb128 0x10
	.long	.LASF79
	.value	0x420a
	.uleb128 0x10
	.long	.LASF80
	.value	0x420b
	.uleb128 0x10
	.long	.LASF81
	.value	0x420c
	.byte	0
	.uleb128 0x7
	.long	.LASF82
	.byte	0xd8
	.byte	0x6
	.byte	0x2a
	.long	0x4d9
	.uleb128 0x11
	.string	"r15"
	.byte	0x6
	.byte	0x2c
	.long	0x2ab
	.byte	0
	.uleb128 0x11
	.string	"r14"
	.byte	0x6
	.byte	0x2d
	.long	0x2ab
	.byte	0x8
	.uleb128 0x11
	.string	"r13"
	.byte	0x6
	.byte	0x2e
	.long	0x2ab
	.byte	0x10
	.uleb128 0x11
	.string	"r12"
	.byte	0x6
	.byte	0x2f
	.long	0x2ab
	.byte	0x18
	.uleb128 0x11
	.string	"rbp"
	.byte	0x6
	.byte	0x30
	.long	0x2ab
	.byte	0x20
	.uleb128 0x11
	.string	"rbx"
	.byte	0x6
	.byte	0x31
	.long	0x2ab
	.byte	0x28
	.uleb128 0x11
	.string	"r11"
	.byte	0x6
	.byte	0x32
	.long	0x2ab
	.byte	0x30
	.uleb128 0x11
	.string	"r10"
	.byte	0x6
	.byte	0x33
	.long	0x2ab
	.byte	0x38
	.uleb128 0x11
	.string	"r9"
	.byte	0x6
	.byte	0x34
	.long	0x2ab
	.byte	0x40
	.uleb128 0x11
	.string	"r8"
	.byte	0x6
	.byte	0x35
	.long	0x2ab
	.byte	0x48
	.uleb128 0x11
	.string	"rax"
	.byte	0x6
	.byte	0x36
	.long	0x2ab
	.byte	0x50
	.uleb128 0x11
	.string	"rcx"
	.byte	0x6
	.byte	0x37
	.long	0x2ab
	.byte	0x58
	.uleb128 0x11
	.string	"rdx"
	.byte	0x6
	.byte	0x38
	.long	0x2ab
	.byte	0x60
	.uleb128 0x11
	.string	"rsi"
	.byte	0x6
	.byte	0x39
	.long	0x2ab
	.byte	0x68
	.uleb128 0x11
	.string	"rdi"
	.byte	0x6
	.byte	0x3a
	.long	0x2ab
	.byte	0x70
	.uleb128 0x8
	.long	.LASF83
	.byte	0x6
	.byte	0x3b
	.long	0x2ab
	.byte	0x78
	.uleb128 0x11
	.string	"rip"
	.byte	0x6
	.byte	0x3c
	.long	0x2ab
	.byte	0x80
	.uleb128 0x11
	.string	"cs"
	.byte	0x6
	.byte	0x3d
	.long	0x2ab
	.byte	0x88
	.uleb128 0x8
	.long	.LASF84
	.byte	0x6
	.byte	0x3e
	.long	0x2ab
	.byte	0x90
	.uleb128 0x11
	.string	"rsp"
	.byte	0x6
	.byte	0x3f
	.long	0x2ab
	.byte	0x98
	.uleb128 0x11
	.string	"ss"
	.byte	0x6
	.byte	0x40
	.long	0x2ab
	.byte	0xa0
	.uleb128 0x8
	.long	.LASF85
	.byte	0x6
	.byte	0x41
	.long	0x2ab
	.byte	0xa8
	.uleb128 0x8
	.long	.LASF86
	.byte	0x6
	.byte	0x42
	.long	0x2ab
	.byte	0xb0
	.uleb128 0x11
	.string	"ds"
	.byte	0x6
	.byte	0x43
	.long	0x2ab
	.byte	0xb8
	.uleb128 0x11
	.string	"es"
	.byte	0x6
	.byte	0x44
	.long	0x2ab
	.byte	0xc0
	.uleb128 0x11
	.string	"fs"
	.byte	0x6
	.byte	0x45
	.long	0x2ab
	.byte	0xc8
	.uleb128 0x11
	.string	"gs"
	.byte	0x6
	.byte	0x46
	.long	0x2ab
	.byte	0xd0
	.byte	0
	.uleb128 0x12
	.long	.LASF96
	.byte	0x1
	.byte	0x12
	.long	0x62
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x53a
	.uleb128 0x13
	.long	.LASF87
	.byte	0x1
	.byte	0x13
	.long	0x2a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x14
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x13
	.long	.LASF88
	.byte	0x1
	.byte	0x1d
	.long	0x62
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x15
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.byte	0
	.byte	0
	.uleb128 0x16
	.long	.LASF97
	.byte	0x1
	.byte	0x29
	.long	0x28e
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x56a
	.uleb128 0x17
	.long	.LASF98
	.byte	0x1
	.byte	0x29
	.long	0x69
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x18
	.long	.LASF89
	.byte	0x7
	.byte	0xaa
	.long	0x262
	.uleb128 0x19
	.long	.LASF90
	.byte	0x1
	.byte	0x10
	.long	0x390
	.uleb128 0x9
	.byte	0x3
	.quad	regs
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF93:
	.string	"/home/hermit/Codes/OS/pt7/4_ptrace"
.LASF57:
	.string	"PTRACE_CONT"
.LASF29:
	.string	"_old_offset"
.LASF82:
	.string	"user_regs_struct"
.LASF18:
	.string	"_IO_write_ptr"
.LASF51:
	.string	"PTRACE_PEEKTEXT"
.LASF24:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"size_t"
.LASF11:
	.string	"sizetype"
.LASF84:
	.string	"eflags"
.LASF34:
	.string	"_offset"
.LASF78:
	.string	"PTRACE_PEEKSIGINFO"
.LASF10:
	.string	"__pid_t"
.LASF2:
	.string	"short unsigned int"
.LASF95:
	.string	"__ptrace_request"
.LASF96:
	.string	"main"
.LASF20:
	.string	"_IO_buf_base"
.LASF86:
	.string	"gs_base"
.LASF25:
	.string	"_markers"
.LASF15:
	.string	"_IO_read_end"
.LASF58:
	.string	"PTRACE_KILL"
.LASF52:
	.string	"PTRACE_PEEKDATA"
.LASF63:
	.string	"PTRACE_SETFPREGS"
.LASF76:
	.string	"PTRACE_INTERRUPT"
.LASF55:
	.string	"PTRACE_POKEDATA"
.LASF43:
	.string	"_IO_marker"
.LASF47:
	.string	"long long int"
.LASF75:
	.string	"PTRACE_SEIZE"
.LASF33:
	.string	"_lock"
.LASF6:
	.string	"long int"
.LASF74:
	.string	"PTRACE_SETREGSET"
.LASF30:
	.string	"_cur_column"
.LASF68:
	.string	"PTRACE_SYSCALL"
.LASF79:
	.string	"PTRACE_GETSIGMASK"
.LASF71:
	.string	"PTRACE_GETSIGINFO"
.LASF56:
	.string	"PTRACE_POKEUSER"
.LASF66:
	.string	"PTRACE_GETFPXREGS"
.LASF50:
	.string	"PTRACE_TRACEME"
.LASF45:
	.string	"_sbuf"
.LASF42:
	.string	"_IO_FILE"
.LASF1:
	.string	"unsigned char"
.LASF61:
	.string	"PTRACE_SETREGS"
.LASF4:
	.string	"signed char"
.LASF49:
	.string	"long long unsigned int"
.LASF32:
	.string	"_shortbuf"
.LASF98:
	.string	"code"
.LASF17:
	.string	"_IO_write_base"
.LASF41:
	.string	"_unused2"
.LASF14:
	.string	"_IO_read_ptr"
.LASF46:
	.string	"_pos"
.LASF21:
	.string	"_IO_buf_end"
.LASF69:
	.string	"PTRACE_SETOPTIONS"
.LASF88:
	.string	"status"
.LASF12:
	.string	"char"
.LASF53:
	.string	"PTRACE_PEEKUSER"
.LASF85:
	.string	"fs_base"
.LASF64:
	.string	"PTRACE_ATTACH"
.LASF44:
	.string	"_next"
.LASF35:
	.string	"__pad1"
.LASF36:
	.string	"__pad2"
.LASF37:
	.string	"__pad3"
.LASF38:
	.string	"__pad4"
.LASF39:
	.string	"__pad5"
.LASF23:
	.string	"_IO_backup_base"
.LASF59:
	.string	"PTRACE_SINGLESTEP"
.LASF80:
	.string	"PTRACE_SETSIGMASK"
.LASF89:
	.string	"stderr"
.LASF72:
	.string	"PTRACE_SETSIGINFO"
.LASF91:
	.string	"GNU C11 5.4.0 20160609 -mtune=generic -march=x86-64 -g -fstack-protector-strong"
.LASF0:
	.string	"long unsigned int"
.LASF67:
	.string	"PTRACE_SETFPXREGS"
.LASF19:
	.string	"_IO_write_end"
.LASF9:
	.string	"__off64_t"
.LASF48:
	.string	"pid_t"
.LASF70:
	.string	"PTRACE_GETEVENTMSG"
.LASF8:
	.string	"__off_t"
.LASF87:
	.string	"child"
.LASF26:
	.string	"_chain"
.LASF77:
	.string	"PTRACE_LISTEN"
.LASF92:
	.string	"my_ptrace.c"
.LASF90:
	.string	"regs"
.LASF28:
	.string	"_flags2"
.LASF40:
	.string	"_mode"
.LASF16:
	.string	"_IO_read_base"
.LASF65:
	.string	"PTRACE_DETACH"
.LASF81:
	.string	"PTRACE_SECCOMP_GET_FILTER"
.LASF83:
	.string	"orig_rax"
.LASF31:
	.string	"_vtable_offset"
.LASF62:
	.string	"PTRACE_GETFPREGS"
.LASF22:
	.string	"_IO_save_base"
.LASF54:
	.string	"PTRACE_POKETEXT"
.LASF27:
	.string	"_fileno"
.LASF3:
	.string	"unsigned int"
.LASF73:
	.string	"PTRACE_GETREGSET"
.LASF97:
	.string	"get_syscode"
.LASF13:
	.string	"_flags"
.LASF94:
	.string	"_IO_lock_t"
.LASF60:
	.string	"PTRACE_GETREGS"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
