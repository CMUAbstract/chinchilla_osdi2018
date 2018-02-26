.globl	main
	.align	2
	.type	main,@function
main:
mov.w	r1, r4
call	#init
mov.b	&0x0222, r12
and.w	#207, r12
bis.w	#16, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a #1, r13
mov	#7, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
mov.b	&0x0222, r12
and.w	#239, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a	#1, r13
mov	#47, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
call	#_safe_find_child
push.w	r5
mov.w	&special_sp, r5
mov.w	0(r5), r12
pop.w	r5
mov.w	r15, 0(r5)
mov.w	r12, r15
call	#check_before_write_must
mov.w	0(r5), r12
mov.w	r12, &_global_child_main
push.w	r2
push.w	r5
push.w	r6
mov.w	&special_sp, r5
sub.w	#2, r5
mov.w	r5, &special_sp
mov.w	&stack_tracer, r6
cmp.w	r6, r5
jhs	+4
mov.w	r5, &stack_tracer
pop.w	r6
pop.w	r5
pop.w	r2
mov.b	&0x0222, r12
and.w	#207, r12
bis.w	#32, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a #1, r13
mov	#7, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
mov.b	&0x0222, r12
and.w	#239, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a	#1, r13
mov	#47, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
mov.w	#-23288, &0x0120
ret
.Lfunc_end0:
	.size main, .Lfunc_end0-main
.globl	_safe_find_child
	.align	2
	.type	_safe_find_child,@function
_safe_find_child:
.LBB4_3:
mov.w	#_global_retval_find_child, r15
call	#check_before_write_must
mov.w	#0, &_global_retval_find_child
mov.b	&0x0222, r12
and.w	#207, r12
bis.w	#32, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a #1, r13
mov	#7, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
mov.b	&0x0222, r12
and.w	#239, r12
mov.b	r12, r13
mov.b	r13, &0x0222
pushm.a	#1, r13
mov	#47, r13
dec	r13
jnz	$-2
popm.a	#1, r13
nop
mov.w	#-23288, &0x0120
ret
.Lfunc_end1:
	.size _safe_find_child, .Lfunc_end1-_safe_find_child

	.globl	init
	.align	2
	.type	init,@function
init:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
sub.w	#8, r1
mov.w	#_global_l_init_dict, r15
mov.w	#_global_phi_newBB165_sub, r14
mov.w	#_global_l_init_dict_bak, r13
call	#set_global_range
call	#init_hw
call	#edb_init
eint { nop
jmp	.LBB7_1
.LBB7_1:                                ; %do.body
call	#request_non_interactive_debug_mode
mov.w	&curctx, r12
mov.w	0(r12), r12
mov.w	30(r12), r12
mov.w	r1, r13
mov.w	r12, 2(r13)
mov.w	#.L.str.2, 0(r13)
call	#printf
mov.w	r15, -4(r4)             ; 2-byte Folded Spill
call	#resume_application
jmp	.LBB7_2
.LBB7_2:                                ; %do.end
mov.w	#0, -2(r4)
jmp	.LBB7_3
.LBB7_3:                                ; %for.cond
mov.w	-2(r4), r12
cmp.w	#1200, r12
jhs	.LBB7_6
jmp	.LBB7_4
.LBB7_4:                                ; %for.body
jmp	.LBB7_5
.LBB7_5:                                ; %for.inc
mov.w	-2(r4), r12
add.w	#1, r12
mov.w	r12, -2(r4)
jmp	.LBB7_3
.LBB7_6:                                ; %for.end
add.w	#8, r1
pop.w	r4
ret
.Lfunc_end2:
	.size init, .Lfunc_end2-init

	.globl	check_before_write_must
	.align	2
	.type	check_before_write_must,@function
check_before_write_must:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
sub.w	#10, r1
mov.w	r15, r12
mov.w	r15, -2(r4)
mov.w	&start_addr, r13
sub.w	r13, r15
mov.w	r15, -4(r4)
clrc
rrc.w	r15
rra.w	r15
rra.w	r15
mov.b	backup_bitmask(r15), r13
mov.b	&bitmask_counter, r15
cmp.w	r15, r13
mov.w	r12, -10(r4)            ; 2-byte Folded Spill
jne	.LBB37_3
jmp	.LBB37_1
.LBB37_1:                               ; %land.lhs.true
mov.w	#0, r12
cmp.w	#1, r12
jne	.LBB37_3
jmp	.LBB37_2
.LBB37_2:                               ; %if.then
jmp	.LBB37_7
.LBB37_3:                               ; %if.end
mov.w	&curctx, r12
mov.w	2(r12), r12
cmp.w	#3000, r12
jne	.LBB37_6
jmp	.LBB37_4
.LBB37_4:                               ; %land.lhs.true.5
mov.w	#0, r12
cmp.w	#1, r12
jne	.LBB37_6
jmp	.LBB37_5
.LBB37_5:                               ; %if.then.6
mov.w	#-23288, &0x0120
jmp	.LBB37_6
.LBB37_6:                               ; %if.end.7
mov.w	-2(r4), r12
and.w	#-8, r12
mov.w	r12, -6(r4)
mov.w	&offset, r13
sub.w	r13, r12
mov.w	r12, -8(r4)
mov.w	-6(r4), r13
mov.b	7(r13), r14
mov.b	r14, 7(r12)
mov.b	6(r13), r14
mov.b	r14, 6(r12)
mov.b	5(r13), r14
mov.b	r14, 5(r12)
mov.b	4(r13), r14
mov.b	r14, 4(r12)
mov.b	3(r13), r14
mov.b	r14, 3(r12)
mov.b	2(r13), r14
mov.b	r14, 2(r12)
mov.b	1(r13), r14
mov.b	r14, 1(r12)
mov.b	0(r13), r14
mov.b	r14, 0(r12)
mov.w	-6(r4), r12
mov.w	&curctx, r13
mov.w	2(r13), r13
rla.w	r13
mov.w	r12, backup(r13)
mov.w	&curctx, r12
mov.w	2(r12), r13
add.w	#1, r13
mov.w	r13, 2(r12)
mov.b	&bitmask_counter, r14
mov.w	-4(r4), r12
clrc
rrc.w	r12
rra.w	r12
rra.w	r12
mov.b	r14, backup_bitmask(r12)
jmp	.LBB37_7
.LBB37_7:                               ; %return
add.w	#10, r1
pop.w	r4
ret
.Lfunc_end3:
	.size check_before_write_must, .Lfunc_end3-check_before_write_must

	.globl	set_global_range
	.align	2
	.type	set_global_range,@function
set_global_range:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
push.w	r11
push.w	r10
sub.w	#12, r1
mov.w	r13, r12
mov.w	r14, r11
mov.w	r15, r10
mov.w	r15, -6(r4)
mov.w	r14, -8(r4)
mov.w	r13, -10(r4)
mov.w	-6(r4), r13
mov.w	r13, &start_addr
mov.w	&global_size, r14
add.w	r14, r13
add.w	#-2, r13
mov.w	r13, &end_addr
mov.w	-6(r4), r13
mov.w	-10(r4), r14
sub.w	r14, r13
mov.w	r13, &offset
mov.w	r12, -12(r4)            ; 2-byte Folded Spill
mov.w	r11, -14(r4)            ; 2-byte Folded Spill
mov.w	r10, -16(r4)            ; 2-byte Folded Spill
add.w	#12, r1
pop.w	r10
pop.w	r11
pop.w	r4
ret
.Lfunc_end4:
	.size set_global_range, .Lfunc_end4-set_global_range

	.globl	init_hw
	.align	2
	.type	init_hw,@function
init_hw:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
call	#msp_watchdog_disable
mov.w	&0x0130, r12
and.w	#-2, r12
mov.w	r12, &0x0130
call	#msp_clock_setup
pop.w	r4
ret
.Lfunc_end5:
	.size init_hw, .Lfunc_end5-init_hw

	.globl	msp_watchdog_disable
	.align	2
	.type	msp_watchdog_disable,@function
msp_watchdog_disable:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
mov.w	#23168, &0x015C
pop.w	r4
ret
.Lfunc_end6:
	.size msp_watchdog_disable, .Lfunc_end6-msp_watchdog_disable

	.globl	msp_clock_setup
	.align	2
	.type	msp_clock_setup,@function
msp_clock_setup:
; BB#0:                                 ; %entry
push.w	r4
mov.w	r1, r4
mov.b	#-91, &0x0160+1
mov.w	#51, &0x0164
mov.w	#0, &0x0166
pop.w	r4
ret
.Lfunc_end7:
	.size msp_clock_setup, .Lfunc_end7-msp_clock_setup
.type	overflow,@object        ; @overflow
.section	.bss,"aw",@nobits
.globl	overflow
.align	1
overflow:
.short	0                       ; 0x0
.size	overflow, 2

.type	_np_dict.addr_init_dict,@object ; @_np_dict.addr_init_dict
.section	.nv_vars,"aw",@progbits
.globl	_np_dict.addr_init_dict
.align	1
_np_dict.addr_init_dict:
.short	0
.size	_np_dict.addr_init_dict, 2

.type	_np_dict.addr_find_child,@object ; @_np_dict.addr_find_child
.globl	_np_dict.addr_find_child
.align	1
_np_dict.addr_find_child:
.short	0
.size	_np_dict.addr_find_child, 2

.type	_np_dict.addr_add_node,@object ; @_np_dict.addr_add_node
.globl	_np_dict.addr_add_node
.align	1
_np_dict.addr_add_node:
.short	0
.size	_np_dict.addr_add_node, 2

.type	_kw_loopVar,@object     ; @_kw_loopVar
.globl	_kw_loopVar
.align	1
_kw_loopVar:
.short	0                       ; 0x0
.size	_kw_loopVar, 2

.type	chkpt_book,@object      ; @chkpt_book
.globl	chkpt_book
.align	1
chkpt_book:
.zero	57
.size	chkpt_book, 57

.type	chkpt_status,@object    ; @chkpt_status
.globl	chkpt_status
.align	1
chkpt_status:
.zero	114,255
.size	chkpt_status, 114

.type	CHKPT_NUM,@object       ; @CHKPT_NUM
.data
.globl	CHKPT_NUM
.align	1
CHKPT_NUM:
.short	57                      ; 0x39
.size	CHKPT_NUM, 2

.type	_global_l_init_dict_bak,@object ; @_global_l_init_dict_bak
.section	.nv_vars,"aw",@progbits
.globl	_global_l_init_dict_bak
.align	3
_global_l_init_dict_bak:
.short	0                       ; 0x0
.size	_global_l_init_dict_bak, 2

.type	_global_letter.addr_find_child_bak,@object ; @_global_letter.addr_find_child_bak
.globl	_global_letter.addr_find_child_bak
.align	1
_global_letter.addr_find_child_bak:
.short	0                       ; 0x0
.size	_global_letter.addr_find_child_bak, 2

.type	_global_parent_node_find_child_bak,@object ; @_global_parent_node_find_child_bak
.globl	_global_parent_node_find_child_bak
.align	1
_global_parent_node_find_child_bak:
.short	0
.size	_global_parent_node_find_child_bak, 2

.type	_global_retval_find_child_bak,@object ; @_global_retval_find_child_bak
.globl	_global_retval_find_child_bak
.align	1
_global_retval_find_child_bak:
.short	0                       ; 0x0
.size	_global_retval_find_child_bak, 2

.type	_global_sibling_find_child_bak,@object ; @_global_sibling_find_child_bak
.globl	_global_sibling_find_child_bak
.align	3
_global_sibling_find_child_bak:
.short	0                       ; 0x0
.size	_global_sibling_find_child_bak, 2

.type	_global_sibling_node_find_child_bak,@object ; @_global_sibling_node_find_child_bak
.globl	_global_sibling_node_find_child_bak
.align	1
_global_sibling_node_find_child_bak:
.short	0
.size	_global_sibling_node_find_child_bak, 2

.type	_global_letter.addr_add_node_bak,@object ; @_global_letter.addr_add_node_bak
.globl	_global_letter.addr_add_node_bak
.align	1
_global_letter.addr_add_node_bak:
.short	0                       ; 0x0
.size	_global_letter.addr_add_node_bak, 2

.type	_global_parent.addr_add_node_bak,@object ; @_global_parent.addr_add_node_bak
.globl	_global_parent.addr_add_node_bak
.align	1
_global_parent.addr_add_node_bak:
.short	0                       ; 0x0
.size	_global_parent.addr_add_node_bak, 2

.type	_global_node_index_add_node_bak,@object ; @_global_node_index_add_node_bak
.globl	_global_node_index_add_node_bak
.align	3
_global_node_index_add_node_bak:
.short	0                       ; 0x0
.size	_global_node_index_add_node_bak, 2

.type	_global_child4_add_node_bak,@object ; @_global_child4_add_node_bak
.globl	_global_child4_add_node_bak
.align	1
_global_child4_add_node_bak:
.short	0                       ; 0x0
.size	_global_child4_add_node_bak, 2

.type	_global_sibling9_add_node_bak,@object ; @_global_sibling9_add_node_bak
.globl	_global_sibling9_add_node_bak
.align	1
_global_sibling9_add_node_bak:
.short	0                       ; 0x0
.size	_global_sibling9_add_node_bak, 2

.type	_global_sibling_node_add_node_bak,@object ; @_global_sibling_node_add_node_bak
.globl	_global_sibling_node_add_node_bak
.align	1
_global_sibling_node_add_node_bak:
.short	0
.size	_global_sibling_node_add_node_bak, 2

.type	_global_dict_promoted_main_bak,@object ; @_global_dict_promoted_main_bak
.globl	_global_dict_promoted_main_bak
.align	3
_global_dict_promoted_main_bak:
.zero	3074
.size	_global_dict_promoted_main_bak, 3074

.type	_global_letter_main_bak,@object ; @_global_letter_main_bak
.globl	_global_letter_main_bak
.align	3
_global_letter_main_bak:
.short	0                       ; 0x0
.size	_global_letter_main_bak, 2

.type	_global_letter_idx_main_bak,@object ; @_global_letter_idx_main_bak
.globl	_global_letter_idx_main_bak
.align	1
_global_letter_idx_main_bak:
.short	0                       ; 0x0
.size	_global_letter_idx_main_bak, 2

.type	_global_prev_sample_main_bak,@object ; @_global_prev_sample_main_bak
.globl	_global_prev_sample_main_bak
.align	1
_global_prev_sample_main_bak:
.short	0                       ; 0x0
.size	_global_prev_sample_main_bak, 2

.type	_global_child_main_bak,@object ; @_global_child_main_bak
.globl	_global_child_main_bak
.align	1
_global_child_main_bak:
.short	0                       ; 0x0
.size	_global_child_main_bak, 2

.type	_global_log_promoted_main_bak,@object ; @_global_log_promoted_main_bak
.globl	_global_log_promoted_main_bak
.align	3
_global_log_promoted_main_bak:
.zero	132
.size	_global_log_promoted_main_bak, 132

.type	_global_sample_main_bak,@object ; @_global_sample_main_bak
.globl	_global_sample_main_bak
.align	3
_global_sample_main_bak:
.short	0                       ; 0x0
.size	_global_sample_main_bak, 2

.type	_global_parent_main_bak,@object ; @_global_parent_main_bak
.globl	_global_parent_main_bak
.align	1
_global_parent_main_bak:
.short	0                       ; 0x0
.size	_global_parent_main_bak, 2

.type	_global_phi_newBB88_2_bak,@object ; @_global_phi_newBB88_2_bak
.globl	_global_phi_newBB88_2_bak
.align	1
_global_phi_newBB88_2_bak:
.short	0                       ; 0x0
.size	_global_phi_newBB88_2_bak, 2

.type	_global_phi_newBB165_sub_bak,@object ; @_global_phi_newBB165_sub_bak
.globl	_global_phi_newBB165_sub_bak
.align	1
_global_phi_newBB165_sub_bak:
.short	0                       ; 0x0
.size	_global_phi_newBB165_sub_bak, 2

.type	_global_l_init_dict,@object ; @_global_l_init_dict
.globl	_global_l_init_dict
.align	3
_global_l_init_dict:
.short	0                       ; 0x0
.size	_global_l_init_dict, 2

.type	_global_letter.addr_find_child,@object ; @_global_letter.addr_find_child
.globl	_global_letter.addr_find_child
.align	1
_global_letter.addr_find_child:
.short	0                       ; 0x0
.size	_global_letter.addr_find_child, 2

.type	_global_parent_node_find_child,@object ; @_global_parent_node_find_child
.globl	_global_parent_node_find_child
.align	1
_global_parent_node_find_child:
.short	0
.size	_global_parent_node_find_child, 2

.type	_global_retval_find_child,@object ; @_global_retval_find_child
.globl	_global_retval_find_child
.align	1
_global_retval_find_child:
.short	0                       ; 0x0
.size	_global_retval_find_child, 2

.type	_global_sibling_find_child,@object ; @_global_sibling_find_child
.globl	_global_sibling_find_child
.align	3
_global_sibling_find_child:
.short	0                       ; 0x0
.size	_global_sibling_find_child, 2

.type	_global_sibling_node_find_child,@object ; @_global_sibling_node_find_child
.globl	_global_sibling_node_find_child
.align	1
_global_sibling_node_find_child:
.short	0
.size	_global_sibling_node_find_child, 2

.type	_global_letter.addr_add_node,@object ; @_global_letter.addr_add_node
.globl	_global_letter.addr_add_node
.align	1
_global_letter.addr_add_node:
.short	0                       ; 0x0
.size	_global_letter.addr_add_node, 2

.type	_global_parent.addr_add_node,@object ; @_global_parent.addr_add_node
.globl	_global_parent.addr_add_node
.align	1
_global_parent.addr_add_node:
.short	0                       ; 0x0
.size	_global_parent.addr_add_node, 2

.type	_global_node_index_add_node,@object ; @_global_node_index_add_node
.globl	_global_node_index_add_node
.align	3
_global_node_index_add_node:
.short	0                       ; 0x0
.size	_global_node_index_add_node, 2

.type	_global_child4_add_node,@object ; @_global_child4_add_node
.globl	_global_child4_add_node
.align	1
_global_child4_add_node:
.short	0                       ; 0x0
.size	_global_child4_add_node, 2

.type	_global_sibling9_add_node,@object ; @_global_sibling9_add_node
.globl	_global_sibling9_add_node
.align	1
_global_sibling9_add_node:
.short	0                       ; 0x0
.size	_global_sibling9_add_node, 2

.type	_global_sibling_node_add_node,@object ; @_global_sibling_node_add_node
.globl	_global_sibling_node_add_node
.align	1
_global_sibling_node_add_node:
.short	0
.size	_global_sibling_node_add_node, 2

.type	_global_dict_promoted_main,@object ; @_global_dict_promoted_main
.globl	_global_dict_promoted_main
.align	3
_global_dict_promoted_main:
.zero	3074
.size	_global_dict_promoted_main, 3074

.type	_global_letter_main,@object ; @_global_letter_main
.globl	_global_letter_main
.align	3
_global_letter_main:
.short	0                       ; 0x0
.size	_global_letter_main, 2

.type	_global_letter_idx_main,@object ; @_global_letter_idx_main
.globl	_global_letter_idx_main
.align	1
_global_letter_idx_main:
.short	0                       ; 0x0
.size	_global_letter_idx_main, 2

.type	_global_prev_sample_main,@object ; @_global_prev_sample_main
.globl	_global_prev_sample_main
.align	1
_global_prev_sample_main:
.short	0                       ; 0x0
.size	_global_prev_sample_main, 2

.type	_global_child_main,@object ; @_global_child_main
.globl	_global_child_main
.align	1
_global_child_main:
.short	0                       ; 0x0
.size	_global_child_main, 2

.type	_global_log_promoted_main,@object ; @_global_log_promoted_main
.globl	_global_log_promoted_main
.align	3
_global_log_promoted_main:
.zero	132
.size	_global_log_promoted_main, 132

.type	_global_sample_main,@object ; @_global_sample_main
.globl	_global_sample_main
.align	3
_global_sample_main:
.short	0                       ; 0x0
.size	_global_sample_main, 2

.type	_global_parent_main,@object ; @_global_parent_main
.globl	_global_parent_main
.align	1
_global_parent_main:
.short	0                       ; 0x0
.size	_global_parent_main, 2

.type	_global_phi_newBB88_2,@object ; @_global_phi_newBB88_2
.globl	_global_phi_newBB88_2
.align	1
_global_phi_newBB88_2:
.short	0                       ; 0x0
.size	_global_phi_newBB88_2, 2

.type	_global_phi_newBB165_sub,@object ; @_global_phi_newBB165_sub
.globl	_global_phi_newBB165_sub
.align	1
_global_phi_newBB165_sub:
.short	0                       ; 0x0
.size	_global_phi_newBB165_sub, 2

.type	backup_bitmask,@object  ; @backup_bitmask
.globl	backup_bitmask
.align	1
backup_bitmask:
.zero	407
.size	backup_bitmask, 407

.type	global_size,@object     ; @global_size
.globl	global_size
.align	1
global_size:
.short	3256                    ; 0xcb8
.size	global_size, 2

.type	.L.str,@object          ; @.str
.section	.ro_nv_vars,"aMS",@progbits
.L.str:
.asciz	"rate: samples/block: %u/%u\r\n"
.size	.L.str, 29

.type	.L.str.1,@object        ; @.str.1
.L.str.1:
.asciz	"add node: table full\r\n"
.size	.L.str.1, 23

.type	.L.str.2,@object        ; @.str.2
.L.str.2:
.asciz	"a%u.\r\n"
.size	.L.str.2, 7

.type	.L.str.3,@object        ; @.str.3
.L.str.3:
.asciz	"start: \r\n"
.size	.L.str.3, 10

.type	.L.str.4,@object        ; @.str.4
.L.str.4:
.asciz	"end\r\n"
.size	.L.str.4, 6

.type	watchdog_bits,@object   ; @watchdog_bits
.local	watchdog_bits
.comm	watchdog_bits,1,1
.type	bitmask_counter,@object ; @bitmask_counter
.section	.nv_vars,"aw",@progbits
.globl	bitmask_counter
bitmask_counter:
.byte	1                       ; 0x1
.size	bitmask_counter, 1

.type	need_bitmask_clear,@object ; @need_bitmask_clear
.globl	need_bitmask_clear
need_bitmask_clear:
.byte	0                       ; 0x0
.size	need_bitmask_clear, 1

.type	program_end,@object     ; @program_end
.section	.bss,"aw",@nobits
.globl	program_end
program_end:
.byte	0                       ; 0x0
.size	program_end, 1

.type	isSafeKill,@object      ; @isSafeKill
.section	.nv_vars,"aw",@progbits
.globl	isSafeKill
.align	1
isSafeKill:
.short	1                       ; 0x1
.size	isSafeKill, 2

.type	chkpt_cutvar,@object    ; @chkpt_cutvar
.globl	chkpt_cutvar
.align	1
chkpt_cutvar:
.long	1717986918              ; 0x66666666
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.long	0                       ; 0x0
.size	chkpt_cutvar, 220

.type	var_record,@object      ; @var_record
.globl	var_record
.align	1
var_record:
.short	21845                   ; 0x5555
.short	21845
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.zero	4
.size	var_record, 120

.type	special_stack,@object   ; @special_stack
.globl	special_stack
.align	1
special_stack:
.zero	600
.size	special_stack, 600

.type	special_sp,@object      ; @special_sp
.section	.data.rel,"aw",@progbits
.globl	special_sp
.align	1
special_sp:
.short	special_stack-2
.size	special_sp, 2

.type	stack_tracer,@object    ; @stack_tracer
.section	.nv_vars,"aw",@progbits
.globl	stack_tracer
.align	1
stack_tracer:
.short	special_stack-2
.size	stack_tracer, 2

.type	context_0,@object       ; @context_0
.globl	context_0
.align	1
context_0:
.short	0
.short	0                       ; 0x0
.zero	600
.short	0
.short	special_stack-2
.size	context_0, 608

.type	context_1,@object       ; @context_1
.globl	context_1
.align	1
context_1:
.short	0
.short	0                       ; 0x0
.zero	600
.short	0
.short	special_stack-2
.size	context_1, 608

.type	curctx,@object          ; @curctx
.globl	curctx
.align	1
curctx:
.short	context_0
.size	curctx, 2

.type	isNoProgress,@object    ; @isNoProgress
.globl	isNoProgress
isNoProgress:
.byte	0                       ; 0x0
.size	isNoProgress, 1

.type	mode_status,@object     ; @mode_status
.globl	mode_status
.align	1
mode_status:
.short	65535                   ; 0xffff
.size	mode_status, 2

.type	chkpt_ever_taken,@object ; @chkpt_ever_taken
.globl	chkpt_ever_taken
chkpt_ever_taken:
.byte	0                       ; 0x0
.size	chkpt_ever_taken, 1

.type	chkpt_iterator,@object  ; @chkpt_iterator
.globl	chkpt_iterator
.align	1
chkpt_iterator:
.short	0                       ; 0x0
.size	chkpt_iterator, 2

.type	chkpt_patching,@object  ; @chkpt_patching
.globl	chkpt_patching
chkpt_patching:
.byte	0                       ; 0x0
.size	chkpt_patching, 1

.type	start_addr,@object      ; @start_addr
.globl	start_addr
.align	1
start_addr:
.short	0
.size	start_addr, 2

.type	end_addr,@object        ; @end_addr
.globl	end_addr
.align	1
end_addr:
.short	0
.size	end_addr, 2

.type	offset,@object          ; @offset
.globl	offset
.align	1
offset:
.short	0                       ; 0x0
.size	offset, 2

.type	chkpt_count,@object     ; @chkpt_count
.globl	chkpt_count
.align	1
chkpt_count:
.short	0                       ; 0x0
.size	chkpt_count, 2

.type	prev_chkpt_cnt,@object  ; @prev_chkpt_cnt
.globl	prev_chkpt_cnt
.align	1
prev_chkpt_cnt:
.short	0                       ; 0x0
.size	prev_chkpt_cnt, 2

.type	prev_prev_chkpt_cnt,@object ; @prev_prev_chkpt_cnt
.globl	prev_prev_chkpt_cnt
.align	1
prev_prev_chkpt_cnt:
.short	0                       ; 0x0
.size	prev_prev_chkpt_cnt, 2

.type	chkpt_i,@object         ; @chkpt_i
.globl	chkpt_i
.align	1
chkpt_i:
.short	0                       ; 0x0
.size	chkpt_i, 2

.type	hist0,@object           ; @hist0
.globl	hist0
.align	1
hist0:
.short	65535                   ; 0xffff
.short	65535                   ; 0xffff
.byte	0                       ; 0x0
.zero	1
.size	hist0, 6

.type	hist1,@object           ; @hist1
.globl	hist1
.align	1
hist1:
.short	65535                   ; 0xffff
.short	65535                   ; 0xffff
.byte	0                       ; 0x0
.zero	1
.size	hist1, 6

.type	cur_hist,@object        ; @cur_hist
.globl	cur_hist
.align	1
cur_hist:
.short	hist0
.size	cur_hist, 2

.type	clear_bitmask_iter,@object ; @clear_bitmask_iter
.globl	clear_bitmask_iter
.align	1
clear_bitmask_iter:
.short	0                       ; 0x0
.size	clear_bitmask_iter, 2

.type	regs_0,@object          ; @regs_0
.globl	regs_0
.align	1
regs_0:
.zero	32
.size	regs_0, 32

.type	regs_1,@object          ; @regs_1
.globl	regs_1
.align	1
regs_1:
.zero	32
.size	regs_1, 32

.type	backup,@object          ; @backup
.globl	backup
.align	1
backup:
.zero	6000
.size	backup, 6000

.type	.L.str.25,@object       ; @.str.25
.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.25:
.asciz	"chkpt[%u]=%u\r\n"
.size	.L.str.25, 15

.type	.L.str.1.26,@object     ; @.str.1.26
.L.str.1.26:
.asciz	"recovery: %u\r\n"
.size	.L.str.1.26, 15


.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
.section	".note.GNU-stack","",@progbits
