; ModuleID = 'templog.a.bc'
target datalayout = "e-m:e-p:16:16-i32:16:32-a:16-n8:16"
target triple = "msp430"

%struct.task_t = type { void ()*, i32, i16, i16, [32 x i8] }
%struct._node_t = type { i16, i16, i16 }
%struct._context_t = type { %struct.task_t*, i16, %struct._context_t* }

@overflow = global i16 0, align 2
@"\010x03C0" = external global i16, align 2
@__vector_timer0_b1 = global void ()* @TimerB1_ISR, section "__interrupt_vector_timer0_b1", align 2
@timer = global i16* @"\010x03C0", align 2
@_task_task_init = global %struct.task_t { void ()* @task_init, i32 2, i16 1, i16 0, [32 x i8] c"task_init\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_init_dict = global %struct.task_t { void ()* @task_init_dict, i32 4, i16 2, i16 0, [32 x i8] c"task_init_dict\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_sample = global %struct.task_t { void ()* @task_sample, i32 8, i16 3, i16 0, [32 x i8] c"task_sample\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_measure_temp = global %struct.task_t { void ()* @task_measure_temp, i32 16, i16 4, i16 0, [32 x i8] c"task_measure_temp\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_letterize = global %struct.task_t { void ()* @task_letterize, i32 32, i16 5, i16 0, [32 x i8] c"task_letterize\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_compress = global %struct.task_t { void ()* @task_compress, i32 64, i16 6, i16 0, [32 x i8] c"task_compress\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_find_sibling = global %struct.task_t { void ()* @task_find_sibling, i32 128, i16 7, i16 0, [32 x i8] c"task_find_sibling\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_add_node = global %struct.task_t { void ()* @task_add_node, i32 256, i16 8, i16 0, [32 x i8] c"task_add_node\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_add_insert = global %struct.task_t { void ()* @task_add_insert, i32 512, i16 9, i16 0, [32 x i8] c"task_add_insert\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_append_compressed = global %struct.task_t { void ()* @task_append_compressed, i32 1024, i16 10, i16 0, [32 x i8] c"task_append_compressed\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_print = global %struct.task_t { void ()* @task_print, i32 2048, i16 11, i16 0, [32 x i8] c"task_print\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@_task_task_done = global %struct.task_t { void ()* @task_done, i32 4096, i16 12, i16 0, [32 x i8] c"task_done\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@nvram = global i16 0, align 2
@"\010x0222" = external global i8, align 1
@_global_parent_next = global i16 0, section ".nv_vars", align 2
@_global_out_len_bak = global i16 0, section ".nv_vars", align 2
@_global_out_len = global i16 0, section ".nv_vars", align 2
@_global_letter_bak = global i16 0, section ".nv_vars", align 2
@_global_letter = global i16 0, section ".nv_vars", align 2
@_global_prev_sample_bak = global i16 0, section ".nv_vars", align 2
@_global_prev_sample = global i16 0, section ".nv_vars", align 2
@_global_letter_idx_bak = global i16 0, section ".nv_vars", align 2
@_global_letter_idx = global i16 0, section ".nv_vars", align 2
@_global_sample_count_bak = global i16 0, section ".nv_vars", align 2
@_global_sample_count = global i16 0, section ".nv_vars", align 2
@_global_dict = global [512 x %struct._node_t] zeroinitializer, section ".nv_vars", align 2
@_global_node_count_bak = global i16 0, section ".nv_vars", align 2
@_global_node_count = global i16 0, section ".nv_vars", align 2
@_global_sample = global i16 0, section ".nv_vars", align 2
@_global_sibling_bak = global i16 0, section ".nv_vars", align 2
@_global_sibling = global i16 0, section ".nv_vars", align 2
@_global_parent_node = global %struct._node_t zeroinitializer, section ".nv_vars", align 2
@_global_parent = global i16 0, section ".nv_vars", align 2
@_global_child = global i16 0, section ".nv_vars", align 2
@_global_sibling_node = global %struct._node_t zeroinitializer, section ".nv_vars", align 2
@_global_symbol = global i16 0, section ".nv_vars", align 2
@_global_compressed_data = global [64 x %struct._node_t] zeroinitializer, section ".nv_vars", align 2
@"\010x03D0" = external global i16, align 2
@_task__entry_task = global %struct.task_t { void ()* @_entry_task, i32 1, i16 0, i16 0, [32 x i8] c"_entry_task\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00" }, section ".nv_vars", align 2
@"\010x0130" = external global i16, align 2
@"\010x0224" = external global i8, align 1
@llvm.used = appending global [1 x i8*] [i8* bitcast (void ()* @TimerB1_ISR to i8*)], section "llvm.metadata"
@data_src = global [1 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [1 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [1 x i16] zeroinitializer, section ".nv_vars", align 2
@.str = private unnamed_addr constant [7 x i8] c".%u.\0D\0A\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"TIME end is 65536*%u+%u\0D\0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"compressed block:\0D\0A\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"%04x \00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"\0D\0A\00", align 1
@.str.5 = private unnamed_addr constant [29 x i8] c"rate: samples/block: %u/%u\0D\0A\00", align 1
@"\010x015C" = external global i16, align 2
@"\010x0160+1" = external global i8, align 1
@"\010x0162" = external global i16, align 2
@"\010x0164" = external global i16, align 2
@"\010x0166" = external global i16, align 2
@watchdog_bits = internal unnamed_addr global i8 0, align 1
@data_src_base = global i8** getelementptr inbounds ([1 x i8*], [1 x i8*]* @data_src, i32 0, i32 0), section ".nv_vars", align 2
@data_dest_base = global i8** getelementptr inbounds ([1 x i8*], [1 x i8*]* @data_dest, i32 0, i32 0), section ".nv_vars", align 2
@data_size_base = global i16* getelementptr inbounds ([1 x i16], [1 x i16]* @data_size, i32 0, i32 0), section ".nv_vars", align 2
@gv_index = global i16 0, section ".nv_vars", align 2
@num_dirty_gv = global i16 0, section ".nv_vars", align 2
@rcount = global i16 0, align 2
@wcount = global i16 0, align 2
@tcount = global i16 0, align 2
@max_num_dirty_gv = global i16 0, align 2
@curtime = global i16 0, section ".nv_vars", align 2
@context_3 = global %struct._context_t zeroinitializer, section ".nv_vars", align 2
@context_2 = global %struct._context_t { %struct.task_t* @_task__entry_task, i16 0, %struct._context_t* @context_3 }, section ".nv_vars", align 2
@context_1 = global %struct._context_t zeroinitializer, section ".nv_vars", align 2
@context_0 = global %struct._context_t { %struct.task_t* @_task__entry_task, i16 0, %struct._context_t* @context_1 }, section ".nv_vars", align 2
@curctx = global %struct._context_t* @context_0, section ".nv_vars", align 2
@_numBoots = global i16 0, section ".nv_vars", align 2

@__interrupt_vector_51 = alias void (), void ()* @TimerB1_ISR

; Function Attrs: noinline nounwind
define msp430_intrcc void @TimerB1_ISR() #0 {
entry:
  %0 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !225
  %and = and i16 %0, -3, !dbg !225
  store volatile i16 %and, i16* @"\010x03C0", align 2, !dbg !225
  %1 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !226
  %tobool = icmp ne i16 %1, 0, !dbg !226
  br i1 %tobool, label %if.then, label %if.end, !dbg !228

if.then:                                          ; preds = %entry
  %2 = load i16, i16* @overflow, align 2, !dbg !229
  %inc = add i16 %2, 1, !dbg !229
  store i16 %inc, i16* @overflow, align 2, !dbg !229
  %3 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !231
  %or = or i16 %3, 4, !dbg !231
  store volatile i16 %or, i16* @"\010x03C0", align 2, !dbg !231
  %4 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !232
  %or1 = or i16 %4, 2, !dbg !232
  store volatile i16 %or1, i16* @"\010x03C0", align 2, !dbg !232
  %5 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !233
  %and2 = and i16 %5, -2, !dbg !233
  store volatile i16 %and2, i16* @"\010x03C0", align 2, !dbg !233
  br label %if.end, !dbg !234

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !235
}

; Function Attrs: nounwind
define void @init() #1 {
entry:
  call void @init_hw(), !dbg !236
  call void bitcast (void (...)* @mspconsole_init to void ()*)(), !dbg !237
  call void asm sideeffect "eint { nop", ""() #5, !dbg !238, !srcloc !239
  %0 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !240
  %task = getelementptr inbounds %struct._context_t, %struct._context_t* %0, i32 0, i32 0, !dbg !240
  %1 = load %struct.task_t*, %struct.task_t** %task, align 2, !dbg !240
  %idx = getelementptr inbounds %struct.task_t, %struct.task_t* %1, i32 0, i32 2, !dbg !240
  %2 = load i16, i16* %idx, align 2, !dbg !240
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i16 %2), !dbg !240
  ret void, !dbg !241
}

declare void @mspconsole_init(...) #2

declare i16 @printf(i8*, ...) #2

; Function Attrs: nounwind
define void @task_init() #1 {
entry:
  %0 = load volatile i8, i8* @"\010x0222", align 1, !dbg !242
  %conv = zext i8 %0 to i16, !dbg !242
  %and = and i16 %conv, -2, !dbg !242
  %conv1 = trunc i16 %and to i8, !dbg !242
  store volatile i8 %conv1, i8* @"\010x0222", align 1, !dbg !242
  %1 = load volatile i8, i8* @"\010x0222", align 1, !dbg !243
  %conv2 = zext i8 %1 to i16, !dbg !243
  %or = or i16 %conv2, 2, !dbg !243
  %conv3 = trunc i16 %or to i8, !dbg !243
  store volatile i8 %conv3, i8* @"\010x0222", align 1, !dbg !243
  store i16 0, i16* @_global_parent_next, align 2, !dbg !244
  store i16 0, i16* @_global_out_len, align 2, !dbg !245
  store i16 0, i16* @_global_letter, align 2, !dbg !246
  store i16 0, i16* @_global_prev_sample, align 2, !dbg !247
  store i16 0, i16* @_global_letter_idx, align 2, !dbg !248
  store i16 1, i16* @_global_sample_count, align 2, !dbg !249
  call void @transition_to(%struct.task_t* @_task_task_init_dict), !dbg !250
  ret void, !dbg !251
}

; Function Attrs: nounwind
define void @task_init_dict() #1 {
entry:
  %0 = load i16, i16* @_global_letter
  store i16 %0, i16* @_global_letter_bak
  %node = alloca %struct._node_t, align 2
  %i = alloca i16, align 2
  call void @llvm.dbg.declare(metadata %struct._node_t* %node, metadata !252, metadata !253), !dbg !254
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %node, i32 0, i32 0, !dbg !255
  %1 = load i16, i16* @_global_letter_bak, align 2, !dbg !256
  store i16 %1, i16* %letter, align 2, !dbg !255
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %node, i32 0, i32 1, !dbg !255
  store i16 0, i16* %sibling, align 2, !dbg !255
  %child = getelementptr inbounds %struct._node_t, %struct._node_t* %node, i32 0, i32 2, !dbg !255
  store i16 0, i16* %child, align 2, !dbg !255
  call void @llvm.dbg.declare(metadata i16* %i, metadata !257, metadata !253), !dbg !258
  %2 = load i16, i16* @_global_letter_bak, align 2, !dbg !259
  store i16 %2, i16* %i, align 2, !dbg !258
  %3 = load i16, i16* %i, align 2, !dbg !260
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %3, !dbg !260
  %4 = bitcast %struct._node_t* %arrayidx to i8*, !dbg !261
  %5 = bitcast %struct._node_t* %node to i8*, !dbg !261
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %4, i8* %5, i16 6, i32 2, i1 false), !dbg !261
  %6 = load i16, i16* @_global_letter_bak, align 2, !dbg !262
  %inc = add i16 %6, 1, !dbg !262
  store i16 %inc, i16* @_global_letter_bak, align 2, !dbg !262
  %7 = load i16, i16* @_global_letter_bak, align 2, !dbg !263
  %cmp = icmp ult i16 %7, 256, !dbg !265
  br i1 %cmp, label %if.then, label %if.else, !dbg !266

if.then:                                          ; preds = %entry
  %8 = bitcast i16* @_global_letter to i8*
  %9 = bitcast i16* @_global_letter_bak to i8*
  %10 = getelementptr inbounds i16, i16* null, i16 1
  %11 = ptrtoint i16* %10 to i16
  call void @write_to_gbuf(i8* %9, i8* %8, i16 %11)
  call void @transition_to(%struct.task_t* @_task_task_init_dict), !dbg !267
  br label %if.end, !dbg !269

if.else:                                          ; preds = %entry
  store i16 256, i16* @_global_node_count, align 2, !dbg !270
  %12 = bitcast i16* @_global_letter to i8*
  %13 = bitcast i16* @_global_letter_bak to i8*
  %14 = getelementptr inbounds i16, i16* null, i16 1
  %15 = ptrtoint i16* %14 to i16
  call void @write_to_gbuf(i8* %13, i8* %12, i16 %15)
  call void @transition_to(%struct.task_t* @_task_task_sample), !dbg !272
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void, !dbg !273
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: nounwind argmemonly
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture, i8* nocapture readonly, i16, i32, i1) #4

; Function Attrs: nounwind
define void @task_sample() #1 {
entry:
  %0 = load i16, i16* @_global_letter_idx
  store i16 %0, i16* @_global_letter_idx_bak
  %next_letter_idx = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %next_letter_idx, metadata !274, metadata !253), !dbg !275
  %1 = load i16, i16* @_global_letter_idx_bak, align 2, !dbg !276
  %add = add i16 %1, 1, !dbg !277
  store i16 %add, i16* %next_letter_idx, align 2, !dbg !275
  %2 = load i16, i16* %next_letter_idx, align 2, !dbg !278
  %cmp = icmp eq i16 %2, 2, !dbg !280
  br i1 %cmp, label %if.then, label %if.end, !dbg !281

if.then:                                          ; preds = %entry
  store i16 0, i16* %next_letter_idx, align 2, !dbg !282
  br label %if.end, !dbg !283

if.end:                                           ; preds = %if.then, %entry
  %3 = load i16, i16* @_global_letter_idx_bak, align 2, !dbg !284
  %cmp1 = icmp eq i16 %3, 0, !dbg !286
  br i1 %cmp1, label %if.then.2, label %if.else, !dbg !287

if.then.2:                                        ; preds = %if.end
  %4 = load i16, i16* %next_letter_idx, align 2, !dbg !288
  store i16 %4, i16* @_global_letter_idx_bak, align 2, !dbg !290
  %5 = bitcast i16* @_global_letter_idx to i8*
  %6 = bitcast i16* @_global_letter_idx_bak to i8*
  %7 = getelementptr inbounds i16, i16* null, i16 1
  %8 = ptrtoint i16* %7 to i16
  call void @write_to_gbuf(i8* %6, i8* %5, i16 %8)
  call void @transition_to(%struct.task_t* @_task_task_measure_temp), !dbg !291
  br label %if.end.3, !dbg !292

if.else:                                          ; preds = %if.end
  %9 = load i16, i16* %next_letter_idx, align 2, !dbg !293
  store i16 %9, i16* @_global_letter_idx_bak, align 2, !dbg !295
  %10 = bitcast i16* @_global_letter_idx to i8*
  %11 = bitcast i16* @_global_letter_idx_bak to i8*
  %12 = getelementptr inbounds i16, i16* null, i16 1
  %13 = ptrtoint i16* %12 to i16
  call void @write_to_gbuf(i8* %11, i8* %10, i16 %13)
  call void @transition_to(%struct.task_t* @_task_task_letterize), !dbg !296
  br label %if.end.3

if.end.3:                                         ; preds = %if.else, %if.then.2
  ret void, !dbg !297
}

; Function Attrs: nounwind
define void @task_measure_temp() #1 {
entry:
  %0 = load i16, i16* @_global_prev_sample
  store i16 %0, i16* @_global_prev_sample_bak
  %prev_sample = alloca i16, align 2
  %sample = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %prev_sample, metadata !298, metadata !253), !dbg !299
  %1 = load i16, i16* @_global_prev_sample_bak, align 2, !dbg !300
  store i16 %1, i16* %prev_sample, align 2, !dbg !301
  call void @llvm.dbg.declare(metadata i16* %sample, metadata !302, metadata !253), !dbg !303
  %2 = load i16, i16* %prev_sample, align 2, !dbg !304
  %call = call i16 @acquire_sample(i16 %2), !dbg !305
  store i16 %call, i16* %sample, align 2, !dbg !303
  %3 = load i16, i16* %sample, align 2, !dbg !306
  store i16 %3, i16* %prev_sample, align 2, !dbg !307
  %4 = load i16, i16* %prev_sample, align 2, !dbg !308
  store i16 %4, i16* @_global_prev_sample_bak, align 2, !dbg !309
  %5 = load i16, i16* %sample, align 2, !dbg !310
  store i16 %5, i16* @_global_sample, align 2, !dbg !311
  %6 = bitcast i16* @_global_prev_sample to i8*
  %7 = bitcast i16* @_global_prev_sample_bak to i8*
  %8 = getelementptr inbounds i16, i16* null, i16 1
  %9 = ptrtoint i16* %8 to i16
  call void @write_to_gbuf(i8* %7, i8* %6, i16 %9)
  call void @transition_to(%struct.task_t* @_task_task_letterize), !dbg !312
  ret void, !dbg !313
}

; Function Attrs: nounwind
define void @task_letterize() #1 {
entry:
  %letter_idx = alloca i16, align 2
  %letter_shift = alloca i16, align 2
  %letter = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %letter_idx, metadata !314, metadata !253), !dbg !315
  %0 = load i16, i16* @_global_letter_idx, align 2, !dbg !316
  store i16 %0, i16* %letter_idx, align 2, !dbg !315
  %1 = load i16, i16* %letter_idx, align 2, !dbg !317
  %cmp = icmp eq i16 %1, 0, !dbg !319
  br i1 %cmp, label %if.then, label %if.else, !dbg !320

if.then:                                          ; preds = %entry
  store i16 2, i16* %letter_idx, align 2, !dbg !321
  br label %if.end, !dbg !322

if.else:                                          ; preds = %entry
  %2 = load i16, i16* %letter_idx, align 2, !dbg !323
  %dec = add i16 %2, -1, !dbg !323
  store i16 %dec, i16* %letter_idx, align 2, !dbg !323
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  call void @llvm.dbg.declare(metadata i16* %letter_shift, metadata !324, metadata !253), !dbg !325
  %3 = load i16, i16* %letter_idx, align 2, !dbg !326
  %mul = mul i16 8, %3, !dbg !327
  store i16 %mul, i16* %letter_shift, align 2, !dbg !325
  call void @llvm.dbg.declare(metadata i16* %letter, metadata !328, metadata !253), !dbg !329
  %4 = load i16, i16* @_global_sample, align 2, !dbg !330
  %5 = load i16, i16* %letter_shift, align 2, !dbg !331
  %shl = shl i16 255, %5, !dbg !332
  %and = and i16 %4, %shl, !dbg !333
  %6 = load i16, i16* %letter_shift, align 2, !dbg !334
  %shr = lshr i16 %and, %6, !dbg !335
  store i16 %shr, i16* %letter, align 2, !dbg !329
  %7 = load i16, i16* %letter, align 2, !dbg !336
  store i16 %7, i16* @_global_letter, align 2, !dbg !337
  call void @transition_to(%struct.task_t* @_task_task_compress), !dbg !338
  ret void, !dbg !339
}

; Function Attrs: nounwind
define void @task_compress() #1 {
entry:
  %0 = load i16, i16* @_global_sample_count
  store i16 %0, i16* @_global_sample_count_bak
  %parent_node = alloca %struct._node_t, align 2
  %parent = alloca i16, align 2
  call void @llvm.dbg.declare(metadata %struct._node_t* %parent_node, metadata !340, metadata !253), !dbg !341
  call void @llvm.dbg.declare(metadata i16* %parent, metadata !342, metadata !253), !dbg !343
  %1 = load i16, i16* @_global_parent_next, align 2, !dbg !344
  store i16 %1, i16* %parent, align 2, !dbg !343
  %2 = load i16, i16* %parent, align 2, !dbg !345
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %2, !dbg !345
  %3 = bitcast %struct._node_t* %parent_node to i8*, !dbg !345
  %4 = bitcast %struct._node_t* %arrayidx to i8*, !dbg !345
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %3, i8* %4, i16 6, i32 2, i1 false), !dbg !345
  %child = getelementptr inbounds %struct._node_t, %struct._node_t* %parent_node, i32 0, i32 2, !dbg !346
  %5 = load i16, i16* %child, align 2, !dbg !346
  store i16 %5, i16* @_global_sibling, align 2, !dbg !347
  %6 = bitcast %struct._node_t* %parent_node to i8*, !dbg !348
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* bitcast (%struct._node_t* @_global_parent_node to i8*), i8* %6, i16 6, i32 2, i1 false), !dbg !348
  %7 = load i16, i16* %parent, align 2, !dbg !349
  store i16 %7, i16* @_global_parent, align 2, !dbg !350
  %child1 = getelementptr inbounds %struct._node_t, %struct._node_t* %parent_node, i32 0, i32 2, !dbg !351
  %8 = load i16, i16* %child1, align 2, !dbg !351
  store i16 %8, i16* @_global_child, align 2, !dbg !352
  %9 = load i16, i16* @_global_sample_count_bak, align 2, !dbg !353
  %inc = add i16 %9, 1, !dbg !353
  store i16 %inc, i16* @_global_sample_count_bak, align 2, !dbg !353
  %10 = bitcast i16* @_global_sample_count to i8*
  %11 = bitcast i16* @_global_sample_count_bak to i8*
  %12 = getelementptr inbounds i16, i16* null, i16 1
  %13 = ptrtoint i16* %12 to i16
  call void @write_to_gbuf(i8* %11, i8* %10, i16 %13)
  call void @transition_to(%struct.task_t* @_task_task_find_sibling), !dbg !354
  ret void, !dbg !355
}

; Function Attrs: nounwind
define void @task_find_sibling() #1 {
entry:
  %0 = load i16, i16* @_global_sibling
  store i16 %0, i16* @_global_sibling_bak
  %sibling_node = alloca %struct._node_t*, align 2
  %i = alloca i16, align 2
  %starting_node_idx = alloca i16, align 2
  call void @llvm.dbg.declare(metadata %struct._node_t** %sibling_node, metadata !356, metadata !253), !dbg !358
  %1 = load i16, i16* @_global_sibling_bak, align 2, !dbg !359
  %cmp = icmp ne i16 %1, 0, !dbg !361
  br i1 %cmp, label %if.then, label %if.end.7, !dbg !362

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i16* %i, metadata !363, metadata !253), !dbg !365
  %2 = load i16, i16* @_global_sibling_bak, align 2, !dbg !366
  store i16 %2, i16* %i, align 2, !dbg !365
  %3 = load i16, i16* %i, align 2, !dbg !367
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %3, !dbg !367
  store %struct._node_t* %arrayidx, %struct._node_t** %sibling_node, align 2, !dbg !368
  %4 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !369
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %4, i32 0, i32 0, !dbg !371
  %5 = load i16, i16* %letter, align 2, !dbg !371
  %6 = load i16, i16* @_global_letter, align 2, !dbg !372
  %cmp1 = icmp eq i16 %5, %6, !dbg !373
  br i1 %cmp1, label %if.then.2, label %if.else, !dbg !374

if.then.2:                                        ; preds = %if.then
  %7 = load i16, i16* @_global_sibling_bak, align 2, !dbg !375
  store i16 %7, i16* @_global_parent_next, align 2, !dbg !377
  %8 = bitcast i16* @_global_sibling to i8*
  %9 = bitcast i16* @_global_sibling_bak to i8*
  %10 = getelementptr inbounds i16, i16* null, i16 1
  %11 = ptrtoint i16* %10 to i16
  call void @write_to_gbuf(i8* %9, i8* %8, i16 %11)
  call void @transition_to(%struct.task_t* @_task_task_letterize), !dbg !378
  br label %if.end.6, !dbg !379

if.else:                                          ; preds = %if.then
  %12 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !380
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %12, i32 0, i32 1, !dbg !383
  %13 = load i16, i16* %sibling, align 2, !dbg !383
  %cmp3 = icmp ne i16 %13, 0, !dbg !384
  br i1 %cmp3, label %if.then.4, label %if.end, !dbg !385

if.then.4:                                        ; preds = %if.else
  %14 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !386
  %sibling5 = getelementptr inbounds %struct._node_t, %struct._node_t* %14, i32 0, i32 1, !dbg !388
  %15 = load i16, i16* %sibling5, align 2, !dbg !388
  store i16 %15, i16* @_global_sibling_bak, align 2, !dbg !389
  %16 = bitcast i16* @_global_sibling to i8*
  %17 = bitcast i16* @_global_sibling_bak to i8*
  %18 = getelementptr inbounds i16, i16* null, i16 1
  %19 = ptrtoint i16* %18 to i16
  call void @write_to_gbuf(i8* %17, i8* %16, i16 %19)
  call void @transition_to(%struct.task_t* @_task_task_find_sibling), !dbg !390
  br label %if.end, !dbg !391

if.end:                                           ; preds = %if.then.4, %if.else
  br label %if.end.6

if.end.6:                                         ; preds = %if.end, %if.then.2
  br label %if.end.7, !dbg !392

if.end.7:                                         ; preds = %if.end.6, %entry
  call void @llvm.dbg.declare(metadata i16* %starting_node_idx, metadata !393, metadata !253), !dbg !394
  %20 = load i16, i16* @_global_letter, align 2, !dbg !395
  store i16 %20, i16* %starting_node_idx, align 2, !dbg !394
  %21 = load i16, i16* %starting_node_idx, align 2, !dbg !396
  store i16 %21, i16* @_global_parent_next, align 2, !dbg !397
  %22 = load i16, i16* @_global_child, align 2, !dbg !398
  %cmp8 = icmp eq i16 %22, 0, !dbg !400
  br i1 %cmp8, label %if.then.9, label %if.else.10, !dbg !401

if.then.9:                                        ; preds = %if.end.7
  %23 = bitcast i16* @_global_sibling to i8*
  %24 = bitcast i16* @_global_sibling_bak to i8*
  %25 = getelementptr inbounds i16, i16* null, i16 1
  %26 = ptrtoint i16* %25 to i16
  call void @write_to_gbuf(i8* %24, i8* %23, i16 %26)
  call void @transition_to(%struct.task_t* @_task_task_add_insert), !dbg !402
  br label %if.end.11, !dbg !404

if.else.10:                                       ; preds = %if.end.7
  %27 = bitcast i16* @_global_sibling to i8*
  %28 = bitcast i16* @_global_sibling_bak to i8*
  %29 = getelementptr inbounds i16, i16* null, i16 1
  %30 = ptrtoint i16* %29 to i16
  call void @write_to_gbuf(i8* %28, i8* %27, i16 %30)
  call void @transition_to(%struct.task_t* @_task_task_add_node), !dbg !405
  br label %if.end.11

if.end.11:                                        ; preds = %if.else.10, %if.then.9
  ret void, !dbg !407
}

; Function Attrs: nounwind
define void @task_add_node() #1 {
entry:
  %0 = load i16, i16* @_global_sibling
  store i16 %0, i16* @_global_sibling_bak
  %sibling_node = alloca %struct._node_t*, align 2
  %i = alloca i16, align 2
  %next_sibling = alloca i16, align 2
  %sibling_node_obj = alloca %struct._node_t, align 2
  call void @llvm.dbg.declare(metadata %struct._node_t** %sibling_node, metadata !408, metadata !253), !dbg !409
  call void @llvm.dbg.declare(metadata i16* %i, metadata !410, metadata !253), !dbg !411
  %1 = load i16, i16* @_global_sibling_bak, align 2, !dbg !412
  store i16 %1, i16* %i, align 2, !dbg !411
  %2 = load i16, i16* %i, align 2, !dbg !413
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %2, !dbg !413
  store %struct._node_t* %arrayidx, %struct._node_t** %sibling_node, align 2, !dbg !414
  %3 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !415
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %3, i32 0, i32 1, !dbg !417
  %4 = load i16, i16* %sibling, align 2, !dbg !417
  %cmp = icmp ne i16 %4, 0, !dbg !418
  br i1 %cmp, label %if.then, label %if.else, !dbg !419

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i16* %next_sibling, metadata !420, metadata !253), !dbg !422
  %5 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !423
  %sibling1 = getelementptr inbounds %struct._node_t, %struct._node_t* %5, i32 0, i32 1, !dbg !424
  %6 = load i16, i16* %sibling1, align 2, !dbg !424
  store i16 %6, i16* %next_sibling, align 2, !dbg !422
  %7 = load i16, i16* %next_sibling, align 2, !dbg !425
  store i16 %7, i16* @_global_sibling_bak, align 2, !dbg !426
  %8 = bitcast i16* @_global_sibling to i8*
  %9 = bitcast i16* @_global_sibling_bak to i8*
  %10 = getelementptr inbounds i16, i16* null, i16 1
  %11 = ptrtoint i16* %10 to i16
  call void @write_to_gbuf(i8* %9, i8* %8, i16 %11)
  call void @transition_to(%struct.task_t* @_task_task_add_node), !dbg !427
  br label %if.end, !dbg !428

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata %struct._node_t* %sibling_node_obj, metadata !429, metadata !253), !dbg !431
  %12 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !432
  %13 = bitcast %struct._node_t* %sibling_node_obj to i8*, !dbg !433
  %14 = bitcast %struct._node_t* %12 to i8*, !dbg !433
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %13, i8* %14, i16 6, i32 2, i1 false), !dbg !433
  %15 = bitcast %struct._node_t* %sibling_node_obj to i8*, !dbg !434
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* bitcast (%struct._node_t* @_global_sibling_node to i8*), i8* %15, i16 6, i32 2, i1 false), !dbg !434
  %16 = bitcast i16* @_global_sibling to i8*
  %17 = bitcast i16* @_global_sibling_bak to i8*
  %18 = getelementptr inbounds i16, i16* null, i16 1
  %19 = ptrtoint i16* %18 to i16
  call void @write_to_gbuf(i8* %17, i8* %16, i16 %19)
  call void @transition_to(%struct.task_t* @_task_task_add_insert), !dbg !435
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void, !dbg !436
}

; Function Attrs: nounwind
define void @task_add_insert() #1 {
entry:
  %0 = load i16, i16* @_global_node_count
  store i16 %0, i16* @_global_node_count_bak
  %child = alloca i16, align 2
  %child_node = alloca %struct._node_t, align 2
  %parent_node_obj = alloca %struct._node_t, align 2
  %i = alloca i16, align 2
  %last_sibling = alloca i16, align 2
  %last_sibling_node = alloca %struct._node_t, align 2
  %1 = load i16, i16* @_global_node_count_bak, align 2, !dbg !437
  %cmp = icmp eq i16 %1, 512, !dbg !439
  br i1 %cmp, label %if.then, label %if.end, !dbg !440

if.then:                                          ; preds = %entry
  br label %while.body, !dbg !441

while.body:                                       ; preds = %if.then, %while.body
  br label %while.body, !dbg !443

if.end:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata i16* %child, metadata !446, metadata !253), !dbg !447
  %2 = load i16, i16* @_global_node_count_bak, align 2, !dbg !448
  store i16 %2, i16* %child, align 2, !dbg !447
  call void @llvm.dbg.declare(metadata %struct._node_t* %child_node, metadata !449, metadata !253), !dbg !450
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %child_node, i32 0, i32 0, !dbg !451
  %3 = load i16, i16* @_global_letter, align 2, !dbg !452
  store i16 %3, i16* %letter, align 2, !dbg !451
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %child_node, i32 0, i32 1, !dbg !451
  store i16 0, i16* %sibling, align 2, !dbg !451
  %child1 = getelementptr inbounds %struct._node_t, %struct._node_t* %child_node, i32 0, i32 2, !dbg !451
  store i16 0, i16* %child1, align 2, !dbg !451
  %4 = load i16, i16* getelementptr inbounds (%struct._node_t, %struct._node_t* @_global_parent_node, i32 0, i32 2), align 2, !dbg !453
  %cmp2 = icmp eq i16 %4, 0, !dbg !455
  br i1 %cmp2, label %if.then.3, label %if.else, !dbg !456

if.then.3:                                        ; preds = %if.end
  call void @llvm.dbg.declare(metadata %struct._node_t* %parent_node_obj, metadata !457, metadata !253), !dbg !459
  %5 = bitcast %struct._node_t* %parent_node_obj to i8*, !dbg !460
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %5, i8* bitcast (%struct._node_t* @_global_parent_node to i8*), i16 6, i32 2, i1 false), !dbg !460
  %6 = load i16, i16* %child, align 2, !dbg !461
  %child4 = getelementptr inbounds %struct._node_t, %struct._node_t* %parent_node_obj, i32 0, i32 2, !dbg !462
  store i16 %6, i16* %child4, align 2, !dbg !463
  call void @llvm.dbg.declare(metadata i16* %i, metadata !464, metadata !253), !dbg !465
  %7 = load i16, i16* @_global_parent, align 2, !dbg !466
  store i16 %7, i16* %i, align 2, !dbg !465
  %8 = load i16, i16* %i, align 2, !dbg !467
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %8, !dbg !467
  %9 = bitcast %struct._node_t* %arrayidx to i8*, !dbg !468
  %10 = bitcast %struct._node_t* %parent_node_obj to i8*, !dbg !468
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %9, i8* %10, i16 6, i32 2, i1 false), !dbg !468
  br label %if.end.7, !dbg !469

if.else:                                          ; preds = %if.end
  call void @llvm.dbg.declare(metadata i16* %last_sibling, metadata !470, metadata !253), !dbg !472
  %11 = load i16, i16* @_global_sibling, align 2, !dbg !473
  store i16 %11, i16* %last_sibling, align 2, !dbg !472
  call void @llvm.dbg.declare(metadata %struct._node_t* %last_sibling_node, metadata !474, metadata !253), !dbg !475
  %12 = bitcast %struct._node_t* %last_sibling_node to i8*, !dbg !476
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %12, i8* bitcast (%struct._node_t* @_global_sibling_node to i8*), i16 6, i32 2, i1 false), !dbg !476
  %13 = load i16, i16* %child, align 2, !dbg !477
  %sibling5 = getelementptr inbounds %struct._node_t, %struct._node_t* %last_sibling_node, i32 0, i32 1, !dbg !478
  store i16 %13, i16* %sibling5, align 2, !dbg !479
  %14 = load i16, i16* %last_sibling, align 2, !dbg !480
  %arrayidx6 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %14, !dbg !480
  %15 = bitcast %struct._node_t* %arrayidx6 to i8*, !dbg !481
  %16 = bitcast %struct._node_t* %last_sibling_node to i8*, !dbg !481
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %15, i8* %16, i16 6, i32 2, i1 false), !dbg !481
  br label %if.end.7

if.end.7:                                         ; preds = %if.else, %if.then.3
  %17 = load i16, i16* %child, align 2, !dbg !482
  %arrayidx8 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* @_global_dict, i16 0, i16 %17, !dbg !482
  %18 = bitcast %struct._node_t* %arrayidx8 to i8*, !dbg !483
  %19 = bitcast %struct._node_t* %child_node to i8*, !dbg !483
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %18, i8* %19, i16 6, i32 2, i1 false), !dbg !483
  %20 = load i16, i16* @_global_parent, align 2, !dbg !484
  store i16 %20, i16* @_global_symbol, align 2, !dbg !485
  %21 = load i16, i16* @_global_node_count_bak, align 2, !dbg !486
  %inc = add i16 %21, 1, !dbg !486
  store i16 %inc, i16* @_global_node_count_bak, align 2, !dbg !486
  %22 = bitcast i16* @_global_node_count to i8*
  %23 = bitcast i16* @_global_node_count_bak to i8*
  %24 = getelementptr inbounds i16, i16* null, i16 1
  %25 = ptrtoint i16* %24 to i16
  call void @write_to_gbuf(i8* %23, i8* %22, i16 %25)
  call void @transition_to(%struct.task_t* @_task_task_append_compressed), !dbg !487
  ret void, !dbg !488
}

; Function Attrs: nounwind
define void @task_append_compressed() #1 {
entry:
  %0 = load i16, i16* @_global_out_len
  store i16 %0, i16* @_global_out_len_bak
  %i = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %i, metadata !489, metadata !253), !dbg !490
  %1 = load i16, i16* @_global_out_len_bak, align 2, !dbg !491
  store i16 %1, i16* %i, align 2, !dbg !490
  %2 = load i16, i16* @_global_symbol, align 2, !dbg !492
  %3 = load i16, i16* %i, align 2, !dbg !493
  %arrayidx = getelementptr inbounds [64 x %struct._node_t], [64 x %struct._node_t]* @_global_compressed_data, i16 0, i16 %3, !dbg !493
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %arrayidx, i32 0, i32 0, !dbg !494
  store i16 %2, i16* %letter, align 2, !dbg !495
  %4 = load i16, i16* @_global_out_len_bak, align 2, !dbg !496
  %inc = add i16 %4, 1, !dbg !496
  store i16 %inc, i16* @_global_out_len_bak, align 2, !dbg !496
  %cmp = icmp eq i16 %inc, 64, !dbg !498
  br i1 %cmp, label %if.then, label %if.else, !dbg !499

if.then:                                          ; preds = %entry
  %5 = bitcast i16* @_global_out_len to i8*
  %6 = bitcast i16* @_global_out_len_bak to i8*
  %7 = getelementptr inbounds i16, i16* null, i16 1
  %8 = ptrtoint i16* %7 to i16
  call void @write_to_gbuf(i8* %6, i8* %5, i16 %8)
  call void @transition_to(%struct.task_t* @_task_task_print), !dbg !500
  br label %if.end, !dbg !502

if.else:                                          ; preds = %entry
  %9 = bitcast i16* @_global_out_len to i8*
  %10 = bitcast i16* @_global_out_len_bak to i8*
  %11 = getelementptr inbounds i16, i16* null, i16 1
  %12 = ptrtoint i16* %11 to i16
  call void @write_to_gbuf(i8* %10, i8* %9, i16 %12)
  call void @transition_to(%struct.task_t* @_task_task_sample), !dbg !503
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void, !dbg !505
}

; Function Attrs: nounwind
define void @task_print() #1 {
entry:
  %i = alloca i16, align 2
  %index = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %i, metadata !506, metadata !253), !dbg !507
  %0 = load i16, i16* @overflow, align 2, !dbg !508
  %1 = load volatile i16, i16* @"\010x03D0", align 2, !dbg !508
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i32 0, i32 0), i16 %0, i16 %1), !dbg !508
  %call1 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2, i32 0, i32 0)), !dbg !509
  store i16 0, i16* %i, align 2, !dbg !510
  br label %for.cond, !dbg !512

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i16, i16* %i, align 2, !dbg !513
  %cmp = icmp ult i16 %2, 64, !dbg !517
  br i1 %cmp, label %for.body, label %for.end, !dbg !518

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i16* %index, metadata !519, metadata !253), !dbg !521
  %3 = load i16, i16* %i, align 2, !dbg !522
  %arrayidx = getelementptr inbounds [64 x %struct._node_t], [64 x %struct._node_t]* @_global_compressed_data, i16 0, i16 %3, !dbg !522
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %arrayidx, i32 0, i32 0, !dbg !523
  %4 = load i16, i16* %letter, align 2, !dbg !523
  store i16 %4, i16* %index, align 2, !dbg !521
  %5 = load i16, i16* %index, align 2, !dbg !524
  %call2 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i32 0, i32 0), i16 %5), !dbg !524
  %6 = load i16, i16* %i, align 2, !dbg !525
  %cmp3 = icmp ugt i16 %6, 0, !dbg !527
  br i1 %cmp3, label %land.lhs.true, label %if.end, !dbg !528

land.lhs.true:                                    ; preds = %for.body
  %7 = load i16, i16* %i, align 2, !dbg !529
  %add = add i16 %7, 1, !dbg !531
  %rem = urem i16 %add, 8, !dbg !532
  %cmp4 = icmp eq i16 %rem, 0, !dbg !533
  br i1 %cmp4, label %if.then, label %if.end, !dbg !534

if.then:                                          ; preds = %land.lhs.true
  %call5 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)), !dbg !535
  br label %if.end, !dbg !535

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  br label %for.inc, !dbg !536

for.inc:                                          ; preds = %if.end
  %8 = load i16, i16* %i, align 2, !dbg !537
  %inc = add i16 %8, 1, !dbg !537
  store i16 %inc, i16* %i, align 2, !dbg !537
  br label %for.cond, !dbg !538

for.end:                                          ; preds = %for.cond
  %call6 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)), !dbg !539
  %9 = load i16, i16* @_global_sample_count, align 2, !dbg !540
  %call7 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.5, i32 0, i32 0), i16 %9, i16 64), !dbg !540
  call void @transition_to(%struct.task_t* @_task_task_done), !dbg !541
  ret void, !dbg !542
}

; Function Attrs: nounwind
define void @task_done() #1 {
entry:
  %i = alloca i16, align 2
  %0 = load volatile i8, i8* @"\010x0222", align 1, !dbg !543
  %conv = zext i8 %0 to i16, !dbg !543
  %or = or i16 %conv, 1, !dbg !543
  %conv1 = trunc i16 %or to i8, !dbg !543
  store volatile i8 %conv1, i8* @"\010x0222", align 1, !dbg !543
  %1 = load volatile i8, i8* @"\010x0222", align 1, !dbg !544
  %conv2 = zext i8 %1 to i16, !dbg !544
  %and = and i16 %conv2, -3, !dbg !544
  %conv3 = trunc i16 %and to i8, !dbg !544
  store volatile i8 %conv3, i8* @"\010x0222", align 1, !dbg !544
  call void @llvm.dbg.declare(metadata i16* %i, metadata !545, metadata !253), !dbg !547
  store i16 0, i16* %i, align 2, !dbg !547
  br label %for.cond, !dbg !548

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i16, i16* %i, align 2, !dbg !549
  %cmp = icmp ult i16 %2, 10000, !dbg !553
  br i1 %cmp, label %for.body, label %for.end, !dbg !554

for.body:                                         ; preds = %for.cond
  br label %for.inc, !dbg !555

for.inc:                                          ; preds = %for.body
  %3 = load i16, i16* %i, align 2, !dbg !557
  %inc = add i16 %3, 1, !dbg !557
  store i16 %inc, i16* %i, align 2, !dbg !557
  br label %for.cond, !dbg !558

for.end:                                          ; preds = %for.cond
  call void @transition_to(%struct.task_t* @_task_task_init), !dbg !559
  ret void, !dbg !560
}

; Function Attrs: nounwind
define void @_entry_task() #1 {
entry:
  call void @transition_to(%struct.task_t* @_task_task_init), !dbg !561
  ret void, !dbg !561
}

; Function Attrs: nounwind
define void @_init() #1 {
entry:
  call void @init(), !dbg !562
  ret void, !dbg !562
}

declare void @modify_gbuf(i8*, i16, i16)

define void @clear_isDirty() {
entry:
  ret void
}

; Function Attrs: nounwind
define internal void @init_hw() #1 {
entry:
  call void @msp_watchdog_disable(), !dbg !563
  %0 = load volatile i16, i16* @"\010x0130", align 2, !dbg !564
  %and = and i16 %0, -2, !dbg !564
  store volatile i16 %and, i16* @"\010x0130", align 2, !dbg !564
  %1 = load volatile i8, i8* @"\010x0224", align 1, !dbg !565
  %conv = zext i8 %1 to i16, !dbg !565
  %or = or i16 %conv, 1, !dbg !565
  %conv1 = trunc i16 %or to i8, !dbg !565
  store volatile i8 %conv1, i8* @"\010x0224", align 1, !dbg !565
  %2 = load volatile i8, i8* @"\010x0224", align 1, !dbg !566
  %conv2 = zext i8 %2 to i16, !dbg !566
  %or3 = or i16 %conv2, 2, !dbg !566
  %conv4 = trunc i16 %or3 to i8, !dbg !566
  store volatile i8 %conv4, i8* @"\010x0224", align 1, !dbg !566
  %3 = load volatile i8, i8* @"\010x0222", align 1, !dbg !567
  %conv5 = zext i8 %3 to i16, !dbg !567
  %or6 = or i16 %conv5, 1, !dbg !567
  %conv7 = trunc i16 %or6 to i8, !dbg !567
  store volatile i8 %conv7, i8* @"\010x0222", align 1, !dbg !567
  %4 = load volatile i8, i8* @"\010x0222", align 1, !dbg !568
  %conv8 = zext i8 %4 to i16, !dbg !568
  %and9 = and i16 %conv8, -3, !dbg !568
  %conv10 = trunc i16 %and9 to i8, !dbg !568
  store volatile i8 %conv10, i8* @"\010x0222", align 1, !dbg !568
  call void @msp_clock_setup(), !dbg !569
  ret void, !dbg !570
}

; Function Attrs: nounwind
define internal i16 @acquire_sample(i16 %prev_sample) #1 {
entry:
  %prev_sample.addr = alloca i16, align 2
  %sample = alloca i16, align 2
  store i16 %prev_sample, i16* %prev_sample.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %prev_sample.addr, metadata !571, metadata !253), !dbg !572
  call void @llvm.dbg.declare(metadata i16* %sample, metadata !573, metadata !253), !dbg !574
  %0 = load i16, i16* %prev_sample.addr, align 2, !dbg !575
  %add = add i16 %0, 1, !dbg !576
  %and = and i16 %add, 3, !dbg !577
  store i16 %and, i16* %sample, align 2, !dbg !574
  %1 = load i16, i16* %sample, align 2, !dbg !578
  ret i16 %1, !dbg !579
}

; Function Attrs: nounwind
define void @msp_watchdog_enable(i8 zeroext %bits) #1 {
entry:
  tail call void @llvm.dbg.value(metadata i8 %bits, i64 0, metadata !116, metadata !253), !dbg !580
  %conv = zext i8 %bits to i16, !dbg !581
  %or = or i16 %conv, 23048, !dbg !582
  store volatile i16 %or, i16* @"\010x015C", align 2, !dbg !583, !tbaa !584
  store i8 %bits, i8* @watchdog_bits, align 1, !dbg !588, !tbaa !589
  ret void, !dbg !590
}

; Function Attrs: nounwind
define void @msp_watchdog_disable() #1 {
entry:
  store volatile i16 23168, i16* @"\010x015C", align 2, !dbg !591, !tbaa !584
  ret void, !dbg !592
}

; Function Attrs: nounwind
define void @msp_watchdog_kick() #1 {
entry:
  %0 = load i8, i8* @watchdog_bits, align 1, !dbg !593, !tbaa !589
  %conv = zext i8 %0 to i16, !dbg !593
  %or = or i16 %conv, 23048, !dbg !594
  store volatile i16 %or, i16* @"\010x015C", align 2, !dbg !595, !tbaa !584
  ret void, !dbg !596
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #3

; Function Attrs: nounwind
define i8* @memcpy(i8* %dest, i8* nocapture readonly %src, i16 %n) #1 {
entry:
  tail call void @llvm.dbg.value(metadata i8* %dest, i64 0, metadata !137, metadata !253), !dbg !597
  tail call void @llvm.dbg.value(metadata i8* %src, i64 0, metadata !138, metadata !253), !dbg !598
  tail call void @llvm.dbg.value(metadata i16 %n, i64 0, metadata !139, metadata !253), !dbg !599
  tail call void @llvm.dbg.value(metadata i16 0, i64 0, metadata !140, metadata !253), !dbg !600
  %cmp.7 = icmp eq i16 %n, 0, !dbg !601
  br i1 %cmp.7, label %while.end, label %while.body.preheader, !dbg !602

while.body.preheader:                             ; preds = %entry
  br label %while.body, !dbg !603

while.body:                                       ; preds = %while.body.preheader, %while.body
  %i.08 = phi i16 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %add.ptr = getelementptr inbounds i8, i8* %src, i16 %i.08, !dbg !603
  %0 = load i8, i8* %add.ptr, align 1, !dbg !605, !tbaa !589
  %add.ptr1 = getelementptr inbounds i8, i8* %dest, i16 %i.08, !dbg !606
  store i8 %0, i8* %add.ptr1, align 1, !dbg !607, !tbaa !589
  %inc = add nuw i16 %i.08, 1, !dbg !608
  tail call void @llvm.dbg.value(metadata i16 %inc, i64 0, metadata !140, metadata !253), !dbg !600
  %exitcond = icmp eq i16 %inc, %n, !dbg !602
  br i1 %exitcond, label %while.end.loopexit, label %while.body, !dbg !602

while.end.loopexit:                               ; preds = %while.body
  br label %while.end, !dbg !609

while.end:                                        ; preds = %while.end.loopexit, %entry
  ret i8* %dest, !dbg !609
}

; Function Attrs: nounwind
define void @my_memset(i8* nocapture readnone %s, i16 %c, i16 %n) #1 {
entry:
  tail call void @llvm.dbg.value(metadata i8* %s, i64 0, metadata !146, metadata !253), !dbg !610
  tail call void @llvm.dbg.value(metadata i16 %c, i64 0, metadata !147, metadata !253), !dbg !611
  tail call void @llvm.dbg.value(metadata i16 %n, i64 0, metadata !148, metadata !253), !dbg !612
  tail call void asm sideeffect "mov r15, r12\0Aadd r15, r13\0Acmp r13, r12\0Ajz $$+10\0Amov.b r14, 0(r12)\0Ainc r12\0Ajmp $$-10\0A", ""() #5, !dbg !613, !srcloc !614
  ret void, !dbg !615
}

; Function Attrs: nounwind
define void @msp_clock_setup() #1 {
entry:
  store volatile i8 -91, i8* @"\010x0160+1", align 1, !dbg !616, !tbaa !589
  store volatile i16 70, i16* @"\010x0162", align 2, !dbg !617, !tbaa !584
  store volatile i16 51, i16* @"\010x0164", align 2, !dbg !618, !tbaa !584
  store volatile i16 0, i16* @"\010x0166", align 2, !dbg !619, !tbaa !584
  ret void, !dbg !620
}

; Function Attrs: nounwind
define void @task_prologue() #1 {
entry:
  %curtask = alloca %struct.task_t*, align 2
  %w_data_dest = alloca i8*, align 2
  %w_data_src = alloca i8*, align 2
  %w_data_size = alloca i16, align 2
  %0 = load volatile i16, i16* @_numBoots, align 2, !dbg !621
  %cmp = icmp eq i16 %0, -1, !dbg !623
  br i1 %cmp, label %if.then, label %if.end, !dbg !624

if.then:                                          ; preds = %entry
  call void @clear_isDirty(), !dbg !625
  %1 = load volatile i16, i16* @_numBoots, align 2, !dbg !627
  %inc = add i16 %1, 1, !dbg !627
  store volatile i16 %inc, i16* @_numBoots, align 2, !dbg !627
  br label %if.end, !dbg !628

if.end:                                           ; preds = %if.then, %entry
  %2 = load volatile i16, i16* @_numBoots, align 2, !dbg !629
  %inc1 = add i16 %2, 1, !dbg !629
  store volatile i16 %inc1, i16* @_numBoots, align 2, !dbg !629
  call void @llvm.dbg.declare(metadata %struct.task_t** %curtask, metadata !630, metadata !253), !dbg !631
  %3 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !632
  %prev_ctx = getelementptr inbounds %struct._context_t, %struct._context_t* %3, i32 0, i32 2, !dbg !633
  %4 = load %struct._context_t*, %struct._context_t** %prev_ctx, align 2, !dbg !633
  %task = getelementptr inbounds %struct._context_t, %struct._context_t* %4, i32 0, i32 0, !dbg !634
  %5 = load %struct.task_t*, %struct.task_t** %task, align 2, !dbg !634
  store %struct.task_t* %5, %struct.task_t** %curtask, align 2, !dbg !631
  %6 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !635
  %time = getelementptr inbounds %struct._context_t, %struct._context_t* %6, i32 0, i32 1, !dbg !637
  %7 = load i16, i16* %time, align 2, !dbg !637
  %8 = load %struct.task_t*, %struct.task_t** %curtask, align 2, !dbg !638
  %last_execute_time = getelementptr inbounds %struct.task_t, %struct.task_t* %8, i32 0, i32 3, !dbg !639
  %9 = load volatile i16, i16* %last_execute_time, align 2, !dbg !639
  %cmp2 = icmp ne i16 %7, %9, !dbg !640
  br i1 %cmp2, label %if.then.3, label %if.else, !dbg !641

if.then.3:                                        ; preds = %if.end
  br label %while.cond, !dbg !642

while.cond:                                       ; preds = %while.body, %if.then.3
  %10 = load volatile i16, i16* @gv_index, align 2, !dbg !644
  %11 = load volatile i16, i16* @num_dirty_gv, align 2, !dbg !647
  %cmp4 = icmp ult i16 %10, %11, !dbg !648
  br i1 %cmp4, label %while.body, label %while.end, !dbg !642

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i8** %w_data_dest, metadata !649, metadata !253), !dbg !651
  %12 = load i8**, i8*** @data_dest_base, align 2, !dbg !652
  %13 = load volatile i16, i16* @gv_index, align 2, !dbg !653
  %add.ptr = getelementptr inbounds i8*, i8** %12, i16 %13, !dbg !654
  %14 = load i8*, i8** %add.ptr, align 2, !dbg !655
  store i8* %14, i8** %w_data_dest, align 2, !dbg !651
  call void @llvm.dbg.declare(metadata i8** %w_data_src, metadata !656, metadata !253), !dbg !657
  %15 = load i8**, i8*** @data_src_base, align 2, !dbg !658
  %16 = load volatile i16, i16* @gv_index, align 2, !dbg !659
  %add.ptr5 = getelementptr inbounds i8*, i8** %15, i16 %16, !dbg !660
  %17 = load i8*, i8** %add.ptr5, align 2, !dbg !661
  store i8* %17, i8** %w_data_src, align 2, !dbg !657
  call void @llvm.dbg.declare(metadata i16* %w_data_size, metadata !662, metadata !253), !dbg !663
  %18 = load i16*, i16** @data_size_base, align 2, !dbg !664
  %19 = load volatile i16, i16* @gv_index, align 2, !dbg !665
  %add.ptr6 = getelementptr inbounds i16, i16* %18, i16 %19, !dbg !666
  %20 = load i16, i16* %add.ptr6, align 2, !dbg !667
  store i16 %20, i16* %w_data_size, align 2, !dbg !663
  %21 = load i8*, i8** %w_data_dest, align 2, !dbg !668
  %22 = load i8*, i8** %w_data_src, align 2, !dbg !669
  %23 = load i16, i16* %w_data_size, align 2, !dbg !670
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* %21, i8* %22, i16 %23, i32 1, i1 false), !dbg !671
  %24 = load volatile i16, i16* @gv_index, align 2, !dbg !672
  %inc7 = add i16 %24, 1, !dbg !672
  store volatile i16 %inc7, i16* @gv_index, align 2, !dbg !672
  br label %while.cond, !dbg !642

while.end:                                        ; preds = %while.cond
  store volatile i16 0, i16* @num_dirty_gv, align 2, !dbg !673
  store volatile i16 0, i16* @gv_index, align 2, !dbg !674
  %25 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !675
  %time8 = getelementptr inbounds %struct._context_t, %struct._context_t* %25, i32 0, i32 1, !dbg !676
  %26 = load i16, i16* %time8, align 2, !dbg !676
  %27 = load %struct.task_t*, %struct.task_t** %curtask, align 2, !dbg !677
  %last_execute_time9 = getelementptr inbounds %struct.task_t, %struct.task_t* %27, i32 0, i32 3, !dbg !678
  store volatile i16 %26, i16* %last_execute_time9, align 2, !dbg !679
  br label %if.end.10, !dbg !680

if.else:                                          ; preds = %if.end
  store volatile i16 0, i16* @num_dirty_gv, align 2, !dbg !681
  br label %if.end.10

if.end.10:                                        ; preds = %if.else, %while.end
  ret void, !dbg !683
}

; Function Attrs: nounwind
define void @transition_to(%struct.task_t* %next_task) #1 {
entry:
  %next_task.addr = alloca %struct.task_t*, align 2
  %next_ctx = alloca %struct._context_t*, align 2
  store %struct.task_t* %next_task, %struct.task_t** %next_task.addr, align 2
  call void @llvm.dbg.declare(metadata %struct.task_t** %next_task.addr, metadata !684, metadata !253), !dbg !685
  call void @llvm.dbg.declare(metadata %struct._context_t** %next_ctx, metadata !686, metadata !253), !dbg !687
  %0 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !688
  %cmp = icmp eq %struct._context_t* %0, @context_0, !dbg !689
  %cond = select i1 %cmp, %struct._context_t* @context_2, %struct._context_t* @context_0, !dbg !688
  store %struct._context_t* %cond, %struct._context_t** %next_ctx, align 2, !dbg !690
  %1 = load %struct.task_t*, %struct.task_t** %next_task.addr, align 2, !dbg !691
  %2 = load %struct._context_t*, %struct._context_t** %next_ctx, align 2, !dbg !692
  %task = getelementptr inbounds %struct._context_t, %struct._context_t* %2, i32 0, i32 0, !dbg !693
  store %struct.task_t* %1, %struct.task_t** %task, align 2, !dbg !694
  %3 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !695
  %time = getelementptr inbounds %struct._context_t, %struct._context_t* %3, i32 0, i32 1, !dbg !696
  %4 = load i16, i16* %time, align 2, !dbg !696
  %add = add i16 %4, 1, !dbg !697
  %5 = load %struct._context_t*, %struct._context_t** %next_ctx, align 2, !dbg !698
  %time1 = getelementptr inbounds %struct._context_t, %struct._context_t* %5, i32 0, i32 1, !dbg !699
  store i16 %add, i16* %time1, align 2, !dbg !700
  %6 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !701
  %time2 = getelementptr inbounds %struct._context_t, %struct._context_t* %6, i32 0, i32 1, !dbg !702
  %7 = load i16, i16* %time2, align 2, !dbg !702
  %8 = load %struct._context_t*, %struct._context_t** %next_ctx, align 2, !dbg !703
  %prev_ctx = getelementptr inbounds %struct._context_t, %struct._context_t* %8, i32 0, i32 2, !dbg !704
  %9 = load %struct._context_t*, %struct._context_t** %prev_ctx, align 2, !dbg !704
  %time3 = getelementptr inbounds %struct._context_t, %struct._context_t* %9, i32 0, i32 1, !dbg !705
  store i16 %7, i16* %time3, align 2, !dbg !706
  %10 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !707
  %task4 = getelementptr inbounds %struct._context_t, %struct._context_t* %10, i32 0, i32 0, !dbg !708
  %11 = load %struct.task_t*, %struct.task_t** %task4, align 2, !dbg !708
  %12 = load %struct._context_t*, %struct._context_t** %next_ctx, align 2, !dbg !709
  %prev_ctx5 = getelementptr inbounds %struct._context_t, %struct._context_t* %12, i32 0, i32 2, !dbg !710
  %13 = load %struct._context_t*, %struct._context_t** %prev_ctx5, align 2, !dbg !710
  %task6 = getelementptr inbounds %struct._context_t, %struct._context_t* %13, i32 0, i32 0, !dbg !711
  store %struct.task_t* %11, %struct.task_t** %task6, align 2, !dbg !712
  %14 = load %struct._context_t*, %struct._context_t** %next_ctx, align 2, !dbg !713
  store volatile %struct._context_t* %14, %struct._context_t** @curctx, align 2, !dbg !714
  call void @task_prologue(), !dbg !715
  %15 = load %struct.task_t*, %struct.task_t** %next_task.addr, align 2, !dbg !716
  %func = getelementptr inbounds %struct.task_t, %struct.task_t* %15, i32 0, i32 0, !dbg !717
  %16 = load void ()*, void ()** %func, align 2, !dbg !717
  call void asm sideeffect "mov #0x2400, r1\0Abr $0\0A", "r"(void ()* %16) #5, !dbg !718, !srcloc !719
  ret void, !dbg !720
}

; Function Attrs: nounwind
define void @write_to_gbuf(i8* %data_src, i8* %data_dest, i16 %var_size) #1 {
entry:
  %data_src.addr = alloca i8*, align 2
  %data_dest.addr = alloca i8*, align 2
  %var_size.addr = alloca i16, align 2
  store i8* %data_src, i8** %data_src.addr, align 2
  call void @llvm.dbg.declare(metadata i8** %data_src.addr, metadata !721, metadata !253), !dbg !722
  store i8* %data_dest, i8** %data_dest.addr, align 2
  call void @llvm.dbg.declare(metadata i8** %data_dest.addr, metadata !723, metadata !253), !dbg !724
  store i16 %var_size, i16* %var_size.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %var_size.addr, metadata !725, metadata !253), !dbg !726
  %0 = load i16, i16* %var_size.addr, align 2, !dbg !727
  %1 = load i16*, i16** @data_size_base, align 2, !dbg !728
  %2 = load volatile i16, i16* @num_dirty_gv, align 2, !dbg !729
  %add.ptr = getelementptr inbounds i16, i16* %1, i16 %2, !dbg !730
  store i16 %0, i16* %add.ptr, align 2, !dbg !731
  %3 = load i8*, i8** %data_dest.addr, align 2, !dbg !732
  %4 = load i8**, i8*** @data_dest_base, align 2, !dbg !733
  %5 = load volatile i16, i16* @num_dirty_gv, align 2, !dbg !734
  %add.ptr1 = getelementptr inbounds i8*, i8** %4, i16 %5, !dbg !735
  store i8* %3, i8** %add.ptr1, align 2, !dbg !736
  %6 = load i8*, i8** %data_src.addr, align 2, !dbg !737
  %7 = load i8**, i8*** @data_src_base, align 2, !dbg !738
  %8 = load volatile i16, i16* @num_dirty_gv, align 2, !dbg !739
  %add.ptr2 = getelementptr inbounds i8*, i8** %7, i16 %8, !dbg !740
  store i8* %6, i8** %add.ptr2, align 2, !dbg !741
  %9 = load volatile i16, i16* @num_dirty_gv, align 2, !dbg !742
  %inc = add i16 %9, 1, !dbg !742
  store volatile i16 %inc, i16* @num_dirty_gv, align 2, !dbg !742
  ret void, !dbg !743
}

; Function Attrs: nounwind
define i16 @main() #1 {
entry:
  %retval = alloca i16, align 2
  store i16 0, i16* %retval, align 2
  call void @_init(), !dbg !744
  call void @task_prologue(), !dbg !745
  %0 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !746
  %task = getelementptr inbounds %struct._context_t, %struct._context_t* %0, i32 0, i32 0, !dbg !747
  %1 = load %struct.task_t*, %struct.task_t** %task, align 2, !dbg !747
  %func = getelementptr inbounds %struct.task_t, %struct.task_t* %1, i32 0, i32 0, !dbg !748
  %2 = load void ()*, void ()** %func, align 2, !dbg !748
  call void asm sideeffect "br $0\0A", "r"(void ()* %2) #5, !dbg !749, !srcloc !750
  ret i16 0, !dbg !751
}

attributes #0 = { noinline nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind argmemonly }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0, !104, !121, !123, !149, !153, !155}
!llvm.ident = !{!221, !221, !222, !221, !221, !221, !221}
!llvm.module.flags = !{!223, !224}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, retainedTypes: !3, subprograms: !6, globals: !31)
!1 = !DIFile(filename: "/home/reviewer/src/apps/app-temp-log-alpaca-new/src/main.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/bld/alpaca")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "index_t", file: !1, line: 55, baseType: !5)
!5 = !DIBasicType(name: "unsigned int", size: 16, align: 16, encoding: DW_ATE_unsigned)
!6 = !{!7, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26}
!7 = distinct !DISubprogram(name: "TimerB1_ISR", scope: !1, file: !1, line: 43, type: !8, isLocal: false, isDefinition: true, scopeLine: 43, flags: DIFlagPrototyped, isOptimized: false, function: void ()* @TimerB1_ISR, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = distinct !DISubprogram(name: "init", scope: !1, file: !1, line: 115, type: !8, isLocal: false, isDefinition: true, scopeLine: 116, isOptimized: false, function: void ()* @init, variables: !2)
!11 = distinct !DISubprogram(name: "task_init", scope: !1, file: !1, line: 154, type: !8, isLocal: false, isDefinition: true, scopeLine: 155, isOptimized: false, function: void ()* @task_init, variables: !2)
!12 = distinct !DISubprogram(name: "task_init_dict", scope: !1, file: !1, line: 176, type: !8, isLocal: false, isDefinition: true, scopeLine: 177, isOptimized: false, function: void ()* @task_init_dict, variables: !2)
!13 = distinct !DISubprogram(name: "task_sample", scope: !1, file: !1, line: 198, type: !8, isLocal: false, isDefinition: true, scopeLine: 199, isOptimized: false, function: void ()* @task_sample, variables: !2)
!14 = distinct !DISubprogram(name: "task_measure_temp", scope: !1, file: !1, line: 218, type: !8, isLocal: false, isDefinition: true, scopeLine: 219, isOptimized: false, function: void ()* @task_measure_temp, variables: !2)
!15 = distinct !DISubprogram(name: "task_letterize", scope: !1, file: !1, line: 243, type: !8, isLocal: false, isDefinition: true, scopeLine: 244, isOptimized: false, function: void ()* @task_letterize, variables: !2)
!16 = distinct !DISubprogram(name: "task_compress", scope: !1, file: !1, line: 259, type: !8, isLocal: false, isDefinition: true, scopeLine: 260, isOptimized: false, function: void ()* @task_compress, variables: !2)
!17 = distinct !DISubprogram(name: "task_find_sibling", scope: !1, file: !1, line: 295, type: !8, isLocal: false, isDefinition: true, scopeLine: 296, isOptimized: false, function: void ()* @task_find_sibling, variables: !2)
!18 = distinct !DISubprogram(name: "task_add_node", scope: !1, file: !1, line: 347, type: !8, isLocal: false, isDefinition: true, scopeLine: 348, isOptimized: false, function: void ()* @task_add_node, variables: !2)
!19 = distinct !DISubprogram(name: "task_add_insert", scope: !1, file: !1, line: 386, type: !8, isLocal: false, isDefinition: true, scopeLine: 387, isOptimized: false, function: void ()* @task_add_insert, variables: !2)
!20 = distinct !DISubprogram(name: "task_append_compressed", scope: !1, file: !1, line: 436, type: !8, isLocal: false, isDefinition: true, scopeLine: 437, isOptimized: false, function: void ()* @task_append_compressed, variables: !2)
!21 = distinct !DISubprogram(name: "task_print", scope: !1, file: !1, line: 451, type: !8, isLocal: false, isDefinition: true, scopeLine: 452, isOptimized: false, function: void ()* @task_print, variables: !2)
!22 = distinct !DISubprogram(name: "task_done", scope: !1, file: !1, line: 471, type: !8, isLocal: false, isDefinition: true, scopeLine: 472, isOptimized: false, function: void ()* @task_done, variables: !2)
!23 = distinct !DISubprogram(name: "_entry_task", scope: !1, file: !1, line: 485, type: !8, isLocal: false, isDefinition: true, scopeLine: 485, isOptimized: false, function: void ()* @_entry_task, variables: !2)
!24 = distinct !DISubprogram(name: "_init", scope: !1, file: !1, line: 486, type: !8, isLocal: false, isDefinition: true, scopeLine: 486, isOptimized: false, function: void ()* @_init, variables: !2)
!25 = distinct !DISubprogram(name: "init_hw", scope: !1, file: !1, line: 101, type: !8, isLocal: true, isDefinition: true, scopeLine: 102, isOptimized: false, function: void ()* @init_hw, variables: !2)
!26 = distinct !DISubprogram(name: "acquire_sample", scope: !1, file: !1, line: 147, type: !27, isLocal: true, isDefinition: true, scopeLine: 148, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16)* @acquire_sample, variables: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!29, !30}
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "sample_t", file: !1, line: 57, baseType: !5)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "letter_t", file: !1, line: 56, baseType: !5)
!31 = !{!32, !33, !35, !38, !63, !64, !65, !66, !67, !68, !69, !70, !71, !72, !73, !74, !75, !76, !77, !78, !79, !80, !81, !91, !92, !93, !94, !95, !96, !97, !98, !102, !103}
!32 = !DIGlobalVariable(name: "overflow", scope: !0, file: !1, line: 40, type: !5, isLocal: false, isDefinition: true, variable: i16* @overflow)
!33 = !DIGlobalVariable(name: "__vector_timer0_b1", scope: !0, file: !1, line: 53, type: !34, isLocal: false, isDefinition: true, variable: void ()** @__vector_timer0_b1)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 16, align: 16)
!35 = !DIGlobalVariable(name: "timer", scope: !0, file: !1, line: 58, type: !36, isLocal: false, isDefinition: true, variable: i16** @timer)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 16, align: 16)
!37 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !5)
!38 = !DIGlobalVariable(name: "_task_task_init", scope: !0, file: !1, line: 67, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_init)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_t", file: !40, line: 81, baseType: !41)
!40 = !DIFile(filename: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/src/include/libalpaca/alpaca.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/bld/alpaca")
!41 = !DICompositeType(tag: DW_TAG_structure_type, file: !40, line: 66, size: 336, align: 16, elements: !42)
!42 = !{!43, !46, !53, !55, !58}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "func", scope: !41, file: !40, line: 67, baseType: !44, size: 16, align: 16)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 16, align: 16)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_func_t", file: !40, line: 23, baseType: !8)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !41, file: !40, line: 68, baseType: !47, size: 32, align: 16, offset: 16)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_mask_t", file: !40, line: 25, baseType: !48)
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !49, line: 66, baseType: !50)
!49 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/bld/alpaca")
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !51, line: 56, baseType: !52)
!51 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/bld/alpaca")
!52 = !DIBasicType(name: "long unsigned int", size: 32, align: 16, encoding: DW_ATE_unsigned)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "idx", scope: !41, file: !40, line: 69, baseType: !54, size: 16, align: 16, offset: 48)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_idx_t", file: !40, line: 27, baseType: !5)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "last_execute_time", scope: !41, file: !40, line: 78, baseType: !56, size: 16, align: 16, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !57)
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "chain_time_t", file: !40, line: 24, baseType: !5)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !41, file: !40, line: 80, baseType: !59, size: 256, align: 8, offset: 80)
!59 = !DICompositeType(tag: DW_TAG_array_type, baseType: !60, size: 256, align: 8, elements: !61)
!60 = !DIBasicType(name: "char", size: 8, align: 8, encoding: DW_ATE_signed_char)
!61 = !{!62}
!62 = !DISubrange(count: 32)
!63 = !DIGlobalVariable(name: "_task_task_init_dict", scope: !0, file: !1, line: 68, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_init_dict)
!64 = !DIGlobalVariable(name: "_task_task_sample", scope: !0, file: !1, line: 69, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_sample)
!65 = !DIGlobalVariable(name: "_task_task_measure_temp", scope: !0, file: !1, line: 70, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_measure_temp)
!66 = !DIGlobalVariable(name: "_task_task_letterize", scope: !0, file: !1, line: 71, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_letterize)
!67 = !DIGlobalVariable(name: "_task_task_compress", scope: !0, file: !1, line: 72, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_compress)
!68 = !DIGlobalVariable(name: "_task_task_find_sibling", scope: !0, file: !1, line: 73, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_find_sibling)
!69 = !DIGlobalVariable(name: "_task_task_add_node", scope: !0, file: !1, line: 74, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_add_node)
!70 = !DIGlobalVariable(name: "_task_task_add_insert", scope: !0, file: !1, line: 75, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_add_insert)
!71 = !DIGlobalVariable(name: "_task_task_append_compressed", scope: !0, file: !1, line: 76, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_append_compressed)
!72 = !DIGlobalVariable(name: "_task_task_print", scope: !0, file: !1, line: 77, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_print)
!73 = !DIGlobalVariable(name: "_task_task_done", scope: !0, file: !1, line: 78, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task_task_done)
!74 = !DIGlobalVariable(name: "nvram", scope: !0, file: !1, line: 153, type: !5, isLocal: false, isDefinition: true, variable: i16* @nvram)
!75 = !DIGlobalVariable(name: "_task__entry_task", scope: !0, file: !1, line: 485, type: !39, isLocal: false, isDefinition: true, variable: %struct.task_t* @_task__entry_task)
!76 = !DIGlobalVariable(name: "_global_letter", scope: !0, file: !1, line: 80, type: !30, isLocal: false, isDefinition: true, variable: i16* @_global_letter)
!77 = !DIGlobalVariable(name: "_global_letter_idx", scope: !0, file: !1, line: 81, type: !5, isLocal: false, isDefinition: true, variable: i16* @_global_letter_idx)
!78 = !DIGlobalVariable(name: "_global_prev_sample", scope: !0, file: !1, line: 83, type: !29, isLocal: false, isDefinition: true, variable: i16* @_global_prev_sample)
!79 = !DIGlobalVariable(name: "_global_out_len", scope: !0, file: !1, line: 85, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_out_len)
!80 = !DIGlobalVariable(name: "_global_node_count", scope: !0, file: !1, line: 86, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_node_count)
!81 = !DIGlobalVariable(name: "_global_dict", scope: !0, file: !1, line: 87, type: !82, isLocal: false, isDefinition: true, variable: [512 x %struct._node_t]* @_global_dict)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 24576, align: 16, elements: !89)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_t", file: !1, line: 65, baseType: !84)
!84 = !DICompositeType(tag: DW_TAG_structure_type, name: "_node_t", file: !1, line: 61, size: 48, align: 16, elements: !85)
!85 = !{!86, !87, !88}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "letter", scope: !84, file: !1, line: 62, baseType: !30, size: 16, align: 16)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "sibling", scope: !84, file: !1, line: 63, baseType: !4, size: 16, align: 16, offset: 16)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "child", scope: !84, file: !1, line: 64, baseType: !4, size: 16, align: 16, offset: 32)
!89 = !{!90}
!90 = !DISubrange(count: 512)
!91 = !DIGlobalVariable(name: "_global_sample", scope: !0, file: !1, line: 88, type: !29, isLocal: false, isDefinition: true, variable: i16* @_global_sample)
!92 = !DIGlobalVariable(name: "_global_sample_count", scope: !0, file: !1, line: 89, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_sample_count)
!93 = !DIGlobalVariable(name: "_global_sibling", scope: !0, file: !1, line: 90, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_sibling)
!94 = !DIGlobalVariable(name: "_global_child", scope: !0, file: !1, line: 91, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_child)
!95 = !DIGlobalVariable(name: "_global_parent", scope: !0, file: !1, line: 92, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_parent)
!96 = !DIGlobalVariable(name: "_global_parent_next", scope: !0, file: !1, line: 93, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_parent_next)
!97 = !DIGlobalVariable(name: "_global_parent_node", scope: !0, file: !1, line: 94, type: !83, isLocal: false, isDefinition: true, variable: %struct._node_t* @_global_parent_node)
!98 = !DIGlobalVariable(name: "_global_compressed_data", scope: !0, file: !1, line: 95, type: !99, isLocal: false, isDefinition: true, variable: [64 x %struct._node_t]* @_global_compressed_data)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 3072, align: 16, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 64)
!102 = !DIGlobalVariable(name: "_global_sibling_node", scope: !0, file: !1, line: 96, type: !83, isLocal: false, isDefinition: true, variable: %struct._node_t* @_global_sibling_node)
!103 = !DIGlobalVariable(name: "_global_symbol", scope: !0, file: !1, line: 97, type: !4, isLocal: false, isDefinition: true, variable: i16* @_global_symbol)
!104 = distinct !DICompileUnit(language: DW_LANG_C99, file: !105, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !106, globals: !119)
!105 = !DIFile(filename: "../../src/watchdog.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!106 = !{!107, !117, !118}
!107 = distinct !DISubprogram(name: "msp_watchdog_enable", scope: !105, file: !105, line: 7, type: !108, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: true, function: void (i8)* @msp_watchdog_enable, variables: !115)
!108 = !DISubroutineType(types: !109)
!109 = !{null, !110}
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !111, line: 42, baseType: !112)
!111 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!112 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !113, line: 28, baseType: !114)
!113 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!114 = !DIBasicType(name: "unsigned char", size: 8, align: 8, encoding: DW_ATE_unsigned_char)
!115 = !{!116}
!116 = !DILocalVariable(name: "bits", arg: 1, scope: !107, file: !105, line: 7, type: !110)
!117 = distinct !DISubprogram(name: "msp_watchdog_disable", scope: !105, file: !105, line: 13, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: true, function: void ()* @msp_watchdog_disable, variables: !2)
!118 = distinct !DISubprogram(name: "msp_watchdog_kick", scope: !105, file: !105, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 19, isOptimized: true, function: void ()* @msp_watchdog_kick, variables: !2)
!119 = !{!120}
!120 = !DIGlobalVariable(name: "watchdog_bits", scope: !104, file: !105, line: 5, type: !110, isLocal: true, isDefinition: true, variable: i8* @watchdog_bits)
!121 = distinct !DICompileUnit(language: DW_LANG_C99, file: !122, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 52ed5ec631b0bbf5c714baa0cd83c33ebfe0c6aa) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2)
!122 = !DIFile(filename: "../../src/mspware/pmm.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!123 = distinct !DICompileUnit(language: DW_LANG_C99, file: !124, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, retainedTypes: !125, subprograms: !127)
!124 = !DIFile(filename: "../../src/mem.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!125 = !{!126}
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 16, align: 16)
!127 = !{!128, !141}
!128 = distinct !DISubprogram(name: "memcpy", scope: !124, file: !124, line: 3, type: !129, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: true, function: i8* (i8*, i8*, i16)* @memcpy, variables: !136)
!129 = !DISubroutineType(types: !130)
!130 = !{!131, !131, !132, !134}
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 16, align: 16)
!132 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !133, size: 16, align: 16)
!133 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !135, line: 212, baseType: !5)
!135 = !DIFile(filename: "/opt/ti/mspgcc/lib/gcc/msp430-elf/4.9.1/include/stddef.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!136 = !{!137, !138, !139, !140}
!137 = !DILocalVariable(name: "dest", arg: 1, scope: !128, file: !124, line: 3, type: !131)
!138 = !DILocalVariable(name: "src", arg: 2, scope: !128, file: !124, line: 3, type: !132)
!139 = !DILocalVariable(name: "n", arg: 3, scope: !128, file: !124, line: 3, type: !134)
!140 = !DILocalVariable(name: "i", scope: !128, file: !124, line: 5, type: !134)
!141 = distinct !DISubprogram(name: "my_memset", scope: !124, file: !124, line: 24, type: !142, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: true, function: void (i8*, i16, i16)* @my_memset, variables: !145)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !131, !144, !134}
!144 = !DIBasicType(name: "int", size: 16, align: 16, encoding: DW_ATE_signed)
!145 = !{!146, !147, !148}
!146 = !DILocalVariable(name: "s", arg: 1, scope: !141, file: !124, line: 24, type: !131)
!147 = !DILocalVariable(name: "c", arg: 2, scope: !141, file: !124, line: 24, type: !144)
!148 = !DILocalVariable(name: "n", arg: 3, scope: !141, file: !124, line: 24, type: !134)
!149 = distinct !DICompileUnit(language: DW_LANG_C99, file: !150, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !151)
!150 = !DIFile(filename: "../../src/clock.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libmsp/bld/clang")
!151 = !{!152}
!152 = distinct !DISubprogram(name: "msp_clock_setup", scope: !150, file: !150, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: true, function: void ()* @msp_clock_setup, variables: !2)
!153 = distinct !DICompileUnit(language: DW_LANG_C99, file: !154, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2)
!154 = !DIFile(filename: "../../src/empty.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/libio/bld/clang")
!155 = distinct !DICompileUnit(language: DW_LANG_C99, file: !156, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !157, globals: !193)
!156 = !DIFile(filename: "../../src/alpaca.c", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang")
!157 = !{!158, !159, !182, !190}
!158 = distinct !DISubprogram(name: "task_prologue", scope: !156, file: !156, line: 54, type: !8, isLocal: false, isDefinition: true, scopeLine: 55, isOptimized: false, function: void ()* @task_prologue, variables: !2)
!159 = distinct !DISubprogram(name: "transition_to", scope: !156, file: !156, line: 106, type: !160, isLocal: false, isDefinition: true, scopeLine: 107, flags: DIFlagPrototyped, isOptimized: false, function: void (%struct.task_t*)* @transition_to, variables: !2)
!160 = !DISubroutineType(types: !161)
!161 = !{null, !162}
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 16, align: 16)
!163 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_t", file: !164, line: 81, baseType: !165)
!164 = !DIFile(filename: "../../src/include/libalpaca/alpaca.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang")
!165 = !DICompositeType(tag: DW_TAG_structure_type, file: !164, line: 66, size: 336, align: 16, elements: !166)
!166 = !{!167, !170, !176, !178, !181}
!167 = !DIDerivedType(tag: DW_TAG_member, name: "func", scope: !165, file: !164, line: 67, baseType: !168, size: 16, align: 16)
!168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !169, size: 16, align: 16)
!169 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_func_t", file: !164, line: 23, baseType: !8)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !165, file: !164, line: 68, baseType: !171, size: 32, align: 16, offset: 16)
!171 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_mask_t", file: !164, line: 25, baseType: !172)
!172 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !173, line: 66, baseType: !174)
!173 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang")
!174 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !175, line: 56, baseType: !52)
!175 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang")
!176 = !DIDerivedType(tag: DW_TAG_member, name: "idx", scope: !165, file: !164, line: 69, baseType: !177, size: 16, align: 16, offset: 48)
!177 = !DIDerivedType(tag: DW_TAG_typedef, name: "task_idx_t", file: !164, line: 27, baseType: !5)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "last_execute_time", scope: !165, file: !164, line: 78, baseType: !179, size: 16, align: 16, offset: 64)
!179 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !180)
!180 = !DIDerivedType(tag: DW_TAG_typedef, name: "chain_time_t", file: !164, line: 24, baseType: !5)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !165, file: !164, line: 80, baseType: !59, size: 256, align: 8, offset: 80)
!182 = distinct !DISubprogram(name: "write_to_gbuf", scope: !156, file: !156, line: 173, type: !183, isLocal: false, isDefinition: true, scopeLine: 175, flags: DIFlagPrototyped, isOptimized: false, function: void (i8*, i8*, i16)* @write_to_gbuf, variables: !2)
!183 = !DISubroutineType(types: !184)
!184 = !{null, !185, !185, !188}
!185 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !186, size: 16, align: 16)
!186 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !173, line: 42, baseType: !187)
!187 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !175, line: 28, baseType: !114)
!188 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !189, line: 212, baseType: !5)
!189 = !DIFile(filename: "/opt/ti/mspgcc/lib/gcc/msp430-elf/4.9.1/include/stddef.h", directory: "/home/reviewer/src/apps/app-temp-log-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang")
!190 = distinct !DISubprogram(name: "main", scope: !156, file: !156, line: 193, type: !191, isLocal: false, isDefinition: true, scopeLine: 193, isOptimized: false, function: i16 ()* @main, variables: !2)
!191 = !DISubroutineType(types: !192)
!192 = !{!144}
!193 = !{!194, !196, !197, !199, !200, !201, !202, !203, !204, !205, !206, !214, !215, !216, !217, !220}
!194 = !DIGlobalVariable(name: "data_src_base", scope: !155, file: !156, line: 14, type: !195, isLocal: false, isDefinition: true, variable: i8*** @data_src_base)
!195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !185, size: 16, align: 16)
!196 = !DIGlobalVariable(name: "data_dest_base", scope: !155, file: !156, line: 15, type: !195, isLocal: false, isDefinition: true, variable: i8*** @data_dest_base)
!197 = !DIGlobalVariable(name: "data_size_base", scope: !155, file: !156, line: 16, type: !198, isLocal: false, isDefinition: true, variable: i16** @data_size_base)
!198 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 16, align: 16)
!199 = !DIGlobalVariable(name: "gv_index", scope: !155, file: !156, line: 17, type: !37, isLocal: false, isDefinition: true, variable: i16* @gv_index)
!200 = !DIGlobalVariable(name: "num_dirty_gv", scope: !155, file: !156, line: 18, type: !37, isLocal: false, isDefinition: true, variable: i16* @num_dirty_gv)
!201 = !DIGlobalVariable(name: "rcount", scope: !155, file: !156, line: 20, type: !5, isLocal: false, isDefinition: true, variable: i16* @rcount)
!202 = !DIGlobalVariable(name: "wcount", scope: !155, file: !156, line: 21, type: !5, isLocal: false, isDefinition: true, variable: i16* @wcount)
!203 = !DIGlobalVariable(name: "tcount", scope: !155, file: !156, line: 22, type: !5, isLocal: false, isDefinition: true, variable: i16* @tcount)
!204 = !DIGlobalVariable(name: "max_num_dirty_gv", scope: !155, file: !156, line: 23, type: !5, isLocal: false, isDefinition: true, variable: i16* @max_num_dirty_gv)
!205 = !DIGlobalVariable(name: "curtime", scope: !155, file: !156, line: 30, type: !179, isLocal: false, isDefinition: true, variable: i16* @curtime)
!206 = !DIGlobalVariable(name: "context_3", scope: !155, file: !156, line: 33, type: !207, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_3)
!207 = !DIDerivedType(tag: DW_TAG_typedef, name: "context_t", file: !164, line: 175, baseType: !208)
!208 = !DICompositeType(tag: DW_TAG_structure_type, name: "_context_t", file: !164, line: 166, size: 48, align: 16, elements: !209)
!209 = !{!210, !211, !212}
!210 = !DIDerivedType(tag: DW_TAG_member, name: "task", scope: !208, file: !164, line: 168, baseType: !162, size: 16, align: 16)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "time", scope: !208, file: !164, line: 171, baseType: !180, size: 16, align: 16, offset: 16)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "prev_ctx", scope: !208, file: !164, line: 174, baseType: !213, size: 16, align: 16, offset: 32)
!213 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !208, size: 16, align: 16)
!214 = !DIGlobalVariable(name: "context_2", scope: !155, file: !156, line: 34, type: !207, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_2)
!215 = !DIGlobalVariable(name: "context_1", scope: !155, file: !156, line: 39, type: !207, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_1)
!216 = !DIGlobalVariable(name: "context_0", scope: !155, file: !156, line: 40, type: !207, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_0)
!217 = !DIGlobalVariable(name: "curctx", scope: !155, file: !156, line: 46, type: !218, isLocal: false, isDefinition: true, variable: %struct._context_t** @curctx)
!218 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !219)
!219 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 16, align: 16)
!220 = !DIGlobalVariable(name: "_numBoots", scope: !155, file: !156, line: 50, type: !37, isLocal: false, isDefinition: true, variable: i16* @_numBoots)
!221 = !{!"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"}
!222 = !{!"clang version 3.8.0 (http://llvm.org/git/clang.git 52ed5ec631b0bbf5c714baa0cd83c33ebfe0c6aa) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"}
!223 = !{i32 2, !"Dwarf Version", i32 4}
!224 = !{i32 2, !"Debug Info Version", i32 3}
!225 = !DILocation(line: 44, column: 9, scope: !7)
!226 = !DILocation(line: 45, column: 6, scope: !227)
!227 = distinct !DILexicalBlock(scope: !7, file: !1, line: 45, column: 6)
!228 = !DILocation(line: 45, column: 6, scope: !7)
!229 = !DILocation(line: 46, column: 12, scope: !230)
!230 = distinct !DILexicalBlock(scope: !227, file: !1, line: 45, column: 22)
!231 = !DILocation(line: 47, column: 10, scope: !230)
!232 = !DILocation(line: 48, column: 10, scope: !230)
!233 = !DILocation(line: 49, column: 10, scope: !230)
!234 = !DILocation(line: 50, column: 3, scope: !230)
!235 = !DILocation(line: 51, column: 2, scope: !7)
!236 = !DILocation(line: 133, column: 2, scope: !10)
!237 = !DILocation(line: 140, column: 2, scope: !10)
!238 = !DILocation(line: 141, column: 2, scope: !10)
!239 = !{i32 -2146723283}
!240 = !DILocation(line: 144, column: 2, scope: !10)
!241 = !DILocation(line: 145, column: 1, scope: !10)
!242 = !DILocation(line: 156, column: 15, scope: !11)
!243 = !DILocation(line: 157, column: 15, scope: !11)
!244 = !DILocation(line: 159, column: 18, scope: !11)
!245 = !DILocation(line: 163, column: 14, scope: !11)
!246 = !DILocation(line: 165, column: 13, scope: !11)
!247 = !DILocation(line: 167, column: 18, scope: !11)
!248 = !DILocation(line: 169, column: 17, scope: !11)
!249 = !DILocation(line: 171, column: 19, scope: !11)
!250 = !DILocation(line: 173, column: 2, scope: !11)
!251 = !DILocation(line: 174, column: 1, scope: !11)
!252 = !DILocalVariable(name: "node", scope: !12, file: !1, line: 180, type: !83)
!253 = !DIExpression()
!254 = !DILocation(line: 180, column: 9, scope: !12)
!255 = !DILocation(line: 180, column: 16, scope: !12)
!256 = !DILocation(line: 181, column: 13, scope: !12)
!257 = !DILocalVariable(name: "i", scope: !12, file: !1, line: 185, type: !144)
!258 = !DILocation(line: 185, column: 6, scope: !12)
!259 = !DILocation(line: 185, column: 10, scope: !12)
!260 = !DILocation(line: 186, column: 2, scope: !12)
!261 = !DILocation(line: 186, column: 16, scope: !12)
!262 = !DILocation(line: 188, column: 12, scope: !12)
!263 = !DILocation(line: 189, column: 6, scope: !264)
!264 = distinct !DILexicalBlock(scope: !12, file: !1, line: 189, column: 6)
!265 = !DILocation(line: 189, column: 17, scope: !264)
!266 = !DILocation(line: 189, column: 6, scope: !12)
!267 = !DILocation(line: 190, column: 3, scope: !268)
!268 = distinct !DILexicalBlock(scope: !264, file: !1, line: 189, column: 32)
!269 = !DILocation(line: 191, column: 2, scope: !268)
!270 = !DILocation(line: 192, column: 18, scope: !271)
!271 = distinct !DILexicalBlock(scope: !264, file: !1, line: 191, column: 9)
!272 = !DILocation(line: 193, column: 3, scope: !271)
!273 = !DILocation(line: 196, column: 1, scope: !12)
!274 = !DILocalVariable(name: "next_letter_idx", scope: !13, file: !1, line: 204, type: !5)
!275 = !DILocation(line: 204, column: 11, scope: !13)
!276 = !DILocation(line: 204, column: 29, scope: !13)
!277 = !DILocation(line: 204, column: 44, scope: !13)
!278 = !DILocation(line: 205, column: 6, scope: !279)
!279 = distinct !DILexicalBlock(scope: !13, file: !1, line: 205, column: 6)
!280 = !DILocation(line: 205, column: 22, scope: !279)
!281 = !DILocation(line: 205, column: 6, scope: !13)
!282 = !DILocation(line: 206, column: 19, scope: !279)
!283 = !DILocation(line: 206, column: 3, scope: !279)
!284 = !DILocation(line: 209, column: 6, scope: !285)
!285 = distinct !DILexicalBlock(scope: !13, file: !1, line: 209, column: 6)
!286 = !DILocation(line: 209, column: 21, scope: !285)
!287 = !DILocation(line: 209, column: 6, scope: !13)
!288 = !DILocation(line: 210, column: 20, scope: !289)
!289 = distinct !DILexicalBlock(scope: !285, file: !1, line: 209, column: 27)
!290 = !DILocation(line: 210, column: 18, scope: !289)
!291 = !DILocation(line: 211, column: 3, scope: !289)
!292 = !DILocation(line: 212, column: 2, scope: !289)
!293 = !DILocation(line: 213, column: 20, scope: !294)
!294 = distinct !DILexicalBlock(scope: !285, file: !1, line: 212, column: 9)
!295 = !DILocation(line: 213, column: 18, scope: !294)
!296 = !DILocation(line: 214, column: 3, scope: !294)
!297 = !DILocation(line: 216, column: 1, scope: !13)
!298 = !DILocalVariable(name: "prev_sample", scope: !14, file: !1, line: 224, type: !29)
!299 = !DILocation(line: 224, column: 11, scope: !14)
!300 = !DILocation(line: 227, column: 16, scope: !14)
!301 = !DILocation(line: 227, column: 14, scope: !14)
!302 = !DILocalVariable(name: "sample", scope: !14, file: !1, line: 232, type: !29)
!303 = !DILocation(line: 232, column: 11, scope: !14)
!304 = !DILocation(line: 232, column: 35, scope: !14)
!305 = !DILocation(line: 232, column: 20, scope: !14)
!306 = !DILocation(line: 236, column: 16, scope: !14)
!307 = !DILocation(line: 236, column: 14, scope: !14)
!308 = !DILocation(line: 237, column: 20, scope: !14)
!309 = !DILocation(line: 237, column: 18, scope: !14)
!310 = !DILocation(line: 239, column: 15, scope: !14)
!311 = !DILocation(line: 239, column: 13, scope: !14)
!312 = !DILocation(line: 240, column: 2, scope: !14)
!313 = !DILocation(line: 241, column: 1, scope: !14)
!314 = !DILocalVariable(name: "letter_idx", scope: !15, file: !1, line: 245, type: !5)
!315 = !DILocation(line: 245, column: 11, scope: !15)
!316 = !DILocation(line: 245, column: 24, scope: !15)
!317 = !DILocation(line: 246, column: 6, scope: !318)
!318 = distinct !DILexicalBlock(scope: !15, file: !1, line: 246, column: 6)
!319 = !DILocation(line: 246, column: 17, scope: !318)
!320 = !DILocation(line: 246, column: 6, scope: !15)
!321 = !DILocation(line: 247, column: 14, scope: !318)
!322 = !DILocation(line: 247, column: 3, scope: !318)
!323 = !DILocation(line: 249, column: 13, scope: !318)
!324 = !DILocalVariable(name: "letter_shift", scope: !15, file: !1, line: 250, type: !5)
!325 = !DILocation(line: 250, column: 11, scope: !15)
!326 = !DILocation(line: 250, column: 45, scope: !15)
!327 = !DILocation(line: 250, column: 43, scope: !15)
!328 = !DILocalVariable(name: "letter", scope: !15, file: !1, line: 251, type: !30)
!329 = !DILocation(line: 251, column: 11, scope: !15)
!330 = !DILocation(line: 251, column: 21, scope: !15)
!331 = !DILocation(line: 251, column: 50, scope: !15)
!332 = !DILocation(line: 251, column: 47, scope: !15)
!333 = !DILocation(line: 251, column: 32, scope: !15)
!334 = !DILocation(line: 251, column: 68, scope: !15)
!335 = !DILocation(line: 251, column: 65, scope: !15)
!336 = !DILocation(line: 255, column: 15, scope: !15)
!337 = !DILocation(line: 255, column: 13, scope: !15)
!338 = !DILocation(line: 256, column: 2, scope: !15)
!339 = !DILocation(line: 257, column: 1, scope: !15)
!340 = !DILocalVariable(name: "parent_node", scope: !16, file: !1, line: 265, type: !83)
!341 = !DILocation(line: 265, column: 9, scope: !16)
!342 = !DILocalVariable(name: "parent", scope: !16, file: !1, line: 268, type: !4)
!343 = !DILocation(line: 268, column: 10, scope: !16)
!344 = !DILocation(line: 268, column: 19, scope: !16)
!345 = !DILocation(line: 272, column: 16, scope: !16)
!346 = !DILocation(line: 276, column: 28, scope: !16)
!347 = !DILocation(line: 276, column: 14, scope: !16)
!348 = !DILocation(line: 286, column: 20, scope: !16)
!349 = !DILocation(line: 287, column: 15, scope: !16)
!350 = !DILocation(line: 287, column: 13, scope: !16)
!351 = !DILocation(line: 288, column: 26, scope: !16)
!352 = !DILocation(line: 288, column: 12, scope: !16)
!353 = !DILocation(line: 290, column: 18, scope: !16)
!354 = !DILocation(line: 292, column: 2, scope: !16)
!355 = !DILocation(line: 293, column: 1, scope: !16)
!356 = !DILocalVariable(name: "sibling_node", scope: !17, file: !1, line: 301, type: !357)
!357 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 16, align: 16)
!358 = !DILocation(line: 301, column: 10, scope: !17)
!359 = !DILocation(line: 305, column: 6, scope: !360)
!360 = distinct !DILexicalBlock(scope: !17, file: !1, line: 305, column: 6)
!361 = !DILocation(line: 305, column: 18, scope: !360)
!362 = !DILocation(line: 305, column: 6, scope: !17)
!363 = !DILocalVariable(name: "i", scope: !364, file: !1, line: 307, type: !144)
!364 = distinct !DILexicalBlock(scope: !360, file: !1, line: 305, column: 26)
!365 = !DILocation(line: 307, column: 7, scope: !364)
!366 = !DILocation(line: 307, column: 11, scope: !364)
!367 = !DILocation(line: 308, column: 19, scope: !364)
!368 = !DILocation(line: 308, column: 16, scope: !364)
!369 = !DILocation(line: 313, column: 7, scope: !370)
!370 = distinct !DILexicalBlock(scope: !364, file: !1, line: 313, column: 7)
!371 = !DILocation(line: 313, column: 21, scope: !370)
!372 = !DILocation(line: 313, column: 31, scope: !370)
!373 = !DILocation(line: 313, column: 28, scope: !370)
!374 = !DILocation(line: 313, column: 7, scope: !364)
!375 = !DILocation(line: 315, column: 22, scope: !376)
!376 = distinct !DILexicalBlock(scope: !370, file: !1, line: 313, column: 43)
!377 = !DILocation(line: 315, column: 20, scope: !376)
!378 = !DILocation(line: 317, column: 4, scope: !376)
!379 = !DILocation(line: 318, column: 3, scope: !376)
!380 = !DILocation(line: 319, column: 7, scope: !381)
!381 = distinct !DILexicalBlock(scope: !382, file: !1, line: 319, column: 7)
!382 = distinct !DILexicalBlock(scope: !370, file: !1, line: 318, column: 10)
!383 = !DILocation(line: 319, column: 21, scope: !381)
!384 = !DILocation(line: 319, column: 29, scope: !381)
!385 = !DILocation(line: 319, column: 7, scope: !382)
!386 = !DILocation(line: 320, column: 19, scope: !387)
!387 = distinct !DILexicalBlock(scope: !381, file: !1, line: 319, column: 34)
!388 = !DILocation(line: 320, column: 33, scope: !387)
!389 = !DILocation(line: 320, column: 17, scope: !387)
!390 = !DILocation(line: 321, column: 5, scope: !387)
!391 = !DILocation(line: 322, column: 4, scope: !387)
!392 = !DILocation(line: 325, column: 2, scope: !364)
!393 = !DILocalVariable(name: "starting_node_idx", scope: !17, file: !1, line: 332, type: !4)
!394 = !DILocation(line: 332, column: 10, scope: !17)
!395 = !DILocation(line: 332, column: 39, scope: !17)
!396 = !DILocation(line: 333, column: 20, scope: !17)
!397 = !DILocation(line: 333, column: 18, scope: !17)
!398 = !DILocation(line: 339, column: 6, scope: !399)
!399 = distinct !DILexicalBlock(scope: !17, file: !1, line: 339, column: 6)
!400 = !DILocation(line: 339, column: 16, scope: !399)
!401 = !DILocation(line: 339, column: 6, scope: !17)
!402 = !DILocation(line: 340, column: 3, scope: !403)
!403 = distinct !DILexicalBlock(scope: !399, file: !1, line: 339, column: 24)
!404 = !DILocation(line: 341, column: 2, scope: !403)
!405 = !DILocation(line: 342, column: 3, scope: !406)
!406 = distinct !DILexicalBlock(scope: !399, file: !1, line: 341, column: 9)
!407 = !DILocation(line: 345, column: 1, scope: !17)
!408 = !DILocalVariable(name: "sibling_node", scope: !18, file: !1, line: 353, type: !357)
!409 = !DILocation(line: 353, column: 10, scope: !18)
!410 = !DILocalVariable(name: "i", scope: !18, file: !1, line: 362, type: !144)
!411 = !DILocation(line: 362, column: 6, scope: !18)
!412 = !DILocation(line: 362, column: 10, scope: !18)
!413 = !DILocation(line: 363, column: 18, scope: !18)
!414 = !DILocation(line: 363, column: 15, scope: !18)
!415 = !DILocation(line: 368, column: 6, scope: !416)
!416 = distinct !DILexicalBlock(scope: !18, file: !1, line: 368, column: 6)
!417 = !DILocation(line: 368, column: 20, scope: !416)
!418 = !DILocation(line: 368, column: 28, scope: !416)
!419 = !DILocation(line: 368, column: 6, scope: !18)
!420 = !DILocalVariable(name: "next_sibling", scope: !421, file: !1, line: 369, type: !4)
!421 = distinct !DILexicalBlock(scope: !416, file: !1, line: 368, column: 36)
!422 = !DILocation(line: 369, column: 11, scope: !421)
!423 = !DILocation(line: 369, column: 26, scope: !421)
!424 = !DILocation(line: 369, column: 40, scope: !421)
!425 = !DILocation(line: 370, column: 17, scope: !421)
!426 = !DILocation(line: 370, column: 15, scope: !421)
!427 = !DILocation(line: 371, column: 3, scope: !421)
!428 = !DILocation(line: 373, column: 2, scope: !421)
!429 = !DILocalVariable(name: "sibling_node_obj", scope: !430, file: !1, line: 377, type: !83)
!430 = distinct !DILexicalBlock(scope: !416, file: !1, line: 373, column: 9)
!431 = !DILocation(line: 377, column: 10, scope: !430)
!432 = !DILocation(line: 377, column: 30, scope: !430)
!433 = !DILocation(line: 377, column: 29, scope: !430)
!434 = !DILocation(line: 380, column: 22, scope: !430)
!435 = !DILocation(line: 382, column: 3, scope: !430)
!436 = !DILocation(line: 384, column: 1, scope: !18)
!437 = !DILocation(line: 392, column: 6, scope: !438)
!438 = distinct !DILexicalBlock(scope: !19, file: !1, line: 392, column: 6)
!439 = !DILocation(line: 392, column: 21, scope: !438)
!440 = !DILocation(line: 392, column: 6, scope: !19)
!441 = !DILocation(line: 393, column: 3, scope: !442)
!442 = distinct !DILexicalBlock(scope: !438, file: !1, line: 392, column: 35)
!443 = !DILocation(line: 393, column: 3, scope: !444)
!444 = !DILexicalBlockFile(scope: !445, file: !1, discriminator: 2)
!445 = !DILexicalBlockFile(scope: !442, file: !1, discriminator: 1)
!446 = !DILocalVariable(name: "child", scope: !19, file: !1, line: 398, type: !4)
!447 = !DILocation(line: 398, column: 10, scope: !19)
!448 = !DILocation(line: 398, column: 18, scope: !19)
!449 = !DILocalVariable(name: "child_node", scope: !19, file: !1, line: 399, type: !83)
!450 = !DILocation(line: 399, column: 9, scope: !19)
!451 = !DILocation(line: 399, column: 22, scope: !19)
!452 = !DILocation(line: 400, column: 13, scope: !19)
!453 = !DILocation(line: 405, column: 22, scope: !454)
!454 = distinct !DILexicalBlock(scope: !19, file: !1, line: 405, column: 6)
!455 = !DILocation(line: 405, column: 28, scope: !454)
!456 = !DILocation(line: 405, column: 6, scope: !19)
!457 = !DILocalVariable(name: "parent_node_obj", scope: !458, file: !1, line: 409, type: !83)
!458 = distinct !DILexicalBlock(scope: !454, file: !1, line: 405, column: 36)
!459 = !DILocation(line: 409, column: 10, scope: !458)
!460 = !DILocation(line: 409, column: 28, scope: !458)
!461 = !DILocation(line: 410, column: 27, scope: !458)
!462 = !DILocation(line: 410, column: 19, scope: !458)
!463 = !DILocation(line: 410, column: 25, scope: !458)
!464 = !DILocalVariable(name: "i", scope: !458, file: !1, line: 412, type: !144)
!465 = !DILocation(line: 412, column: 7, scope: !458)
!466 = !DILocation(line: 412, column: 11, scope: !458)
!467 = !DILocation(line: 413, column: 3, scope: !458)
!468 = !DILocation(line: 413, column: 17, scope: !458)
!469 = !DILocation(line: 415, column: 2, scope: !458)
!470 = !DILocalVariable(name: "last_sibling", scope: !471, file: !1, line: 417, type: !4)
!471 = distinct !DILexicalBlock(scope: !454, file: !1, line: 415, column: 9)
!472 = !DILocation(line: 417, column: 11, scope: !471)
!473 = !DILocation(line: 417, column: 26, scope: !471)
!474 = !DILocalVariable(name: "last_sibling_node", scope: !471, file: !1, line: 419, type: !83)
!475 = !DILocation(line: 419, column: 10, scope: !471)
!476 = !DILocation(line: 419, column: 30, scope: !471)
!477 = !DILocation(line: 423, column: 31, scope: !471)
!478 = !DILocation(line: 423, column: 21, scope: !471)
!479 = !DILocation(line: 423, column: 29, scope: !471)
!480 = !DILocation(line: 425, column: 3, scope: !471)
!481 = !DILocation(line: 425, column: 28, scope: !471)
!482 = !DILocation(line: 427, column: 2, scope: !19)
!483 = !DILocation(line: 427, column: 20, scope: !19)
!484 = !DILocation(line: 429, column: 15, scope: !19)
!485 = !DILocation(line: 429, column: 13, scope: !19)
!486 = !DILocation(line: 431, column: 16, scope: !19)
!487 = !DILocation(line: 433, column: 2, scope: !19)
!488 = !DILocation(line: 434, column: 1, scope: !19)
!489 = !DILocalVariable(name: "i", scope: !20, file: !1, line: 441, type: !144)
!490 = !DILocation(line: 441, column: 6, scope: !20)
!491 = !DILocation(line: 441, column: 10, scope: !20)
!492 = !DILocation(line: 442, column: 34, scope: !20)
!493 = !DILocation(line: 442, column: 2, scope: !20)
!494 = !DILocation(line: 442, column: 25, scope: !20)
!495 = !DILocation(line: 442, column: 32, scope: !20)
!496 = !DILocation(line: 444, column: 6, scope: !497)
!497 = distinct !DILexicalBlock(scope: !20, file: !1, line: 444, column: 6)
!498 = !DILocation(line: 444, column: 20, scope: !497)
!499 = !DILocation(line: 444, column: 6, scope: !20)
!500 = !DILocation(line: 445, column: 3, scope: !501)
!501 = distinct !DILexicalBlock(scope: !497, file: !1, line: 444, column: 35)
!502 = !DILocation(line: 446, column: 2, scope: !501)
!503 = !DILocation(line: 447, column: 3, scope: !504)
!504 = distinct !DILexicalBlock(scope: !497, file: !1, line: 446, column: 9)
!505 = !DILocation(line: 449, column: 1, scope: !20)
!506 = !DILocalVariable(name: "i", scope: !21, file: !1, line: 453, type: !5)
!507 = !DILocation(line: 453, column: 11, scope: !21)
!508 = !DILocation(line: 455, column: 2, scope: !21)
!509 = !DILocation(line: 457, column: 2, scope: !21)
!510 = !DILocation(line: 458, column: 9, scope: !511)
!511 = distinct !DILexicalBlock(scope: !21, file: !1, line: 458, column: 2)
!512 = !DILocation(line: 458, column: 7, scope: !511)
!513 = !DILocation(line: 458, column: 14, scope: !514)
!514 = !DILexicalBlockFile(scope: !515, file: !1, discriminator: 2)
!515 = !DILexicalBlockFile(scope: !516, file: !1, discriminator: 1)
!516 = distinct !DILexicalBlock(scope: !511, file: !1, line: 458, column: 2)
!517 = !DILocation(line: 458, column: 16, scope: !516)
!518 = !DILocation(line: 458, column: 2, scope: !511)
!519 = !DILocalVariable(name: "index", scope: !520, file: !1, line: 459, type: !4)
!520 = distinct !DILexicalBlock(scope: !516, file: !1, line: 458, column: 35)
!521 = !DILocation(line: 459, column: 11, scope: !520)
!522 = !DILocation(line: 459, column: 19, scope: !520)
!523 = !DILocation(line: 459, column: 42, scope: !520)
!524 = !DILocation(line: 460, column: 3, scope: !520)
!525 = !DILocation(line: 461, column: 7, scope: !526)
!526 = distinct !DILexicalBlock(scope: !520, file: !1, line: 461, column: 7)
!527 = !DILocation(line: 461, column: 9, scope: !526)
!528 = !DILocation(line: 461, column: 13, scope: !526)
!529 = !DILocation(line: 461, column: 17, scope: !530)
!530 = !DILexicalBlockFile(scope: !526, file: !1, discriminator: 1)
!531 = !DILocation(line: 461, column: 19, scope: !526)
!532 = !DILocation(line: 461, column: 24, scope: !526)
!533 = !DILocation(line: 461, column: 28, scope: !526)
!534 = !DILocation(line: 461, column: 7, scope: !520)
!535 = !DILocation(line: 462, column: 4, scope: !526)
!536 = !DILocation(line: 463, column: 2, scope: !520)
!537 = !DILocation(line: 458, column: 30, scope: !516)
!538 = !DILocation(line: 458, column: 2, scope: !516)
!539 = !DILocation(line: 464, column: 2, scope: !21)
!540 = !DILocation(line: 465, column: 2, scope: !21)
!541 = !DILocation(line: 468, column: 2, scope: !21)
!542 = !DILocation(line: 469, column: 1, scope: !21)
!543 = !DILocation(line: 473, column: 15, scope: !22)
!544 = !DILocation(line: 474, column: 15, scope: !22)
!545 = !DILocalVariable(name: "i", scope: !546, file: !1, line: 475, type: !5)
!546 = distinct !DILexicalBlock(scope: !22, file: !1, line: 475, column: 2)
!547 = !DILocation(line: 475, column: 15, scope: !546)
!548 = !DILocation(line: 475, column: 6, scope: !546)
!549 = !DILocation(line: 475, column: 19, scope: !550)
!550 = !DILexicalBlockFile(scope: !551, file: !1, discriminator: 2)
!551 = !DILexicalBlockFile(scope: !552, file: !1, discriminator: 1)
!552 = distinct !DILexicalBlock(scope: !546, file: !1, line: 475, column: 2)
!553 = !DILocation(line: 475, column: 20, scope: !552)
!554 = !DILocation(line: 475, column: 2, scope: !546)
!555 = !DILocation(line: 476, column: 2, scope: !556)
!556 = distinct !DILexicalBlock(scope: !552, file: !1, line: 475, column: 31)
!557 = !DILocation(line: 475, column: 27, scope: !552)
!558 = !DILocation(line: 475, column: 2, scope: !552)
!559 = !DILocation(line: 482, column: 2, scope: !22)
!560 = !DILocation(line: 483, column: 1, scope: !22)
!561 = !DILocation(line: 485, column: 2, scope: !23)
!562 = !DILocation(line: 486, column: 1, scope: !24)
!563 = !DILocation(line: 103, column: 2, scope: !25)
!564 = !DILocation(line: 104, column: 2, scope: !25)
!565 = !DILocation(line: 108, column: 15, scope: !25)
!566 = !DILocation(line: 109, column: 15, scope: !25)
!567 = !DILocation(line: 110, column: 15, scope: !25)
!568 = !DILocation(line: 111, column: 15, scope: !25)
!569 = !DILocation(line: 112, column: 2, scope: !25)
!570 = !DILocation(line: 113, column: 1, scope: !25)
!571 = !DILocalVariable(name: "prev_sample", arg: 1, scope: !26, file: !1, line: 147, type: !30)
!572 = !DILocation(line: 147, column: 41, scope: !26)
!573 = !DILocalVariable(name: "sample", scope: !26, file: !1, line: 150, type: !30)
!574 = !DILocation(line: 150, column: 11, scope: !26)
!575 = !DILocation(line: 150, column: 21, scope: !26)
!576 = !DILocation(line: 150, column: 33, scope: !26)
!577 = !DILocation(line: 150, column: 38, scope: !26)
!578 = !DILocation(line: 151, column: 9, scope: !26)
!579 = !DILocation(line: 151, column: 2, scope: !26)
!580 = !DILocation(line: 7, column: 34, scope: !107)
!581 = !DILocation(line: 9, column: 33, scope: !107)
!582 = !DILocation(line: 9, column: 31, scope: !107)
!583 = !DILocation(line: 9, column: 12, scope: !107)
!584 = !{!585, !585, i64 0}
!585 = !{!"int", !586, i64 0}
!586 = !{!"omnipotent char", !587, i64 0}
!587 = !{!"Simple C/C++ TBAA"}
!588 = !DILocation(line: 10, column: 19, scope: !107)
!589 = !{!586, !586, i64 0}
!590 = !DILocation(line: 11, column: 1, scope: !107)
!591 = !DILocation(line: 15, column: 13, scope: !117)
!592 = !DILocation(line: 16, column: 1, scope: !117)
!593 = !DILocation(line: 20, column: 33, scope: !118)
!594 = !DILocation(line: 20, column: 31, scope: !118)
!595 = !DILocation(line: 20, column: 12, scope: !118)
!596 = !DILocation(line: 21, column: 1, scope: !118)
!597 = !DILocation(line: 3, column: 20, scope: !128)
!598 = !DILocation(line: 3, column: 38, scope: !128)
!599 = !DILocation(line: 3, column: 50, scope: !128)
!600 = !DILocation(line: 5, column: 12, scope: !128)
!601 = !DILocation(line: 6, column: 14, scope: !128)
!602 = !DILocation(line: 6, column: 5, scope: !128)
!603 = !DILocation(line: 7, column: 45, scope: !604)
!604 = distinct !DILexicalBlock(scope: !128, file: !124, line: 6, column: 19)
!605 = !DILocation(line: 7, column: 31, scope: !604)
!606 = !DILocation(line: 7, column: 24, scope: !604)
!607 = !DILocation(line: 7, column: 29, scope: !604)
!608 = !DILocation(line: 8, column: 9, scope: !604)
!609 = !DILocation(line: 10, column: 5, scope: !128)
!610 = !DILocation(line: 24, column: 22, scope: !141)
!611 = !DILocation(line: 24, column: 29, scope: !141)
!612 = !DILocation(line: 24, column: 39, scope: !141)
!613 = !DILocation(line: 26, column: 9, scope: !141)
!614 = !{i32 505, i32 526, i32 546, i32 566, i32 581, i32 606, i32 621}
!615 = !DILocation(line: 35, column: 1, scope: !141)
!616 = !DILocation(line: 144, column: 14, scope: !152)
!617 = !DILocation(line: 146, column: 12, scope: !152)
!618 = !DILocation(line: 148, column: 12, scope: !152)
!619 = !DILocation(line: 149, column: 12, scope: !152)
!620 = !DILocation(line: 154, column: 1, scope: !152)
!621 = !DILocation(line: 56, column: 5, scope: !622)
!622 = distinct !DILexicalBlock(scope: !158, file: !156, line: 56, column: 5)
!623 = !DILocation(line: 56, column: 15, scope: !622)
!624 = !DILocation(line: 56, column: 5, scope: !158)
!625 = !DILocation(line: 57, column: 3, scope: !626)
!626 = distinct !DILexicalBlock(scope: !622, file: !156, line: 56, column: 25)
!627 = !DILocation(line: 58, column: 3, scope: !626)
!628 = !DILocation(line: 59, column: 2, scope: !626)
!629 = !DILocation(line: 60, column: 5, scope: !158)
!630 = !DILocalVariable(name: "curtask", scope: !158, file: !156, line: 68, type: !162)
!631 = !DILocation(line: 68, column: 10, scope: !158)
!632 = !DILocation(line: 68, column: 20, scope: !158)
!633 = !DILocation(line: 68, column: 28, scope: !158)
!634 = !DILocation(line: 68, column: 38, scope: !158)
!635 = !DILocation(line: 73, column: 6, scope: !636)
!636 = distinct !DILexicalBlock(scope: !158, file: !156, line: 73, column: 6)
!637 = !DILocation(line: 73, column: 14, scope: !636)
!638 = !DILocation(line: 73, column: 22, scope: !636)
!639 = !DILocation(line: 73, column: 31, scope: !636)
!640 = !DILocation(line: 73, column: 19, scope: !636)
!641 = !DILocation(line: 73, column: 6, scope: !158)
!642 = !DILocation(line: 74, column: 2, scope: !643)
!643 = distinct !DILexicalBlock(scope: !636, file: !156, line: 73, column: 50)
!644 = !DILocation(line: 74, column: 9, scope: !645)
!645 = !DILexicalBlockFile(scope: !646, file: !156, discriminator: 2)
!646 = !DILexicalBlockFile(scope: !643, file: !156, discriminator: 1)
!647 = !DILocation(line: 74, column: 20, scope: !643)
!648 = !DILocation(line: 74, column: 18, scope: !643)
!649 = !DILocalVariable(name: "w_data_dest", scope: !650, file: !156, line: 76, type: !185)
!650 = distinct !DILexicalBlock(scope: !643, file: !156, line: 74, column: 34)
!651 = !DILocation(line: 76, column: 12, scope: !650)
!652 = !DILocation(line: 76, column: 28, scope: !650)
!653 = !DILocation(line: 76, column: 45, scope: !650)
!654 = !DILocation(line: 76, column: 43, scope: !650)
!655 = !DILocation(line: 76, column: 26, scope: !650)
!656 = !DILocalVariable(name: "w_data_src", scope: !650, file: !156, line: 77, type: !185)
!657 = !DILocation(line: 77, column: 12, scope: !650)
!658 = !DILocation(line: 77, column: 26, scope: !650)
!659 = !DILocation(line: 77, column: 42, scope: !650)
!660 = !DILocation(line: 77, column: 40, scope: !650)
!661 = !DILocation(line: 77, column: 24, scope: !650)
!662 = !DILocalVariable(name: "w_data_size", scope: !650, file: !156, line: 80, type: !5)
!663 = !DILocation(line: 80, column: 12, scope: !650)
!664 = !DILocation(line: 80, column: 28, scope: !650)
!665 = !DILocation(line: 80, column: 45, scope: !650)
!666 = !DILocation(line: 80, column: 43, scope: !650)
!667 = !DILocation(line: 80, column: 26, scope: !650)
!668 = !DILocation(line: 82, column: 10, scope: !650)
!669 = !DILocation(line: 82, column: 23, scope: !650)
!670 = !DILocation(line: 82, column: 35, scope: !650)
!671 = !DILocation(line: 82, column: 3, scope: !650)
!672 = !DILocation(line: 84, column: 14, scope: !650)
!673 = !DILocation(line: 87, column: 15, scope: !643)
!674 = !DILocation(line: 88, column: 11, scope: !643)
!675 = !DILocation(line: 89, column: 38, scope: !643)
!676 = !DILocation(line: 89, column: 46, scope: !643)
!677 = !DILocation(line: 89, column: 9, scope: !643)
!678 = !DILocation(line: 89, column: 18, scope: !643)
!679 = !DILocation(line: 89, column: 36, scope: !643)
!680 = !DILocation(line: 90, column: 6, scope: !643)
!681 = !DILocation(line: 92, column: 14, scope: !682)
!682 = distinct !DILexicalBlock(scope: !636, file: !156, line: 91, column: 7)
!683 = !DILocation(line: 97, column: 1, scope: !158)
!684 = !DILocalVariable(name: "next_task", arg: 1, scope: !159, file: !156, line: 106, type: !162)
!685 = !DILocation(line: 106, column: 28, scope: !159)
!686 = !DILocalVariable(name: "next_ctx", scope: !159, file: !156, line: 144, type: !219)
!687 = !DILocation(line: 144, column: 17, scope: !159)
!688 = !DILocation(line: 146, column: 18, scope: !159)
!689 = !DILocation(line: 146, column: 25, scope: !159)
!690 = !DILocation(line: 146, column: 15, scope: !159)
!691 = !DILocation(line: 148, column: 19, scope: !159)
!692 = !DILocation(line: 148, column: 2, scope: !159)
!693 = !DILocation(line: 148, column: 12, scope: !159)
!694 = !DILocation(line: 148, column: 17, scope: !159)
!695 = !DILocation(line: 149, column: 19, scope: !159)
!696 = !DILocation(line: 149, column: 27, scope: !159)
!697 = !DILocation(line: 149, column: 32, scope: !159)
!698 = !DILocation(line: 149, column: 2, scope: !159)
!699 = !DILocation(line: 149, column: 12, scope: !159)
!700 = !DILocation(line: 149, column: 17, scope: !159)
!701 = !DILocation(line: 150, column: 29, scope: !159)
!702 = !DILocation(line: 150, column: 37, scope: !159)
!703 = !DILocation(line: 150, column: 2, scope: !159)
!704 = !DILocation(line: 150, column: 12, scope: !159)
!705 = !DILocation(line: 150, column: 22, scope: !159)
!706 = !DILocation(line: 150, column: 27, scope: !159)
!707 = !DILocation(line: 151, column: 29, scope: !159)
!708 = !DILocation(line: 151, column: 37, scope: !159)
!709 = !DILocation(line: 151, column: 2, scope: !159)
!710 = !DILocation(line: 151, column: 12, scope: !159)
!711 = !DILocation(line: 151, column: 22, scope: !159)
!712 = !DILocation(line: 151, column: 27, scope: !159)
!713 = !DILocation(line: 153, column: 11, scope: !159)
!714 = !DILocation(line: 153, column: 9, scope: !159)
!715 = !DILocation(line: 155, column: 2, scope: !159)
!716 = !DILocation(line: 161, column: 24, scope: !159)
!717 = !DILocation(line: 161, column: 35, scope: !159)
!718 = !DILocation(line: 157, column: 5, scope: !159)
!719 = !{i32 5023, i32 5052}
!720 = !DILocation(line: 171, column: 1, scope: !159)
!721 = !DILocalVariable(name: "data_src", arg: 1, scope: !182, file: !156, line: 173, type: !185)
!722 = !DILocation(line: 173, column: 29, scope: !182)
!723 = !DILocalVariable(name: "data_dest", arg: 2, scope: !182, file: !156, line: 173, type: !185)
!724 = !DILocation(line: 173, column: 48, scope: !182)
!725 = !DILocalVariable(name: "var_size", arg: 3, scope: !182, file: !156, line: 173, type: !188)
!726 = !DILocation(line: 173, column: 66, scope: !182)
!727 = !DILocation(line: 183, column: 37, scope: !182)
!728 = !DILocation(line: 183, column: 4, scope: !182)
!729 = !DILocation(line: 183, column: 21, scope: !182)
!730 = !DILocation(line: 183, column: 19, scope: !182)
!731 = !DILocation(line: 183, column: 35, scope: !182)
!732 = !DILocation(line: 184, column: 37, scope: !182)
!733 = !DILocation(line: 184, column: 4, scope: !182)
!734 = !DILocation(line: 184, column: 21, scope: !182)
!735 = !DILocation(line: 184, column: 19, scope: !182)
!736 = !DILocation(line: 184, column: 35, scope: !182)
!737 = !DILocation(line: 185, column: 36, scope: !182)
!738 = !DILocation(line: 185, column: 4, scope: !182)
!739 = !DILocation(line: 185, column: 20, scope: !182)
!740 = !DILocation(line: 185, column: 18, scope: !182)
!741 = !DILocation(line: 185, column: 34, scope: !182)
!742 = !DILocation(line: 186, column: 14, scope: !182)
!743 = !DILocation(line: 190, column: 1, scope: !182)
!744 = !DILocation(line: 194, column: 5, scope: !190)
!745 = !DILocation(line: 204, column: 5, scope: !190)
!746 = !DILocation(line: 209, column: 21, scope: !190)
!747 = !DILocation(line: 209, column: 29, scope: !190)
!748 = !DILocation(line: 209, column: 35, scope: !190)
!749 = !DILocation(line: 206, column: 5, scope: !190)
!750 = !{i32 6310}
!751 = !DILocation(line: 212, column: 5, scope: !190)
