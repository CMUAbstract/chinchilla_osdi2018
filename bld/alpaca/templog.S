	.text
	.file	"templog.a.bc"
	.globl	TimerB1_ISR
	.align	2
	.type	TimerB1_ISR,@function
TimerB1_ISR:                            ; @TimerB1_ISR
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r12
	mov.w	&0x03C0, r12
	and.w	#-3, r12
	mov.w	r12, &0x03C0
	mov.w	&0x03C0, r12
	cmp.w	#0, r12
	jeq	.LBB0_2
	jmp	.LBB0_1
.LBB0_1:                                ; %if.then
	mov.w	&overflow, r12
	add.w	#1, r12
	mov.w	r12, &overflow
	mov.w	&0x03C0, r12
	bis.w	#4, r12
	mov.w	r12, &0x03C0
	mov.w	&0x03C0, r12
	bis.w	#2, r12
	mov.w	r12, &0x03C0
	mov.w	&0x03C0, r12
	and.w	#-2, r12
	mov.w	r12, &0x03C0
	jmp	.LBB0_2
.LBB0_2:                                ; %if.end
	pop.w	r12
	pop.w	r4
	reti
.Lfunc_end0:
	.size	TimerB1_ISR, .Lfunc_end0-TimerB1_ISR

	.globl	init
	.align	2
	.type	init,@function
init:                                   ; @init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	call	#init_hw
	call	#mspconsole_init
	;APP
	eint { nop
	;NO_APP
	pop.w	r4
	ret
.Lfunc_end1:
	.size	init, .Lfunc_end1-init

	.globl	task_init
	.align	2
	.type	task_init,@function
task_init:                              ; @task_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#0, &_global_parent_next
	mov.w	#0, &_global_out_len
	mov.w	#0, &_global_letter
	mov.w	#0, &_global_prev_sample
	mov.w	#0, &_global_letter_idx
	mov.w	#1, &_global_sample_count
	mov.w	#_task_task_init_dict, r15
	call	#transition_to
	pop.w	r4
	ret
.Lfunc_end2:
	.size	task_init, .Lfunc_end2-task_init

	.globl	task_init_dict
	.align	2
	.type	task_init_dict,@function
task_init_dict:                         ; @task_init_dict
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	mov.w	&_global_letter, r12
	mov.w	r12, &_global_letter_bak
	mov.w	r12, -6(r4)
	mov.w	#0, -4(r4)
	mov.w	#0, -2(r4)
	mov.w	&_global_letter_bak, r12
	mov.w	r12, -8(r4)
	mov.w	#6, r14
	mov.w	r12, r15
	call	#__mulhi3hw_noint
	mov.w	-2(r4), r12
	mov.w	r12, _global_dict+4(r15)
	mov.w	-4(r4), r12
	mov.w	r12, _global_dict+2(r15)
	mov.w	-6(r4), r12
	mov.w	r12, _global_dict(r15)
	mov.w	&_global_letter_bak, r12
	add.w	#1, r12
	mov.w	r12, &_global_letter_bak
	cmp.w	#256, r12
	jhs	.LBB3_2
	jmp	.LBB3_1
.LBB3_1:                                ; %if.then
	mov.w	#_global_letter, r14
	mov.w	#_global_letter_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_init_dict, r15
	call	#transition_to
	jmp	.LBB3_3
.LBB3_2:                                ; %if.else
	mov.w	#256, &_global_node_count
	mov.w	#_global_letter, r14
	mov.w	#_global_letter_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_sample, r15
	call	#transition_to
	jmp	.LBB3_3
.LBB3_3:                                ; %if.end
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end3:
	.size	task_init_dict, .Lfunc_end3-task_init_dict

	.globl	task_sample
	.align	2
	.type	task_sample,@function
task_sample:                            ; @task_sample
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	&_global_letter_idx, r12
	mov.w	r12, &_global_letter_idx_bak
	add.w	#1, r12
	mov.w	r12, -2(r4)
	cmp.w	#2, r12
	jne	.LBB4_2
	jmp	.LBB4_1
.LBB4_1:                                ; %if.then
	mov.w	#0, -2(r4)
	jmp	.LBB4_2
.LBB4_2:                                ; %if.end
	mov.w	&_global_letter_idx_bak, r12
	cmp.w	#0, r12
	jne	.LBB4_4
	jmp	.LBB4_3
.LBB4_3:                                ; %if.then.2
	mov.w	-2(r4), r12
	mov.w	r12, &_global_letter_idx_bak
	mov.w	#_global_letter_idx_bak, r15
	mov.w	#_global_letter_idx, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_measure_temp, r15
	call	#transition_to
	jmp	.LBB4_5
.LBB4_4:                                ; %if.else
	mov.w	-2(r4), r12
	mov.w	r12, &_global_letter_idx_bak
	mov.w	#_global_letter_idx_bak, r15
	mov.w	#_global_letter_idx, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_letterize, r15
	call	#transition_to
	jmp	.LBB4_5
.LBB4_5:                                ; %if.end.3
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end4:
	.size	task_sample, .Lfunc_end4-task_sample

	.globl	task_measure_temp
	.align	2
	.type	task_measure_temp,@function
task_measure_temp:                      ; @task_measure_temp
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	mov.w	#_global_prev_sample, r14
	mov.w	&_global_prev_sample, r12
	mov.w	r12, &_global_prev_sample_bak
	mov.w	#_global_prev_sample_bak, r15
	mov.w	r12, -2(r4)
	mov.w	r15, -6(r4)             ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	r14, -8(r4)             ; 2-byte Folded Spill
	call	#acquire_sample
	mov.w	r15, -4(r4)
	mov.w	r15, -2(r4)
	mov.w	r15, &_global_prev_sample_bak
	mov.w	-4(r4), r12
	mov.w	r12, &_global_sample
	mov.w	#2, r13
	mov.w	-6(r4), r15             ; 2-byte Folded Reload
	mov.w	-8(r4), r14             ; 2-byte Folded Reload
	call	#write_to_gbuf
	mov.w	#_task_task_letterize, r15
	call	#transition_to
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end5:
	.size	task_measure_temp, .Lfunc_end5-task_measure_temp

	.globl	task_letterize
	.align	2
	.type	task_letterize,@function
task_letterize:                         ; @task_letterize
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#16, r1
	mov.w	&_global_letter_idx, r12
	mov.w	r12, -2(r4)
	cmp.w	#0, r12
	jne	.LBB6_2
	jmp	.LBB6_1
.LBB6_1:                                ; %if.then
	mov.w	#2, -2(r4)
	jmp	.LBB6_3
.LBB6_2:                                ; %if.else
	mov.w	-2(r4), r12
	add.w	#-1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB6_3
.LBB6_3:                                ; %if.end
	;DEBUG_VALUE: task_letterize:letter_shift <- [FP+-4]
	mov.w	-2(r4), r12
	rla.w	r12
	rla.w	r12
	rla.w	r12
	mov.w	r12, -4(r4)
	;DEBUG_VALUE: task_letterize:letter <- [FP+-6]
	mov.w	&_global_sample, r12
	mov.b	-4(r4), r13
	mov.w	#255, r14
	cmp.b	#0, r13
	mov.b	r13, r15
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	mov.b	r13, -9(r4)             ; 1-byte Folded Spill
	mov.w	r14, -12(r4)            ; 2-byte Folded Spill
	mov.b	r15, -13(r4)            ; 1-byte Folded Spill
	jeq	.LBB6_5
.LBB6_4:                                ; %if.end
                                        ; =>This Inner Loop Header: Depth=1
	mov.b	-13(r4), r12            ; 1-byte Folded Reload
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	rla.w	r13
	sub.b	#1, r12
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	mov.b	r12, -13(r4)            ; 1-byte Folded Spill
	jne	.LBB6_4
.LBB6_5:                                ; %if.end
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	mov.w	-8(r4), r13             ; 2-byte Folded Reload
	and.w	r12, r13
	mov.b	-9(r4), r14             ; 1-byte Folded Reload
	cmp.b	#0, r14
	mov.b	r14, -14(r4)            ; 1-byte Folded Spill
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	jeq	.LBB6_7
.LBB6_6:                                ; %if.end
                                        ; =>This Inner Loop Header: Depth=1
	mov.b	-14(r4), r12            ; 1-byte Folded Reload
	mov.w	-16(r4), r13            ; 2-byte Folded Reload
	clrc
	rrc.w	r13
	sub.b	#1, r12
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	mov.b	r12, -14(r4)            ; 1-byte Folded Spill
	jne	.LBB6_6
.LBB6_7:                                ; %if.end
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -6(r4)
	mov.w	r12, &_global_letter
	mov.w	#_task_task_compress, r15
	call	#transition_to
	add.w	#16, r1
	pop.w	r4
	ret
.Lfunc_end6:
	.size	task_letterize, .Lfunc_end6-task_letterize

	.globl	task_compress
	.align	2
	.type	task_compress,@function
task_compress:                          ; @task_compress
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	mov.w	#_global_sample_count, r14
	mov.w	&_global_sample_count, r12
	mov.w	r12, &_global_sample_count_bak
	mov.w	#_global_sample_count_bak, r15
	mov.w	&_global_parent_next, r12
	mov.w	r12, -8(r4)
	mov.w	#6, r13
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	r14, -12(r4)            ; 2-byte Folded Spill
	mov.w	r13, r14
	call	#__mulhi3hw_noint
	mov.w	_global_dict+4(r15), r12
	mov.w	r12, -2(r4)
	mov.w	_global_dict+2(r15), r12
	mov.w	r12, -4(r4)
	mov.w	_global_dict(r15), r12
	mov.w	r12, -6(r4)
	mov.w	-2(r4), r12
	mov.w	r12, &_global_sibling
	mov.w	-2(r4), r12
	mov.w	r12, &_global_parent_node+4
	mov.w	-4(r4), r12
	mov.w	r12, &_global_parent_node+2
	mov.w	-6(r4), r12
	mov.w	r12, &_global_parent_node
	mov.w	-8(r4), r12
	mov.w	r12, &_global_parent
	mov.w	-2(r4), r12
	mov.w	r12, &_global_child
	mov.w	&_global_sample_count_bak, r12
	add.w	#1, r12
	mov.w	r12, &_global_sample_count_bak
	mov.w	#2, r13
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	mov.w	-12(r4), r14            ; 2-byte Folded Reload
	call	#write_to_gbuf
	mov.w	#_task_task_find_sibling, r15
	call	#transition_to
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end7:
	.size	task_compress, .Lfunc_end7-task_compress

	.globl	task_find_sibling
	.align	2
	.type	task_find_sibling,@function
task_find_sibling:                      ; @task_find_sibling
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	mov.w	&_global_sibling, r12
	mov.w	r12, &_global_sibling_bak
	cmp.w	#0, r12
	jeq	.LBB8_7
	jmp	.LBB8_1
.LBB8_1:                                ; %if.then
	;DEBUG_VALUE: i <- [FP+-4]
	mov.w	&_global_sibling_bak, r12
	mov.w	r12, -4(r4)
	mov.w	#6, r14
	mov.w	r12, r15
	call	#__mulhi3hw_noint
	mov.w	r15, r12
	add.w	#_global_dict, r12
	mov.w	r12, -2(r4)
	mov.w	_global_dict(r15), r12
	mov.w	&_global_letter, r14
	cmp.w	r14, r12
	jne	.LBB8_3
	jmp	.LBB8_2
.LBB8_2:                                ; %if.then.2
	mov.w	#_global_sibling_bak, r15
	mov.w	&_global_sibling_bak, r12
	mov.w	r12, &_global_parent_next
	mov.w	#_global_sibling, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_letterize, r15
	call	#transition_to
	jmp	.LBB8_6
.LBB8_3:                                ; %if.else
	mov.w	-2(r4), r12
	mov.w	2(r12), r12
	cmp.w	#0, r12
	jeq	.LBB8_5
	jmp	.LBB8_4
.LBB8_4:                                ; %if.then.4
	mov.w	-2(r4), r12
	mov.w	2(r12), r12
	mov.w	r12, &_global_sibling_bak
	mov.w	#_global_sibling_bak, r15
	mov.w	#_global_sibling, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_find_sibling, r15
	call	#transition_to
	jmp	.LBB8_5
.LBB8_5:                                ; %if.end
	jmp	.LBB8_6
.LBB8_6:                                ; %if.end.6
	jmp	.LBB8_7
.LBB8_7:                                ; %if.end.7
	;DEBUG_VALUE: task_find_sibling:starting_node_idx <- [FP+-6]
	mov.w	&_global_letter, r12
	mov.w	r12, -6(r4)
	mov.w	r12, &_global_parent_next
	mov.w	&_global_child, r12
	cmp.w	#0, r12
	jne	.LBB8_9
	jmp	.LBB8_8
.LBB8_8:                                ; %if.then.9
	mov.w	#_global_sibling, r14
	mov.w	#_global_sibling_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_add_insert, r15
	call	#transition_to
	jmp	.LBB8_10
.LBB8_9:                                ; %if.else.10
	mov.w	#_global_sibling, r14
	mov.w	#_global_sibling_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_add_node, r15
	call	#transition_to
	jmp	.LBB8_10
.LBB8_10:                               ; %if.end.11
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end8:
	.size	task_find_sibling, .Lfunc_end8-task_find_sibling

	.globl	task_add_node
	.align	2
	.type	task_add_node,@function
task_add_node:                          ; @task_add_node
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	mov.w	&_global_sibling, r12
	mov.w	r12, &_global_sibling_bak
	mov.w	r12, -4(r4)
	mov.w	#6, r14
	mov.w	r12, r15
	call	#__mulhi3hw_noint
	mov.w	r15, r12
	add.w	#_global_dict, r12
	mov.w	r12, -2(r4)
	mov.w	_global_dict+2(r15), r12
	cmp.w	#0, r12
	jeq	.LBB9_2
	jmp	.LBB9_1
.LBB9_1:                                ; %if.then
	;DEBUG_VALUE: next_sibling <- [FP+-6]
	mov.w	-2(r4), r12
	mov.w	2(r12), r12
	mov.w	r12, -6(r4)
	mov.w	r12, &_global_sibling_bak
	mov.w	#_global_sibling_bak, r15
	mov.w	#_global_sibling, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_add_node, r15
	call	#transition_to
	jmp	.LBB9_3
.LBB9_2:                                ; %if.else
	;DEBUG_VALUE: sibling_node_obj <- [FP+-12]
	mov.w	-2(r4), r12
	mov.w	4(r12), r13
	mov.w	r13, -8(r4)
	mov.w	2(r12), r13
	mov.w	r13, -10(r4)
	mov.w	0(r12), r12
	mov.w	r12, -12(r4)
	mov.w	-8(r4), r12
	mov.w	r12, &_global_sibling_node+4
	mov.w	-10(r4), r12
	mov.w	r12, &_global_sibling_node+2
	mov.w	-12(r4), r12
	mov.w	r12, &_global_sibling_node
	mov.w	#_global_sibling, r14
	mov.w	#_global_sibling_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_add_insert, r15
	call	#transition_to
	jmp	.LBB9_3
.LBB9_3:                                ; %if.end
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end9:
	.size	task_add_node, .Lfunc_end9-task_add_node

	.globl	task_add_insert
	.align	2
	.type	task_add_insert,@function
task_add_insert:                        ; @task_add_insert
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#24, r1
	mov.w	&_global_node_count, r12
	mov.w	r12, &_global_node_count_bak
	cmp.w	#512, r12
	jne	.LBB10_3
	jmp	.LBB10_1
.LBB10_1:                               ; %if.then
	jmp	.LBB10_2
.LBB10_2:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	jmp	.LBB10_2
.LBB10_3:                               ; %if.end
	;DEBUG_VALUE: task_add_insert:child <- [FP+-2]
	mov.w	&_global_node_count_bak, r12
	mov.w	r12, -2(r4)
	;DEBUG_VALUE: task_add_insert:child_node <- [FP+-8]
	mov.w	&_global_letter, r12
	mov.w	r12, -8(r4)
	mov.w	#0, -6(r4)
	mov.w	#0, -4(r4)
	mov.w	&_global_parent_node+4, r12
	cmp.w	#0, r12
	jne	.LBB10_5
	jmp	.LBB10_4
.LBB10_4:                               ; %if.then.3
	;DEBUG_VALUE: parent_node_obj <- [FP+-14]
	mov.w	&_global_parent_node+4, r12
	mov.w	r12, -10(r4)
	mov.w	&_global_parent_node+2, r12
	mov.w	r12, -12(r4)
	mov.w	&_global_parent_node, r12
	mov.w	r12, -14(r4)
	mov.w	-2(r4), r12
	mov.w	r12, -10(r4)
	;DEBUG_VALUE: i <- [FP+-16]
	mov.w	&_global_parent, r12
	mov.w	r12, -16(r4)
	mov.w	#6, r14
	mov.w	r12, r15
	call	#__mulhi3hw_noint
	mov.w	-10(r4), r12
	mov.w	r12, _global_dict+4(r15)
	mov.w	-12(r4), r12
	mov.w	r12, _global_dict+2(r15)
	mov.w	-14(r4), r12
	mov.w	r12, _global_dict(r15)
	jmp	.LBB10_6
.LBB10_5:                               ; %if.else
	;DEBUG_VALUE: last_sibling <- [FP+-18]
	mov.w	&_global_sibling, r12
	mov.w	r12, -18(r4)
	;DEBUG_VALUE: last_sibling_node <- [FP+-24]
	mov.w	&_global_sibling_node+4, r12
	mov.w	r12, -20(r4)
	mov.w	&_global_sibling_node+2, r12
	mov.w	r12, -22(r4)
	mov.w	&_global_sibling_node, r12
	mov.w	r12, -24(r4)
	mov.w	-2(r4), r12
	mov.w	r12, -22(r4)
	mov.w	-18(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	-20(r4), r12
	mov.w	r12, _global_dict+4(r15)
	mov.w	-22(r4), r12
	mov.w	r12, _global_dict+2(r15)
	mov.w	-24(r4), r12
	mov.w	r12, _global_dict(r15)
	jmp	.LBB10_6
.LBB10_6:                               ; %if.end.7
	mov.w	-2(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	-4(r4), r14
	mov.w	r14, _global_dict+4(r15)
	mov.w	-6(r4), r14
	mov.w	r14, _global_dict+2(r15)
	mov.w	-8(r4), r14
	mov.w	r14, _global_dict(r15)
	mov.w	&_global_parent, r14
	mov.w	r14, &_global_symbol
	mov.w	#_global_node_count_bak, r15
	mov.w	&_global_node_count_bak, r14
	add.w	#1, r14
	mov.w	r14, &_global_node_count_bak
	mov.w	#_global_node_count, r14
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_append_compressed, r15
	call	#transition_to
	add.w	#24, r1
	pop.w	r4
	ret
.Lfunc_end10:
	.size	task_add_insert, .Lfunc_end10-task_add_insert

	.globl	task_append_compressed
	.align	2
	.type	task_append_compressed,@function
task_append_compressed:                 ; @task_append_compressed
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	mov.w	&_global_out_len, r12
	mov.w	r12, &_global_out_len_bak
	mov.w	r12, -2(r4)
	mov.w	&_global_symbol, r13
	mov.w	#6, r14
	mov.w	r12, r15
	mov.w	r13, -4(r4)             ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-4(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, _global_compressed_data(r15)
	mov.w	&_global_out_len_bak, r12
	add.w	#1, r12
	mov.w	r12, &_global_out_len_bak
	cmp.w	#64, r12
	jne	.LBB11_2
	jmp	.LBB11_1
.LBB11_1:                               ; %if.then
	mov.w	#_global_out_len, r14
	mov.w	#_global_out_len_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_print, r15
	call	#transition_to
	jmp	.LBB11_3
.LBB11_2:                               ; %if.else
	mov.w	#_global_out_len, r14
	mov.w	#_global_out_len_bak, r15
	mov.w	#2, r13
	call	#write_to_gbuf
	mov.w	#_task_task_sample, r15
	call	#transition_to
	jmp	.LBB11_3
.LBB11_3:                               ; %if.end
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end11:
	.size	task_append_compressed, .Lfunc_end11-task_append_compressed

	.globl	task_print
	.align	2
	.type	task_print,@function
task_print:                             ; @task_print
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	mov.w	#0, -2(r4)
	jmp	.LBB12_1
.LBB12_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	cmp.w	#64, r12
	jhs	.LBB12_7
	jmp	.LBB12_2
.LBB12_2:                               ; %for.body
                                        ;   in Loop: Header=BB12_1 Depth=1
	;DEBUG_VALUE: index <- [FP+-4]
	mov.w	-2(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	_global_compressed_data(r15), r14
	mov.w	r14, -4(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	jeq	.LBB12_5
	jmp	.LBB12_3
.LBB12_3:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB12_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	bit.w	#7, r12
	jne	.LBB12_5
	jmp	.LBB12_4
.LBB12_4:                               ; %if.then
                                        ;   in Loop: Header=BB12_1 Depth=1
	jmp	.LBB12_5
.LBB12_5:                               ; %if.end
                                        ;   in Loop: Header=BB12_1 Depth=1
	jmp	.LBB12_6
.LBB12_6:                               ; %for.inc
                                        ;   in Loop: Header=BB12_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB12_1
.LBB12_7:                               ; %for.end
	mov.w	#_task_task_done, r15
	call	#transition_to
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end12:
	.size	task_print, .Lfunc_end12-task_print

	.globl	task_done
	.align	2
	.type	task_done,@function
task_done:                              ; @task_done
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#0, r15
	call	#exit
.Lfunc_end13:
	.size	task_done, .Lfunc_end13-task_done

	.globl	_entry_task
	.align	2
	.type	_entry_task,@function
_entry_task:                            ; @_entry_task
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#_task_task_init, r15
	call	#transition_to
	pop.w	r4
	ret
.Lfunc_end14:
	.size	_entry_task, .Lfunc_end14-_entry_task

	.globl	_init
	.align	2
	.type	_init,@function
_init:                                  ; @_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	call	#init
	pop.w	r4
	ret
.Lfunc_end15:
	.size	_init, .Lfunc_end15-_init

	.globl	clear_isDirty
	.align	2
	.type	clear_isDirty,@function
clear_isDirty:                          ; @clear_isDirty
; BB#0:                                 ; %entry
	ret
.Lfunc_end16:
	.size	clear_isDirty, .Lfunc_end16-clear_isDirty

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
.Lfunc_end17:
	.size	init_hw, .Lfunc_end17-init_hw

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
.Lfunc_end18:
	.size	acquire_sample, .Lfunc_end18-acquire_sample

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
.Lfunc_end19:
	.size	msp_watchdog_enable, .Lfunc_end19-msp_watchdog_enable

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
.Lfunc_end20:
	.size	msp_watchdog_disable, .Lfunc_end20-msp_watchdog_disable

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
.Lfunc_end21:
	.size	msp_watchdog_kick, .Lfunc_end21-msp_watchdog_kick

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
	jeq	.LBB22_4
	jmp	.LBB22_1
.LBB22_1:                               ; %while.body.preheader
	mov.w	#0, r12
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jmp	.LBB22_2
.LBB22_2:                               ; %while.body
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
	jne	.LBB22_2
	jmp	.LBB22_3
.LBB22_3:                               ; %while.end.loopexit
	jmp	.LBB22_4
.LBB22_4:                               ; %while.end
	mov.w	-2(r4), r15             ; 2-byte Folded Reload
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end22:
	.size	memcpy, .Lfunc_end22-memcpy

	.globl	my_memset
	.align	2
	.type	my_memset,@function
my_memset:                              ; @my_memset
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	;DEBUG_VALUE: my_memset:s <- R15
	;DEBUG_VALUE: my_memset:c <- R14
	;DEBUG_VALUE: my_memset:n <- R13
	;APP
	mov r15, r12
add r15, r13
cmp r13, r12
jz $+10
mov.b r14, 0(r12)
inc r12
jmp $-10

	;NO_APP
	pop.w	r4
	ret
.Lfunc_end23:
	.size	my_memset, .Lfunc_end23-my_memset

	.globl	msp_clock_setup
	.align	2
	.type	msp_clock_setup,@function
msp_clock_setup:                        ; @msp_clock_setup
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	#-91, &0x0160+1
	mov.w	#70, &0x0162
	mov.w	#51, &0x0164
	mov.w	#0, &0x0166
	pop.w	r4
	ret
.Lfunc_end24:
	.size	msp_clock_setup, .Lfunc_end24-msp_clock_setup

	.globl	task_prologue
	.align	2
	.type	task_prologue,@function
task_prologue:                          ; @task_prologue
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	mov.w	&_numBoots, r12
	cmp.w	#-1, r12
	jne	.LBB25_2
	jmp	.LBB25_1
.LBB25_1:                               ; %if.then
	call	#clear_isDirty
	mov.w	&_numBoots, r12
	add.w	#1, r12
	mov.w	r12, &_numBoots
	jmp	.LBB25_2
.LBB25_2:                               ; %if.end
	mov.w	&_numBoots, r12
	add.w	#1, r12
	mov.w	r12, &_numBoots
	mov.w	&curctx, r12
	mov.b	2(r12), r13
	cmp.b	#0, r13
	jeq	.LBB25_7
	jmp	.LBB25_3
.LBB25_3:                               ; %if.then.2
	jmp	.LBB25_4
.LBB25_4:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&gv_index, r12
	mov.w	&num_dirty_gv, r13
	cmp.w	r13, r12
	jhs	.LBB25_6
	jmp	.LBB25_5
.LBB25_5:                               ; %while.body
                                        ;   in Loop: Header=BB25_4 Depth=1
	;DEBUG_VALUE: w_data_dest <- [FP+-2]
	mov.w	&data_dest_base, r12
	mov.w	&gv_index, r13
	rla.w	r13
	add.w	r13, r12
	mov.w	0(r12), r12
	mov.w	r12, -2(r4)
	;DEBUG_VALUE: w_data_src <- [FP+-4]
	mov.w	&data_src_base, r12
	mov.w	&gv_index, r13
	rla.w	r13
	add.w	r13, r12
	mov.w	0(r12), r12
	mov.w	r12, -4(r4)
	;DEBUG_VALUE: w_data_size <- [FP+-6]
	mov.w	&data_size_base, r12
	mov.w	&gv_index, r13
	rla.w	r13
	add.w	r13, r12
	mov.w	0(r12), r12
	mov.w	r12, -6(r4)
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	r12, r13
	call	#memcpy
	mov.w	&gv_index, r12
	add.w	#1, r12
	mov.w	r12, &gv_index
	jmp	.LBB25_4
.LBB25_6:                               ; %while.end
	mov.w	#0, &num_dirty_gv
	mov.w	#0, &gv_index
	mov.w	&curctx, r12
	mov.b	#0, 2(r12)
	jmp	.LBB25_8
.LBB25_7:                               ; %if.else
	mov.w	#0, &num_dirty_gv
	jmp	.LBB25_8
.LBB25_8:                               ; %if.end.8
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end25:
	.size	task_prologue, .Lfunc_end25-task_prologue

	.globl	transition_to
	.align	2
	.type	transition_to,@function
transition_to:                          ; @transition_to
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: transition_to:next_task <- undef
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&curctx, r15
	mov.w	#context_0, r13
	mov.w	#context_1, r14
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
	mov.w	-2(r4), r13
	mov.w	r13, 0(r12)
	mov.w	-4(r4), r12
	mov.b	#1, 2(r12)
	mov.w	-4(r4), r12
	mov.w	r12, &curctx
	call	#task_prologue
	mov.w	-2(r4), r12
	mov.w	0(r12), r12
	;APP
	mov #0x2400, r1
br r12

	;NO_APP
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end26:
	.size	transition_to, .Lfunc_end26-transition_to

	.globl	write_to_gbuf
	.align	2
	.type	write_to_gbuf,@function
write_to_gbuf:                          ; @write_to_gbuf
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#12, r1
	;DEBUG_VALUE: write_to_gbuf:data_src <- undef
	;DEBUG_VALUE: write_to_gbuf:data_dest <- undef
	;DEBUG_VALUE: write_to_gbuf:var_size <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r15, -6(r4)
	mov.w	r14, -8(r4)
	mov.w	r13, -10(r4)
	mov.w	&data_size_base, r14
	mov.w	&num_dirty_gv, r15
	rla.w	r15
	add.w	r15, r14
	mov.w	r13, 0(r14)
	mov.w	-8(r4), r13
	mov.w	&data_dest_base, r14
	mov.w	&num_dirty_gv, r15
	rla.w	r15
	add.w	r15, r14
	mov.w	r13, 0(r14)
	mov.w	-6(r4), r13
	mov.w	&data_src_base, r14
	mov.w	&num_dirty_gv, r15
	rla.w	r15
	add.w	r15, r14
	mov.w	r13, 0(r14)
	mov.w	&num_dirty_gv, r13
	add.w	#1, r13
	mov.w	r13, &num_dirty_gv
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	mov.w	r11, -14(r4)            ; 2-byte Folded Spill
	mov.w	r10, -16(r4)            ; 2-byte Folded Spill
	add.w	#12, r1
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end27:
	.size	write_to_gbuf, .Lfunc_end27-write_to_gbuf

	.globl	main
	.align	2
	.type	main,@function
main:                                   ; @main
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	#0, -2(r4)
	call	#_init
	call	#task_prologue
	mov.w	&curctx, r12
	mov.w	0(r12), r12
	mov.w	0(r12), r12
	;APP
	br r12

	;NO_APP
	mov.w	#0, r15
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end28:
	.size	main, .Lfunc_end28-main

	.type	overflow,@object        ; @overflow
	.section	.bss,"aw",@nobits
	.globl	overflow
	.align	1
overflow:
	.short	0                       ; 0x0
	.size	overflow, 2

	.type	__vector_timer0_b1,@object ; @__vector_timer0_b1
	.section	__interrupt_vector_timer0_b1,"aw",@progbits
	.globl	__vector_timer0_b1
	.align	1
__vector_timer0_b1:
	.short	TimerB1_ISR
	.size	__vector_timer0_b1, 2

	.type	timer,@object           ; @timer
	.section	.data.rel,"aw",@progbits
	.globl	timer
	.align	1
timer:
	.short	0x03C0
	.size	timer, 2

	.type	_task_task_init,@object ; @_task_task_init
	.section	.nv_vars,"aw",@progbits
	.globl	_task_task_init
	.align	1
_task_task_init:
	.short	task_init
	.long	2                       ; 0x2
	.short	1                       ; 0x1
	.short	0                       ; 0x0
	.asciz	"task_init\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_init, 42

	.type	_task_task_init_dict,@object ; @_task_task_init_dict
	.globl	_task_task_init_dict
	.align	1
_task_task_init_dict:
	.short	task_init_dict
	.long	4                       ; 0x4
	.short	2                       ; 0x2
	.short	0                       ; 0x0
	.asciz	"task_init_dict\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_init_dict, 42

	.type	_task_task_sample,@object ; @_task_task_sample
	.globl	_task_task_sample
	.align	1
_task_task_sample:
	.short	task_sample
	.long	8                       ; 0x8
	.short	3                       ; 0x3
	.short	0                       ; 0x0
	.asciz	"task_sample\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_sample, 42

	.type	_task_task_measure_temp,@object ; @_task_task_measure_temp
	.globl	_task_task_measure_temp
	.align	1
_task_task_measure_temp:
	.short	task_measure_temp
	.long	16                      ; 0x10
	.short	4                       ; 0x4
	.short	0                       ; 0x0
	.asciz	"task_measure_temp\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_measure_temp, 42

	.type	_task_task_letterize,@object ; @_task_task_letterize
	.globl	_task_task_letterize
	.align	1
_task_task_letterize:
	.short	task_letterize
	.long	32                      ; 0x20
	.short	5                       ; 0x5
	.short	0                       ; 0x0
	.asciz	"task_letterize\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_letterize, 42

	.type	_task_task_compress,@object ; @_task_task_compress
	.globl	_task_task_compress
	.align	1
_task_task_compress:
	.short	task_compress
	.long	64                      ; 0x40
	.short	6                       ; 0x6
	.short	0                       ; 0x0
	.asciz	"task_compress\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_compress, 42

	.type	_task_task_find_sibling,@object ; @_task_task_find_sibling
	.globl	_task_task_find_sibling
	.align	1
_task_task_find_sibling:
	.short	task_find_sibling
	.long	128                     ; 0x80
	.short	7                       ; 0x7
	.short	0                       ; 0x0
	.asciz	"task_find_sibling\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_find_sibling, 42

	.type	_task_task_add_node,@object ; @_task_task_add_node
	.globl	_task_task_add_node
	.align	1
_task_task_add_node:
	.short	task_add_node
	.long	256                     ; 0x100
	.short	8                       ; 0x8
	.short	0                       ; 0x0
	.asciz	"task_add_node\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_add_node, 42

	.type	_task_task_add_insert,@object ; @_task_task_add_insert
	.globl	_task_task_add_insert
	.align	1
_task_task_add_insert:
	.short	task_add_insert
	.long	512                     ; 0x200
	.short	9                       ; 0x9
	.short	0                       ; 0x0
	.asciz	"task_add_insert\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_add_insert, 42

	.type	_task_task_append_compressed,@object ; @_task_task_append_compressed
	.globl	_task_task_append_compressed
	.align	1
_task_task_append_compressed:
	.short	task_append_compressed
	.long	1024                    ; 0x400
	.short	10                      ; 0xa
	.short	0                       ; 0x0
	.asciz	"task_append_compressed\000\000\000\000\000\000\000\000\000"
	.size	_task_task_append_compressed, 42

	.type	_task_task_print,@object ; @_task_task_print
	.globl	_task_task_print
	.align	1
_task_task_print:
	.short	task_print
	.long	2048                    ; 0x800
	.short	11                      ; 0xb
	.short	0                       ; 0x0
	.asciz	"task_print\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_print, 42

	.type	_task_task_done,@object ; @_task_task_done
	.globl	_task_task_done
	.align	1
_task_task_done:
	.short	task_done
	.long	4096                    ; 0x1000
	.short	12                      ; 0xc
	.short	0                       ; 0x0
	.asciz	"task_done\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task_task_done, 42

	.type	nvram,@object           ; @nvram
	.section	.bss,"aw",@nobits
	.globl	nvram
	.align	1
nvram:
	.short	0                       ; 0x0
	.size	nvram, 2

	.type	_global_parent_next,@object ; @_global_parent_next
	.section	.nv_vars,"aw",@progbits
	.globl	_global_parent_next
	.align	1
_global_parent_next:
	.short	0                       ; 0x0
	.size	_global_parent_next, 2

	.type	_global_out_len_bak,@object ; @_global_out_len_bak
	.globl	_global_out_len_bak
	.align	1
_global_out_len_bak:
	.short	0                       ; 0x0
	.size	_global_out_len_bak, 2

	.type	_global_out_len,@object ; @_global_out_len
	.globl	_global_out_len
	.align	1
_global_out_len:
	.short	0                       ; 0x0
	.size	_global_out_len, 2

	.type	_global_letter_bak,@object ; @_global_letter_bak
	.globl	_global_letter_bak
	.align	1
_global_letter_bak:
	.short	0                       ; 0x0
	.size	_global_letter_bak, 2

	.type	_global_letter,@object  ; @_global_letter
	.globl	_global_letter
	.align	1
_global_letter:
	.short	0                       ; 0x0
	.size	_global_letter, 2

	.type	_global_prev_sample_bak,@object ; @_global_prev_sample_bak
	.globl	_global_prev_sample_bak
	.align	1
_global_prev_sample_bak:
	.short	0                       ; 0x0
	.size	_global_prev_sample_bak, 2

	.type	_global_prev_sample,@object ; @_global_prev_sample
	.globl	_global_prev_sample
	.align	1
_global_prev_sample:
	.short	0                       ; 0x0
	.size	_global_prev_sample, 2

	.type	_global_letter_idx_bak,@object ; @_global_letter_idx_bak
	.globl	_global_letter_idx_bak
	.align	1
_global_letter_idx_bak:
	.short	0                       ; 0x0
	.size	_global_letter_idx_bak, 2

	.type	_global_letter_idx,@object ; @_global_letter_idx
	.globl	_global_letter_idx
	.align	1
_global_letter_idx:
	.short	0                       ; 0x0
	.size	_global_letter_idx, 2

	.type	_global_sample_count_bak,@object ; @_global_sample_count_bak
	.globl	_global_sample_count_bak
	.align	1
_global_sample_count_bak:
	.short	0                       ; 0x0
	.size	_global_sample_count_bak, 2

	.type	_global_sample_count,@object ; @_global_sample_count
	.globl	_global_sample_count
	.align	1
_global_sample_count:
	.short	0                       ; 0x0
	.size	_global_sample_count, 2

	.type	_global_dict,@object    ; @_global_dict
	.globl	_global_dict
	.align	1
_global_dict:
	.zero	3072
	.size	_global_dict, 3072

	.type	_global_node_count_bak,@object ; @_global_node_count_bak
	.globl	_global_node_count_bak
	.align	1
_global_node_count_bak:
	.short	0                       ; 0x0
	.size	_global_node_count_bak, 2

	.type	_global_node_count,@object ; @_global_node_count
	.globl	_global_node_count
	.align	1
_global_node_count:
	.short	0                       ; 0x0
	.size	_global_node_count, 2

	.type	_global_sample,@object  ; @_global_sample
	.globl	_global_sample
	.align	1
_global_sample:
	.short	0                       ; 0x0
	.size	_global_sample, 2

	.type	_global_sibling_bak,@object ; @_global_sibling_bak
	.globl	_global_sibling_bak
	.align	1
_global_sibling_bak:
	.short	0                       ; 0x0
	.size	_global_sibling_bak, 2

	.type	_global_sibling,@object ; @_global_sibling
	.globl	_global_sibling
	.align	1
_global_sibling:
	.short	0                       ; 0x0
	.size	_global_sibling, 2

	.type	_global_parent_node,@object ; @_global_parent_node
	.globl	_global_parent_node
	.align	1
_global_parent_node:
	.zero	6
	.size	_global_parent_node, 6

	.type	_global_parent,@object  ; @_global_parent
	.globl	_global_parent
	.align	1
_global_parent:
	.short	0                       ; 0x0
	.size	_global_parent, 2

	.type	_global_child,@object   ; @_global_child
	.globl	_global_child
	.align	1
_global_child:
	.short	0                       ; 0x0
	.size	_global_child, 2

	.type	_global_sibling_node,@object ; @_global_sibling_node
	.globl	_global_sibling_node
	.align	1
_global_sibling_node:
	.zero	6
	.size	_global_sibling_node, 6

	.type	_global_symbol,@object  ; @_global_symbol
	.globl	_global_symbol
	.align	1
_global_symbol:
	.short	0                       ; 0x0
	.size	_global_symbol, 2

	.type	_global_compressed_data,@object ; @_global_compressed_data
	.globl	_global_compressed_data
	.align	1
_global_compressed_data:
	.zero	384
	.size	_global_compressed_data, 384

	.type	_task__entry_task,@object ; @_task__entry_task
	.globl	_task__entry_task
	.align	1
_task__entry_task:
	.short	_entry_task
	.long	1                       ; 0x1
	.short	0                       ; 0x0
	.short	0                       ; 0x0
	.asciz	"_entry_task\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.size	_task__entry_task, 42

	.type	data_src,@object        ; @data_src
	.globl	data_src
	.align	1
data_src:
	.zero	2
	.size	data_src, 2

	.type	data_dest,@object       ; @data_dest
	.globl	data_dest
	.align	1
data_dest:
	.zero	2
	.size	data_dest, 2

	.type	data_size,@object       ; @data_size
	.globl	data_size
	.align	1
data_size:
	.zero	2
	.size	data_size, 2

	.type	watchdog_bits,@object   ; @watchdog_bits
	.local	watchdog_bits
	.comm	watchdog_bits,1,1
	.type	data_src_base,@object   ; @data_src_base
	.globl	data_src_base
	.align	1
data_src_base:
	.short	data_src
	.size	data_src_base, 2

	.type	data_dest_base,@object  ; @data_dest_base
	.globl	data_dest_base
	.align	1
data_dest_base:
	.short	data_dest
	.size	data_dest_base, 2

	.type	data_size_base,@object  ; @data_size_base
	.globl	data_size_base
	.align	1
data_size_base:
	.short	data_size
	.size	data_size_base, 2

	.type	gv_index,@object        ; @gv_index
	.globl	gv_index
	.align	1
gv_index:
	.short	0                       ; 0x0
	.size	gv_index, 2

	.type	num_dirty_gv,@object    ; @num_dirty_gv
	.globl	num_dirty_gv
	.align	1
num_dirty_gv:
	.short	0                       ; 0x0
	.size	num_dirty_gv, 2

	.type	rcount,@object          ; @rcount
	.section	.bss,"aw",@nobits
	.globl	rcount
	.align	1
rcount:
	.short	0                       ; 0x0
	.size	rcount, 2

	.type	wcount,@object          ; @wcount
	.globl	wcount
	.align	1
wcount:
	.short	0                       ; 0x0
	.size	wcount, 2

	.type	tcount,@object          ; @tcount
	.globl	tcount
	.align	1
tcount:
	.short	0                       ; 0x0
	.size	tcount, 2

	.type	max_num_dirty_gv,@object ; @max_num_dirty_gv
	.globl	max_num_dirty_gv
	.align	1
max_num_dirty_gv:
	.short	0                       ; 0x0
	.size	max_num_dirty_gv, 2

	.type	context_1,@object       ; @context_1
	.section	.nv_vars,"aw",@progbits
	.globl	context_1
	.align	1
context_1:
	.zero	6
	.size	context_1, 6

	.type	context_0,@object       ; @context_0
	.globl	context_0
	.align	1
context_0:
	.short	_task__entry_task
	.byte	0                       ; 0x0
	.zero	1
	.short	0
	.size	context_0, 6

	.type	curctx,@object          ; @curctx
	.globl	curctx
	.align	1
curctx:
	.short	context_0
	.size	curctx, 2

	.type	_numBoots,@object       ; @_numBoots
	.globl	_numBoots
	.align	1
_numBoots:
	.short	0                       ; 0x0
	.size	_numBoots, 2


	.globl	__interrupt_vector_51
__interrupt_vector_51 = TimerB1_ISR
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 52ed5ec631b0bbf5c714baa0cd83c33ebfe0c6aa) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"
	.section	".note.GNU-stack","",@progbits
