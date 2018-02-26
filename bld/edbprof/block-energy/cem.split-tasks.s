	.text
	.file	"cem.a.bc"
	.globl	__loop_bound__
	.align	2
	.type	__loop_bound__,@function
__loop_bound__:                         ; @__loop_bound__
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: __loop_bound__:val <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end0:
	.size	__loop_bound__, .Lfunc_end0-__loop_bound__

	.globl	_kw_print_log
	.align	2
	.type	_kw_print_log,@function
_kw_print_log:                          ; @_kw_print_log
; BB#0:                                 ; %entry
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#4, r5
	mov.w	r5, &special_sp
	pop.w	r5
	push.w	r5
	mov.w	2(r1), r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	r5, 0(r6)
	pop.w	r6
	pop.w	r5
	push.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r4, -2(r5)
	pop.w	r5
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: print_log:log <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	call	#request_energy_guard_debug_mode
	mov.w	-2(r4), r12
	mov.w	130(r12), r15
	mov.w	128(r12), r12
	mov.w	r1, r13
	mov.w	r12, 4(r13)
	mov.w	r15, 2(r13)
	mov.w	#.L.str, 0(r13)
	call	#printf
	mov.w	r15, -6(r4)             ; 2-byte Folded Spill
	call	#resume_application
	mov.w	-2(r4), r12
	mov.w	130(r12), r12
	cmp.w	#353, r12
	jeq	.LBB1_4
	jmp	.LBB1_1
.LBB1_1:                                ; %condBB
	mov.w	&chkpt_status, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB1_3
	jmp	.LBB1_2
.LBB1_2:                                ; %newBB
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#0, 30(r12)
	call	#checkpoint
	jmp	.LBB1_3
.LBB1_3:                                ; %if.then
	mov.w	#0, r15
	call	#exit
.LBB1_4:                                ; %condBB2
	mov.w	&chkpt_status+2, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB1_6
	jmp	.LBB1_5
.LBB1_5:                                ; %newBB3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#1, 30(r12)
	call	#checkpoint
	jmp	.LBB1_6
.LBB1_6:                                ; %if.end
	add.w	#12, r1
	pop.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-2(r5), r4
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	0(r6), r5
	pop.w	r6
	mov.w	r5, 2(r1)
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r5
	sub.w	#4, r5
	mov.w	r5, &special_sp
	mov.w	&stack_tracer, r6
	cmp.w	r6, r5
	jhs	+4
	mov.w	r5, &stack_tracer
	pop.w	r6
	pop.w	r5
	ret
.Lfunc_end1:
	.size	_kw_print_log, .Lfunc_end1-_kw_print_log

	.globl	acquire_sample
	.align	2
	.type	acquire_sample,@function
acquire_sample:                         ; @acquire_sample
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	;DEBUG_VALUE: acquire_sample:prev_sample <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	add.w	#1, r15
	and.w	#3, r15
	mov.w	r15, -4(r4)
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end2:
	.size	acquire_sample, .Lfunc_end2-acquire_sample

	.globl	_kw_init_dict
	.align	2
	.type	_kw_init_dict,@function
_kw_init_dict:                          ; @_kw_init_dict
; BB#0:                                 ; %entry
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#4, r5
	mov.w	r5, &special_sp
	pop.w	r5
	push.w	r5
	mov.w	2(r1), r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	r5, 0(r6)
	pop.w	r6
	pop.w	r5
	push.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r4, -2(r5)
	pop.w	r5
	mov.w	r1, r4
	sub.w	#20, r1
	mov.w	r15, r12
	mov.w	r15, &_np_dict.addr_init_dict
	mov.w	r15, r13
	add.w	#3072, r13
	mov.w	r15, -4(r4)             ; 2-byte Folded Spill
	mov.w	r13, r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-4(r4), r12             ; 2-byte Folded Reload
	mov.w	#0, 3072(r12)
	mov.w	#_global_l_init_dict, r15
	call	#check_before_write_must
	mov.w	#0, &_global_l_init_dict
	mov.w	#-32768, &_kw_loopVar
	jmp	.LBB3_1
.LBB3_1:                                ; %condBB
	mov.w	&chkpt_status+4, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB3_5
	jmp	.LBB3_2
.LBB3_2:                                ; %newBB
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#2, 30(r12)
	call	#checkpoint
	jmp	.LBB3_5
.LBB3_3:                                ; %condBB24
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&chkpt_status+12, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB3_5
	jmp	.LBB3_4
.LBB3_4:                                ; %newBB25
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#6, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_l_init_dict, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB3_5
.LBB3_5:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&_global_l_init_dict, r12
	cmp.w	#256, r12
	jhs	.LBB3_12
	jmp	.LBB3_6
.LBB3_6:                                ; %condBB3
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&chkpt_status+6, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB3_8
	jmp	.LBB3_7
.LBB3_7:                                ; %newBB4
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#3, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_l_init_dict, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB3_8
.LBB3_8:                                ; %for.body
                                        ;   in Loop: Header=BB3_5 Depth=1
	;DEBUG_VALUE: node <- [FP+-2]
	mov.w	&_global_l_init_dict, r15
	mov.w	&_np_dict.addr_init_dict, r12
	mov.w	#6, r14
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -2(r4)
	mov.w	&_global_l_init_dict, r14
	mov.w	r12, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r14, -12(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	-12(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, 0(r12)
	mov.w	-2(r4), r14
	mov.w	r14, r15
	add.w	#2, r15
	mov.w	r14, -14(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	#0, 2(r12)
	mov.w	-2(r4), r14
	mov.w	r14, r15
	add.w	#4, r15
	mov.w	r14, -16(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	#0, 4(r12)
	mov.w	&_np_dict.addr_init_dict, r14
	mov.w	r14, r15
	add.w	#3072, r15
	mov.w	3072(r14), r13
	add.w	#1, r13
	mov.w	r14, -18(r4)            ; 2-byte Folded Spill
	mov.w	r13, -20(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	-20(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 3072(r12)
	jmp	.LBB3_9
.LBB3_9:                                ; %condBB17
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&chkpt_status+10, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB3_11
	jmp	.LBB3_10
.LBB3_10:                               ; %newBB18
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#5, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_l_init_dict, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB3_11
.LBB3_11:                               ; %for.inc
                                        ;   in Loop: Header=BB3_5 Depth=1
	mov.w	&_global_l_init_dict, r12
	add.w	#1, r12
	mov.w	r12, &_global_l_init_dict
	mov.w	&_kw_loopVar, r12
	add.w	#1, r12
	mov.w	r12, &_kw_loopVar
	jmp	.LBB3_3
.LBB3_12:                               ; %condBB10
	mov.w	&chkpt_status+8, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB3_14
	jmp	.LBB3_13
.LBB3_13:                               ; %newBB11
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#4, 30(r12)
	call	#checkpoint
	jmp	.LBB3_14
.LBB3_14:                               ; %for.end
	add.w	#20, r1
	pop.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-2(r5), r4
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	0(r6), r5
	pop.w	r6
	mov.w	r5, 2(r1)
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r5
	sub.w	#4, r5
	mov.w	r5, &special_sp
	mov.w	&stack_tracer, r6
	cmp.w	r6, r5
	jhs	+4
	mov.w	r5, &stack_tracer
	pop.w	r6
	pop.w	r5
	ret
.Lfunc_end3:
	.size	_kw_init_dict, .Lfunc_end3-_kw_init_dict

	.globl	_kw_find_child
	.align	2
	.type	_kw_find_child,@function
_kw_find_child:                         ; @_kw_find_child
; BB#0:                                 ; %entry
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#10, r5
	mov.w	r5, &special_sp
	pop.w	r5
	push.w	r5
	mov.w	2(r1), r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	r5, 0(r6)
	pop.w	r6
	pop.w	r5
	push.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r4, -2(r5)
	pop.w	r5
	mov.w	r1, r4
	push.w	r11
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r11, -4(r5)
	pop.w	r5
	push.w	r10
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r10, -6(r5)
	pop.w	r5
	push.w	r9
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r9, -8(r5)
	pop.w	r5
	sub.w	#22, r1
	;DEBUG_VALUE: find_child:parent <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	#_global_letter.addr_find_child, r9
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	mov.w	r9, r15
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	mov.w	r14, -14(r4)            ; 2-byte Folded Spill
	mov.w	r10, -16(r4)            ; 2-byte Folded Spill
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_letter.addr_find_child
	mov.w	-14(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, -8(r4)
	mov.w	-12(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, &_np_dict.addr_find_child
	mov.w	-8(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	#_global_parent_node_find_child, r15
	mov.w	r12, -22(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-22(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_parent_node_find_child
	mov.w	4(r12), r13
	cmp.w	#0, r13
	jne	.LBB4_4
	jmp	.LBB4_1
.LBB4_1:                                ; %condBB
	mov.w	&chkpt_status+14, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_3
	jmp	.LBB4_2
.LBB4_2:                                ; %newBB
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#7, 30(r12)
	call	#checkpoint
	jmp	.LBB4_3
.LBB4_3:                                ; %if.then
	mov.w	#_global_retval_find_child, r15
	call	#check_before_write_must
	mov.w	#0, &_global_retval_find_child
	br	#.LBB4_27
.LBB4_4:                                ; %condBB3
	mov.w	&chkpt_status+16, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_6
	jmp	.LBB4_5
.LBB4_5:                                ; %newBB4
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#8, 30(r12)
	call	#checkpoint
	jmp	.LBB4_6
.LBB4_6:                                ; %if.end
	mov.w	&_global_parent_node_find_child, r12
	mov.w	4(r12), r12
	mov.w	#_global_sibling_find_child, r15
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-24(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_sibling_find_child
	mov.w	#-32768, &_kw_loopVar
	mov.w	#_global_sibling_node_find_child, r15
	call	#check_before_write_must
	jmp	.LBB4_7
.LBB4_7:                                ; %condBB17
	mov.w	&chkpt_status+20, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_11
	jmp	.LBB4_8
.LBB4_8:                                ; %newBB18
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#10, 30(r12)
	call	#checkpoint
	jmp	.LBB4_11
.LBB4_9:                                ; %condBB66
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&chkpt_status+34, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB4_11
	jmp	.LBB4_10
.LBB4_10:                               ; %newBB67
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#17, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling_node_find_child, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_find_child, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB4_11
.LBB4_11:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&_global_sibling_find_child, r12
	cmp.w	#0, r12
	jeq	.LBB4_24
	jmp	.LBB4_12
.LBB4_12:                               ; %condBB24
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&chkpt_status+22, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB4_14
	jmp	.LBB4_13
.LBB4_13:                               ; %newBB25
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#11, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling_node_find_child, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_find_child, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB4_14
.LBB4_14:                               ; %while.body
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&_global_sibling_find_child, r15
	mov.w	&_np_dict.addr_find_child, r12
	mov.w	#6, r14
	mov.w	r12, -26(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-26(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, &_global_sibling_node_find_child
	mov.w	0(r12), r12
	mov.w	&_global_letter.addr_find_child, r14
	cmp.w	r14, r12
	jne	.LBB4_18
	jmp	.LBB4_15
.LBB4_15:                               ; %condBB38
	mov.w	&chkpt_status+26, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_17
	jmp	.LBB4_16
.LBB4_16:                               ; %newBB39
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#13, 30(r12)
	call	#checkpoint
	jmp	.LBB4_17
.LBB4_17:                               ; %if.then.7
	mov.w	&_global_sibling_find_child, r12
	mov.w	#_global_retval_find_child, r15
	mov.w	r12, -28(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_retval_find_child
	jmp	.LBB4_29
.LBB4_18:                               ; %condBB45
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&chkpt_status+28, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB4_20
	jmp	.LBB4_19
.LBB4_19:                               ; %newBB46
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#14, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling_node_find_child, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_find_child, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB4_20
.LBB4_20:                               ; %if.else
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&_global_sibling_node_find_child, r12
	mov.w	2(r12), r12
	mov.w	r12, &_global_sibling_find_child
	jmp	.LBB4_21
.LBB4_21:                               ; %condBB59
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&chkpt_status+32, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB4_23
	jmp	.LBB4_22
.LBB4_22:                               ; %newBB60
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#16, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling_node_find_child, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_find_child, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB4_23
.LBB4_23:                               ; %if.end.9
                                        ;   in Loop: Header=BB4_11 Depth=1
	mov.w	&_kw_loopVar, r12
	add.w	#1, r12
	mov.w	r12, &_kw_loopVar
	jmp	.LBB4_9
.LBB4_24:                               ; %condBB31
	mov.w	&chkpt_status+24, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_26
	jmp	.LBB4_25
.LBB4_25:                               ; %newBB32
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#12, 30(r12)
	call	#checkpoint
	jmp	.LBB4_26
.LBB4_26:                               ; %while.end
	mov.w	#_global_retval_find_child, r15
	call	#check_before_write_must
	mov.w	#0, &_global_retval_find_child
	jmp	.LBB4_31
.LBB4_27:                               ; %condBB10
	mov.w	&chkpt_status+18, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_33
	jmp	.LBB4_28
.LBB4_28:                               ; %newBB11
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#9, 30(r12)
	call	#checkpoint
	jmp	.LBB4_33
.LBB4_29:                               ; %condBB52
	mov.w	&chkpt_status+30, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_33
	jmp	.LBB4_30
.LBB4_30:                               ; %newBB53
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#15, 30(r12)
	call	#checkpoint
	jmp	.LBB4_33
.LBB4_31:                               ; %condBB73
	mov.w	&chkpt_status+36, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB4_33
	jmp	.LBB4_32
.LBB4_32:                               ; %newBB74
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#18, 30(r12)
	call	#checkpoint
	jmp	.LBB4_33
.LBB4_33:                               ; %return
	mov.w	&_global_retval_find_child, r15
	add.w	#22, r1
	pop.w	r9
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-8(r5), r9
	pop.w	r5
	pop.w	r10
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-6(r5), r10
	pop.w	r5
	pop.w	r11
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-4(r5), r11
	pop.w	r5
	pop.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-2(r5), r4
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	0(r6), r5
	pop.w	r6
	mov.w	r5, 2(r1)
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r5
	sub.w	#10, r5
	mov.w	r5, &special_sp
	mov.w	&stack_tracer, r6
	cmp.w	r6, r5
	jhs	+4
	mov.w	r5, &stack_tracer
	pop.w	r6
	pop.w	r5
	ret
.Lfunc_end4:
	.size	_kw_find_child, .Lfunc_end4-_kw_find_child

	.globl	_kw_add_node
	.align	2
	.type	_kw_add_node,@function
_kw_add_node:                           ; @_kw_add_node
; BB#0:                                 ; %entry
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#10, r5
	mov.w	r5, &special_sp
	pop.w	r5
	push.w	r5
	mov.w	2(r1), r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	r5, 0(r6)
	pop.w	r6
	pop.w	r5
	push.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r4, -2(r5)
	pop.w	r5
	mov.w	r1, r4
	push.w	r11
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r11, -4(r5)
	pop.w	r5
	push.w	r10
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r10, -6(r5)
	pop.w	r5
	push.w	r9
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r9, -8(r5)
	pop.w	r5
	sub.w	#60, r1
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	#_global_letter.addr_add_node, r9
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	mov.w	r9, r15
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	mov.w	r14, -14(r4)            ; 2-byte Folded Spill
	mov.w	r10, -16(r4)            ; 2-byte Folded Spill
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_letter.addr_add_node
	mov.w	#_global_parent.addr_add_node, r15
	call	#check_before_write_must
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_parent.addr_add_node
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, &_np_dict.addr_add_node
	mov.w	3072(r13), r14
	cmp.w	#512, r14
	jne	.LBB5_10
	jmp	.LBB5_1
.LBB5_1:                                ; %condBB
	mov.w	&chkpt_status+38, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_3
	jmp	.LBB5_2
.LBB5_2:                                ; %newBB
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#19, 30(r12)
	call	#checkpoint
	jmp	.LBB5_3
.LBB5_3:                                ; %if.then
	jmp	.LBB5_4
.LBB5_4:                                ; %condBB11
	mov.w	&chkpt_status+42, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_6
	jmp	.LBB5_5
.LBB5_5:                                ; %newBB12
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#21, 30(r12)
	call	#checkpoint
	jmp	.LBB5_6
.LBB5_6:                                ; %do.body
	call	#request_non_interactive_debug_mode
	mov.w	r1, r12
	mov.w	#.L.str.1, 0(r12)
	call	#printf
	mov.w	r15, -22(r4)            ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB5_7
.LBB5_7:                                ; %condBB18
	mov.w	&chkpt_status+44, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_9
	jmp	.LBB5_8
.LBB5_8:                                ; %newBB19
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#22, 30(r12)
	call	#checkpoint
	jmp	.LBB5_9
.LBB5_9:                                ; %do.end
	jmp	.LBB5_12
.LBB5_10:                               ; %condBB4
	mov.w	&chkpt_status+40, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_14
	jmp	.LBB5_11
.LBB5_11:                               ; %newBB5
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#20, 30(r12)
	call	#checkpoint
	jmp	.LBB5_14
.LBB5_12:                               ; %condBB26
	mov.w	&chkpt_status+46, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_14
	jmp	.LBB5_13
.LBB5_13:                               ; %newBB27
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#23, 30(r12)
	call	#checkpoint
	jmp	.LBB5_14
.LBB5_14:                               ; %if.end
	;DEBUG_VALUE: add_node:node <- [FP+-2]
	mov.w	&_np_dict.addr_add_node, r12
	mov.w	3072(r12), r15
	mov.w	#6, r13
	mov.w	r13, r14
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	mov.w	r13, -26(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-24(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -8(r4)
	mov.w	&_global_letter.addr_add_node, r13
	mov.w	r12, r15
	mov.w	r12, -28(r4)            ; 2-byte Folded Spill
	mov.w	r13, -30(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	-30(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 0(r12)
	mov.w	-8(r4), r13
	mov.w	r13, r14
	add.w	#2, r14
	mov.w	r14, r15
	mov.w	r13, -32(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	mov.w	#0, 2(r12)
	mov.w	-8(r4), r13
	mov.w	r13, r14
	add.w	#4, r14
	mov.w	r14, r15
	mov.w	r13, -34(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-34(r4), r12            ; 2-byte Folded Reload
	mov.w	#0, 4(r12)
	mov.w	&_np_dict.addr_add_node, r13
	mov.w	r13, r14
	add.w	#3072, r14
	mov.w	3072(r13), r15
	mov.w	r15, r11
	add.w	#1, r11
	mov.w	r15, -36(r4)            ; 2-byte Folded Spill
	mov.w	r14, r15
	mov.w	r13, -38(r4)            ; 2-byte Folded Spill
	mov.w	r11, -40(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-38(r4), r12            ; 2-byte Folded Reload
	mov.w	-40(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 3072(r12)
	mov.w	#_global_node_index_add_node, r15
	call	#check_before_write_must
	mov.w	-36(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_node_index_add_node
	mov.w	&_global_parent.addr_add_node, r15
	mov.w	&_np_dict.addr_add_node, r13
	mov.w	-26(r4), r14            ; 2-byte Folded Reload
	mov.w	r13, -42(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-42(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	4(r12), r12
	mov.w	#_global_child4_add_node, r15
	mov.w	r12, -44(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-44(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_child4_add_node
	cmp.w	#0, r12
	jeq	.LBB5_29
	jmp	.LBB5_15
.LBB5_15:                               ; %condBB33
	mov.w	&chkpt_status+48, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_17
	jmp	.LBB5_16
.LBB5_16:                               ; %newBB34
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#24, 30(r12)
	call	#checkpoint
	jmp	.LBB5_17
.LBB5_17:                               ; %if.then.8
	mov.w	&_global_child4_add_node, r12
	mov.w	#_global_sibling9_add_node, r15
	mov.w	r12, -46(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-46(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_sibling9_add_node
	mov.w	&_np_dict.addr_add_node, r15
	mov.w	#6, r14
	mov.w	r15, -48(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#__mulhi3hw_noint
	mov.w	-48(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	#_global_sibling_node_add_node, r15
	mov.w	r12, -50(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-50(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_sibling_node_add_node
	mov.w	#-32768, &_kw_loopVar
	jmp	.LBB5_18
.LBB5_18:                               ; %condBB47
	mov.w	&chkpt_status+52, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_22
	jmp	.LBB5_19
.LBB5_19:                               ; %newBB48
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#26, 30(r12)
	call	#checkpoint
	jmp	.LBB5_22
.LBB5_20:                               ; %condBB68
                                        ;   in Loop: Header=BB5_22 Depth=1
	mov.w	&chkpt_status+58, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB5_22
	jmp	.LBB5_21
.LBB5_21:                               ; %newBB69
                                        ;   in Loop: Header=BB5_22 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#29, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling9_add_node, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_node_add_node, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB5_22
.LBB5_22:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&_global_sibling_node_add_node, r12
	mov.w	2(r12), r12
	cmp.w	#0, r12
	jeq	.LBB5_26
	jmp	.LBB5_23
.LBB5_23:                               ; %condBB54
                                        ;   in Loop: Header=BB5_22 Depth=1
	mov.w	&chkpt_status+54, r12
	mov.w	&mode_status, r13
	and.w	r13, r12
	mov.w	&_kw_loopVar, r13
	cmp.w	r13, r12
	jhs	.LBB5_25
	jmp	.LBB5_24
.LBB5_24:                               ; %newBB55
                                        ;   in Loop: Header=BB5_22 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#27, 30(r12)
	call	#checkpoint
	mov.w	#1, &_kw_loopVar
	mov.w	#_global_sibling9_add_node, r15
	call	#check_before_write_must_unconditional
	mov.w	#_global_sibling_node_add_node, r15
	call	#check_before_write_must_unconditional
	jmp	.LBB5_25
.LBB5_25:                               ; %while.body
                                        ;   in Loop: Header=BB5_22 Depth=1
	mov.w	&_global_sibling_node_add_node, r12
	mov.w	2(r12), r12
	mov.w	r12, &_global_sibling9_add_node
	mov.w	&_np_dict.addr_add_node, r13
	mov.w	#6, r14
	mov.w	r12, r15
	mov.w	r13, -52(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-52(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, &_global_sibling_node_add_node
	mov.w	&_kw_loopVar, r12
	add.w	#1, r12
	mov.w	r12, &_kw_loopVar
	jmp	.LBB5_20
.LBB5_26:                               ; %condBB61
	mov.w	&chkpt_status+56, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_28
	jmp	.LBB5_27
.LBB5_27:                               ; %newBB62
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#28, 30(r12)
	call	#checkpoint
	jmp	.LBB5_28
.LBB5_28:                               ; %while.end
	mov.w	&_global_node_index_add_node, r12
	mov.w	&_global_sibling9_add_node, r15
	mov.w	&_np_dict.addr_add_node, r13
	mov.w	#6, r14
	mov.w	r12, -54(r4)            ; 2-byte Folded Spill
	mov.w	r13, -56(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-56(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, r15
	mov.w	r12, -58(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-58(r4), r12            ; 2-byte Folded Reload
	mov.w	-54(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 2(r12)
	jmp	.LBB5_32
.LBB5_29:                               ; %condBB40
	mov.w	&chkpt_status+50, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_31
	jmp	.LBB5_30
.LBB5_30:                               ; %newBB41
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#25, 30(r12)
	call	#checkpoint
	jmp	.LBB5_31
.LBB5_31:                               ; %if.else
	mov.w	&_global_node_index_add_node, r12
	mov.w	&_global_parent.addr_add_node, r15
	mov.w	&_np_dict.addr_add_node, r13
	mov.w	#6, r14
	mov.w	r12, -60(r4)            ; 2-byte Folded Spill
	mov.w	r13, -62(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-62(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, r13
	add.w	#4, r13
	mov.w	r13, r15
	mov.w	r12, -64(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-64(r4), r12            ; 2-byte Folded Reload
	mov.w	-60(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 4(r12)
	jmp	.LBB5_34
.LBB5_32:                               ; %condBB75
	mov.w	&chkpt_status+60, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_36
	jmp	.LBB5_33
.LBB5_33:                               ; %newBB76
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#30, 30(r12)
	call	#checkpoint
	jmp	.LBB5_36
.LBB5_34:                               ; %condBB82
	mov.w	&chkpt_status+62, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB5_36
	jmp	.LBB5_35
.LBB5_35:                               ; %newBB83
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#31, 30(r12)
	call	#checkpoint
	jmp	.LBB5_36
.LBB5_36:                               ; %if.end.23
	add.w	#60, r1
	pop.w	r9
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-8(r5), r9
	pop.w	r5
	pop.w	r10
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-6(r5), r10
	pop.w	r5
	pop.w	r11
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-4(r5), r11
	pop.w	r5
	pop.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-2(r5), r4
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	0(r6), r5
	pop.w	r6
	mov.w	r5, 2(r1)
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r5
	sub.w	#10, r5
	mov.w	r5, &special_sp
	mov.w	&stack_tracer, r6
	cmp.w	r6, r5
	jhs	+4
	mov.w	r5, &stack_tracer
	pop.w	r6
	pop.w	r5
	ret
.Lfunc_end5:
	.size	_kw_add_node, .Lfunc_end5-_kw_add_node

	.globl	append_compressed
	.align	2
	.type	append_compressed,@function
append_compressed:                      ; @append_compressed
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	push.w	r9
	sub.w	#18, r1
	;DEBUG_VALUE: append_compressed:parent <- undef
	;DEBUG_VALUE: append_compressed:log <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	mov.w	-8(r4), r15
	mov.w	r14, r11
	add.w	#128, r11
	mov.w	128(r14), r10
	mov.w	r10, r9
	add.w	#1, r9
	mov.w	r15, -12(r4)            ; 2-byte Folded Spill
	mov.w	r11, r15
	mov.w	r14, -14(r4)            ; 2-byte Folded Spill
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r10, -20(r4)            ; 2-byte Folded Spill
	mov.w	r9, -22(r4)             ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	-22(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 128(r12)
	mov.w	-10(r4), r13
	mov.w	-20(r4), r14            ; 2-byte Folded Reload
	rla.w	r14
	add.w	r14, r13
	mov.w	r13, r15
	mov.w	r13, -24(r4)            ; 2-byte Folded Spill
	call	#check_before_write_may
	mov.w	-24(r4), r12            ; 2-byte Folded Reload
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 0(r12)
	add.w	#18, r1
	pop.w	r9
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end6:
	.size	append_compressed, .Lfunc_end6-append_compressed

	.globl	init
	.align	2
	.type	init,@function
init:                                   ; @init
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
	;APP
	eint { nop
	;NO_APP
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
	;DEBUG_VALUE: i <- [FP+-2]
	mov.w	#0, -2(r4)
	jmp	.LBB7_3
.LBB7_3:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	cmp.w	#1200, r12
	jhs	.LBB7_6
	jmp	.LBB7_4
.LBB7_4:                                ; %for.body
                                        ;   in Loop: Header=BB7_3 Depth=1
	jmp	.LBB7_5
.LBB7_5:                                ; %for.inc
                                        ;   in Loop: Header=BB7_3 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB7_3
.LBB7_6:                                ; %for.end
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end7:
	.size	init, .Lfunc_end7-init

	.globl	main
	.align	2
	.type	main,@function
main:                                   ; @main
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#44, r1
	call	#init
	call	#restore
	mov.w	#0, -2(r4)
	jmp	.LBB8_1
.LBB8_1:                                ; %condBB
	mov.w	&chkpt_status+64, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_5
	jmp	.LBB8_2
.LBB8_2:                                ; %newBB
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#32, 30(r12)
	call	#checkpoint
	jmp	.LBB8_5
.LBB8_3:                                ; %condBB150
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+108, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_5
	jmp	.LBB8_4
.LBB8_4:                                ; %newBB151
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#54, 30(r12)
	call	#checkpoint
	jmp	.LBB8_5
.LBB8_5:                                ; %while.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB8_16 Depth 2
                                        ;       Child Loop BB8_37 Depth 3
                                        ;         Child Loop BB8_49 Depth 4
                                        ;         Child Loop BB8_51 Depth 4
	jmp	.LBB8_6
.LBB8_6:                                ; %condBB3
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+66, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_8
	jmp	.LBB8_7
.LBB8_7:                                ; %newBB4
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#33, 30(r12)
	call	#checkpoint
	jmp	.LBB8_8
.LBB8_8:                                ; %do.body
                                        ;   in Loop: Header=BB8_5 Depth=1
	call	#request_non_interactive_debug_mode
	mov.w	r1, r12
	mov.w	#.L.str.3, 0(r12)
	call	#printf
	mov.w	r15, -8(r4)             ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB8_9
.LBB8_9:                                ; %condBB10
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+68, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_11
	jmp	.LBB8_10
.LBB8_10:                               ; %newBB11
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#34, 30(r12)
	call	#checkpoint
	jmp	.LBB8_11
.LBB8_11:                               ; %do.end
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	#_global_dict_promoted_main, r15
	call	#_kw_init_dict
	mov.w	#_global_letter_main, r15
	call	#check_before_write_must
	mov.w	#0, &_global_letter_main
	mov.w	#_global_letter_idx_main, r15
	call	#check_before_write_must
	mov.w	#0, &_global_letter_idx_main
	mov.w	#_global_prev_sample_main, r15
	call	#check_before_write_must
	mov.w	#0, &_global_prev_sample_main
	mov.w	#130, r15
	add.w	#_global_log_promoted_main, r15
	call	#check_before_write_may
	mov.w	#1, &_global_log_promoted_main+130
	mov.w	#128, r15
	add.w	#_global_log_promoted_main, r15
	call	#check_before_write_may
	mov.w	#0, &_global_log_promoted_main+128
	jmp	.LBB8_12
.LBB8_12:                               ; %condBB17
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+70, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_16
	jmp	.LBB8_13
.LBB8_13:                               ; %newBB18
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#35, 30(r12)
	call	#checkpoint
	jmp	.LBB8_16
.LBB8_14:                               ; %condBB157
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+110, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_16
	jmp	.LBB8_15
.LBB8_15:                               ; %newBB158
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#55, 30(r12)
	call	#checkpoint
	jmp	.LBB8_16
.LBB8_16:                               ; %while.body.2
                                        ;   Parent Loop BB8_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB8_37 Depth 3
                                        ;         Child Loop BB8_49 Depth 4
                                        ;         Child Loop BB8_51 Depth 4
	mov.w	&_global_letter_main, r12
	mov.w	#_global_child_main, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_child_main
	mov.w	&_global_letter_idx_main, r12
	cmp.w	#0, r12
	jne	.LBB8_20
	jmp	.LBB8_17
.LBB8_17:                               ; %condBB24
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+72, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_19
	jmp	.LBB8_18
.LBB8_18:                               ; %newBB25
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#36, 30(r12)
	call	#checkpoint
	jmp	.LBB8_19
.LBB8_19:                               ; %if.then
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	#_global_prev_sample_main, r15
	mov.w	&_global_prev_sample_main, r12
	mov.w	r15, -12(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#acquire_sample
	mov.w	#_global_sample_main, r12
	mov.w	r15, -14(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#check_before_write_must
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_sample_main
	mov.w	-12(r4), r15            ; 2-byte Folded Reload
	call	#check_before_write_must
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_prev_sample_main
	jmp	.LBB8_22
.LBB8_20:                               ; %condBB31
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+74, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_24
	jmp	.LBB8_21
.LBB8_21:                               ; %newBB32
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#37, 30(r12)
	call	#checkpoint
	jmp	.LBB8_24
.LBB8_22:                               ; %condBB38
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+76, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_24
	jmp	.LBB8_23
.LBB8_23:                               ; %newBB39
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#38, 30(r12)
	call	#checkpoint
	jmp	.LBB8_24
.LBB8_24:                               ; %if.end
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	#_global_letter_idx_main, r15
	mov.w	&_global_letter_idx_main, r12
	add.w	#1, r12
	mov.w	r12, -16(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_letter_idx_main
	cmp.w	#2, r12
	jne	.LBB8_28
	jmp	.LBB8_25
.LBB8_25:                               ; %condBB45
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+78, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_27
	jmp	.LBB8_26
.LBB8_26:                               ; %newBB46
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#39, 30(r12)
	call	#checkpoint
	jmp	.LBB8_27
.LBB8_27:                               ; %if.then.5
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	#_global_letter_idx_main, r15
	call	#check_before_write_must
	mov.w	#0, &_global_letter_idx_main
	jmp	.LBB8_30
.LBB8_28:                               ; %condBB52
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+80, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_32
	jmp	.LBB8_29
.LBB8_29:                               ; %newBB53
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#40, 30(r12)
	call	#checkpoint
	jmp	.LBB8_32
.LBB8_30:                               ; %condBB59
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+82, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_32
	jmp	.LBB8_31
.LBB8_31:                               ; %newBB60
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#41, 30(r12)
	call	#checkpoint
	jmp	.LBB8_32
.LBB8_32:                               ; %if.end.6
                                        ;   in Loop: Header=BB8_16 Depth=2
	jmp	.LBB8_33
.LBB8_33:                               ; %condBB66
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+84, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_37
	jmp	.LBB8_34
.LBB8_34:                               ; %newBB67
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#42, 30(r12)
	call	#checkpoint
	jmp	.LBB8_37
.LBB8_35:                               ; %condBB101
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+94, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_37
	jmp	.LBB8_36
.LBB8_36:                               ; %newBB102
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#47, 30(r12)
	call	#checkpoint
	jmp	.LBB8_37
.LBB8_37:                               ; %do.body.7
                                        ;   Parent Loop BB8_5 Depth=1
                                        ;     Parent Loop BB8_16 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB8_49 Depth 4
                                        ;         Child Loop BB8_51 Depth 4
	;DEBUG_VALUE: letter_idx_tmp <- [FP+-4]
	mov.w	&_global_letter_idx_main, r12
	cmp.w	#0, r12
	jne	.LBB8_41
	jmp	.LBB8_38
.LBB8_38:                               ; %condBB73
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+86, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_40
	jmp	.LBB8_39
.LBB8_39:                               ; %newBB74
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#43, 30(r12)
	call	#checkpoint
	jmp	.LBB8_40
.LBB8_40:                               ; %cond.true
                                        ;   in Loop: Header=BB8_37 Depth=3
	jmp	.LBB8_44
.LBB8_41:                               ; %condBB80
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+88, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_43
	jmp	.LBB8_42
.LBB8_42:                               ; %newBB81
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#44, 30(r12)
	call	#checkpoint
	jmp	.LBB8_43
.LBB8_43:                               ; %cond.false
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&_global_letter_idx_main, r12
	add.w	#-1, r12
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	jmp	.LBB8_46
.LBB8_44:                               ; %condBB87
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+90, r12
	mov.w	&mode_status, r13
	mov.w	#2, r14
	bit.w	r13, r12
	mov.w	r14, -20(r4)            ; 2-byte Folded Spill
	jne	.LBB8_48
	jmp	.LBB8_45
.LBB8_45:                               ; %newBB88
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#45, 30(r12)
	mov.w	#2, &_global_phi_newBB88_2
	call	#checkpoint
	mov.w	&_global_phi_newBB88_2, r12
	mov.w	r12, -20(r4)            ; 2-byte Folded Spill
	jmp	.LBB8_48
.LBB8_46:                               ; %condBB164
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+112, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -20(r4)            ; 2-byte Folded Spill
	jne	.LBB8_48
	jmp	.LBB8_47
.LBB8_47:                               ; %newBB165
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#56, 30(r12)
	mov.w	#_global_phi_newBB165_sub, r15
	call	#check_before_write_must
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_phi_newBB165_sub
	call	#checkpoint
	mov.w	&_global_phi_newBB165_sub, r12
	mov.w	r12, -20(r4)            ; 2-byte Folded Spill
	jmp	.LBB8_48
.LBB8_48:                               ; %cond.end
                                        ;   in Loop: Header=BB8_37 Depth=3
	;DEBUG_VALUE: letter_shift <- [FP+-6]
	mov.w	-20(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	rla.w	r12
	rla.w	r12
	rla.w	r12
	mov.w	r12, -6(r4)
	mov.w	&_global_sample_main, r12
	mov.b	-6(r4), r13
	mov.w	#255, r14
	cmp.b	#0, r13
	mov.b	r13, r15
	mov.w	r12, -22(r4)            ; 2-byte Folded Spill
	mov.b	r13, -23(r4)            ; 1-byte Folded Spill
	mov.w	r14, -26(r4)            ; 2-byte Folded Spill
	mov.b	r15, -27(r4)            ; 1-byte Folded Spill
	jeq	.LBB8_50
.LBB8_49:                               ; %cond.end
                                        ;   Parent Loop BB8_5 Depth=1
                                        ;     Parent Loop BB8_16 Depth=2
                                        ;       Parent Loop BB8_37 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.b	-27(r4), r12            ; 1-byte Folded Reload
	mov.w	-26(r4), r13            ; 2-byte Folded Reload
	rla.w	r13
	sub.b	#1, r12
	mov.w	r13, -26(r4)            ; 2-byte Folded Spill
	mov.b	r12, -27(r4)            ; 1-byte Folded Spill
	jne	.LBB8_49
.LBB8_50:                               ; %cond.end
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	-26(r4), r12            ; 2-byte Folded Reload
	mov.w	-22(r4), r13            ; 2-byte Folded Reload
	and.w	r12, r13
	mov.b	-23(r4), r14            ; 1-byte Folded Reload
	cmp.b	#0, r14
	mov.b	r14, -28(r4)            ; 1-byte Folded Spill
	mov.w	r13, -30(r4)            ; 2-byte Folded Spill
	jeq	.LBB8_52
.LBB8_51:                               ; %cond.end
                                        ;   Parent Loop BB8_5 Depth=1
                                        ;     Parent Loop BB8_16 Depth=2
                                        ;       Parent Loop BB8_37 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov.b	-28(r4), r12            ; 1-byte Folded Reload
	mov.w	-30(r4), r13            ; 2-byte Folded Reload
	clrc
	rrc.w	r13
	sub.b	#1, r12
	mov.w	r13, -30(r4)            ; 2-byte Folded Spill
	mov.b	r12, -28(r4)            ; 1-byte Folded Spill
	jne	.LBB8_51
.LBB8_52:                               ; %cond.end
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	mov.w	#_global_letter_main, r15
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#2, r5
	mov.w	r5, &special_sp
	pop.w	r5
	mov.w	r12, -32(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_letter_main
	mov.w	#130, r12
	add.w	#_global_log_promoted_main, r12
	mov.w	&_global_log_promoted_main+130, r15
	add.w	#1, r15
	mov.w	r15, -34(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#check_before_write_may
	mov.w	-34(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_log_promoted_main+130
	mov.w	#_global_child_main, r15
	mov.w	&_global_child_main, r12
	mov.w	#_global_parent_main, r13
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r15, 0(r5)
	pop.w	r5
	mov.w	r13, r15
	mov.w	r12, -38(r4)            ; 2-byte Folded Spill
	call	#check_before_write_must
	mov.w	-38(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &_global_parent_main
	mov.w	&_global_letter_main, r15
	mov.w	#_global_dict_promoted_main, r13
	mov.w	r12, r14
	call	#_kw_find_child
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	0(r5), r12            ; 2-byte Folded Reload

	pop.w	r5
	mov.w	r15, -40(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#check_before_write_must
	mov.w	-40(r4), r12            ; 2-byte Folded Reload
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
	jmp	.LBB8_53
.LBB8_53:                               ; %condBB94
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&chkpt_status+92, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_55
	jmp	.LBB8_54
.LBB8_54:                               ; %newBB95
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#46, 30(r12)
	call	#checkpoint
	jmp	.LBB8_55
.LBB8_55:                               ; %do.cond
                                        ;   in Loop: Header=BB8_37 Depth=3
	mov.w	&_global_child_main, r12
	cmp.w	#0, r12
	jeq	4
	br	#.LBB8_35
	jmp	.LBB8_56
.LBB8_56:                               ; %condBB108
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+96, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_58
	jmp	.LBB8_57
.LBB8_57:                               ; %newBB109
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#48, 30(r12)
	call	#checkpoint
	jmp	.LBB8_58
.LBB8_58:                               ; %do.end.13
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&_global_parent_main, r15
	mov.w	#_global_log_promoted_main, r14
	call	#append_compressed
	mov.w	&_global_letter_main, r15
	mov.w	&_global_parent_main, r14
	mov.w	#_global_dict_promoted_main, r13
	call	#_kw_add_node
	mov.w	&_global_log_promoted_main+128, r13
	cmp.w	#64, r13
	jne	.LBB8_68
	jmp	.LBB8_59
.LBB8_59:                               ; %condBB115
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+98, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_61
	jmp	.LBB8_60
.LBB8_60:                               ; %newBB116
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#49, 30(r12)
	call	#checkpoint
	jmp	.LBB8_61
.LBB8_61:                               ; %if.then.16
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	#_global_log_promoted_main, r15
	call	#_kw_print_log
	mov.w	#128, r15
	add.w	#_global_log_promoted_main, r15
	call	#check_before_write_may
	mov.w	#0, &_global_log_promoted_main+128
	mov.w	#130, r15
	add.w	#_global_log_promoted_main, r15
	call	#check_before_write_may
	mov.w	#0, &_global_log_promoted_main+130
	jmp	.LBB8_62
.LBB8_62:                               ; %condBB129
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+102, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_64
	jmp	.LBB8_63
.LBB8_63:                               ; %newBB130
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#51, 30(r12)
	call	#checkpoint
	jmp	.LBB8_64
.LBB8_64:                               ; %do.body.19
                                        ;   in Loop: Header=BB8_5 Depth=1
	call	#request_non_interactive_debug_mode
	mov.w	r1, r12
	mov.w	#.L.str.4, 0(r12)
	call	#printf
	mov.w	r15, -42(r4)            ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB8_65
.LBB8_65:                               ; %condBB136
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+104, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_67
	jmp	.LBB8_66
.LBB8_66:                               ; %newBB137
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#52, 30(r12)
	call	#checkpoint
	jmp	.LBB8_67
.LBB8_67:                               ; %do.end.22
                                        ;   in Loop: Header=BB8_5 Depth=1
	call	#_kw_end_run
	jmp	.LBB8_71
.LBB8_68:                               ; %condBB122
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&chkpt_status+100, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_70
	jmp	.LBB8_69
.LBB8_69:                               ; %newBB123
                                        ;   in Loop: Header=BB8_16 Depth=2
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#50, 30(r12)
	call	#checkpoint
	jmp	.LBB8_70
.LBB8_70:                               ; %if.end.23
                                        ;   in Loop: Header=BB8_16 Depth=2
	br	#.LBB8_14
.LBB8_71:                               ; %condBB143
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&chkpt_status+106, r12
	mov.w	&mode_status, r13
	bit.w	r13, r12
	jne	.LBB8_73
	jmp	.LBB8_72
.LBB8_72:                               ; %newBB144
                                        ;   in Loop: Header=BB8_5 Depth=1
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#53, 30(r12)
	call	#checkpoint
	jmp	.LBB8_73
.LBB8_73:                               ; %while.end
                                        ;   in Loop: Header=BB8_5 Depth=1
	br	#.LBB8_3
.Lfunc_end8:
	.size	main, .Lfunc_end8-main

	.align	2
	.type	init_hw,@function
init_hw:                                ; @init_hw
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
.Lfunc_end9:
	.size	init_hw, .Lfunc_end9-init_hw

	.globl	msp_watchdog_enable
	.align	2
	.type	msp_watchdog_enable,@function
msp_watchdog_enable:                    ; @msp_watchdog_enable
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	;DEBUG_VALUE: msp_watchdog_enable:bits <- R15
	;DEBUG_VALUE: msp_watchdog_enable:bits <- R15
	mov.b	r15, r12
	bis.w	#23048, r15
	mov.w	r15, &0x015C
	mov.b	r12, &watchdog_bits
	pop.w	r4
	ret
.Lfunc_end10:
	.size	msp_watchdog_enable, .Lfunc_end10-msp_watchdog_enable

	.globl	msp_watchdog_disable
	.align	2
	.type	msp_watchdog_disable,@function
msp_watchdog_disable:                   ; @msp_watchdog_disable
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#23168, &0x015C
	pop.w	r4
	ret
.Lfunc_end11:
	.size	msp_watchdog_disable, .Lfunc_end11-msp_watchdog_disable

	.globl	msp_watchdog_kick
	.align	2
	.type	msp_watchdog_kick,@function
msp_watchdog_kick:                      ; @msp_watchdog_kick
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&watchdog_bits, r12
	bis.w	#23048, r12
	mov.w	r12, &0x015C
	pop.w	r4
	ret
.Lfunc_end12:
	.size	msp_watchdog_kick, .Lfunc_end12-msp_watchdog_kick

	.globl	memcpy
	.align	2
	.type	memcpy,@function
memcpy:                                 ; @memcpy
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: memcpy:dest <- R15
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:n <- R13
	;DEBUG_VALUE: memcpy:n <- R13
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:dest <- R15
	;DEBUG_VALUE: memcpy:i <- 0
	mov.w	r13, r12
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:dest <- R15
	cmp.w	#0, r13
	mov.w	r15, -2(r4)             ; 2-byte Folded Spill
	;DEBUG_VALUE: memcpy:dest <- [FP+-2]
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	mov.w	r14, -6(r4)             ; 2-byte Folded Spill
	;DEBUG_VALUE: memcpy:src <- [FP+-6]
	jeq	.LBB13_4
	jmp	.LBB13_1
.LBB13_1:                               ; %while.body.preheader
	mov.w	#0, r12
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jmp	.LBB13_2
.LBB13_2:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	-6(r4), r13             ; 2-byte Folded Reload
	add.w	r12, r13
	mov.b	0(r13), r14
	mov.w	-2(r4), r13             ; 2-byte Folded Reload
	add.w	r12, r13
	mov.b	r14, 0(r13)
	add.w	#1, r12
	;DEBUG_VALUE: memcpy:i <- R12
	mov.w	-4(r4), r13             ; 2-byte Folded Reload
	cmp.w	r13, r12
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jne	.LBB13_2
	jmp	.LBB13_3
.LBB13_3:                               ; %while.end.loopexit
	jmp	.LBB13_4
.LBB13_4:                               ; %while.end
	mov.w	-2(r4), r15             ; 2-byte Folded Reload
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end13:
	.size	memcpy, .Lfunc_end13-memcpy

	.globl	msp_clock_setup
	.align	2
	.type	msp_clock_setup,@function
msp_clock_setup:                        ; @msp_clock_setup
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	#-91, &0x0160+1
	mov.w	#51, &0x0164
	mov.w	#0, &0x0166
	pop.w	r4
	ret
.Lfunc_end14:
	.size	msp_clock_setup, .Lfunc_end14-msp_clock_setup

	.globl	mult16
	.align	2
	.type	mult16,@function
mult16:                                 ; @mult16
; BB#0:                                 ; %entry
	;APP
	MOV R15, &0x04C0
MOV R14, &0x04C8
MOV &0x04CA, R14
MOV &0x04CC, R15
RET

	;NO_APP
.Lfunc_end15:
	.size	mult16, .Lfunc_end15-mult16

	.globl	sqrt16
	.align	2
	.type	sqrt16,@function
sqrt16:                                 ; @sqrt16
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#30, r1
	;DEBUG_VALUE: sqrt16:x <- undef
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -6(r4)
	mov.w	r14, -8(r4)
	mov.w	#-1, -10(r4)
	mov.w	#0, -12(r4)
	mov.w	-10(r4), r14
	clrc
	rrc.w	r14
	mov.w	r14, -14(r4)
	mov.w	#0, -18(r4)
	mov.w	#0, -20(r4)
	mov.w	r13, -22(r4)            ; 2-byte Folded Spill
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	jmp	.LBB16_1
.LBB16_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-20(r4), r12
	mov.w	-18(r4), r13
	mov.w	-8(r4), r14
	mov.w	-6(r4), r15
	mov.b	#0, r11
	xor.w	r15, r13
	xor.w	r14, r12
	bis.w	r13, r12
	cmp.w	#0, r12
	mov.b	r11, -25(r4)            ; 1-byte Folded Spill
	jeq	.LBB16_3
	jmp	.LBB16_2
.LBB16_2:                               ; %land.rhs
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	sub.w	r13, r12
	cmp.w	#2, r12
	mov.w	r2, r12
	and.w	#1, r12
	mov.b	r12, r14
	mov.b	r14, -25(r4)            ; 1-byte Folded Spill
	jmp	.LBB16_3
.LBB16_3:                               ; %land.end
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.b	-25(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB16_10
	jmp	.LBB16_4
.LBB16_4:                               ; %while.body
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	mov.w	#0, r14
	add.w	r13, r12
	addc.w	#0, r14
	clrc
	rrc.w	r12
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	bis.w	r14, r12
	mov.w	r12, -14(r4)
	mov.w	r12, r15
	mov.w	r12, r14
	call	#mult16
	mov.w	r15, -18(r4)
	mov.w	r14, -20(r4)
	mov.w	-8(r4), r12
	mov.w	-6(r4), r13
	cmp.w	r13, r15
	mov.w	r2, r11
	and.w	#1, r11
	cmp.w	r12, r14
	mov.w	r2, r12
	and.w	#1, r12
	cmp.w	r13, r15
	mov.w	r11, -28(r4)            ; 2-byte Folded Spill
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
	jeq	.LBB16_6
; BB#5:                                 ; %while.body
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
.LBB16_6:                               ; %while.body
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	bit.w	#1, r12
	jne	.LBB16_8
	jmp	.LBB16_7
.LBB16_7:                               ; %if.then
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -12(r4)
	jmp	.LBB16_9
.LBB16_8:                               ; %if.else
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -10(r4)
	jmp	.LBB16_9
.LBB16_9:                               ; %if.end
                                        ;   in Loop: Header=BB16_1 Depth=1
	jmp	.LBB16_1
.LBB16_10:                              ; %while.end
	mov.w	-14(r4), r15
	add.w	#30, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end16:
	.size	sqrt16, .Lfunc_end16-sqrt16

	.globl	udivmodhi4
	.align	2
	.type	udivmodhi4,@function
udivmodhi4:                             ; @udivmodhi4
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#20, r1
	;DEBUG_VALUE: udivmodhi4:num <- undef
	;DEBUG_VALUE: udivmodhi4:den <- undef
	;DEBUG_VALUE: udivmodhi4:modwanted <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	mov.w	r13, -12(r4)
	mov.w	#1, -14(r4)
	mov.w	#0, -16(r4)
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	mov.w	r10, -22(r4)            ; 2-byte Folded Spill
	jmp	.LBB17_1
.LBB17_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	mov.b	#0, r14
	cmp.w	r13, r12
	mov.b	r14, -23(r4)            ; 1-byte Folded Spill
	jhs	.LBB17_4
	jmp	.LBB17_2
.LBB17_2:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.w	-14(r4), r12
	mov.b	#0, r13
	cmp.w	#0, r12
	mov.b	r13, -23(r4)            ; 1-byte Folded Spill
	jeq	.LBB17_4
	jmp	.LBB17_3
.LBB17_3:                               ; %land.rhs
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.b	-9(r4), r12
	bit.b	#-128, r12
	mov.w	r2, r13
	rra.w	r13
	and.w	#1, r13
	mov.b	r13, r12
	mov.b	r12, -23(r4)            ; 1-byte Folded Spill
	jmp	.LBB17_4
.LBB17_4:                               ; %land.end
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.b	-23(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB17_6
	jmp	.LBB17_5
.LBB17_5:                               ; %while.body
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.w	-10(r4), r12
	rla.w	r12
	mov.w	r12, -10(r4)
	mov.w	-14(r4), r12
	rla.w	r12
	mov.w	r12, -14(r4)
	jmp	.LBB17_1
.LBB17_6:                               ; %while.end
	jmp	.LBB17_7
.LBB17_7:                               ; %while.cond.3
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-14(r4), r12
	cmp.w	#0, r12
	jeq	.LBB17_11
	jmp	.LBB17_8
.LBB17_8:                               ; %while.body.5
                                        ;   in Loop: Header=BB17_7 Depth=1
	mov.w	-8(r4), r12
	mov.w	-10(r4), r13
	cmp.w	r13, r12
	jlo	.LBB17_10
	jmp	.LBB17_9
.LBB17_9:                               ; %if.then
                                        ;   in Loop: Header=BB17_7 Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	mov.w	-14(r4), r12
	mov.w	-16(r4), r13
	bis.w	r12, r13
	mov.w	r13, -16(r4)
	jmp	.LBB17_10
.LBB17_10:                              ; %if.end
                                        ;   in Loop: Header=BB17_7 Depth=1
	mov.w	-14(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -14(r4)
	mov.w	-10(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -10(r4)
	jmp	.LBB17_7
.LBB17_11:                              ; %while.end.8
	mov.w	-12(r4), r12
	cmp.w	#0, r12
	jeq	.LBB17_13
	jmp	.LBB17_12
.LBB17_12:                              ; %if.then.10
	mov.w	-8(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB17_14
.LBB17_13:                              ; %if.end.11
	mov.w	-16(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB17_14
.LBB17_14:                              ; %return
	mov.w	-6(r4), r15
	add.w	#20, r1
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end17:
	.size	udivmodhi4, .Lfunc_end17-udivmodhi4

	.globl	__divhi3
	.align	2
	.type	__divhi3,@function
__divhi3:                               ; @__divhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __divhi3:a <- undef
	;DEBUG_VALUE: __divhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB18_2
	jmp	.LBB18_1
.LBB18_1:                               ; %if.then
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB18_2
.LBB18_2:                               ; %if.end
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB18_4
	jmp	.LBB18_3
.LBB18_3:                               ; %if.then.2
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB18_4
.LBB18_4:                               ; %if.end.7
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#0, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r13
	cmp.w	#0, r13
	jeq	.LBB18_6
	jmp	.LBB18_5
.LBB18_5:                               ; %if.then.9
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB18_6
.LBB18_6:                               ; %if.end.11
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end18:
	.size	__divhi3, .Lfunc_end18-__divhi3

	.globl	__modhi3
	.align	2
	.type	__modhi3,@function
__modhi3:                               ; @__modhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __modhi3:a <- undef
	;DEBUG_VALUE: __modhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB19_2
	jmp	.LBB19_1
.LBB19_1:                               ; %if.then
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	#1, -6(r4)
	jmp	.LBB19_2
.LBB19_2:                               ; %if.end
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB19_4
	jmp	.LBB19_3
.LBB19_3:                               ; %if.then.2
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	jmp	.LBB19_4
.LBB19_4:                               ; %if.end.4
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#1, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r13
	cmp.w	#0, r13
	jeq	.LBB19_6
	jmp	.LBB19_5
.LBB19_5:                               ; %if.then.5
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB19_6
.LBB19_6:                               ; %if.end.7
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end19:
	.size	__modhi3, .Lfunc_end19-__modhi3

	.globl	__udivhi3
	.align	2
	.type	__udivhi3,@function
__udivhi3:                              ; @__udivhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __udivhi3:a <- undef
	;DEBUG_VALUE: __udivhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#0, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end20:
	.size	__udivhi3, .Lfunc_end20-__udivhi3

	.globl	__umodhi3
	.align	2
	.type	__umodhi3,@function
__umodhi3:                              ; @__umodhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __umodhi3:a <- undef
	;DEBUG_VALUE: __umodhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#1, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end21:
	.size	__umodhi3, .Lfunc_end21-__umodhi3

	.globl	set_global_range
	.align	2
	.type	set_global_range,@function
set_global_range:                       ; @set_global_range
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#12, r1
	;DEBUG_VALUE: set_global_range:_start_addr <- undef
	;DEBUG_VALUE: set_global_range:_end_addr <- undef
	;DEBUG_VALUE: set_global_range:_start_addr_bak <- undef
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
.Lfunc_end22:
	.size	set_global_range, .Lfunc_end22-set_global_range

	.globl	update_checkpoints_naive
	.align	2
	.type	update_checkpoints_naive,@function
update_checkpoints_naive:               ; @update_checkpoints_naive
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	#0, -2(r4)
	jmp	.LBB23_1
.LBB23_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	mov.w	&CHKPT_NUM, r13
	cmp.w	r13, r12
	jhs	.LBB23_6
	jmp	.LBB23_2
.LBB23_2:                               ; %for.body
                                        ;   in Loop: Header=BB23_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	chkpt_book(r12), r13
	cmp.b	#0, r13
	jne	.LBB23_4
	jmp	.LBB23_3
.LBB23_3:                               ; %if.then
                                        ;   in Loop: Header=BB23_1 Depth=1
	mov.w	-2(r4), r12
	rla.w	r12
	mov.w	#1, chkpt_status(r12)
	jmp	.LBB23_4
.LBB23_4:                               ; %if.end
                                        ;   in Loop: Header=BB23_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	#0, chkpt_book(r12)
	jmp	.LBB23_5
.LBB23_5:                               ; %for.inc
                                        ;   in Loop: Header=BB23_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB23_1
.LBB23_6:                               ; %for.end
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end23:
	.size	update_checkpoints_naive, .Lfunc_end23-update_checkpoints_naive

	.globl	update_checkpoints_hysteresis
	.align	2
	.type	update_checkpoints_hysteresis,@function
update_checkpoints_hysteresis:          ; @update_checkpoints_hysteresis
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	#0, -2(r4)
	jmp	.LBB24_1
.LBB24_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	mov.w	&CHKPT_NUM, r13
	cmp.w	r13, r12
	jhs	.LBB24_6
	jmp	.LBB24_2
.LBB24_2:                               ; %for.body
                                        ;   in Loop: Header=BB24_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	chkpt_book(r12), r12
	sxt	r12
	cmp.w	#6, r12
	jl	.LBB24_4
	jmp	.LBB24_3
.LBB24_3:                               ; %if.then
                                        ;   in Loop: Header=BB24_1 Depth=1
	mov.w	-2(r4), r12
	rla.w	r12
	mov.w	#1, chkpt_status(r12)
	jmp	.LBB24_4
.LBB24_4:                               ; %if.end
                                        ;   in Loop: Header=BB24_1 Depth=1
	jmp	.LBB24_5
.LBB24_5:                               ; %for.inc
                                        ;   in Loop: Header=BB24_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB24_1
.LBB24_6:                               ; %for.end
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end24:
	.size	update_checkpoints_hysteresis, .Lfunc_end24-update_checkpoints_hysteresis

	.globl	_kw_end_run
	.align	2
	.type	_kw_end_run,@function
_kw_end_run:                            ; @_kw_end_run
; BB#0:                                 ; %entry
	push.w	r5
	mov.w	&special_sp, r5
	add.w	#4, r5
	mov.w	r5, &special_sp
	pop.w	r5
	push.w	r5
	mov.w	2(r1), r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	r5, 0(r6)
	pop.w	r6
	pop.w	r5
	push.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	r4, -2(r5)
	pop.w	r5
	mov.w	r1, r4
	mov.w	&cur_hist, r12
	mov.b	#1, 4(r12)
	mov.w	#0, &chkpt_count
	mov.w	#0, &chkpt_i
	mov.w	#0, &chkpt_iterator
	mov.b	#0, &chkpt_patching
	call	#checkpoint
	call	#update_checkpoints_pair
	pop.w	r4
	push.w	r5
	mov.w	&special_sp, r5
	mov.w	-2(r5), r4
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r6
	mov.w	0(r6), r5
	pop.w	r6
	mov.w	r5, 2(r1)
	pop.w	r5
	push.w	r5
	push.w	r6
	mov.w	&special_sp, r5
	sub.w	#4, r5
	mov.w	r5, &special_sp
	mov.w	&stack_tracer, r6
	cmp.w	r6, r5
	jhs	+4
	mov.w	r5, &stack_tracer
	pop.w	r6
	pop.w	r5
	ret
.Lfunc_end25:
	.size	_kw_end_run, .Lfunc_end25-_kw_end_run

	.globl	binary_patch
	.align	2
	.type	binary_patch,@function
binary_patch:                           ; @binary_patch
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: binary_patch:c_cnt <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&cur_hist, r15
	mov.w	#hist0, r13
	mov.w	#hist1, r14
	cmp.w	r13, r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r14, -10(r4)            ; 2-byte Folded Spill
	jeq	.LBB26_2
; BB#1:                                 ; %entry
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
.LBB26_2:                               ; %entry
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	mov.w	&cur_hist, r13
	mov.w	0(r13), r13
	mov.w	r13, 2(r12)
	mov.w	-2(r4), r12
	mov.w	-4(r4), r13
	mov.w	r12, 0(r13)
	mov.w	-4(r4), r12
	mov.b	#0, 4(r12)
	mov.w	-4(r4), r12
	mov.w	r12, &cur_hist
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end26:
	.size	binary_patch, .Lfunc_end26-binary_patch

	.globl	update_checkpoints_pair
	.align	2
	.type	update_checkpoints_pair,@function
update_checkpoints_pair:                ; @update_checkpoints_pair
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	mov.w	&cur_hist, r12
	mov.b	4(r12), r13
	cmp.b	#0, r13
	jeq	.LBB27_18
	jmp	.LBB27_1
.LBB27_1:                               ; %if.then
	jmp	.LBB27_2
.LBB27_2:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&chkpt_i, r12
	mov.w	&CHKPT_NUM, r13
	cmp.w	r13, r12
	jhs	.LBB27_17
	jmp	.LBB27_3
.LBB27_3:                               ; %while.body
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	chkpt_status(r12), r12
	cmp.w	#-1, r12
	jeq	.LBB27_15
	jmp	.LBB27_4
.LBB27_4:                               ; %if.then.2
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	mov.b	chkpt_book(r12), r12
	sxt	r12
	cmp.w	#1, r12
	jge	.LBB27_12
	jmp	.LBB27_5
.LBB27_5:                               ; %if.then.6
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	mov.b	#1, chkpt_book(r12)
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	chkpt_status(r12), r12
	cmp.w	#0, r12
	jne	.LBB27_7
	jmp	.LBB27_6
.LBB27_6:                               ; %if.then.11
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	#1, chkpt_status(r12)
	jmp	.LBB27_11
.LBB27_7:                               ; %if.else
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	chkpt_status(r12), r12
	cmp.w	#-32768, r12
	jne	.LBB27_9
	jmp	.LBB27_8
.LBB27_8:                               ; %if.then.16
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	#-1, chkpt_status(r12)
	jmp	.LBB27_10
.LBB27_9:                               ; %if.else.18
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	rla.w	r12
	mov.w	chkpt_status(r12), r13
	rla.w	r13
	mov.w	r13, chkpt_status(r12)
	jmp	.LBB27_10
.LBB27_10:                              ; %if.end
                                        ;   in Loop: Header=BB27_2 Depth=1
	jmp	.LBB27_11
.LBB27_11:                              ; %if.end.20
                                        ;   in Loop: Header=BB27_2 Depth=1
	jmp	.LBB27_12
.LBB27_12:                              ; %if.end.21
                                        ;   in Loop: Header=BB27_2 Depth=1
	jmp	.LBB27_13
.LBB27_13:                              ; %do.body
                                        ;   in Loop: Header=BB27_2 Depth=1
	call	#request_non_interactive_debug_mode
	mov.w	&chkpt_i, r12
	mov.w	r12, r13
	rla.w	r13
	mov.w	chkpt_status(r13), r13
	mov.w	r1, r14
	mov.w	r13, 4(r14)
	mov.w	r12, 2(r14)
	mov.w	#.L.str.25, 0(r14)
	call	#printf
	mov.w	r15, -2(r4)             ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB27_14
.LBB27_14:                              ; %do.end
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	add.w	#1, r12
	mov.w	r12, &chkpt_i
	mov.w	&chkpt_count, r12
	add.w	#1, r12
	mov.w	r12, &chkpt_count
	mov.w	&chkpt_i, r12
	mov.b	#0, chkpt_book-1(r12)
	jmp	.LBB27_16
.LBB27_15:                              ; %if.else.25
                                        ;   in Loop: Header=BB27_2 Depth=1
	mov.w	&chkpt_i, r12
	add.w	#1, r12
	mov.w	r12, &chkpt_i
	jmp	.LBB27_16
.LBB27_16:                              ; %if.end.27
                                        ;   in Loop: Header=BB27_2 Depth=1
	jmp	.LBB27_2
.LBB27_17:                              ; %while.end
	mov.w	&chkpt_count, r15
	call	#binary_patch
	jmp	.LBB27_18
.LBB27_18:                              ; %if.end.28
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end27:
	.size	update_checkpoints_pair, .Lfunc_end27-update_checkpoints_pair

	.globl	update_hysteresis
	.align	2
	.type	update_hysteresis,@function
update_hysteresis:                      ; @update_hysteresis
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: update_hysteresis:last_chkpt <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.b	#0, chkpt_book(r15)
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end28:
	.size	update_hysteresis, .Lfunc_end28-update_hysteresis

	.globl	make_table
	.align	2
	.type	make_table,@function
make_table:                             ; @make_table
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: make_table:addr <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end29:
	.size	make_table, .Lfunc_end29-make_table

	.globl	clear_bitmask
	.align	2
	.type	clear_bitmask,@function
clear_bitmask:                          ; @clear_bitmask
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	&global_size, r12
	add.w	#7, r12
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -2(r4)
	jmp	.LBB30_1
.LBB30_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&clear_bitmask_iter, r12
	mov.w	-2(r4), r13
	cmp.w	r13, r12
	jhs	.LBB30_3
	jmp	.LBB30_2
.LBB30_2:                               ; %while.body
                                        ;   in Loop: Header=BB30_1 Depth=1
	mov.w	&clear_bitmask_iter, r12
	mov.b	#0, backup_bitmask(r12)
	mov.w	&clear_bitmask_iter, r12
	add.w	#1, r12
	mov.w	r12, &clear_bitmask_iter
	jmp	.LBB30_1
.LBB30_3:                               ; %while.end
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end30:
	.size	clear_bitmask, .Lfunc_end30-clear_bitmask

	.globl	checkpoint
	.align	2
	.type	checkpoint,@function
checkpoint:                             ; @checkpoint
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#22, r1
	;APP
	PUSH R12
	;NO_APP
	mov.w	&curctx, r12
	;APP
	MOV 0(r12), R12
	;NO_APP
	;APP
	MOV 26(R1), 0(R12)
	;NO_APP
	;APP
	MOV R1, 2(R12)
	;NO_APP
	;APP
	ADD #28, 2(R12)
	;NO_APP
	;APP
	MOV R2, 4(R12)
	;NO_APP
	;APP
	MOV 24(R1), 6(R12)
	;NO_APP
	;APP
	MOV R5, 8(R12)
	;NO_APP
	;APP
	MOV R6, 10(R12)
	;NO_APP
	;APP
	MOV R7, 12(R12)
	;NO_APP
	;APP
	MOV R8, 14(R12)
	;NO_APP
	;APP
	MOV R9, 16(R12)
	;NO_APP
	;APP
	MOV R10, 18(R12)
	;NO_APP
	;APP
	MOV R11, 20(R12)
	;NO_APP
	;APP
	MOV R12, -2(r4)
	;NO_APP
	mov.w	&curctx, r12
	mov.w	606(r12), r12
	mov.w	&stack_tracer, r13
	cmp.w	r12, r13
	jhs	.LBB31_2
	jmp	.LBB31_1
.LBB31_1:                               ; %cond.true
	mov.w	&stack_tracer, r12
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	jmp	.LBB31_3
.LBB31_2:                               ; %cond.false
	mov.w	&curctx, r12
	mov.w	606(r12), r12
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	jmp	.LBB31_3
.LBB31_3:                               ; %cond.end
	;DEBUG_VALUE: checkpoint:stack_size <- [FP+-6]
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	mov.w	&special_sp, r13
	sub.w	r12, r13
	mov.w	r13, -6(r4)
	;DEBUG_VALUE: checkpoint:st_offset <- [FP+-8]
	mov.w	-4(r4), r12
	add.w	#2, r12
	mov.w	#special_stack, r13
	sub.w	r13, r12
	mov.w	r12, -8(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	jeq	.LBB31_5
	jmp	.LBB31_4
.LBB31_4:                               ; %if.then
	mov.w	&curctx, r12
	mov.w	-8(r4), r13
	add.w	r13, r12
	add.w	#4, r12
	add.w	#special_stack, r13
	mov.w	-6(r4), r14
	mov.w	r12, r15
	mov.w	r14, -14(r4)            ; 2-byte Folded Spill
	mov.w	r13, r14
	mov.w	-14(r4), r13            ; 2-byte Folded Reload
	call	#memcpy
	jmp	.LBB31_5
.LBB31_5:                               ; %if.end
	mov.w	&special_sp, r12
	mov.w	&curctx, r13
	mov.w	r12, 604(r13)
	;DEBUG_VALUE: checkpoint:next_ctx <- [FP+-10]
	mov.w	&curctx, r12
	mov.w	#context_0, r13
	mov.w	#context_1, r14
	cmp.w	r13, r12
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	mov.w	r14, -18(r4)            ; 2-byte Folded Spill
	jeq	.LBB31_7
; BB#6:                                 ; %if.end
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
.LBB31_7:                               ; %if.end
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -10(r4)
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#regs_0, r13
	mov.w	#regs_1, r14
	cmp.w	r13, r12
	mov.w	r13, -20(r4)            ; 2-byte Folded Spill
	mov.w	r14, -22(r4)            ; 2-byte Folded Spill
	jeq	.LBB31_9
; BB#8:                                 ; %if.end
	mov.w	-20(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -22(r4)            ; 2-byte Folded Spill
.LBB31_9:                               ; %if.end
	mov.w	-22(r4), r12            ; 2-byte Folded Reload
	mov.w	-10(r4), r13
	mov.w	r12, 0(r13)
	mov.w	-10(r4), r12
	mov.w	#0, 2(r12)
	mov.w	&stack_tracer, r12
	mov.w	-10(r4), r13
	mov.w	r12, 606(r13)
	mov.b	&bitmask_counter, r14
	add.b	#1, r14
	mov.b	r14, &bitmask_counter
	cmp.b	#0, r14
	jne	.LBB31_11
	jmp	.LBB31_10
.LBB31_10:                              ; %if.then.14
	mov.b	#1, &need_bitmask_clear
	mov.b	&bitmask_counter, r12
	add.b	#1, r12
	mov.b	r12, &bitmask_counter
	jmp	.LBB31_11
.LBB31_11:                              ; %if.end.16
	mov.b	&need_bitmask_clear, r12
	cmp.b	#0, r12
	jeq	.LBB31_13
	jmp	.LBB31_12
.LBB31_12:                              ; %if.then.18
	call	#clear_bitmask
	mov.b	#0, &need_bitmask_clear
	jmp	.LBB31_13
.LBB31_13:                              ; %if.end.19
	mov.w	-10(r4), r12
	mov.w	r12, &curctx
	mov.b	#0, &isNoProgress
	mov.w	&special_sp, r12
	mov.w	r12, &stack_tracer
	;APP
	MOV -2(r4), R12
	;NO_APP
	;APP
	MOV 4(R12), R2
	;NO_APP
	;APP
	POP R12
	;NO_APP
	add.w	#22, r1
	pop.w	r4
	ret
.Lfunc_end31:
	.size	checkpoint, .Lfunc_end31-checkpoint

	.globl	is_backed_up
	.align	2
	.type	is_backed_up,@function
is_backed_up:                           ; @is_backed_up
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	;DEBUG_VALUE: is_backed_up:addr <- undef
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
	mov.w	r2, r13
	rra.w	r13
	and.w	#1, r13
	mov.w	r13, r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end32:
	.size	is_backed_up, .Lfunc_end32-is_backed_up

	.globl	back_up
	.align	2
	.type	back_up,@function
back_up:                                ; @back_up
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: back_up:addr <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&curctx, r15
	mov.w	2(r15), r15
	cmp.w	#3000, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jne	.LBB33_2
	jmp	.LBB33_1
.LBB33_1:                               ; %if.then
	mov.w	#-23288, &0x0120
	jmp	.LBB33_2
.LBB33_2:                               ; %if.end
	;DEBUG_VALUE: back_up:addr_aligned <- [FP+-4]
	mov.w	-2(r4), r12
	and.w	#-8, r12
	mov.w	r12, -4(r4)
	;DEBUG_VALUE: back_up:addr_bak <- [FP+-6]
	mov.w	&offset, r13
	sub.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	-4(r4), r13
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
	mov.w	-4(r4), r12
	mov.w	&curctx, r13
	mov.w	2(r13), r13
	rla.w	r13
	mov.w	r12, backup(r13)
	mov.w	&curctx, r12
	mov.w	2(r12), r13
	add.w	#1, r13
	mov.w	r13, 2(r12)
	;DEBUG_VALUE: back_up:index <- [FP+-8]
	mov.w	-2(r4), r12
	mov.w	&start_addr, r13
	sub.w	r13, r12
	mov.w	r12, -8(r4)
	mov.b	&bitmask_counter, r14
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	mov.b	r14, backup_bitmask(r12)
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end33:
	.size	back_up, .Lfunc_end33-back_up

	.globl	restore
	.align	2
	.type	restore,@function
restore:                                ; @restore
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	mov.b	&bitmask_counter, r12
	add.b	#1, r12
	mov.b	r12, &bitmask_counter
	cmp.b	#0, r12
	jne	.LBB34_3
	jmp	.LBB34_1
.LBB34_1:                               ; %land.lhs.true
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB34_3
	jmp	.LBB34_2
.LBB34_2:                               ; %if.then
	mov.b	#1, &need_bitmask_clear
	mov.w	#0, &clear_bitmask_iter
	mov.b	&bitmask_counter, r12
	add.b	#1, r12
	mov.b	r12, &bitmask_counter
	jmp	.LBB34_3
.LBB34_3:                               ; %if.end
	mov.b	&need_bitmask_clear, r12
	cmp.b	#0, r12
	jeq	.LBB34_5
	jmp	.LBB34_4
.LBB34_4:                               ; %if.then.3
	call	#clear_bitmask
	mov.b	#0, &need_bitmask_clear
	jmp	.LBB34_5
.LBB34_5:                               ; %if.end.4
	jmp	.LBB34_6
.LBB34_6:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&curctx, r12
	mov.w	2(r12), r12
	cmp.w	#0, r12
	jeq	.LBB34_8
	jmp	.LBB34_7
.LBB34_7:                               ; %while.body
                                        ;   in Loop: Header=BB34_6 Depth=1
	;DEBUG_VALUE: w_data_dest <- [FP+-2]
	mov.w	&curctx, r12
	mov.w	2(r12), r12
	rla.w	r12
	mov.w	backup-2(r12), r12
	mov.w	r12, -2(r4)
	;DEBUG_VALUE: w_data_src <- [FP+-4]
	mov.w	&offset, r13
	sub.w	r13, r12
	mov.w	r12, -4(r4)
	mov.w	-2(r4), r13
	mov.b	7(r12), r14
	mov.b	r14, 7(r13)
	mov.b	6(r12), r14
	mov.b	r14, 6(r13)
	mov.b	5(r12), r14
	mov.b	r14, 5(r13)
	mov.b	4(r12), r14
	mov.b	r14, 4(r13)
	mov.b	3(r12), r14
	mov.b	r14, 3(r13)
	mov.b	2(r12), r14
	mov.b	r14, 2(r13)
	mov.b	1(r12), r14
	mov.b	r14, 1(r13)
	mov.b	0(r12), r14
	mov.b	r14, 0(r13)
	mov.w	&curctx, r12
	mov.w	2(r12), r13
	add.w	#-1, r13
	mov.w	r13, 2(r12)
	jmp	.LBB34_6
.LBB34_8:                               ; %while.end
	call	#restore_regs
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end34:
	.size	restore, .Lfunc_end34-restore

	.globl	restore_regs
	.align	2
	.type	restore_regs,@function
restore_regs:                           ; @restore_regs
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#14, r1
	mov.b	&chkpt_ever_taken, r12
	cmp.b	#0, r12
	jne	.LBB35_3
	jmp	.LBB35_1
.LBB35_1:                               ; %land.lhs.true
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB35_3
	jmp	.LBB35_2
.LBB35_2:                               ; %if.then
	mov.w	&curctx, r12
	mov.w	#regs_0, 0(r12)
	mov.b	#1, &chkpt_ever_taken
	mov.w	#0, &mode_status
	br	#.LBB35_35
.LBB35_3:                               ; %if.else
	mov.w	&curctx, r12
	mov.w	#context_0, r13
	cmp.w	r13, r12
	jne	.LBB35_5
	jmp	.LBB35_4
.LBB35_4:                               ; %if.then.1
	mov.w	#context_1, -2(r4)
	jmp	.LBB35_6
.LBB35_5:                               ; %if.else.2
	mov.w	#context_0, -2(r4)
	jmp	.LBB35_6
.LBB35_6:                               ; %if.end
	jmp	.LBB35_7
.LBB35_7:                               ; %if.end.3
	mov.w	&mode_status, r12
	cmp.w	#0, r12
	jne	.LBB35_14
	jmp	.LBB35_8
.LBB35_8:                               ; %land.lhs.true.5
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB35_14
	jmp	.LBB35_9
.LBB35_9:                               ; %if.then.6
	jmp	.LBB35_10
.LBB35_10:                              ; %do.body
	call	#request_non_interactive_debug_mode
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	mov.w	r1, r13
	mov.w	r12, 2(r13)
	mov.w	#.L.str.1.26, 0(r13)
	call	#printf
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB35_11
.LBB35_11:                              ; %do.end
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	cmp.w	#-1, r12
	jeq	.LBB35_13
	jmp	.LBB35_12
.LBB35_12:                              ; %if.then.11
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	rla.w	r12
	mov.w	#0, chkpt_status(r12)
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	mov.b	#1, chkpt_book(r12)
	jmp	.LBB35_13
.LBB35_13:                              ; %if.end.18
	mov.w	#-1, &mode_status
	jmp	.LBB35_31
.LBB35_14:                              ; %if.else.19
	mov.b	&isNoProgress, r12
	cmp.b	#0, r12
	jeq	.LBB35_17
	jmp	.LBB35_15
.LBB35_15:                              ; %land.lhs.true.21
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB35_17
	jmp	.LBB35_16
.LBB35_16:                              ; %if.then.22
	mov.w	#0, &mode_status
	jmp	.LBB35_30
.LBB35_17:                              ; %if.else.23
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	mov.w	-2(r4), r13
	mov.w	0(r13), r13
	mov.w	30(r13), r13
	cmp.w	r13, r12
	jne	.LBB35_22
	jmp	.LBB35_18
.LBB35_18:                              ; %land.lhs.true.30
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB35_22
	jmp	.LBB35_19
.LBB35_19:                              ; %if.then.31
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	cmp.w	#-1, r12
	jeq	.LBB35_21
	jmp	.LBB35_20
.LBB35_20:                              ; %if.then.36
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	#-1, 30(r12)
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#-1, 30(r12)
	jmp	.LBB35_21
.LBB35_21:                              ; %if.end.41
	jmp	.LBB35_29
.LBB35_22:                              ; %if.else.42
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	cmp.w	#-1, r12
	jne	.LBB35_24
	jmp	.LBB35_23
.LBB35_23:                              ; %lor.lhs.false
	mov.w	#0, r12
	cmp.w	#0, r12
	jne	.LBB35_25
	jmp	.LBB35_24
.LBB35_24:                              ; %if.then.47
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	mov.b	chkpt_book(r12), r13
	add.w	#2, r13
	mov.b	r13, r14
	mov.b	r14, chkpt_book(r12)
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	mov.w	#-1, 30(r12)
	jmp	.LBB35_25
.LBB35_25:                              ; %if.end.55
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	cmp.w	#-1, r12
	jne	.LBB35_27
	jmp	.LBB35_26
.LBB35_26:                              ; %lor.lhs.false.60
	mov.w	#0, r12
	cmp.w	#0, r12
	jne	.LBB35_28
	jmp	.LBB35_27
.LBB35_27:                              ; %if.then.61
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	30(r12), r12
	mov.b	chkpt_book(r12), r13
	add.b	#-1, r13
	mov.b	r13, chkpt_book(r12)
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	#-1, 30(r12)
	jmp	.LBB35_28
.LBB35_28:                              ; %if.end.67
	jmp	.LBB35_29
.LBB35_29:                              ; %if.end.68
	jmp	.LBB35_30
.LBB35_30:                              ; %if.end.69
	jmp	.LBB35_31
.LBB35_31:                              ; %if.end.70
	mov.b	#1, &isNoProgress
	mov.w	-2(r4), r12
	mov.w	604(r12), r12
	mov.w	r12, &special_sp
	;DEBUG_VALUE: restore_regs:stack_size <- [FP+-6]
	mov.w	&stack_tracer, r13
	sub.w	r13, r12
	mov.w	r12, -6(r4)
	;DEBUG_VALUE: restore_regs:st_offset <- [FP+-8]
	mov.w	&stack_tracer, r12
	add.w	#2, r12
	mov.w	#special_stack, r13
	sub.w	r13, r12
	mov.w	r12, -8(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	jeq	.LBB35_34
	jmp	.LBB35_32
.LBB35_32:                              ; %land.lhs.true.74
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB35_34
	jmp	.LBB35_33
.LBB35_33:                              ; %if.then.75
	mov.w	-8(r4), r12
	mov.w	r12, r13
	add.w	#special_stack, r13
	mov.w	-2(r4), r14
	add.w	r12, r14
	add.w	#4, r14
	mov.w	-6(r4), r12
	mov.w	r13, r15
	mov.w	r12, r13
	call	#memcpy
	jmp	.LBB35_34
.LBB35_34:                              ; %if.end.78
	mov.w	-2(r4), r12
	;APP
	MOV 0(r12), R12
	;NO_APP
	;APP
	MOV 20(R12), R5
	;NO_APP
	;APP
	MOV 18(R12), R5
	;NO_APP
	;APP
	MOV 16(R12), R5
	;NO_APP
	;APP
	MOV 14(R12), R5
	;NO_APP
	;APP
	MOV 12(R12), R5
	;NO_APP
	;APP
	MOV 10(R12), R5
	;NO_APP
	;APP
	MOV 8(R12), R5
	;NO_APP
	;APP
	MOV 6(R12), R5
	;NO_APP
	;APP
	MOV 4(R12), R5
	;NO_APP
	;APP
	MOV 2(R12), R5
	;NO_APP
	;APP
	MOV 0(R12), -4(r4)
	;NO_APP
	;APP
	MOV -4(r4), R5
	;NO_APP
	jmp	.LBB35_35
.LBB35_35:                              ; %return
	add.w	#14, r1
	pop.w	r4
	ret
.Lfunc_end35:
	.size	restore_regs, .Lfunc_end35-restore_regs

	.globl	check_before_write_may
	.align	2
	.type	check_before_write_may,@function
check_before_write_may:                 ; @check_before_write_may
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: check_before_write_may:addr <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&start_addr, r13
	cmp.w	r13, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jlo	.LBB36_2
	jmp	.LBB36_1
.LBB36_1:                               ; %lor.lhs.false
	mov.w	-2(r4), r12
	mov.w	&end_addr, r13
	cmp.w	r12, r13
	jhs	.LBB36_4
	jmp	.LBB36_2
.LBB36_2:                               ; %land.lhs.true
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB36_4
	jmp	.LBB36_3
.LBB36_3:                               ; %if.then
	jmp	.LBB36_11
.LBB36_4:                               ; %if.end
	;DEBUG_VALUE: check_before_write_may:index <- [FP+-4]
	mov.w	-2(r4), r12
	mov.w	&start_addr, r13
	sub.w	r13, r12
	mov.w	r12, -4(r4)
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	mov.b	backup_bitmask(r12), r12
	mov.b	&bitmask_counter, r13
	cmp.w	r13, r12
	jne	.LBB36_7
	jmp	.LBB36_5
.LBB36_5:                               ; %land.lhs.true.5
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB36_7
	jmp	.LBB36_6
.LBB36_6:                               ; %if.then.6
	jmp	.LBB36_11
.LBB36_7:                               ; %if.end.7
	mov.w	&curctx, r12
	mov.w	2(r12), r12
	cmp.w	#3000, r12
	jne	.LBB36_10
	jmp	.LBB36_8
.LBB36_8:                               ; %land.lhs.true.10
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB36_10
	jmp	.LBB36_9
.LBB36_9:                               ; %if.then.11
	mov.w	#-23288, &0x0120
	jmp	.LBB36_10
.LBB36_10:                              ; %if.end.12
	;DEBUG_VALUE: check_before_write_may:addr_aligned <- [FP+-6]
	mov.w	-2(r4), r12
	and.w	#-8, r12
	mov.w	r12, -6(r4)
	;DEBUG_VALUE: check_before_write_may:addr_bak <- [FP+-8]
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
	jmp	.LBB36_11
.LBB36_11:                              ; %return
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end36:
	.size	check_before_write_may, .Lfunc_end36-check_before_write_may

	.globl	check_before_write_must
	.align	2
	.type	check_before_write_must,@function
check_before_write_must:                ; @check_before_write_must
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: check_before_write_must:addr <- undef
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
	;DEBUG_VALUE: check_before_write_must:addr_aligned <- [FP+-6]
	mov.w	-2(r4), r12
	and.w	#-8, r12
	mov.w	r12, -6(r4)
	;DEBUG_VALUE: check_before_write_must:addr_bak <- [FP+-8]
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
.Lfunc_end37:
	.size	check_before_write_must, .Lfunc_end37-check_before_write_must

	.globl	check_before_write_must_unconditional
	.align	2
	.type	check_before_write_must_unconditional,@function
check_before_write_must_unconditional:  ; @check_before_write_must_unconditional
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: check_before_write_must_unconditional:addr <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&start_addr, r13
	sub.w	r13, r15
	mov.w	r15, -4(r4)
	mov.w	&curctx, r13
	mov.w	2(r13), r13
	cmp.w	#3000, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jne	.LBB38_3
	jmp	.LBB38_1
.LBB38_1:                               ; %land.lhs.true
	mov.w	#0, r12
	cmp.w	#1, r12
	jne	.LBB38_3
	jmp	.LBB38_2
.LBB38_2:                               ; %if.then
	mov.w	#-23288, &0x0120
	jmp	.LBB38_3
.LBB38_3:                               ; %if.end
	;DEBUG_VALUE: check_before_write_must_unconditional:addr_aligned <- [FP+-6]
	mov.w	-2(r4), r12
	and.w	#-8, r12
	mov.w	r12, -6(r4)
	;DEBUG_VALUE: check_before_write_must_unconditional:addr_bak <- [FP+-8]
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
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end38:
	.size	check_before_write_must_unconditional, .Lfunc_end38-check_before_write_must_unconditional

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
