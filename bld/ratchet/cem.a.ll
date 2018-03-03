; ModuleID = 'cem.a.bc'
target datalayout = "e-m:e-p:16:16-i32:16:32-a:16-n8:16"
target triple = "msp430"

%struct._context_t = type { i16* }
%struct._log_t = type { [64 x i16], i16, i16 }
%struct._dict_t = type { [512 x %struct._node_t], i16 }
%struct._node_t = type { i16, i16, i16 }

@overflow = global i16 0, align 2
@"\010x03C0" = external global i16, align 2
@__vector_timer0_b1 = global void ()* @TimerB1_ISR, section "__interrupt_vector_timer0_b1", align 2
@"\010x0130" = external global i16, align 2
@llvm.used = appending global [1 x i8*] [i8* bitcast (void ()* @TimerB1_ISR to i8*)], section "llvm.metadata"
@.str = private unnamed_addr constant [29 x i8] c"rate: samples/block: %u/%u\0D\0A\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c"add node: table full\0D\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"a%u.\0D\0A\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"start: \0D\0A\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"end\0D\0A\00", align 1
@"\010x015C" = external global i16, align 2
@"\010x0160+1" = external global i8, align 1
@"\010x0164" = external global i16, align 2
@"\010x0166" = external global i16, align 2
@watchdog_bits = internal unnamed_addr global i8 0, align 1
@context_0 = global %struct._context_t zeroinitializer, section ".nv_vars", align 2
@context_1 = global %struct._context_t zeroinitializer, section ".nv_vars", align 2
@curctx = global %struct._context_t* @context_0, section ".nv_vars", align 2
@chkpt_ever_taken = global i8 0, section ".nv_vars", align 1
@regs_0 = global [16 x i16] zeroinitializer, section ".nv_vars", align 2
@regs_1 = global [16 x i16] zeroinitializer, section ".nv_vars", align 2

@__interrupt_vector_51 = alias void (), void ()* @TimerB1_ISR

; Function Attrs: nounwind
define void @__loop_bound__(i16 %val) #0 {
entry:
  %val.addr = alloca i16, align 2
  store i16 %val, i16* %val.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %val.addr, metadata !177, metadata !178), !dbg !179
  ret void, !dbg !180
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind
define msp430_intrcc void @TimerB1_ISR() #2 {
entry:
  %0 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !181
  %and = and i16 %0, -3, !dbg !181
  store volatile i16 %and, i16* @"\010x03C0", align 2, !dbg !181
  %1 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !182
  %tobool = icmp ne i16 %1, 0, !dbg !182
  br i1 %tobool, label %if.then, label %if.end, !dbg !184

if.then:                                          ; preds = %entry
  %2 = load i16, i16* @overflow, align 2, !dbg !185
  %inc = add i16 %2, 1, !dbg !185
  store i16 %inc, i16* @overflow, align 2, !dbg !185
  %3 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !187
  %or = or i16 %3, 4, !dbg !187
  store volatile i16 %or, i16* @"\010x03C0", align 2, !dbg !187
  %4 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !188
  %or1 = or i16 %4, 2, !dbg !188
  store volatile i16 %or1, i16* @"\010x03C0", align 2, !dbg !188
  %5 = load volatile i16, i16* @"\010x03C0", align 2, !dbg !189
  %and2 = and i16 %5, -2, !dbg !189
  store volatile i16 %and2, i16* @"\010x03C0", align 2, !dbg !189
  br label %if.end, !dbg !190

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !191
}

; Function Attrs: nounwind
define void @print_log(%struct._log_t* %log) #0 {
entry:
  %log.addr = alloca %struct._log_t*, align 2
  %i = alloca i16, align 2
  store %struct._log_t* %log, %struct._log_t** %log.addr, align 2
  call void @llvm.dbg.declare(metadata %struct._log_t** %log.addr, metadata !192, metadata !178), !dbg !193
  call void @llvm.dbg.declare(metadata i16* %i, metadata !194, metadata !178), !dbg !195
  call void bitcast (void (...)* @request_energy_guard_debug_mode to void ()*)(), !dbg !196
  %0 = load %struct._log_t*, %struct._log_t** %log.addr, align 2, !dbg !197
  %sample_count = getelementptr inbounds %struct._log_t, %struct._log_t* %0, i32 0, i32 2, !dbg !197
  %1 = load i16, i16* %sample_count, align 2, !dbg !197
  %2 = load %struct._log_t*, %struct._log_t** %log.addr, align 2, !dbg !197
  %count = getelementptr inbounds %struct._log_t, %struct._log_t* %2, i32 0, i32 1, !dbg !197
  %3 = load i16, i16* %count, align 2, !dbg !197
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i32 0, i32 0), i16 %1, i16 %3), !dbg !197
  call void bitcast (void (...)* @resume_application to void ()*)(), !dbg !198
  %4 = load %struct._log_t*, %struct._log_t** %log.addr, align 2, !dbg !199
  %sample_count1 = getelementptr inbounds %struct._log_t, %struct._log_t* %4, i32 0, i32 2, !dbg !201
  %5 = load i16, i16* %sample_count1, align 2, !dbg !201
  %cmp = icmp ne i16 %5, 353, !dbg !202
  br i1 %cmp, label %if.then, label %if.end, !dbg !203

if.then:                                          ; preds = %entry
  call void @exit(i16 0) #6, !dbg !204
  unreachable, !dbg !204

if.end:                                           ; preds = %entry
  ret void, !dbg !206
}

declare void @request_energy_guard_debug_mode(...) #3

declare i16 @printf(i8*, ...) #3

declare void @resume_application(...) #3

; Function Attrs: noreturn
declare void @exit(i16) #4

; Function Attrs: nounwind
define i16 @acquire_sample(i16 %prev_sample) #0 {
entry:
  %prev_sample.addr = alloca i16, align 2
  %sample = alloca i16, align 2
  store i16 %prev_sample, i16* %prev_sample.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %prev_sample.addr, metadata !207, metadata !178), !dbg !208
  call void @llvm.dbg.declare(metadata i16* %sample, metadata !209, metadata !178), !dbg !210
  %0 = load i16, i16* %prev_sample.addr, align 2, !dbg !211
  %add = add i16 %0, 1, !dbg !212
  %and = and i16 %add, 3, !dbg !213
  store i16 %and, i16* %sample, align 2, !dbg !210
  %1 = load i16, i16* %sample, align 2, !dbg !214
  ret i16 %1, !dbg !215
}

; Function Attrs: nounwind
define void @init_dict(%struct._dict_t* %dict) #0 {
entry:
  call void @checkpoint()
  %dict.addr = alloca %struct._dict_t*, align 2
  %l = alloca i16, align 2
  %node = alloca %struct._node_t*, align 2
  store %struct._dict_t* %dict, %struct._dict_t** %dict.addr, align 2
  call void @llvm.dbg.declare(metadata %struct._dict_t** %dict.addr, metadata !216, metadata !178), !dbg !217
  call void @llvm.dbg.declare(metadata i16* %l, metadata !218, metadata !178), !dbg !219
  %0 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !220
  %node_count = getelementptr inbounds %struct._dict_t, %struct._dict_t* %0, i32 0, i32 1, !dbg !221
  store i16 0, i16* %node_count, align 2, !dbg !222
  store i16 0, i16* %l, align 2, !dbg !223
  br label %for.cond, !dbg !225

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i16, i16* %l, align 2, !dbg !226
  %cmp = icmp ult i16 %1, 256, !dbg !230
  br i1 %cmp, label %for.body, label %for.end, !dbg !231

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata %struct._node_t** %node, metadata !232, metadata !178), !dbg !235
  %2 = load i16, i16* %l, align 2, !dbg !236
  %3 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !237
  %nodes = getelementptr inbounds %struct._dict_t, %struct._dict_t* %3, i32 0, i32 0, !dbg !238
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes, i16 0, i16 %2, !dbg !237
  store %struct._node_t* %arrayidx, %struct._node_t** %node, align 2, !dbg !235
  %4 = load i16, i16* %l, align 2, !dbg !239
  %5 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !240
  %letter = getelementptr inbounds %struct._node_t, %struct._node_t* %5, i32 0, i32 0, !dbg !241
  store i16 %4, i16* %letter, align 2, !dbg !242
  %6 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !243
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %6, i32 0, i32 1, !dbg !244
  store i16 0, i16* %sibling, align 2, !dbg !245
  %7 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !246
  %child = getelementptr inbounds %struct._node_t, %struct._node_t* %7, i32 0, i32 2, !dbg !247
  store i16 0, i16* %child, align 2, !dbg !248
  %8 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !249
  %node_count1 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %8, i32 0, i32 1, !dbg !250
  %9 = load i16, i16* %node_count1, align 2, !dbg !251
  %inc = add i16 %9, 1, !dbg !251
  call void @checkpoint()
  store i16 %inc, i16* %node_count1, align 2, !dbg !251
  br label %for.inc, !dbg !252

for.inc:                                          ; preds = %for.body
  %10 = load i16, i16* %l, align 2, !dbg !253
  %inc2 = add i16 %10, 1, !dbg !253
  call void @checkpoint()
  store i16 %inc2, i16* %l, align 2, !dbg !253
  br label %for.cond, !dbg !254

for.end:                                          ; preds = %for.cond
  ret void, !dbg !255
}

; Function Attrs: nounwind
define i16 @find_child(i16 %letter, i16 %parent, %struct._dict_t* %dict) #0 {
entry:
  call void @checkpoint()
  %retval = alloca i16, align 2
  %letter.addr = alloca i16, align 2
  %parent.addr = alloca i16, align 2
  %dict.addr = alloca %struct._dict_t*, align 2
  %parent_node = alloca %struct._node_t*, align 2
  %sibling = alloca i16, align 2
  %sibling_node = alloca %struct._node_t*, align 2
  store i16 %letter, i16* %letter.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %letter.addr, metadata !256, metadata !178), !dbg !257
  store i16 %parent, i16* %parent.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %parent.addr, metadata !258, metadata !178), !dbg !259
  store %struct._dict_t* %dict, %struct._dict_t** %dict.addr, align 2
  call void @llvm.dbg.declare(metadata %struct._dict_t** %dict.addr, metadata !260, metadata !178), !dbg !261
  call void @llvm.dbg.declare(metadata %struct._node_t** %parent_node, metadata !262, metadata !178), !dbg !263
  %0 = load i16, i16* %parent.addr, align 2, !dbg !264
  %1 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !265
  %nodes = getelementptr inbounds %struct._dict_t, %struct._dict_t* %1, i32 0, i32 0, !dbg !266
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes, i16 0, i16 %0, !dbg !265
  store %struct._node_t* %arrayidx, %struct._node_t** %parent_node, align 2, !dbg !263
  %2 = load %struct._node_t*, %struct._node_t** %parent_node, align 2, !dbg !267
  %child = getelementptr inbounds %struct._node_t, %struct._node_t* %2, i32 0, i32 2, !dbg !269
  %3 = load i16, i16* %child, align 2, !dbg !269
  %cmp = icmp eq i16 %3, 0, !dbg !270
  br i1 %cmp, label %if.then, label %if.end, !dbg !271

if.then:                                          ; preds = %entry
  store i16 0, i16* %retval, align 2, !dbg !272
  br label %return, !dbg !272

if.end:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata i16* %sibling, metadata !274, metadata !178), !dbg !275
  %4 = load %struct._node_t*, %struct._node_t** %parent_node, align 2, !dbg !276
  %child1 = getelementptr inbounds %struct._node_t, %struct._node_t* %4, i32 0, i32 2, !dbg !277
  %5 = load i16, i16* %child1, align 2, !dbg !277
  store i16 %5, i16* %sibling, align 2, !dbg !275
  br label %while.cond, !dbg !278

while.cond:                                       ; preds = %if.end.9, %if.end
  call void @__loop_bound__(i16 256), !dbg !279
  %6 = load i16, i16* %sibling, align 2, !dbg !282
  %cmp2 = icmp ne i16 %6, 0, !dbg !283
  br i1 %cmp2, label %while.body, label %while.end, !dbg !278

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata %struct._node_t** %sibling_node, metadata !284, metadata !178), !dbg !286
  %7 = load i16, i16* %sibling, align 2, !dbg !287
  %8 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !288
  %nodes3 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %8, i32 0, i32 0, !dbg !289
  %arrayidx4 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes3, i16 0, i16 %7, !dbg !288
  store %struct._node_t* %arrayidx4, %struct._node_t** %sibling_node, align 2, !dbg !286
  %9 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !290
  %letter5 = getelementptr inbounds %struct._node_t, %struct._node_t* %9, i32 0, i32 0, !dbg !292
  %10 = load i16, i16* %letter5, align 2, !dbg !292
  %11 = load i16, i16* %letter.addr, align 2, !dbg !293
  %cmp6 = icmp eq i16 %10, %11, !dbg !294
  br i1 %cmp6, label %if.then.7, label %if.else, !dbg !295

if.then.7:                                        ; preds = %while.body
  %12 = load i16, i16* %sibling, align 2, !dbg !296
  store i16 %12, i16* %retval, align 2, !dbg !298
  br label %return, !dbg !298

if.else:                                          ; preds = %while.body
  %13 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !299
  %sibling8 = getelementptr inbounds %struct._node_t, %struct._node_t* %13, i32 0, i32 1, !dbg !301
  %14 = load i16, i16* %sibling8, align 2, !dbg !301
  call void @checkpoint()
  store i16 %14, i16* %sibling, align 2, !dbg !302
  br label %if.end.9

if.end.9:                                         ; preds = %if.else
  br label %while.cond, !dbg !278

while.end:                                        ; preds = %while.cond
  store i16 0, i16* %retval, align 2, !dbg !303
  br label %return, !dbg !303

return:                                           ; preds = %while.end, %if.then.7, %if.then
  %15 = load i16, i16* %retval, align 2, !dbg !304
  ret i16 %15, !dbg !304
}

; Function Attrs: nounwind
define void @add_node(i16 %letter, i16 %parent, %struct._dict_t* %dict) #0 {
entry:
  call void @checkpoint()
  %letter.addr = alloca i16, align 2
  %parent.addr = alloca i16, align 2
  %dict.addr = alloca %struct._dict_t*, align 2
  %node = alloca %struct._node_t*, align 2
  %node_index = alloca i16, align 2
  %child4 = alloca i16, align 2
  %sibling9 = alloca i16, align 2
  %sibling_node = alloca %struct._node_t*, align 2
  store i16 %letter, i16* %letter.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %letter.addr, metadata !305, metadata !178), !dbg !306
  store i16 %parent, i16* %parent.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %parent.addr, metadata !307, metadata !178), !dbg !308
  store %struct._dict_t* %dict, %struct._dict_t** %dict.addr, align 2
  call void @llvm.dbg.declare(metadata %struct._dict_t** %dict.addr, metadata !309, metadata !178), !dbg !310
  %0 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !311
  %node_count = getelementptr inbounds %struct._dict_t, %struct._dict_t* %0, i32 0, i32 1, !dbg !313
  %1 = load i16, i16* %node_count, align 2, !dbg !313
  %cmp = icmp eq i16 %1, 512, !dbg !314
  br i1 %cmp, label %if.then, label %if.end, !dbg !315

if.then:                                          ; preds = %entry
  br label %do.body, !dbg !316

do.body:                                          ; preds = %if.then
  call void bitcast (void (...)* @request_non_interactive_debug_mode to void ()*)(), !dbg !318
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0)), !dbg !318
  call void bitcast (void (...)* @resume_application to void ()*)(), !dbg !318
  br label %do.end, !dbg !318

do.end:                                           ; preds = %do.body
  br label %if.end, !dbg !321

if.end:                                           ; preds = %do.end, %entry
  call void @llvm.dbg.declare(metadata %struct._node_t** %node, metadata !322, metadata !178), !dbg !323
  %2 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !324
  %node_count1 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %2, i32 0, i32 1, !dbg !325
  %3 = load i16, i16* %node_count1, align 2, !dbg !325
  %4 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !326
  %nodes = getelementptr inbounds %struct._dict_t, %struct._dict_t* %4, i32 0, i32 0, !dbg !327
  %arrayidx = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes, i16 0, i16 %3, !dbg !326
  store %struct._node_t* %arrayidx, %struct._node_t** %node, align 2, !dbg !323
  %5 = load i16, i16* %letter.addr, align 2, !dbg !328
  %6 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !329
  %letter2 = getelementptr inbounds %struct._node_t, %struct._node_t* %6, i32 0, i32 0, !dbg !330
  call void @checkpoint()
  store i16 %5, i16* %letter2, align 2, !dbg !331
  %7 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !332
  %sibling = getelementptr inbounds %struct._node_t, %struct._node_t* %7, i32 0, i32 1, !dbg !333
  store i16 0, i16* %sibling, align 2, !dbg !334
  %8 = load %struct._node_t*, %struct._node_t** %node, align 2, !dbg !335
  %child = getelementptr inbounds %struct._node_t, %struct._node_t* %8, i32 0, i32 2, !dbg !336
  store i16 0, i16* %child, align 2, !dbg !337
  call void @llvm.dbg.declare(metadata i16* %node_index, metadata !338, metadata !178), !dbg !339
  %9 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !340
  %node_count3 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %9, i32 0, i32 1, !dbg !341
  %10 = load i16, i16* %node_count3, align 2, !dbg !342
  %inc = add i16 %10, 1, !dbg !342
  call void @checkpoint()
  store i16 %inc, i16* %node_count3, align 2, !dbg !342
  store i16 %10, i16* %node_index, align 2, !dbg !339
  call void @llvm.dbg.declare(metadata i16* %child4, metadata !343, metadata !178), !dbg !344
  %11 = load i16, i16* %parent.addr, align 2, !dbg !345
  %12 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !346
  %nodes5 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %12, i32 0, i32 0, !dbg !347
  %arrayidx6 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes5, i16 0, i16 %11, !dbg !346
  %child7 = getelementptr inbounds %struct._node_t, %struct._node_t* %arrayidx6, i32 0, i32 2, !dbg !348
  %13 = load i16, i16* %child7, align 2, !dbg !348
  store i16 %13, i16* %child4, align 2, !dbg !344
  %14 = load i16, i16* %child4, align 2, !dbg !349
  %tobool = icmp ne i16 %14, 0, !dbg !349
  br i1 %tobool, label %if.then.8, label %if.else, !dbg !351

if.then.8:                                        ; preds = %if.end
  call void @llvm.dbg.declare(metadata i16* %sibling9, metadata !352, metadata !178), !dbg !354
  %15 = load i16, i16* %child4, align 2, !dbg !355
  store i16 %15, i16* %sibling9, align 2, !dbg !354
  call void @llvm.dbg.declare(metadata %struct._node_t** %sibling_node, metadata !356, metadata !178), !dbg !357
  %16 = load i16, i16* %sibling9, align 2, !dbg !358
  %17 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !359
  %nodes10 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %17, i32 0, i32 0, !dbg !360
  %arrayidx11 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes10, i16 0, i16 %16, !dbg !359
  store %struct._node_t* %arrayidx11, %struct._node_t** %sibling_node, align 2, !dbg !357
  br label %while.cond, !dbg !361

while.cond:                                       ; preds = %while.body, %if.then.8
  call void @__loop_bound__(i16 256), !dbg !362
  %18 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !365
  %sibling12 = getelementptr inbounds %struct._node_t, %struct._node_t* %18, i32 0, i32 1, !dbg !366
  %19 = load i16, i16* %sibling12, align 2, !dbg !366
  %cmp13 = icmp ne i16 %19, 0, !dbg !367
  br i1 %cmp13, label %while.body, label %while.end, !dbg !361

while.body:                                       ; preds = %while.cond
  %20 = load %struct._node_t*, %struct._node_t** %sibling_node, align 2, !dbg !368
  %sibling14 = getelementptr inbounds %struct._node_t, %struct._node_t* %20, i32 0, i32 1, !dbg !370
  %21 = load i16, i16* %sibling14, align 2, !dbg !370
  store i16 %21, i16* %sibling9, align 2, !dbg !371
  %22 = load i16, i16* %sibling9, align 2, !dbg !372
  %23 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !373
  %nodes15 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %23, i32 0, i32 0, !dbg !374
  %arrayidx16 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes15, i16 0, i16 %22, !dbg !373
  call void @checkpoint()
  store %struct._node_t* %arrayidx16, %struct._node_t** %sibling_node, align 2, !dbg !375
  br label %while.cond, !dbg !361

while.end:                                        ; preds = %while.cond
  %24 = load i16, i16* %node_index, align 2, !dbg !376
  %25 = load i16, i16* %sibling9, align 2, !dbg !377
  %26 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !378
  %nodes17 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %26, i32 0, i32 0, !dbg !379
  %arrayidx18 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes17, i16 0, i16 %25, !dbg !378
  %sibling19 = getelementptr inbounds %struct._node_t, %struct._node_t* %arrayidx18, i32 0, i32 1, !dbg !380
  call void @checkpoint()
  store i16 %24, i16* %sibling19, align 2, !dbg !381
  br label %if.end.23, !dbg !382

if.else:                                          ; preds = %if.end
  %27 = load i16, i16* %node_index, align 2, !dbg !383
  %28 = load i16, i16* %parent.addr, align 2, !dbg !385
  %29 = load %struct._dict_t*, %struct._dict_t** %dict.addr, align 2, !dbg !386
  %nodes20 = getelementptr inbounds %struct._dict_t, %struct._dict_t* %29, i32 0, i32 0, !dbg !387
  %arrayidx21 = getelementptr inbounds [512 x %struct._node_t], [512 x %struct._node_t]* %nodes20, i16 0, i16 %28, !dbg !386
  %child22 = getelementptr inbounds %struct._node_t, %struct._node_t* %arrayidx21, i32 0, i32 2, !dbg !388
  call void @checkpoint()
  store i16 %27, i16* %child22, align 2, !dbg !389
  br label %if.end.23

if.end.23:                                        ; preds = %if.else, %while.end
  ret void, !dbg !390
}

declare void @request_non_interactive_debug_mode(...) #3

; Function Attrs: nounwind
define void @append_compressed(i16 %parent, %struct._log_t* %log) #0 {
entry:
  call void @checkpoint()
  %parent.addr = alloca i16, align 2
  %log.addr = alloca %struct._log_t*, align 2
  store i16 %parent, i16* %parent.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %parent.addr, metadata !391, metadata !178), !dbg !392
  store %struct._log_t* %log, %struct._log_t** %log.addr, align 2
  call void @llvm.dbg.declare(metadata %struct._log_t** %log.addr, metadata !393, metadata !178), !dbg !394
  %0 = load i16, i16* %parent.addr, align 2, !dbg !395
  %1 = load %struct._log_t*, %struct._log_t** %log.addr, align 2, !dbg !396
  %count = getelementptr inbounds %struct._log_t, %struct._log_t* %1, i32 0, i32 1, !dbg !397
  %2 = load i16, i16* %count, align 2, !dbg !398
  %inc = add i16 %2, 1, !dbg !398
  call void @checkpoint()
  store i16 %inc, i16* %count, align 2, !dbg !398
  %3 = load %struct._log_t*, %struct._log_t** %log.addr, align 2, !dbg !399
  %data = getelementptr inbounds %struct._log_t, %struct._log_t* %3, i32 0, i32 0, !dbg !400
  %arrayidx = getelementptr inbounds [64 x i16], [64 x i16]* %data, i16 0, i16 %2, !dbg !399
  store i16 %0, i16* %arrayidx, align 2, !dbg !401
  ret void, !dbg !402
}

; Function Attrs: nounwind
define void @init() #0 {
entry:
  %i = alloca i16, align 2
  call void @init_hw(), !dbg !403
  call void bitcast (void (...)* @edb_init to void ()*)(), !dbg !404
  call void asm sideeffect "eint { nop", ""() #7, !dbg !405, !srcloc !406
  br label %do.body, !dbg !407

do.body:                                          ; preds = %entry
  call void bitcast (void (...)* @request_non_interactive_debug_mode to void ()*)(), !dbg !408
  %0 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !408
  %cur_reg = getelementptr inbounds %struct._context_t, %struct._context_t* %0, i32 0, i32 0, !dbg !408
  %1 = load i16*, i16** %cur_reg, align 2, !dbg !408
  %arrayidx = getelementptr inbounds i16, i16* %1, i16 15, !dbg !408
  %2 = load i16, i16* %arrayidx, align 2, !dbg !408
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i16 %2), !dbg !408
  call void bitcast (void (...)* @resume_application to void ()*)(), !dbg !408
  br label %do.end, !dbg !408

do.end:                                           ; preds = %do.body
  call void @llvm.dbg.declare(metadata i16* %i, metadata !411, metadata !178), !dbg !413
  store i16 0, i16* %i, align 2, !dbg !413
  br label %for.cond, !dbg !414

for.cond:                                         ; preds = %for.inc, %do.end
  %3 = load i16, i16* %i, align 2, !dbg !415
  %cmp = icmp ult i16 %3, 1200, !dbg !419
  br i1 %cmp, label %for.body, label %for.end, !dbg !420

for.body:                                         ; preds = %for.cond
  br label %for.inc, !dbg !421

for.inc:                                          ; preds = %for.body
  %4 = load i16, i16* %i, align 2, !dbg !423
  %inc = add i16 %4, 1, !dbg !423
  store i16 %inc, i16* %i, align 2, !dbg !423
  br label %for.cond, !dbg !424

for.end:                                          ; preds = %for.cond
  ret void, !dbg !425
}

declare void @edb_init(...) #3

; Function Attrs: nounwind
define i16 @main() #0 {
entry:
  call void @checkpoint()
  %retval = alloca i16, align 2
  %dict = alloca %struct._dict_t, align 2
  %log = alloca %struct._log_t, align 2
  %letter = alloca i16, align 2
  %letter_idx = alloca i16, align 2
  %parent = alloca i16, align 2
  %child = alloca i16, align 2
  %sample = alloca i16, align 2
  %prev_sample = alloca i16, align 2
  %letter_idx_tmp = alloca i16, align 2
  %letter_shift = alloca i16, align 2
  store i16 0, i16* %retval, align 2
  call void @restore_regs(), !dbg !426
  call void @llvm.dbg.declare(metadata %struct._dict_t* %dict, metadata !427, metadata !178), !dbg !428
  call void @llvm.dbg.declare(metadata %struct._log_t* %log, metadata !429, metadata !178), !dbg !430
  br label %while.body, !dbg !431

while.body:                                       ; preds = %entry, %while.end
  call void @__loop_bound__(i16 999), !dbg !432
  br label %do.body, !dbg !434

do.body:                                          ; preds = %while.body
  call void bitcast (void (...)* @request_non_interactive_debug_mode to void ()*)(), !dbg !435
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i32 0, i32 0)), !dbg !435
  call void bitcast (void (...)* @resume_application to void ()*)(), !dbg !435
  br label %do.end, !dbg !435

do.end:                                           ; preds = %do.body
  call void @init_dict(%struct._dict_t* %dict), !dbg !438
  call void @llvm.dbg.declare(metadata i16* %letter, metadata !439, metadata !178), !dbg !440
  store i16 0, i16* %letter, align 2, !dbg !440
  call void @llvm.dbg.declare(metadata i16* %letter_idx, metadata !441, metadata !178), !dbg !442
  store i16 0, i16* %letter_idx, align 2, !dbg !442
  call void @llvm.dbg.declare(metadata i16* %parent, metadata !443, metadata !178), !dbg !444
  call void @llvm.dbg.declare(metadata i16* %child, metadata !445, metadata !178), !dbg !446
  call void @llvm.dbg.declare(metadata i16* %sample, metadata !447, metadata !178), !dbg !448
  call void @llvm.dbg.declare(metadata i16* %prev_sample, metadata !449, metadata !178), !dbg !450
  store i16 0, i16* %prev_sample, align 2, !dbg !450
  %sample_count = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 2, !dbg !451
  store i16 1, i16* %sample_count, align 2, !dbg !452
  %count = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 1, !dbg !453
  store i16 0, i16* %count, align 2, !dbg !454
  br label %while.body.2, !dbg !455

while.body.2:                                     ; preds = %do.end, %if.end.23
  call void @__loop_bound__(i16 999), !dbg !456
  %0 = load i16, i16* %letter, align 2, !dbg !458
  store i16 %0, i16* %child, align 2, !dbg !459
  %1 = load i16, i16* %letter_idx, align 2, !dbg !460
  %cmp = icmp eq i16 %1, 0, !dbg !462
  br i1 %cmp, label %if.then, label %if.end, !dbg !463

if.then:                                          ; preds = %while.body.2
  %2 = load i16, i16* %prev_sample, align 2, !dbg !464
  %call3 = call i16 @acquire_sample(i16 %2), !dbg !466
  store i16 %call3, i16* %sample, align 2, !dbg !467
  %3 = load i16, i16* %sample, align 2, !dbg !468
  store i16 %3, i16* %prev_sample, align 2, !dbg !469
  br label %if.end, !dbg !470

if.end:                                           ; preds = %if.then, %while.body.2
  %4 = load i16, i16* %letter_idx, align 2, !dbg !471
  %inc = add i16 %4, 1, !dbg !471
  call void @checkpoint()
  store i16 %inc, i16* %letter_idx, align 2, !dbg !471
  %5 = load i16, i16* %letter_idx, align 2, !dbg !472
  %cmp4 = icmp eq i16 %5, 2, !dbg !474
  br i1 %cmp4, label %if.then.5, label %if.end.6, !dbg !475

if.then.5:                                        ; preds = %if.end
  call void @checkpoint()
  store i16 0, i16* %letter_idx, align 2, !dbg !476
  br label %if.end.6, !dbg !477

if.end.6:                                         ; preds = %if.then.5, %if.end
  br label %do.body.7, !dbg !478

do.body.7:                                        ; preds = %do.cond, %if.end.6
  call void @__loop_bound__(i16 256), !dbg !479
  call void @llvm.dbg.declare(metadata i16* %letter_idx_tmp, metadata !481, metadata !178), !dbg !482
  %6 = load i16, i16* %letter_idx, align 2, !dbg !483
  %cmp8 = icmp eq i16 %6, 0, !dbg !484
  br i1 %cmp8, label %cond.true, label %cond.false, !dbg !485

cond.true:                                        ; preds = %do.body.7
  br label %cond.end, !dbg !486

cond.false:                                       ; preds = %do.body.7
  %7 = load i16, i16* %letter_idx, align 2, !dbg !488
  %sub = sub i16 %7, 1, !dbg !490
  br label %cond.end, !dbg !485

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i16 [ 2, %cond.true ], [ %sub, %cond.false ], !dbg !485
  store i16 %cond, i16* %letter_idx_tmp, align 2, !dbg !491
  call void @llvm.dbg.declare(metadata i16* %letter_shift, metadata !494, metadata !178), !dbg !495
  %8 = load i16, i16* %letter_idx_tmp, align 2, !dbg !496
  %mul = mul i16 8, %8, !dbg !497
  store i16 %mul, i16* %letter_shift, align 2, !dbg !495
  %9 = load i16, i16* %sample, align 2, !dbg !498
  %10 = load i16, i16* %letter_shift, align 2, !dbg !499
  %shl = shl i16 255, %10, !dbg !500
  %and = and i16 %9, %shl, !dbg !501
  %11 = load i16, i16* %letter_shift, align 2, !dbg !502
  %shr = lshr i16 %and, %11, !dbg !503
  store i16 %shr, i16* %letter, align 2, !dbg !504
  %sample_count9 = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 2, !dbg !505
  %12 = load i16, i16* %sample_count9, align 2, !dbg !506
  %inc10 = add i16 %12, 1, !dbg !506
  call void @checkpoint()
  store i16 %inc10, i16* %sample_count9, align 2, !dbg !506
  %13 = load i16, i16* %child, align 2, !dbg !507
  store i16 %13, i16* %parent, align 2, !dbg !508
  %14 = load i16, i16* %letter, align 2, !dbg !509
  %15 = load i16, i16* %parent, align 2, !dbg !510
  %call11 = call i16 @find_child(i16 %14, i16 %15, %struct._dict_t* %dict), !dbg !511
  store i16 %call11, i16* %child, align 2, !dbg !512
  br label %do.cond, !dbg !513

do.cond:                                          ; preds = %cond.end
  %16 = load i16, i16* %child, align 2, !dbg !514
  %cmp12 = icmp ne i16 %16, 0, !dbg !516
  br i1 %cmp12, label %do.body.7, label %do.end.13, !dbg !513

do.end.13:                                        ; preds = %do.cond
  %17 = load i16, i16* %parent, align 2, !dbg !517
  call void @append_compressed(i16 %17, %struct._log_t* %log), !dbg !518
  %18 = load i16, i16* %letter, align 2, !dbg !519
  %19 = load i16, i16* %parent, align 2, !dbg !520
  call void @add_node(i16 %18, i16 %19, %struct._dict_t* %dict), !dbg !521
  %count14 = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 1, !dbg !522
  %20 = load i16, i16* %count14, align 2, !dbg !522
  %cmp15 = icmp eq i16 %20, 64, !dbg !524
  br i1 %cmp15, label %if.then.16, label %if.end.23, !dbg !525

if.then.16:                                       ; preds = %do.end.13
  call void @print_log(%struct._log_t* %log), !dbg !526
  %count17 = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 1, !dbg !528
  store i16 0, i16* %count17, align 2, !dbg !529
  %sample_count18 = getelementptr inbounds %struct._log_t, %struct._log_t* %log, i32 0, i32 2, !dbg !530
  store i16 0, i16* %sample_count18, align 2, !dbg !531
  br label %do.body.19, !dbg !532

do.body.19:                                       ; preds = %if.then.16
  call void bitcast (void (...)* @request_non_interactive_debug_mode to void ()*)(), !dbg !533
  %call20 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0)), !dbg !533
  call void bitcast (void (...)* @resume_application to void ()*)(), !dbg !533
  br label %do.end.22, !dbg !533

do.end.22:                                        ; preds = %do.body.19
  br label %while.end, !dbg !536

if.end.23:                                        ; preds = %do.end.13
  br label %while.body.2, !dbg !455

while.end:                                        ; preds = %do.end.22
  br label %while.body, !dbg !431

return:                                           ; No predecessors!
  %21 = load i16, i16* %retval, align 2, !dbg !537
  ret i16 %21, !dbg !537
}

; Function Attrs: nounwind
define internal void @init_hw() #0 {
entry:
  call void @msp_watchdog_disable(), !dbg !538
  %0 = load volatile i16, i16* @"\010x0130", align 2, !dbg !539
  %and = and i16 %0, -2, !dbg !539
  store volatile i16 %and, i16* @"\010x0130", align 2, !dbg !539
  call void @msp_clock_setup(), !dbg !540
  ret void, !dbg !541
}

; Function Attrs: nounwind
define void @msp_watchdog_enable(i8 zeroext %bits) #0 {
entry:
  tail call void @llvm.dbg.value(metadata i8 %bits, i64 0, metadata !80, metadata !178), !dbg !542
  %conv = zext i8 %bits to i16, !dbg !543
  %or = or i16 %conv, 23048, !dbg !544
  store volatile i16 %or, i16* @"\010x015C", align 2, !dbg !545, !tbaa !546
  store i8 %bits, i8* @watchdog_bits, align 1, !dbg !550, !tbaa !551
  ret void, !dbg !552
}

; Function Attrs: nounwind
define void @msp_watchdog_disable() #0 {
entry:
  store volatile i16 23168, i16* @"\010x015C", align 2, !dbg !553, !tbaa !546
  ret void, !dbg !554
}

; Function Attrs: nounwind
define void @msp_watchdog_kick() #0 {
entry:
  %0 = load i8, i8* @watchdog_bits, align 1, !dbg !555, !tbaa !551
  %conv = zext i8 %0 to i16, !dbg !555
  %or = or i16 %conv, 23048, !dbg !556
  store volatile i16 %or, i16* @"\010x015C", align 2, !dbg !557, !tbaa !546
  ret void, !dbg !558
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

; Function Attrs: nounwind
define i8* @memcpy(i8* %dest, i8* nocapture readonly %src, i16 %n) #0 {
entry:
  tail call void @llvm.dbg.value(metadata i8* %dest, i64 0, metadata !102, metadata !178), !dbg !559
  tail call void @llvm.dbg.value(metadata i8* %src, i64 0, metadata !103, metadata !178), !dbg !560
  tail call void @llvm.dbg.value(metadata i16 %n, i64 0, metadata !104, metadata !178), !dbg !561
  tail call void @llvm.dbg.value(metadata i16 0, i64 0, metadata !105, metadata !178), !dbg !562
  %cmp.7 = icmp eq i16 %n, 0, !dbg !563
  br i1 %cmp.7, label %while.end, label %while.body.preheader, !dbg !564

while.body.preheader:                             ; preds = %entry
  br label %while.body, !dbg !565

while.body:                                       ; preds = %while.body.preheader, %while.body
  %i.08 = phi i16 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %add.ptr = getelementptr inbounds i8, i8* %src, i16 %i.08, !dbg !565
  %0 = load i8, i8* %add.ptr, align 1, !dbg !567, !tbaa !551
  %add.ptr1 = getelementptr inbounds i8, i8* %dest, i16 %i.08, !dbg !568
  store i8 %0, i8* %add.ptr1, align 1, !dbg !569, !tbaa !551
  %inc = add nuw i16 %i.08, 1, !dbg !570
  tail call void @llvm.dbg.value(metadata i16 %inc, i64 0, metadata !105, metadata !178), !dbg !562
  %exitcond = icmp eq i16 %inc, %n, !dbg !564
  br i1 %exitcond, label %while.end.loopexit, label %while.body, !dbg !564

while.end.loopexit:                               ; preds = %while.body
  br label %while.end, !dbg !571

while.end:                                        ; preds = %while.end.loopexit, %entry
  ret i8* %dest, !dbg !571
}

; Function Attrs: nounwind
define void @msp_clock_setup() #0 {
entry:
  store volatile i8 -91, i8* @"\010x0160+1", align 1, !dbg !572, !tbaa !551
  store volatile i16 51, i16* @"\010x0164", align 2, !dbg !573, !tbaa !546
  store volatile i16 0, i16* @"\010x0166", align 2, !dbg !574, !tbaa !546
  ret void, !dbg !575
}

; Function Attrs: naked noinline nounwind
define i32 @mult16(i16 zeroext, i16 zeroext) #5 {
entry:
  %retval = alloca i32, align 2
  call void asm sideeffect "MOV R15, &0x04C0\0AMOV R14, &0x04C8\0AMOV &0x04CA, R14\0AMOV &0x04CC, R15\0ARET\0A", ""() #7, !dbg !576, !srcloc !577
  unreachable, !dbg !578
}

; Function Attrs: nounwind
define zeroext i16 @sqrt16(i32 %x) #0 {
entry:
  %x.addr = alloca i32, align 2
  %hi = alloca i16, align 2
  %lo = alloca i16, align 2
  %mid = alloca i16, align 2
  %s = alloca i32, align 2
  store i32 %x, i32* %x.addr, align 2
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !579, metadata !178), !dbg !580
  call void @llvm.dbg.declare(metadata i16* %hi, metadata !581, metadata !178), !dbg !582
  store i16 -1, i16* %hi, align 2, !dbg !582
  call void @llvm.dbg.declare(metadata i16* %lo, metadata !583, metadata !178), !dbg !584
  store i16 0, i16* %lo, align 2, !dbg !584
  call void @llvm.dbg.declare(metadata i16* %mid, metadata !585, metadata !178), !dbg !586
  %0 = load i16, i16* %hi, align 2, !dbg !587
  %conv = zext i16 %0 to i32, !dbg !588
  %1 = load i16, i16* %lo, align 2, !dbg !589
  %conv1 = zext i16 %1 to i32, !dbg !590
  %add = add i32 %conv, %conv1, !dbg !591
  %shr = lshr i32 %add, 1, !dbg !592
  %conv2 = trunc i32 %shr to i16, !dbg !593
  store i16 %conv2, i16* %mid, align 2, !dbg !586
  call void @llvm.dbg.declare(metadata i32* %s, metadata !594, metadata !178), !dbg !595
  store i32 0, i32* %s, align 2, !dbg !595
  br label %while.cond, !dbg !596

while.cond:                                       ; preds = %if.end, %entry
  %2 = load i32, i32* %s, align 2, !dbg !597
  %3 = load i32, i32* %x.addr, align 2, !dbg !600
  %cmp = icmp ne i32 %2, %3, !dbg !601
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !602

land.rhs:                                         ; preds = %while.cond
  %4 = load i16, i16* %hi, align 2, !dbg !603
  %5 = load i16, i16* %lo, align 2, !dbg !605
  %sub = sub i16 %4, %5, !dbg !606
  %cmp4 = icmp ugt i16 %sub, 1, !dbg !607
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %6 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ]
  br i1 %6, label %while.body, label %while.end, !dbg !608

while.body:                                       ; preds = %land.end
  %7 = load i16, i16* %hi, align 2, !dbg !610
  %conv6 = zext i16 %7 to i32, !dbg !612
  %8 = load i16, i16* %lo, align 2, !dbg !613
  %conv7 = zext i16 %8 to i32, !dbg !614
  %add8 = add i32 %conv6, %conv7, !dbg !615
  %shr9 = lshr i32 %add8, 1, !dbg !616
  %conv10 = trunc i32 %shr9 to i16, !dbg !617
  store i16 %conv10, i16* %mid, align 2, !dbg !618
  %9 = load i16, i16* %mid, align 2, !dbg !619
  %10 = load i16, i16* %mid, align 2, !dbg !620
  %call = call i32 @mult16(i16 zeroext %9, i16 zeroext %10), !dbg !621
  store i32 %call, i32* %s, align 2, !dbg !622
  %11 = load i32, i32* %s, align 2, !dbg !623
  %12 = load i32, i32* %x.addr, align 2, !dbg !625
  %cmp11 = icmp ult i32 %11, %12, !dbg !626
  br i1 %cmp11, label %if.then, label %if.else, !dbg !627

if.then:                                          ; preds = %while.body
  %13 = load i16, i16* %mid, align 2, !dbg !628
  store i16 %13, i16* %lo, align 2, !dbg !629
  br label %if.end, !dbg !630

if.else:                                          ; preds = %while.body
  %14 = load i16, i16* %mid, align 2, !dbg !631
  store i16 %14, i16* %hi, align 2, !dbg !632
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %while.cond, !dbg !596

while.end:                                        ; preds = %land.end
  %15 = load i16, i16* %mid, align 2, !dbg !633
  ret i16 %15, !dbg !634
}

; Function Attrs: nounwind
define zeroext i16 @udivmodhi4(i16 zeroext %num, i16 zeroext %den, i16 signext %modwanted) #0 {
entry:
  %retval = alloca i16, align 2
  %num.addr = alloca i16, align 2
  %den.addr = alloca i16, align 2
  %modwanted.addr = alloca i16, align 2
  %bit = alloca i16, align 2
  %res = alloca i16, align 2
  store i16 %num, i16* %num.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %num.addr, metadata !635, metadata !178), !dbg !636
  store i16 %den, i16* %den.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %den.addr, metadata !637, metadata !178), !dbg !638
  store i16 %modwanted, i16* %modwanted.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %modwanted.addr, metadata !639, metadata !178), !dbg !640
  call void @llvm.dbg.declare(metadata i16* %bit, metadata !641, metadata !178), !dbg !642
  store i16 1, i16* %bit, align 2, !dbg !642
  call void @llvm.dbg.declare(metadata i16* %res, metadata !643, metadata !178), !dbg !644
  store i16 0, i16* %res, align 2, !dbg !644
  br label %while.cond, !dbg !645

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i16, i16* %den.addr, align 2, !dbg !646
  %1 = load i16, i16* %num.addr, align 2, !dbg !649
  %cmp = icmp ult i16 %0, %1, !dbg !650
  br i1 %cmp, label %land.lhs.true, label %land.end, !dbg !651

land.lhs.true:                                    ; preds = %while.cond
  %2 = load i16, i16* %bit, align 2, !dbg !652
  %tobool = icmp ne i16 %2, 0, !dbg !652
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !654

land.rhs:                                         ; preds = %land.lhs.true
  %3 = load i16, i16* %den.addr, align 2, !dbg !655
  %and = and i16 %3, -32768, !dbg !657
  %tobool1 = icmp ne i16 %and, 0, !dbg !658
  %lnot = xor i1 %tobool1, true, !dbg !658
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %while.cond
  %4 = phi i1 [ false, %land.lhs.true ], [ false, %while.cond ], [ %lnot, %land.rhs ]
  br i1 %4, label %while.body, label %while.end, !dbg !659

while.body:                                       ; preds = %land.end
  %5 = load i16, i16* %den.addr, align 2, !dbg !662
  %shl = shl i16 %5, 1, !dbg !662
  store i16 %shl, i16* %den.addr, align 2, !dbg !662
  %6 = load i16, i16* %bit, align 2, !dbg !664
  %shl2 = shl i16 %6, 1, !dbg !664
  store i16 %shl2, i16* %bit, align 2, !dbg !664
  br label %while.cond, !dbg !645

while.end:                                        ; preds = %land.end
  br label %while.cond.3, !dbg !665

while.cond.3:                                     ; preds = %if.end, %while.end
  %7 = load i16, i16* %bit, align 2, !dbg !666
  %tobool4 = icmp ne i16 %7, 0, !dbg !665
  br i1 %tobool4, label %while.body.5, label %while.end.8, !dbg !665

while.body.5:                                     ; preds = %while.cond.3
  %8 = load i16, i16* %num.addr, align 2, !dbg !668
  %9 = load i16, i16* %den.addr, align 2, !dbg !671
  %cmp6 = icmp uge i16 %8, %9, !dbg !672
  br i1 %cmp6, label %if.then, label %if.end, !dbg !673

if.then:                                          ; preds = %while.body.5
  %10 = load i16, i16* %den.addr, align 2, !dbg !674
  %11 = load i16, i16* %num.addr, align 2, !dbg !676
  %sub = sub i16 %11, %10, !dbg !676
  store i16 %sub, i16* %num.addr, align 2, !dbg !676
  %12 = load i16, i16* %bit, align 2, !dbg !677
  %13 = load i16, i16* %res, align 2, !dbg !678
  %or = or i16 %13, %12, !dbg !678
  store i16 %or, i16* %res, align 2, !dbg !678
  br label %if.end, !dbg !679

if.end:                                           ; preds = %if.then, %while.body.5
  %14 = load i16, i16* %bit, align 2, !dbg !680
  %shr = lshr i16 %14, 1, !dbg !680
  store i16 %shr, i16* %bit, align 2, !dbg !680
  %15 = load i16, i16* %den.addr, align 2, !dbg !681
  %shr7 = lshr i16 %15, 1, !dbg !681
  store i16 %shr7, i16* %den.addr, align 2, !dbg !681
  br label %while.cond.3, !dbg !665

while.end.8:                                      ; preds = %while.cond.3
  %16 = load i16, i16* %modwanted.addr, align 2, !dbg !682
  %tobool9 = icmp ne i16 %16, 0, !dbg !682
  br i1 %tobool9, label %if.then.10, label %if.end.11, !dbg !684

if.then.10:                                       ; preds = %while.end.8
  %17 = load i16, i16* %num.addr, align 2, !dbg !685
  store i16 %17, i16* %retval, align 2, !dbg !686
  br label %return, !dbg !686

if.end.11:                                        ; preds = %while.end.8
  %18 = load i16, i16* %res, align 2, !dbg !687
  store i16 %18, i16* %retval, align 2, !dbg !688
  br label %return, !dbg !688

return:                                           ; preds = %if.end.11, %if.then.10
  %19 = load i16, i16* %retval, align 2, !dbg !689
  ret i16 %19, !dbg !689
}

; Function Attrs: nounwind
define signext i16 @__divhi3(i16 signext %a, i16 signext %b) #0 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %neg = alloca i16, align 2
  %res = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !690, metadata !178), !dbg !691
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !692, metadata !178), !dbg !693
  call void @llvm.dbg.declare(metadata i16* %neg, metadata !694, metadata !178), !dbg !695
  store i16 0, i16* %neg, align 2, !dbg !695
  call void @llvm.dbg.declare(metadata i16* %res, metadata !696, metadata !178), !dbg !697
  %0 = load i16, i16* %a.addr, align 2, !dbg !698
  %cmp = icmp slt i16 %0, 0, !dbg !700
  br i1 %cmp, label %if.then, label %if.end, !dbg !701

if.then:                                          ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !702
  %sub = sub nsw i16 0, %1, !dbg !704
  store i16 %sub, i16* %a.addr, align 2, !dbg !705
  %2 = load i16, i16* %neg, align 2, !dbg !706
  %tobool = icmp ne i16 %2, 0, !dbg !707
  %lnot = xor i1 %tobool, true, !dbg !707
  %lnot.ext = zext i1 %lnot to i16, !dbg !707
  store i16 %lnot.ext, i16* %neg, align 2, !dbg !708
  br label %if.end, !dbg !709

if.end:                                           ; preds = %if.then, %entry
  %3 = load i16, i16* %b.addr, align 2, !dbg !710
  %cmp1 = icmp slt i16 %3, 0, !dbg !712
  br i1 %cmp1, label %if.then.2, label %if.end.7, !dbg !713

if.then.2:                                        ; preds = %if.end
  %4 = load i16, i16* %b.addr, align 2, !dbg !714
  %sub3 = sub nsw i16 0, %4, !dbg !716
  store i16 %sub3, i16* %b.addr, align 2, !dbg !717
  %5 = load i16, i16* %neg, align 2, !dbg !718
  %tobool4 = icmp ne i16 %5, 0, !dbg !719
  %lnot5 = xor i1 %tobool4, true, !dbg !719
  %lnot.ext6 = zext i1 %lnot5 to i16, !dbg !719
  store i16 %lnot.ext6, i16* %neg, align 2, !dbg !720
  br label %if.end.7, !dbg !721

if.end.7:                                         ; preds = %if.then.2, %if.end
  %6 = load i16, i16* %a.addr, align 2, !dbg !722
  %7 = load i16, i16* %b.addr, align 2, !dbg !723
  %call = call zeroext i16 @udivmodhi4(i16 zeroext %6, i16 zeroext %7, i16 signext 0), !dbg !724
  store i16 %call, i16* %res, align 2, !dbg !725
  %8 = load i16, i16* %neg, align 2, !dbg !726
  %tobool8 = icmp ne i16 %8, 0, !dbg !726
  br i1 %tobool8, label %if.then.9, label %if.end.11, !dbg !728

if.then.9:                                        ; preds = %if.end.7
  %9 = load i16, i16* %res, align 2, !dbg !729
  %sub10 = sub nsw i16 0, %9, !dbg !730
  store i16 %sub10, i16* %res, align 2, !dbg !731
  br label %if.end.11, !dbg !732

if.end.11:                                        ; preds = %if.then.9, %if.end.7
  %10 = load i16, i16* %res, align 2, !dbg !733
  ret i16 %10, !dbg !734
}

; Function Attrs: nounwind
define signext i16 @__modhi3(i16 signext %a, i16 signext %b) #0 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %neg = alloca i16, align 2
  %res = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !735, metadata !178), !dbg !736
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !737, metadata !178), !dbg !738
  call void @llvm.dbg.declare(metadata i16* %neg, metadata !739, metadata !178), !dbg !740
  store i16 0, i16* %neg, align 2, !dbg !740
  call void @llvm.dbg.declare(metadata i16* %res, metadata !741, metadata !178), !dbg !742
  %0 = load i16, i16* %a.addr, align 2, !dbg !743
  %cmp = icmp slt i16 %0, 0, !dbg !745
  br i1 %cmp, label %if.then, label %if.end, !dbg !746

if.then:                                          ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !747
  %sub = sub nsw i16 0, %1, !dbg !749
  store i16 %sub, i16* %a.addr, align 2, !dbg !750
  store i16 1, i16* %neg, align 2, !dbg !751
  br label %if.end, !dbg !752

if.end:                                           ; preds = %if.then, %entry
  %2 = load i16, i16* %b.addr, align 2, !dbg !753
  %cmp1 = icmp slt i16 %2, 0, !dbg !755
  br i1 %cmp1, label %if.then.2, label %if.end.4, !dbg !756

if.then.2:                                        ; preds = %if.end
  %3 = load i16, i16* %b.addr, align 2, !dbg !757
  %sub3 = sub nsw i16 0, %3, !dbg !758
  store i16 %sub3, i16* %b.addr, align 2, !dbg !759
  br label %if.end.4, !dbg !760

if.end.4:                                         ; preds = %if.then.2, %if.end
  %4 = load i16, i16* %a.addr, align 2, !dbg !761
  %5 = load i16, i16* %b.addr, align 2, !dbg !762
  %call = call zeroext i16 @udivmodhi4(i16 zeroext %4, i16 zeroext %5, i16 signext 1), !dbg !763
  store i16 %call, i16* %res, align 2, !dbg !764
  %6 = load i16, i16* %neg, align 2, !dbg !765
  %tobool = icmp ne i16 %6, 0, !dbg !765
  br i1 %tobool, label %if.then.5, label %if.end.7, !dbg !767

if.then.5:                                        ; preds = %if.end.4
  %7 = load i16, i16* %res, align 2, !dbg !768
  %sub6 = sub nsw i16 0, %7, !dbg !769
  store i16 %sub6, i16* %res, align 2, !dbg !770
  br label %if.end.7, !dbg !771

if.end.7:                                         ; preds = %if.then.5, %if.end.4
  %8 = load i16, i16* %res, align 2, !dbg !772
  ret i16 %8, !dbg !773
}

; Function Attrs: nounwind
define signext i16 @__udivhi3(i16 signext %a, i16 signext %b) #0 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !774, metadata !178), !dbg !775
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !776, metadata !178), !dbg !777
  %0 = load i16, i16* %a.addr, align 2, !dbg !778
  %1 = load i16, i16* %b.addr, align 2, !dbg !779
  %call = call zeroext i16 @udivmodhi4(i16 zeroext %0, i16 zeroext %1, i16 signext 0), !dbg !780
  ret i16 %call, !dbg !781
}

; Function Attrs: nounwind
define signext i16 @__umodhi3(i16 signext %a, i16 signext %b) #0 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !782, metadata !178), !dbg !783
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !784, metadata !178), !dbg !785
  %0 = load i16, i16* %a.addr, align 2, !dbg !786
  %1 = load i16, i16* %b.addr, align 2, !dbg !787
  %call = call zeroext i16 @udivmodhi4(i16 zeroext %0, i16 zeroext %1, i16 signext 1), !dbg !788
  ret i16 %call, !dbg !789
}

; Function Attrs: nounwind
define void @checkpoint() #0 {
entry:
  %r12 = alloca i16, align 2
  call void @llvm.dbg.declare(metadata i16* %r12, metadata !790, metadata !178), !dbg !791
  call void asm sideeffect "PUSH R12", ""() #7, !dbg !792, !srcloc !793
  %0 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !794
  %cur_reg = getelementptr inbounds %struct._context_t, %struct._context_t* %0, i32 0, i32 0, !dbg !795
  call void asm sideeffect "MOV $0, R12", "=*m"(i16** %cur_reg) #7, !dbg !796, !srcloc !797
  call void asm sideeffect "MOV 26(R1), 0(R12)", ""() #7, !dbg !798, !srcloc !799
  call void asm sideeffect "MOV R1, 2(R12)", ""() #7, !dbg !800, !srcloc !801
  call void asm sideeffect "ADD #28, 2(R12)", ""() #7, !dbg !802, !srcloc !803
  call void asm sideeffect "MOV R2, 4(R12)", ""() #7, !dbg !804, !srcloc !805
  call void asm sideeffect "MOV 24(R1), 6(R12)", ""() #7, !dbg !806, !srcloc !807
  call void asm sideeffect "MOV R5, 8(R12)", ""() #7, !dbg !808, !srcloc !809
  call void asm sideeffect "MOV R6, 10(R12)", ""() #7, !dbg !810, !srcloc !811
  call void asm sideeffect "MOV R7, 12(R12)", ""() #7, !dbg !812, !srcloc !813
  call void asm sideeffect "MOV R8, 14(R12)", ""() #7, !dbg !814, !srcloc !815
  call void asm sideeffect "MOV R9, 16(R12)", ""() #7, !dbg !816, !srcloc !817
  call void asm sideeffect "MOV R10, 18(R12)", ""() #7, !dbg !818, !srcloc !819
  call void asm sideeffect "MOV R11, 20(R12)", ""() #7, !dbg !820, !srcloc !821
  call void asm sideeffect "MOV R12, $0", "=*m"(i16* %r12) #7, !dbg !822, !srcloc !823
  call void asm sideeffect "MOV $0, R12", "=*m"(i16* %r12) #7, !dbg !824, !srcloc !825
  call void asm sideeffect "MOV 4(R12), R2", ""() #7, !dbg !826, !srcloc !827
  call void asm sideeffect "POP R12", ""() #7, !dbg !828, !srcloc !829
  ret void, !dbg !830
}

; Function Attrs: nounwind
define void @restore_regs() #0 {
entry:
  %prev_ctx = alloca %struct._context_t*, align 2
  %pc = alloca i16, align 2
  call void @llvm.dbg.declare(metadata %struct._context_t** %prev_ctx, metadata !831, metadata !178), !dbg !832
  call void @llvm.dbg.declare(metadata i16* %pc, metadata !833, metadata !178), !dbg !834
  %0 = load i8, i8* @chkpt_ever_taken, align 1, !dbg !835
  %tobool = icmp ne i8 %0, 0, !dbg !835
  br i1 %tobool, label %if.else, label %if.then, !dbg !837

if.then:                                          ; preds = %entry
  %1 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !838
  %cur_reg = getelementptr inbounds %struct._context_t, %struct._context_t* %1, i32 0, i32 0, !dbg !840
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @regs_0, i32 0, i32 0), i16** %cur_reg, align 2, !dbg !841
  store i8 1, i8* @chkpt_ever_taken, align 1, !dbg !842
  br label %return, !dbg !843

if.else:                                          ; preds = %entry
  %2 = load volatile %struct._context_t*, %struct._context_t** @curctx, align 2, !dbg !844
  %cmp = icmp eq %struct._context_t* %2, @context_0, !dbg !846
  br i1 %cmp, label %if.then.1, label %if.else.2, !dbg !847

if.then.1:                                        ; preds = %if.else
  store %struct._context_t* @context_1, %struct._context_t** %prev_ctx, align 2, !dbg !848
  br label %if.end, !dbg !850

if.else.2:                                        ; preds = %if.else
  store %struct._context_t* @context_0, %struct._context_t** %prev_ctx, align 2, !dbg !851
  br label %if.end

if.end:                                           ; preds = %if.else.2, %if.then.1
  br label %if.end.3

if.end.3:                                         ; preds = %if.end
  %3 = load %struct._context_t*, %struct._context_t** %prev_ctx, align 2, !dbg !853
  %cur_reg4 = getelementptr inbounds %struct._context_t, %struct._context_t* %3, i32 0, i32 0, !dbg !854
  call void asm sideeffect "MOV $0, R12", "=*m"(i16** %cur_reg4) #7, !dbg !855, !srcloc !856
  call void asm sideeffect "MOV 20(R12), R11", ""() #7, !dbg !857, !srcloc !858
  call void asm sideeffect "MOV 18(R12), R10", ""() #7, !dbg !859, !srcloc !860
  call void asm sideeffect "MOV 16(R12), R9", ""() #7, !dbg !861, !srcloc !862
  call void asm sideeffect "MOV 14(R12), R8", ""() #7, !dbg !863, !srcloc !864
  call void asm sideeffect "MOV 12(R12), R7", ""() #7, !dbg !865, !srcloc !866
  call void asm sideeffect "MOV 10(R12), R6", ""() #7, !dbg !867, !srcloc !868
  call void asm sideeffect "MOV 8(R12), R5", ""() #7, !dbg !869, !srcloc !870
  call void asm sideeffect "MOV 6(R12), R4", ""() #7, !dbg !871, !srcloc !872
  call void asm sideeffect "MOV 4(R12), R2", ""() #7, !dbg !873, !srcloc !874
  call void asm sideeffect "MOV 2(R12), R1", ""() #7, !dbg !875, !srcloc !876
  call void asm sideeffect "MOV 0(R12), $0", "=*m"(i16* %pc) #7, !dbg !877, !srcloc !878
  call void asm sideeffect "MOV $0, R0", "=*m"(i16* %pc) #7, !dbg !879, !srcloc !880
  br label %return, !dbg !881

return:                                           ; preds = %if.end.3, %if.then
  ret void, !dbg !882
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { noinline nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { naked noinline nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!0, !68, !85, !87, !106, !110, !124, !131, !144, !146}
!llvm.ident = !{!174, !174, !174, !174, !174, !174, !174, !174, !174, !174}
!llvm.module.flags = !{!175, !176}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, retainedTypes: !3, subprograms: !6, globals: !64)
!1 = !DIFile(filename: "/home/reviewer/src/apps/auto-templog/src/main_cem.c", directory: "/home/reviewer/src/apps/auto-templog/bld/ratchet")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "index_t", file: !1, line: 59, baseType: !5)
!5 = !DIBasicType(name: "unsigned int", size: 16, align: 16, encoding: DW_ATE_unsigned)
!6 = !{!7, !10, !13, !26, !31, !49, !52, !55, !58, !59, !63}
!7 = distinct !DISubprogram(name: "__loop_bound__", scope: !1, file: !1, line: 32, type: !8, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, function: void (i16)* @__loop_bound__, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !5}
!10 = distinct !DISubprogram(name: "TimerB1_ISR", scope: !1, file: !1, line: 36, type: !11, isLocal: false, isDefinition: true, scopeLine: 36, flags: DIFlagPrototyped, isOptimized: false, function: void ()* @TimerB1_ISR, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = distinct !DISubprogram(name: "print_log", scope: !1, file: !1, line: 80, type: !14, isLocal: false, isDefinition: true, scopeLine: 81, flags: DIFlagPrototyped, isOptimized: false, function: void (%struct._log_t*)* @print_log, variables: !2)
!14 = !DISubroutineType(types: !15)
!15 = !{null, !16}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 16, align: 16)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "log_t", file: !1, line: 78, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_structure_type, name: "_log_t", file: !1, line: 74, size: 1056, align: 16, elements: !19)
!19 = !{!20, !24, !25}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !18, file: !1, line: 75, baseType: !21, size: 1024, align: 16)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 1024, align: 16, elements: !22)
!22 = !{!23}
!23 = !DISubrange(count: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "count", scope: !18, file: !1, line: 76, baseType: !5, size: 16, align: 16, offset: 1024)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "sample_count", scope: !18, file: !1, line: 77, baseType: !5, size: 16, align: 16, offset: 1040)
!26 = distinct !DISubprogram(name: "acquire_sample", scope: !1, file: !1, line: 117, type: !27, isLocal: false, isDefinition: true, scopeLine: 118, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16)* @acquire_sample, variables: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!29, !30}
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "sample_t", file: !1, line: 61, baseType: !5)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "letter_t", file: !1, line: 60, baseType: !5)
!31 = distinct !DISubprogram(name: "init_dict", scope: !1, file: !1, line: 125, type: !32, isLocal: false, isDefinition: true, scopeLine: 126, flags: DIFlagPrototyped, isOptimized: false, function: void (%struct._dict_t*)* @init_dict, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 16, align: 16)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "dict_t", file: !1, line: 72, baseType: !36)
!36 = !DICompositeType(tag: DW_TAG_structure_type, name: "_dict_t", file: !1, line: 69, size: 24592, align: 16, elements: !37)
!37 = !{!38, !48}
!38 = !DIDerivedType(tag: DW_TAG_member, name: "nodes", scope: !36, file: !1, line: 70, baseType: !39, size: 24576, align: 16)
!39 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 24576, align: 16, elements: !46)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_t", file: !1, line: 67, baseType: !41)
!41 = !DICompositeType(tag: DW_TAG_structure_type, name: "_node_t", file: !1, line: 63, size: 48, align: 16, elements: !42)
!42 = !{!43, !44, !45}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "letter", scope: !41, file: !1, line: 64, baseType: !30, size: 16, align: 16)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "sibling", scope: !41, file: !1, line: 65, baseType: !4, size: 16, align: 16, offset: 16)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "child", scope: !41, file: !1, line: 66, baseType: !4, size: 16, align: 16, offset: 32)
!46 = !{!47}
!47 = !DISubrange(count: 512)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "node_count", scope: !36, file: !1, line: 71, baseType: !5, size: 16, align: 16, offset: 24576)
!49 = distinct !DISubprogram(name: "find_child", scope: !1, file: !1, line: 144, type: !50, isLocal: false, isDefinition: true, scopeLine: 145, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16, %struct._dict_t*)* @find_child, variables: !2)
!50 = !DISubroutineType(types: !51)
!51 = !{!4, !30, !4, !34}
!52 = distinct !DISubprogram(name: "add_node", scope: !1, file: !1, line: 176, type: !53, isLocal: false, isDefinition: true, scopeLine: 177, flags: DIFlagPrototyped, isOptimized: false, function: void (i16, i16, %struct._dict_t*)* @add_node, variables: !2)
!53 = !DISubroutineType(types: !54)
!54 = !{null, !30, !4, !34}
!55 = distinct !DISubprogram(name: "append_compressed", scope: !1, file: !1, line: 221, type: !56, isLocal: false, isDefinition: true, scopeLine: 222, flags: DIFlagPrototyped, isOptimized: false, function: void (i16, %struct._log_t*)* @append_compressed, variables: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{null, !4, !16}
!58 = distinct !DISubprogram(name: "init", scope: !1, file: !1, line: 227, type: !11, isLocal: false, isDefinition: true, scopeLine: 228, isOptimized: false, function: void ()* @init, variables: !2)
!59 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 257, type: !60, isLocal: false, isDefinition: true, scopeLine: 258, isOptimized: false, function: i16 ()* @main, variables: !2)
!60 = !DISubroutineType(types: !61)
!61 = !{!62}
!62 = !DIBasicType(name: "int", size: 16, align: 16, encoding: DW_ATE_signed)
!63 = distinct !DISubprogram(name: "init_hw", scope: !1, file: !1, line: 106, type: !11, isLocal: true, isDefinition: true, scopeLine: 107, isOptimized: false, function: void ()* @init_hw, variables: !2)
!64 = !{!65, !66}
!65 = !DIGlobalVariable(name: "overflow", scope: !0, file: !1, line: 33, type: !5, isLocal: false, isDefinition: true, variable: i16* @overflow)
!66 = !DIGlobalVariable(name: "__vector_timer0_b1", scope: !0, file: !1, line: 46, type: !67, isLocal: false, isDefinition: true, variable: void ()** @__vector_timer0_b1)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 16, align: 16)
!68 = distinct !DICompileUnit(language: DW_LANG_C99, file: !69, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !70, globals: !83)
!69 = !DIFile(filename: "../../src/watchdog.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!70 = !{!71, !81, !82}
!71 = distinct !DISubprogram(name: "msp_watchdog_enable", scope: !69, file: !69, line: 7, type: !72, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: true, function: void (i8)* @msp_watchdog_enable, variables: !79)
!72 = !DISubroutineType(types: !73)
!73 = !{null, !74}
!74 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !75, line: 42, baseType: !76)
!75 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!76 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !77, line: 28, baseType: !78)
!77 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!78 = !DIBasicType(name: "unsigned char", size: 8, align: 8, encoding: DW_ATE_unsigned_char)
!79 = !{!80}
!80 = !DILocalVariable(name: "bits", arg: 1, scope: !71, file: !69, line: 7, type: !74)
!81 = distinct !DISubprogram(name: "msp_watchdog_disable", scope: !69, file: !69, line: 13, type: !11, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: true, function: void ()* @msp_watchdog_disable, variables: !2)
!82 = distinct !DISubprogram(name: "msp_watchdog_kick", scope: !69, file: !69, line: 18, type: !11, isLocal: false, isDefinition: true, scopeLine: 19, isOptimized: true, function: void ()* @msp_watchdog_kick, variables: !2)
!83 = !{!84}
!84 = !DIGlobalVariable(name: "watchdog_bits", scope: !68, file: !69, line: 5, type: !74, isLocal: true, isDefinition: true, variable: i8* @watchdog_bits)
!85 = distinct !DICompileUnit(language: DW_LANG_C99, file: !86, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2)
!86 = !DIFile(filename: "../../src/mspware/pmm.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!87 = distinct !DICompileUnit(language: DW_LANG_C99, file: !88, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, retainedTypes: !89, subprograms: !92)
!88 = !DIFile(filename: "../../src/mem.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!89 = !{!90}
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 16, align: 16)
!91 = !DIBasicType(name: "char", size: 8, align: 8, encoding: DW_ATE_signed_char)
!92 = !{!93}
!93 = distinct !DISubprogram(name: "memcpy", scope: !88, file: !88, line: 3, type: !94, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: true, function: i8* (i8*, i8*, i16)* @memcpy, variables: !101)
!94 = !DISubroutineType(types: !95)
!95 = !{!96, !96, !97, !99}
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 16, align: 16)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 16, align: 16)
!98 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !100, line: 212, baseType: !5)
!100 = !DIFile(filename: "/opt/ti/mspgcc/lib/gcc/msp430-elf/4.9.1/include/stddef.h", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!101 = !{!102, !103, !104, !105}
!102 = !DILocalVariable(name: "dest", arg: 1, scope: !93, file: !88, line: 3, type: !96)
!103 = !DILocalVariable(name: "src", arg: 2, scope: !93, file: !88, line: 3, type: !97)
!104 = !DILocalVariable(name: "n", arg: 3, scope: !93, file: !88, line: 3, type: !99)
!105 = !DILocalVariable(name: "i", scope: !93, file: !88, line: 5, type: !99)
!106 = distinct !DICompileUnit(language: DW_LANG_C99, file: !107, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !108)
!107 = !DIFile(filename: "../../src/clock.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmsp/bld/clang")
!108 = !{!109}
!109 = distinct !DISubprogram(name: "msp_clock_setup", scope: !107, file: !107, line: 8, type: !11, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: true, function: void ()* @msp_clock_setup, variables: !2)
!110 = distinct !DICompileUnit(language: DW_LANG_C99, file: !111, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !112)
!111 = !DIFile(filename: "../../src/mult.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmspmath/bld/clang")
!112 = !{!113}
!113 = distinct !DISubprogram(name: "mult16", scope: !111, file: !111, line: 13, type: !114, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, function: i32 (i16, i16)* @mult16, variables: !2)
!114 = !DISubroutineType(types: !115)
!115 = !{!116, !121, !121}
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !117, line: 66, baseType: !118)
!117 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/auto-templog/ext/libmspmath/bld/clang")
!118 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !119, line: 56, baseType: !120)
!119 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/auto-templog/ext/libmspmath/bld/clang")
!120 = !DIBasicType(name: "long unsigned int", size: 32, align: 16, encoding: DW_ATE_unsigned)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !117, line: 54, baseType: !122)
!122 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !119, line: 38, baseType: !123)
!123 = !DIBasicType(name: "unsigned short", size: 16, align: 16, encoding: DW_ATE_unsigned)
!124 = distinct !DICompileUnit(language: DW_LANG_C99, file: !125, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, retainedTypes: !126, subprograms: !127)
!125 = !DIFile(filename: "../../src/sqrt.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmspmath/bld/clang")
!126 = !{!116}
!127 = !{!128}
!128 = distinct !DISubprogram(name: "sqrt16", scope: !125, file: !125, line: 6, type: !129, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i32)* @sqrt16, variables: !2)
!129 = !DISubroutineType(types: !130)
!130 = !{!121, !116}
!131 = distinct !DICompileUnit(language: DW_LANG_C99, file: !132, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !133)
!132 = !DIFile(filename: "../../src/divmodhi3.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libmspmath/bld/clang")
!133 = !{!134, !138, !141, !142, !143}
!134 = distinct !DISubprogram(name: "udivmodhi4", scope: !132, file: !132, line: 30, type: !135, isLocal: false, isDefinition: true, scopeLine: 31, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16, i16)* @udivmodhi4, variables: !2)
!135 = !DISubroutineType(types: !136)
!136 = !{!123, !123, !123, !137}
!137 = !DIBasicType(name: "short", size: 16, align: 16, encoding: DW_ATE_signed)
!138 = distinct !DISubprogram(name: "__divhi3", scope: !132, file: !132, line: 57, type: !139, isLocal: false, isDefinition: true, scopeLine: 58, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16)* @__divhi3, variables: !2)
!139 = !DISubroutineType(types: !140)
!140 = !{!137, !137, !137}
!141 = distinct !DISubprogram(name: "__modhi3", scope: !132, file: !132, line: 83, type: !139, isLocal: false, isDefinition: true, scopeLine: 84, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16)* @__modhi3, variables: !2)
!142 = distinct !DISubprogram(name: "__udivhi3", scope: !132, file: !132, line: 106, type: !139, isLocal: false, isDefinition: true, scopeLine: 107, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16)* @__udivhi3, variables: !2)
!143 = distinct !DISubprogram(name: "__umodhi3", scope: !132, file: !132, line: 112, type: !139, isLocal: false, isDefinition: true, scopeLine: 113, flags: DIFlagPrototyped, isOptimized: false, function: i16 (i16, i16)* @__umodhi3, variables: !2)
!144 = distinct !DICompileUnit(language: DW_LANG_C99, file: !145, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2)
!145 = !DIFile(filename: "../../src/empty.c", directory: "/home/reviewer/src/apps/auto-templog/ext/libio/bld/clang")
!146 = distinct !DICompileUnit(language: DW_LANG_C99, file: !147, producer: "clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)", isOptimized: false, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !148, globals: !151)
!147 = !DIFile(filename: "../../src/ratchet.c", directory: "/home/reviewer/src/apps/auto-templog/ext/ratchet/RatchetRuntime/libratchet/bld/clang")
!148 = !{!149, !150}
!149 = distinct !DISubprogram(name: "checkpoint", scope: !147, file: !147, line: 24, type: !11, isLocal: false, isDefinition: true, scopeLine: 24, isOptimized: false, function: void ()* @checkpoint, variables: !2)
!150 = distinct !DISubprogram(name: "restore_regs", scope: !147, file: !147, line: 78, type: !11, isLocal: false, isDefinition: true, scopeLine: 78, isOptimized: false, function: void ()* @restore_regs, variables: !2)
!151 = !{!152, !159, !160, !163, !168, !173}
!152 = !DIGlobalVariable(name: "context_0", scope: !146, file: !147, line: 11, type: !153, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_0)
!153 = !DIDerivedType(tag: DW_TAG_typedef, name: "context_t", file: !154, line: 15, baseType: !155)
!154 = !DIFile(filename: "../../src/include/libratchet/ratchet.h", directory: "/home/reviewer/src/apps/auto-templog/ext/ratchet/RatchetRuntime/libratchet/bld/clang")
!155 = !DICompositeType(tag: DW_TAG_structure_type, name: "_context_t", file: !154, line: 11, size: 16, align: 16, elements: !156)
!156 = !{!157}
!157 = !DIDerivedType(tag: DW_TAG_member, name: "cur_reg", scope: !155, file: !154, line: 13, baseType: !158, size: 16, align: 16)
!158 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 16, align: 16)
!159 = !DIGlobalVariable(name: "context_1", scope: !146, file: !147, line: 14, type: !153, isLocal: false, isDefinition: true, variable: %struct._context_t* @context_1)
!160 = !DIGlobalVariable(name: "curctx", scope: !146, file: !147, line: 16, type: !161, isLocal: false, isDefinition: true, variable: %struct._context_t** @curctx)
!161 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !162)
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !153, size: 16, align: 16)
!163 = !DIGlobalVariable(name: "chkpt_ever_taken", scope: !146, file: !147, line: 18, type: !164, isLocal: false, isDefinition: true, variable: i8* @chkpt_ever_taken)
!164 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !165, line: 42, baseType: !166)
!165 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/stdint.h", directory: "/home/reviewer/src/apps/auto-templog/ext/ratchet/RatchetRuntime/libratchet/bld/clang")
!166 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !167, line: 28, baseType: !78)
!167 = !DIFile(filename: "/opt/ti/mspgcc/msp430-elf/include/machine/_default_types.h", directory: "/home/reviewer/src/apps/auto-templog/ext/ratchet/RatchetRuntime/libratchet/bld/clang")
!168 = !DIGlobalVariable(name: "regs_0", scope: !146, file: !147, line: 8, type: !169, isLocal: false, isDefinition: true, variable: [16 x i16]* @regs_0)
!169 = !DICompositeType(tag: DW_TAG_array_type, baseType: !170, size: 256, align: 16, elements: !171)
!170 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !5)
!171 = !{!172}
!172 = !DISubrange(count: 16)
!173 = !DIGlobalVariable(name: "regs_1", scope: !146, file: !147, line: 9, type: !169, isLocal: false, isDefinition: true, variable: [16 x i16]* @regs_1)
!174 = !{!"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"}
!175 = !{i32 2, !"Dwarf Version", i32 4}
!176 = !{i32 2, !"Debug Info Version", i32 3}
!177 = !DILocalVariable(name: "val", arg: 1, scope: !7, file: !1, line: 32, type: !5)
!178 = !DIExpression()
!179 = !DILocation(line: 32, column: 30, scope: !7)
!180 = !DILocation(line: 32, column: 35, scope: !7)
!181 = !DILocation(line: 37, column: 9, scope: !10)
!182 = !DILocation(line: 38, column: 6, scope: !183)
!183 = distinct !DILexicalBlock(scope: !10, file: !1, line: 38, column: 6)
!184 = !DILocation(line: 38, column: 6, scope: !10)
!185 = !DILocation(line: 39, column: 12, scope: !186)
!186 = distinct !DILexicalBlock(scope: !183, file: !1, line: 38, column: 22)
!187 = !DILocation(line: 40, column: 10, scope: !186)
!188 = !DILocation(line: 41, column: 10, scope: !186)
!189 = !DILocation(line: 42, column: 10, scope: !186)
!190 = !DILocation(line: 43, column: 3, scope: !186)
!191 = !DILocation(line: 44, column: 2, scope: !10)
!192 = !DILocalVariable(name: "log", arg: 1, scope: !13, file: !1, line: 80, type: !16)
!193 = !DILocation(line: 80, column: 23, scope: !13)
!194 = !DILocalVariable(name: "i", scope: !13, file: !1, line: 82, type: !5)
!195 = !DILocation(line: 82, column: 11, scope: !13)
!196 = !DILocation(line: 84, column: 2, scope: !13)
!197 = !DILocation(line: 86, column: 2, scope: !13)
!198 = !DILocation(line: 99, column: 2, scope: !13)
!199 = !DILocation(line: 101, column: 6, scope: !200)
!200 = distinct !DILexicalBlock(scope: !13, file: !1, line: 101, column: 6)
!201 = !DILocation(line: 101, column: 11, scope: !200)
!202 = !DILocation(line: 101, column: 24, scope: !200)
!203 = !DILocation(line: 101, column: 6, scope: !13)
!204 = !DILocation(line: 102, column: 3, scope: !205)
!205 = distinct !DILexicalBlock(scope: !200, file: !1, line: 101, column: 32)
!206 = !DILocation(line: 104, column: 1, scope: !13)
!207 = !DILocalVariable(name: "prev_sample", arg: 1, scope: !26, file: !1, line: 117, type: !30)
!208 = !DILocation(line: 117, column: 34, scope: !26)
!209 = !DILocalVariable(name: "sample", scope: !26, file: !1, line: 120, type: !30)
!210 = !DILocation(line: 120, column: 11, scope: !26)
!211 = !DILocation(line: 120, column: 21, scope: !26)
!212 = !DILocation(line: 120, column: 33, scope: !26)
!213 = !DILocation(line: 120, column: 38, scope: !26)
!214 = !DILocation(line: 121, column: 9, scope: !26)
!215 = !DILocation(line: 121, column: 2, scope: !26)
!216 = !DILocalVariable(name: "dict", arg: 1, scope: !31, file: !1, line: 125, type: !34)
!217 = !DILocation(line: 125, column: 24, scope: !31)
!218 = !DILocalVariable(name: "l", scope: !31, file: !1, line: 127, type: !30)
!219 = !DILocation(line: 127, column: 11, scope: !31)
!220 = !DILocation(line: 130, column: 2, scope: !31)
!221 = !DILocation(line: 130, column: 8, scope: !31)
!222 = !DILocation(line: 130, column: 19, scope: !31)
!223 = !DILocation(line: 132, column: 9, scope: !224)
!224 = distinct !DILexicalBlock(scope: !31, file: !1, line: 132, column: 2)
!225 = !DILocation(line: 132, column: 7, scope: !224)
!226 = !DILocation(line: 132, column: 14, scope: !227)
!227 = !DILexicalBlockFile(scope: !228, file: !1, discriminator: 2)
!228 = !DILexicalBlockFile(scope: !229, file: !1, discriminator: 1)
!229 = distinct !DILexicalBlock(scope: !224, file: !1, line: 132, column: 2)
!230 = !DILocation(line: 132, column: 16, scope: !229)
!231 = !DILocation(line: 132, column: 2, scope: !224)
!232 = !DILocalVariable(name: "node", scope: !233, file: !1, line: 133, type: !234)
!233 = distinct !DILexicalBlock(scope: !229, file: !1, line: 132, column: 36)
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 16, align: 16)
!235 = !DILocation(line: 133, column: 11, scope: !233)
!236 = !DILocation(line: 133, column: 31, scope: !233)
!237 = !DILocation(line: 133, column: 19, scope: !233)
!238 = !DILocation(line: 133, column: 25, scope: !233)
!239 = !DILocation(line: 134, column: 18, scope: !233)
!240 = !DILocation(line: 134, column: 3, scope: !233)
!241 = !DILocation(line: 134, column: 9, scope: !233)
!242 = !DILocation(line: 134, column: 16, scope: !233)
!243 = !DILocation(line: 135, column: 3, scope: !233)
!244 = !DILocation(line: 135, column: 9, scope: !233)
!245 = !DILocation(line: 135, column: 17, scope: !233)
!246 = !DILocation(line: 136, column: 3, scope: !233)
!247 = !DILocation(line: 136, column: 9, scope: !233)
!248 = !DILocation(line: 136, column: 15, scope: !233)
!249 = !DILocation(line: 138, column: 3, scope: !233)
!250 = !DILocation(line: 138, column: 9, scope: !233)
!251 = !DILocation(line: 138, column: 19, scope: !233)
!252 = !DILocation(line: 140, column: 2, scope: !233)
!253 = !DILocation(line: 132, column: 31, scope: !229)
!254 = !DILocation(line: 132, column: 2, scope: !229)
!255 = !DILocation(line: 141, column: 1, scope: !31)
!256 = !DILocalVariable(name: "letter", arg: 1, scope: !49, file: !1, line: 144, type: !30)
!257 = !DILocation(line: 144, column: 29, scope: !49)
!258 = !DILocalVariable(name: "parent", arg: 2, scope: !49, file: !1, line: 144, type: !4)
!259 = !DILocation(line: 144, column: 45, scope: !49)
!260 = !DILocalVariable(name: "dict", arg: 3, scope: !49, file: !1, line: 144, type: !34)
!261 = !DILocation(line: 144, column: 61, scope: !49)
!262 = !DILocalVariable(name: "parent_node", scope: !49, file: !1, line: 146, type: !234)
!263 = !DILocation(line: 146, column: 10, scope: !49)
!264 = !DILocation(line: 146, column: 37, scope: !49)
!265 = !DILocation(line: 146, column: 25, scope: !49)
!266 = !DILocation(line: 146, column: 31, scope: !49)
!267 = !DILocation(line: 150, column: 6, scope: !268)
!268 = distinct !DILexicalBlock(scope: !49, file: !1, line: 150, column: 6)
!269 = !DILocation(line: 150, column: 19, scope: !268)
!270 = !DILocation(line: 150, column: 25, scope: !268)
!271 = !DILocation(line: 150, column: 6, scope: !49)
!272 = !DILocation(line: 152, column: 3, scope: !273)
!273 = distinct !DILexicalBlock(scope: !268, file: !1, line: 150, column: 33)
!274 = !DILocalVariable(name: "sibling", scope: !49, file: !1, line: 155, type: !4)
!275 = !DILocation(line: 155, column: 10, scope: !49)
!276 = !DILocation(line: 155, column: 20, scope: !49)
!277 = !DILocation(line: 155, column: 33, scope: !49)
!278 = !DILocation(line: 156, column: 2, scope: !49)
!279 = !DILocation(line: 156, column: 9, scope: !280)
!280 = !DILexicalBlockFile(scope: !281, file: !1, discriminator: 2)
!281 = !DILexicalBlockFile(scope: !49, file: !1, discriminator: 1)
!282 = !DILocation(line: 156, column: 29, scope: !49)
!283 = !DILocation(line: 156, column: 37, scope: !49)
!284 = !DILocalVariable(name: "sibling_node", scope: !285, file: !1, line: 158, type: !234)
!285 = distinct !DILexicalBlock(scope: !49, file: !1, line: 156, column: 45)
!286 = !DILocation(line: 158, column: 11, scope: !285)
!287 = !DILocation(line: 158, column: 39, scope: !285)
!288 = !DILocation(line: 158, column: 27, scope: !285)
!289 = !DILocation(line: 158, column: 33, scope: !285)
!290 = !DILocation(line: 163, column: 7, scope: !291)
!291 = distinct !DILexicalBlock(scope: !285, file: !1, line: 163, column: 7)
!292 = !DILocation(line: 163, column: 21, scope: !291)
!293 = !DILocation(line: 163, column: 31, scope: !291)
!294 = !DILocation(line: 163, column: 28, scope: !291)
!295 = !DILocation(line: 163, column: 7, scope: !285)
!296 = !DILocation(line: 165, column: 11, scope: !297)
!297 = distinct !DILexicalBlock(scope: !291, file: !1, line: 163, column: 39)
!298 = !DILocation(line: 165, column: 4, scope: !297)
!299 = !DILocation(line: 167, column: 14, scope: !300)
!300 = distinct !DILexicalBlock(scope: !291, file: !1, line: 166, column: 10)
!301 = !DILocation(line: 167, column: 28, scope: !300)
!302 = !DILocation(line: 167, column: 12, scope: !300)
!303 = !DILocation(line: 172, column: 2, scope: !49)
!304 = !DILocation(line: 173, column: 1, scope: !49)
!305 = !DILocalVariable(name: "letter", arg: 1, scope: !52, file: !1, line: 176, type: !30)
!306 = !DILocation(line: 176, column: 24, scope: !52)
!307 = !DILocalVariable(name: "parent", arg: 2, scope: !52, file: !1, line: 176, type: !4)
!308 = !DILocation(line: 176, column: 40, scope: !52)
!309 = !DILocalVariable(name: "dict", arg: 3, scope: !52, file: !1, line: 176, type: !34)
!310 = !DILocation(line: 176, column: 56, scope: !52)
!311 = !DILocation(line: 178, column: 6, scope: !312)
!312 = distinct !DILexicalBlock(scope: !52, file: !1, line: 178, column: 6)
!313 = !DILocation(line: 178, column: 12, scope: !312)
!314 = !DILocation(line: 178, column: 23, scope: !312)
!315 = !DILocation(line: 178, column: 6, scope: !52)
!316 = !DILocation(line: 180, column: 3, scope: !317)
!317 = distinct !DILexicalBlock(scope: !312, file: !1, line: 178, column: 37)
!318 = !DILocation(line: 180, column: 3, scope: !319)
!319 = !DILexicalBlockFile(scope: !320, file: !1, discriminator: 1)
!320 = distinct !DILexicalBlock(scope: !317, file: !1, line: 180, column: 3)
!321 = !DILocation(line: 183, column: 2, scope: !317)
!322 = !DILocalVariable(name: "node", scope: !52, file: !1, line: 185, type: !234)
!323 = !DILocation(line: 185, column: 10, scope: !52)
!324 = !DILocation(line: 185, column: 30, scope: !52)
!325 = !DILocation(line: 185, column: 36, scope: !52)
!326 = !DILocation(line: 185, column: 18, scope: !52)
!327 = !DILocation(line: 185, column: 24, scope: !52)
!328 = !DILocation(line: 187, column: 17, scope: !52)
!329 = !DILocation(line: 187, column: 2, scope: !52)
!330 = !DILocation(line: 187, column: 8, scope: !52)
!331 = !DILocation(line: 187, column: 15, scope: !52)
!332 = !DILocation(line: 188, column: 2, scope: !52)
!333 = !DILocation(line: 188, column: 8, scope: !52)
!334 = !DILocation(line: 188, column: 16, scope: !52)
!335 = !DILocation(line: 189, column: 2, scope: !52)
!336 = !DILocation(line: 189, column: 8, scope: !52)
!337 = !DILocation(line: 189, column: 14, scope: !52)
!338 = !DILocalVariable(name: "node_index", scope: !52, file: !1, line: 191, type: !4)
!339 = !DILocation(line: 191, column: 10, scope: !52)
!340 = !DILocation(line: 191, column: 23, scope: !52)
!341 = !DILocation(line: 191, column: 29, scope: !52)
!342 = !DILocation(line: 191, column: 39, scope: !52)
!343 = !DILocalVariable(name: "child", scope: !52, file: !1, line: 193, type: !4)
!344 = !DILocation(line: 193, column: 10, scope: !52)
!345 = !DILocation(line: 193, column: 30, scope: !52)
!346 = !DILocation(line: 193, column: 18, scope: !52)
!347 = !DILocation(line: 193, column: 24, scope: !52)
!348 = !DILocation(line: 193, column: 38, scope: !52)
!349 = !DILocation(line: 198, column: 6, scope: !350)
!350 = distinct !DILexicalBlock(scope: !52, file: !1, line: 198, column: 6)
!351 = !DILocation(line: 198, column: 6, scope: !52)
!352 = !DILocalVariable(name: "sibling", scope: !353, file: !1, line: 202, type: !4)
!353 = distinct !DILexicalBlock(scope: !350, file: !1, line: 198, column: 13)
!354 = !DILocation(line: 202, column: 11, scope: !353)
!355 = !DILocation(line: 202, column: 21, scope: !353)
!356 = !DILocalVariable(name: "sibling_node", scope: !353, file: !1, line: 203, type: !234)
!357 = !DILocation(line: 203, column: 11, scope: !353)
!358 = !DILocation(line: 203, column: 39, scope: !353)
!359 = !DILocation(line: 203, column: 27, scope: !353)
!360 = !DILocation(line: 203, column: 33, scope: !353)
!361 = !DILocation(line: 204, column: 3, scope: !353)
!362 = !DILocation(line: 204, column: 10, scope: !363)
!363 = !DILexicalBlockFile(scope: !364, file: !1, discriminator: 2)
!364 = !DILexicalBlockFile(scope: !353, file: !1, discriminator: 1)
!365 = !DILocation(line: 204, column: 30, scope: !353)
!366 = !DILocation(line: 204, column: 44, scope: !353)
!367 = !DILocation(line: 204, column: 52, scope: !353)
!368 = !DILocation(line: 207, column: 14, scope: !369)
!369 = distinct !DILexicalBlock(scope: !353, file: !1, line: 204, column: 60)
!370 = !DILocation(line: 207, column: 28, scope: !369)
!371 = !DILocation(line: 207, column: 12, scope: !369)
!372 = !DILocation(line: 208, column: 32, scope: !369)
!373 = !DILocation(line: 208, column: 20, scope: !369)
!374 = !DILocation(line: 208, column: 26, scope: !369)
!375 = !DILocation(line: 208, column: 17, scope: !369)
!376 = !DILocation(line: 213, column: 34, scope: !353)
!377 = !DILocation(line: 213, column: 15, scope: !353)
!378 = !DILocation(line: 213, column: 3, scope: !353)
!379 = !DILocation(line: 213, column: 9, scope: !353)
!380 = !DILocation(line: 213, column: 24, scope: !353)
!381 = !DILocation(line: 213, column: 32, scope: !353)
!382 = !DILocation(line: 214, column: 2, scope: !353)
!383 = !DILocation(line: 216, column: 31, scope: !384)
!384 = distinct !DILexicalBlock(scope: !350, file: !1, line: 214, column: 9)
!385 = !DILocation(line: 216, column: 15, scope: !384)
!386 = !DILocation(line: 216, column: 3, scope: !384)
!387 = !DILocation(line: 216, column: 9, scope: !384)
!388 = !DILocation(line: 216, column: 23, scope: !384)
!389 = !DILocation(line: 216, column: 29, scope: !384)
!390 = !DILocation(line: 218, column: 1, scope: !52)
!391 = !DILocalVariable(name: "parent", arg: 1, scope: !55, file: !1, line: 221, type: !4)
!392 = !DILocation(line: 221, column: 32, scope: !55)
!393 = !DILocalVariable(name: "log", arg: 2, scope: !55, file: !1, line: 221, type: !16)
!394 = !DILocation(line: 221, column: 47, scope: !55)
!395 = !DILocation(line: 224, column: 28, scope: !55)
!396 = !DILocation(line: 224, column: 12, scope: !55)
!397 = !DILocation(line: 224, column: 17, scope: !55)
!398 = !DILocation(line: 224, column: 22, scope: !55)
!399 = !DILocation(line: 224, column: 2, scope: !55)
!400 = !DILocation(line: 224, column: 7, scope: !55)
!401 = !DILocation(line: 224, column: 26, scope: !55)
!402 = !DILocation(line: 225, column: 1, scope: !55)
!403 = !DILocation(line: 240, column: 2, scope: !58)
!404 = !DILocation(line: 244, column: 2, scope: !58)
!405 = !DILocation(line: 249, column: 2, scope: !58)
!406 = !{i32 -2146761777}
!407 = !DILocation(line: 251, column: 2, scope: !58)
!408 = !DILocation(line: 251, column: 2, scope: !409)
!409 = !DILexicalBlockFile(scope: !410, file: !1, discriminator: 1)
!410 = distinct !DILexicalBlock(scope: !58, file: !1, line: 251, column: 2)
!411 = !DILocalVariable(name: "i", scope: !412, file: !1, line: 252, type: !5)
!412 = distinct !DILexicalBlock(scope: !58, file: !1, line: 252, column: 2)
!413 = !DILocation(line: 252, column: 16, scope: !412)
!414 = !DILocation(line: 252, column: 7, scope: !412)
!415 = !DILocation(line: 252, column: 23, scope: !416)
!416 = !DILexicalBlockFile(scope: !417, file: !1, discriminator: 2)
!417 = !DILexicalBlockFile(scope: !418, file: !1, discriminator: 1)
!418 = distinct !DILexicalBlock(scope: !412, file: !1, line: 252, column: 2)
!419 = !DILocation(line: 252, column: 25, scope: !418)
!420 = !DILocation(line: 252, column: 2, scope: !412)
!421 = !DILocation(line: 254, column: 2, scope: !422)
!422 = distinct !DILexicalBlock(scope: !418, file: !1, line: 252, column: 42)
!423 = !DILocation(line: 252, column: 37, scope: !418)
!424 = !DILocation(line: 252, column: 2, scope: !418)
!425 = !DILocation(line: 255, column: 1, scope: !58)
!426 = !DILocation(line: 260, column: 2, scope: !59)
!427 = !DILocalVariable(name: "dict", scope: !59, file: !1, line: 266, type: !35)
!428 = !DILocation(line: 266, column: 9, scope: !59)
!429 = !DILocalVariable(name: "log", scope: !59, file: !1, line: 267, type: !17)
!430 = !DILocation(line: 267, column: 8, scope: !59)
!431 = !DILocation(line: 269, column: 2, scope: !59)
!432 = !DILocation(line: 270, column: 3, scope: !433)
!433 = distinct !DILexicalBlock(scope: !59, file: !1, line: 269, column: 12)
!434 = !DILocation(line: 272, column: 3, scope: !433)
!435 = !DILocation(line: 272, column: 3, scope: !436)
!436 = !DILexicalBlockFile(scope: !437, file: !1, discriminator: 1)
!437 = distinct !DILexicalBlock(scope: !433, file: !1, line: 272, column: 3)
!438 = !DILocation(line: 276, column: 3, scope: !433)
!439 = !DILocalVariable(name: "letter", scope: !433, file: !1, line: 280, type: !30)
!440 = !DILocation(line: 280, column: 12, scope: !433)
!441 = !DILocalVariable(name: "letter_idx", scope: !433, file: !1, line: 282, type: !5)
!442 = !DILocation(line: 282, column: 12, scope: !433)
!443 = !DILocalVariable(name: "parent", scope: !433, file: !1, line: 283, type: !4)
!444 = !DILocation(line: 283, column: 11, scope: !433)
!445 = !DILocalVariable(name: "child", scope: !433, file: !1, line: 283, type: !4)
!446 = !DILocation(line: 283, column: 19, scope: !433)
!447 = !DILocalVariable(name: "sample", scope: !433, file: !1, line: 284, type: !29)
!448 = !DILocation(line: 284, column: 12, scope: !433)
!449 = !DILocalVariable(name: "prev_sample", scope: !433, file: !1, line: 284, type: !29)
!450 = !DILocation(line: 284, column: 20, scope: !433)
!451 = !DILocation(line: 286, column: 7, scope: !433)
!452 = !DILocation(line: 286, column: 20, scope: !433)
!453 = !DILocation(line: 287, column: 7, scope: !433)
!454 = !DILocation(line: 287, column: 13, scope: !433)
!455 = !DILocation(line: 289, column: 3, scope: !433)
!456 = !DILocation(line: 290, column: 4, scope: !457)
!457 = distinct !DILexicalBlock(scope: !433, file: !1, line: 289, column: 13)
!458 = !DILocation(line: 292, column: 21, scope: !457)
!459 = !DILocation(line: 292, column: 10, scope: !457)
!460 = !DILocation(line: 296, column: 8, scope: !461)
!461 = distinct !DILexicalBlock(scope: !457, file: !1, line: 296, column: 8)
!462 = !DILocation(line: 296, column: 19, scope: !461)
!463 = !DILocation(line: 296, column: 8, scope: !457)
!464 = !DILocation(line: 297, column: 29, scope: !465)
!465 = distinct !DILexicalBlock(scope: !461, file: !1, line: 296, column: 25)
!466 = !DILocation(line: 297, column: 14, scope: !465)
!467 = !DILocation(line: 297, column: 12, scope: !465)
!468 = !DILocation(line: 298, column: 19, scope: !465)
!469 = !DILocation(line: 298, column: 17, scope: !465)
!470 = !DILocation(line: 299, column: 4, scope: !465)
!471 = !DILocation(line: 302, column: 14, scope: !457)
!472 = !DILocation(line: 303, column: 8, scope: !473)
!473 = distinct !DILexicalBlock(scope: !457, file: !1, line: 303, column: 8)
!474 = !DILocation(line: 303, column: 19, scope: !473)
!475 = !DILocation(line: 303, column: 8, scope: !457)
!476 = !DILocation(line: 304, column: 16, scope: !473)
!477 = !DILocation(line: 304, column: 5, scope: !473)
!478 = !DILocation(line: 305, column: 4, scope: !457)
!479 = !DILocation(line: 306, column: 5, scope: !480)
!480 = distinct !DILexicalBlock(scope: !457, file: !1, line: 305, column: 7)
!481 = !DILocalVariable(name: "letter_idx_tmp", scope: !480, file: !1, line: 308, type: !5)
!482 = !DILocation(line: 308, column: 14, scope: !480)
!483 = !DILocation(line: 308, column: 32, scope: !480)
!484 = !DILocation(line: 308, column: 43, scope: !480)
!485 = !DILocation(line: 308, column: 31, scope: !480)
!486 = !DILocation(line: 308, column: 31, scope: !487)
!487 = !DILexicalBlockFile(scope: !480, file: !1, discriminator: 1)
!488 = !DILocation(line: 308, column: 75, scope: !489)
!489 = !DILexicalBlockFile(scope: !480, file: !1, discriminator: 2)
!490 = !DILocation(line: 308, column: 86, scope: !480)
!491 = !DILocation(line: 308, column: 14, scope: !492)
!492 = !DILexicalBlockFile(scope: !493, file: !1, discriminator: 4)
!493 = !DILexicalBlockFile(scope: !480, file: !1, discriminator: 3)
!494 = !DILocalVariable(name: "letter_shift", scope: !480, file: !1, line: 310, type: !5)
!495 = !DILocation(line: 310, column: 14, scope: !480)
!496 = !DILocation(line: 310, column: 48, scope: !480)
!497 = !DILocation(line: 310, column: 46, scope: !480)
!498 = !DILocation(line: 311, column: 15, scope: !480)
!499 = !DILocation(line: 311, column: 40, scope: !480)
!500 = !DILocation(line: 311, column: 37, scope: !480)
!501 = !DILocation(line: 311, column: 22, scope: !480)
!502 = !DILocation(line: 311, column: 58, scope: !480)
!503 = !DILocation(line: 311, column: 55, scope: !480)
!504 = !DILocation(line: 311, column: 12, scope: !480)
!505 = !DILocation(line: 317, column: 9, scope: !480)
!506 = !DILocation(line: 317, column: 21, scope: !480)
!507 = !DILocation(line: 318, column: 14, scope: !480)
!508 = !DILocation(line: 318, column: 12, scope: !480)
!509 = !DILocation(line: 319, column: 24, scope: !480)
!510 = !DILocation(line: 319, column: 32, scope: !480)
!511 = !DILocation(line: 319, column: 13, scope: !480)
!512 = !DILocation(line: 319, column: 11, scope: !480)
!513 = !DILocation(line: 322, column: 4, scope: !480)
!514 = !DILocation(line: 322, column: 13, scope: !515)
!515 = !DILexicalBlockFile(scope: !457, file: !1, discriminator: 1)
!516 = !DILocation(line: 322, column: 19, scope: !457)
!517 = !DILocation(line: 324, column: 22, scope: !457)
!518 = !DILocation(line: 324, column: 4, scope: !457)
!519 = !DILocation(line: 326, column: 13, scope: !457)
!520 = !DILocation(line: 326, column: 21, scope: !457)
!521 = !DILocation(line: 326, column: 4, scope: !457)
!522 = !DILocation(line: 328, column: 12, scope: !523)
!523 = distinct !DILexicalBlock(scope: !457, file: !1, line: 328, column: 8)
!524 = !DILocation(line: 328, column: 18, scope: !523)
!525 = !DILocation(line: 328, column: 8, scope: !457)
!526 = !DILocation(line: 329, column: 5, scope: !527)
!527 = distinct !DILexicalBlock(scope: !523, file: !1, line: 328, column: 33)
!528 = !DILocation(line: 330, column: 9, scope: !527)
!529 = !DILocation(line: 330, column: 15, scope: !527)
!530 = !DILocation(line: 331, column: 9, scope: !527)
!531 = !DILocation(line: 331, column: 22, scope: !527)
!532 = !DILocation(line: 334, column: 5, scope: !527)
!533 = !DILocation(line: 334, column: 5, scope: !534)
!534 = !DILexicalBlockFile(scope: !535, file: !1, discriminator: 1)
!535 = distinct !DILexicalBlock(scope: !527, file: !1, line: 334, column: 5)
!536 = !DILocation(line: 354, column: 5, scope: !527)
!537 = !DILocation(line: 361, column: 1, scope: !59)
!538 = !DILocation(line: 108, column: 2, scope: !63)
!539 = !DILocation(line: 109, column: 2, scope: !63)
!540 = !DILocation(line: 110, column: 2, scope: !63)
!541 = !DILocation(line: 111, column: 1, scope: !63)
!542 = !DILocation(line: 7, column: 34, scope: !71)
!543 = !DILocation(line: 9, column: 33, scope: !71)
!544 = !DILocation(line: 9, column: 31, scope: !71)
!545 = !DILocation(line: 9, column: 12, scope: !71)
!546 = !{!547, !547, i64 0}
!547 = !{!"int", !548, i64 0}
!548 = !{!"omnipotent char", !549, i64 0}
!549 = !{!"Simple C/C++ TBAA"}
!550 = !DILocation(line: 10, column: 19, scope: !71)
!551 = !{!548, !548, i64 0}
!552 = !DILocation(line: 11, column: 1, scope: !71)
!553 = !DILocation(line: 15, column: 13, scope: !81)
!554 = !DILocation(line: 16, column: 1, scope: !81)
!555 = !DILocation(line: 20, column: 33, scope: !82)
!556 = !DILocation(line: 20, column: 31, scope: !82)
!557 = !DILocation(line: 20, column: 12, scope: !82)
!558 = !DILocation(line: 21, column: 1, scope: !82)
!559 = !DILocation(line: 3, column: 20, scope: !93)
!560 = !DILocation(line: 3, column: 38, scope: !93)
!561 = !DILocation(line: 3, column: 50, scope: !93)
!562 = !DILocation(line: 5, column: 12, scope: !93)
!563 = !DILocation(line: 6, column: 14, scope: !93)
!564 = !DILocation(line: 6, column: 5, scope: !93)
!565 = !DILocation(line: 7, column: 45, scope: !566)
!566 = distinct !DILexicalBlock(scope: !93, file: !88, line: 6, column: 19)
!567 = !DILocation(line: 7, column: 31, scope: !566)
!568 = !DILocation(line: 7, column: 24, scope: !566)
!569 = !DILocation(line: 7, column: 29, scope: !566)
!570 = !DILocation(line: 8, column: 9, scope: !566)
!571 = !DILocation(line: 10, column: 5, scope: !93)
!572 = !DILocation(line: 147, column: 14, scope: !109)
!573 = !DILocation(line: 162, column: 12, scope: !109)
!574 = !DILocation(line: 163, column: 12, scope: !109)
!575 = !DILocation(line: 168, column: 1, scope: !109)
!576 = !DILocation(line: 26, column: 5, scope: !113)
!577 = !{i32 992, i32 1022, i32 1051, i32 1080, i32 1109}
!578 = !DILocation(line: 44, column: 1, scope: !113)
!579 = !DILocalVariable(name: "x", arg: 1, scope: !128, file: !125, line: 6, type: !116)
!580 = !DILocation(line: 6, column: 26, scope: !128)
!581 = !DILocalVariable(name: "hi", scope: !128, file: !125, line: 8, type: !121)
!582 = !DILocation(line: 8, column: 14, scope: !128)
!583 = !DILocalVariable(name: "lo", scope: !128, file: !125, line: 9, type: !121)
!584 = !DILocation(line: 9, column: 14, scope: !128)
!585 = !DILocalVariable(name: "mid", scope: !128, file: !125, line: 10, type: !121)
!586 = !DILocation(line: 10, column: 14, scope: !128)
!587 = !DILocation(line: 10, column: 31, scope: !128)
!588 = !DILocation(line: 10, column: 21, scope: !128)
!589 = !DILocation(line: 10, column: 46, scope: !128)
!590 = !DILocation(line: 10, column: 36, scope: !128)
!591 = !DILocation(line: 10, column: 34, scope: !128)
!592 = !DILocation(line: 10, column: 50, scope: !128)
!593 = !DILocation(line: 10, column: 20, scope: !128)
!594 = !DILocalVariable(name: "s", scope: !128, file: !125, line: 11, type: !116)
!595 = !DILocation(line: 11, column: 14, scope: !128)
!596 = !DILocation(line: 13, column: 5, scope: !128)
!597 = !DILocation(line: 13, column: 12, scope: !598)
!598 = !DILexicalBlockFile(scope: !599, file: !125, discriminator: 4)
!599 = !DILexicalBlockFile(scope: !128, file: !125, discriminator: 1)
!600 = !DILocation(line: 13, column: 17, scope: !128)
!601 = !DILocation(line: 13, column: 14, scope: !128)
!602 = !DILocation(line: 13, column: 19, scope: !128)
!603 = !DILocation(line: 13, column: 22, scope: !604)
!604 = !DILexicalBlockFile(scope: !128, file: !125, discriminator: 2)
!605 = !DILocation(line: 13, column: 27, scope: !128)
!606 = !DILocation(line: 13, column: 25, scope: !128)
!607 = !DILocation(line: 13, column: 30, scope: !128)
!608 = !DILocation(line: 13, column: 5, scope: !609)
!609 = !DILexicalBlockFile(scope: !128, file: !125, discriminator: 3)
!610 = !DILocation(line: 14, column: 26, scope: !611)
!611 = distinct !DILexicalBlock(scope: !128, file: !125, line: 13, column: 35)
!612 = !DILocation(line: 14, column: 16, scope: !611)
!613 = !DILocation(line: 14, column: 41, scope: !611)
!614 = !DILocation(line: 14, column: 31, scope: !611)
!615 = !DILocation(line: 14, column: 29, scope: !611)
!616 = !DILocation(line: 14, column: 45, scope: !611)
!617 = !DILocation(line: 14, column: 15, scope: !611)
!618 = !DILocation(line: 14, column: 13, scope: !611)
!619 = !DILocation(line: 15, column: 20, scope: !611)
!620 = !DILocation(line: 15, column: 25, scope: !611)
!621 = !DILocation(line: 15, column: 13, scope: !611)
!622 = !DILocation(line: 15, column: 11, scope: !611)
!623 = !DILocation(line: 16, column: 13, scope: !624)
!624 = distinct !DILexicalBlock(scope: !611, file: !125, line: 16, column: 13)
!625 = !DILocation(line: 16, column: 17, scope: !624)
!626 = !DILocation(line: 16, column: 15, scope: !624)
!627 = !DILocation(line: 16, column: 13, scope: !611)
!628 = !DILocation(line: 17, column: 18, scope: !624)
!629 = !DILocation(line: 17, column: 16, scope: !624)
!630 = !DILocation(line: 17, column: 13, scope: !624)
!631 = !DILocation(line: 19, column: 18, scope: !624)
!632 = !DILocation(line: 19, column: 16, scope: !624)
!633 = !DILocation(line: 22, column: 12, scope: !128)
!634 = !DILocation(line: 22, column: 5, scope: !128)
!635 = !DILocalVariable(name: "num", arg: 1, scope: !134, file: !132, line: 30, type: !123)
!636 = !DILocation(line: 30, column: 28, scope: !134)
!637 = !DILocalVariable(name: "den", arg: 2, scope: !134, file: !132, line: 30, type: !123)
!638 = !DILocation(line: 30, column: 48, scope: !134)
!639 = !DILocalVariable(name: "modwanted", arg: 3, scope: !134, file: !132, line: 30, type: !137)
!640 = !DILocation(line: 30, column: 59, scope: !134)
!641 = !DILocalVariable(name: "bit", scope: !134, file: !132, line: 32, type: !123)
!642 = !DILocation(line: 32, column: 18, scope: !134)
!643 = !DILocalVariable(name: "res", scope: !134, file: !132, line: 33, type: !123)
!644 = !DILocation(line: 33, column: 18, scope: !134)
!645 = !DILocation(line: 35, column: 3, scope: !134)
!646 = !DILocation(line: 35, column: 10, scope: !647)
!647 = !DILexicalBlockFile(scope: !648, file: !132, discriminator: 6)
!648 = !DILexicalBlockFile(scope: !134, file: !132, discriminator: 1)
!649 = !DILocation(line: 35, column: 16, scope: !134)
!650 = !DILocation(line: 35, column: 14, scope: !134)
!651 = !DILocation(line: 35, column: 20, scope: !134)
!652 = !DILocation(line: 35, column: 23, scope: !653)
!653 = !DILexicalBlockFile(scope: !134, file: !132, discriminator: 2)
!654 = !DILocation(line: 35, column: 27, scope: !134)
!655 = !DILocation(line: 35, column: 32, scope: !656)
!656 = !DILexicalBlockFile(scope: !134, file: !132, discriminator: 4)
!657 = !DILocation(line: 35, column: 36, scope: !134)
!658 = !DILocation(line: 35, column: 30, scope: !134)
!659 = !DILocation(line: 35, column: 3, scope: !660)
!660 = !DILexicalBlockFile(scope: !661, file: !132, discriminator: 5)
!661 = !DILexicalBlockFile(scope: !134, file: !132, discriminator: 3)
!662 = !DILocation(line: 37, column: 11, scope: !663)
!663 = distinct !DILexicalBlock(scope: !134, file: !132, line: 36, column: 5)
!664 = !DILocation(line: 38, column: 11, scope: !663)
!665 = !DILocation(line: 40, column: 3, scope: !134)
!666 = !DILocation(line: 40, column: 10, scope: !667)
!667 = !DILexicalBlockFile(scope: !648, file: !132, discriminator: 2)
!668 = !DILocation(line: 42, column: 11, scope: !669)
!669 = distinct !DILexicalBlock(scope: !670, file: !132, line: 42, column: 11)
!670 = distinct !DILexicalBlock(scope: !134, file: !132, line: 41, column: 5)
!671 = !DILocation(line: 42, column: 18, scope: !669)
!672 = !DILocation(line: 42, column: 15, scope: !669)
!673 = !DILocation(line: 42, column: 11, scope: !670)
!674 = !DILocation(line: 44, column: 11, scope: !675)
!675 = distinct !DILexicalBlock(scope: !669, file: !132, line: 43, column: 2)
!676 = !DILocation(line: 44, column: 8, scope: !675)
!677 = !DILocation(line: 45, column: 11, scope: !675)
!678 = !DILocation(line: 45, column: 8, scope: !675)
!679 = !DILocation(line: 46, column: 2, scope: !675)
!680 = !DILocation(line: 47, column: 11, scope: !670)
!681 = !DILocation(line: 48, column: 11, scope: !670)
!682 = !DILocation(line: 51, column: 7, scope: !683)
!683 = distinct !DILexicalBlock(scope: !134, file: !132, line: 51, column: 7)
!684 = !DILocation(line: 51, column: 7, scope: !134)
!685 = !DILocation(line: 52, column: 12, scope: !683)
!686 = !DILocation(line: 52, column: 5, scope: !683)
!687 = !DILocation(line: 53, column: 10, scope: !134)
!688 = !DILocation(line: 53, column: 3, scope: !134)
!689 = !DILocation(line: 54, column: 1, scope: !134)
!690 = !DILocalVariable(name: "a", arg: 1, scope: !138, file: !132, line: 57, type: !137)
!691 = !DILocation(line: 57, column: 17, scope: !138)
!692 = !DILocalVariable(name: "b", arg: 2, scope: !138, file: !132, line: 57, type: !137)
!693 = !DILocation(line: 57, column: 26, scope: !138)
!694 = !DILocalVariable(name: "neg", scope: !138, file: !132, line: 59, type: !137)
!695 = !DILocation(line: 59, column: 9, scope: !138)
!696 = !DILocalVariable(name: "res", scope: !138, file: !132, line: 60, type: !137)
!697 = !DILocation(line: 60, column: 9, scope: !138)
!698 = !DILocation(line: 62, column: 7, scope: !699)
!699 = distinct !DILexicalBlock(scope: !138, file: !132, line: 62, column: 7)
!700 = !DILocation(line: 62, column: 9, scope: !699)
!701 = !DILocation(line: 62, column: 7, scope: !138)
!702 = !DILocation(line: 64, column: 12, scope: !703)
!703 = distinct !DILexicalBlock(scope: !699, file: !132, line: 63, column: 5)
!704 = !DILocation(line: 64, column: 11, scope: !703)
!705 = !DILocation(line: 64, column: 9, scope: !703)
!706 = !DILocation(line: 65, column: 14, scope: !703)
!707 = !DILocation(line: 65, column: 13, scope: !703)
!708 = !DILocation(line: 65, column: 11, scope: !703)
!709 = !DILocation(line: 66, column: 5, scope: !703)
!710 = !DILocation(line: 68, column: 7, scope: !711)
!711 = distinct !DILexicalBlock(scope: !138, file: !132, line: 68, column: 7)
!712 = !DILocation(line: 68, column: 9, scope: !711)
!713 = !DILocation(line: 68, column: 7, scope: !138)
!714 = !DILocation(line: 70, column: 12, scope: !715)
!715 = distinct !DILexicalBlock(scope: !711, file: !132, line: 69, column: 5)
!716 = !DILocation(line: 70, column: 11, scope: !715)
!717 = !DILocation(line: 70, column: 9, scope: !715)
!718 = !DILocation(line: 71, column: 14, scope: !715)
!719 = !DILocation(line: 71, column: 13, scope: !715)
!720 = !DILocation(line: 71, column: 11, scope: !715)
!721 = !DILocation(line: 72, column: 5, scope: !715)
!722 = !DILocation(line: 74, column: 21, scope: !138)
!723 = !DILocation(line: 74, column: 24, scope: !138)
!724 = !DILocation(line: 74, column: 9, scope: !138)
!725 = !DILocation(line: 74, column: 7, scope: !138)
!726 = !DILocation(line: 76, column: 7, scope: !727)
!727 = distinct !DILexicalBlock(scope: !138, file: !132, line: 76, column: 7)
!728 = !DILocation(line: 76, column: 7, scope: !138)
!729 = !DILocation(line: 77, column: 12, scope: !727)
!730 = !DILocation(line: 77, column: 11, scope: !727)
!731 = !DILocation(line: 77, column: 9, scope: !727)
!732 = !DILocation(line: 77, column: 5, scope: !727)
!733 = !DILocation(line: 79, column: 10, scope: !138)
!734 = !DILocation(line: 79, column: 3, scope: !138)
!735 = !DILocalVariable(name: "a", arg: 1, scope: !141, file: !132, line: 83, type: !137)
!736 = !DILocation(line: 83, column: 17, scope: !141)
!737 = !DILocalVariable(name: "b", arg: 2, scope: !141, file: !132, line: 83, type: !137)
!738 = !DILocation(line: 83, column: 26, scope: !141)
!739 = !DILocalVariable(name: "neg", scope: !141, file: !132, line: 85, type: !137)
!740 = !DILocation(line: 85, column: 9, scope: !141)
!741 = !DILocalVariable(name: "res", scope: !141, file: !132, line: 86, type: !137)
!742 = !DILocation(line: 86, column: 9, scope: !141)
!743 = !DILocation(line: 88, column: 7, scope: !744)
!744 = distinct !DILexicalBlock(scope: !141, file: !132, line: 88, column: 7)
!745 = !DILocation(line: 88, column: 9, scope: !744)
!746 = !DILocation(line: 88, column: 7, scope: !141)
!747 = !DILocation(line: 90, column: 12, scope: !748)
!748 = distinct !DILexicalBlock(scope: !744, file: !132, line: 89, column: 5)
!749 = !DILocation(line: 90, column: 11, scope: !748)
!750 = !DILocation(line: 90, column: 9, scope: !748)
!751 = !DILocation(line: 91, column: 11, scope: !748)
!752 = !DILocation(line: 92, column: 5, scope: !748)
!753 = !DILocation(line: 94, column: 7, scope: !754)
!754 = distinct !DILexicalBlock(scope: !141, file: !132, line: 94, column: 7)
!755 = !DILocation(line: 94, column: 9, scope: !754)
!756 = !DILocation(line: 94, column: 7, scope: !141)
!757 = !DILocation(line: 95, column: 10, scope: !754)
!758 = !DILocation(line: 95, column: 9, scope: !754)
!759 = !DILocation(line: 95, column: 7, scope: !754)
!760 = !DILocation(line: 95, column: 5, scope: !754)
!761 = !DILocation(line: 97, column: 21, scope: !141)
!762 = !DILocation(line: 97, column: 24, scope: !141)
!763 = !DILocation(line: 97, column: 9, scope: !141)
!764 = !DILocation(line: 97, column: 7, scope: !141)
!765 = !DILocation(line: 99, column: 7, scope: !766)
!766 = distinct !DILexicalBlock(scope: !141, file: !132, line: 99, column: 7)
!767 = !DILocation(line: 99, column: 7, scope: !141)
!768 = !DILocation(line: 100, column: 12, scope: !766)
!769 = !DILocation(line: 100, column: 11, scope: !766)
!770 = !DILocation(line: 100, column: 9, scope: !766)
!771 = !DILocation(line: 100, column: 5, scope: !766)
!772 = !DILocation(line: 102, column: 10, scope: !141)
!773 = !DILocation(line: 102, column: 3, scope: !141)
!774 = !DILocalVariable(name: "a", arg: 1, scope: !142, file: !132, line: 106, type: !137)
!775 = !DILocation(line: 106, column: 18, scope: !142)
!776 = !DILocalVariable(name: "b", arg: 2, scope: !142, file: !132, line: 106, type: !137)
!777 = !DILocation(line: 106, column: 27, scope: !142)
!778 = !DILocation(line: 108, column: 22, scope: !142)
!779 = !DILocation(line: 108, column: 25, scope: !142)
!780 = !DILocation(line: 108, column: 10, scope: !142)
!781 = !DILocation(line: 108, column: 3, scope: !142)
!782 = !DILocalVariable(name: "a", arg: 1, scope: !143, file: !132, line: 112, type: !137)
!783 = !DILocation(line: 112, column: 18, scope: !143)
!784 = !DILocalVariable(name: "b", arg: 2, scope: !143, file: !132, line: 112, type: !137)
!785 = !DILocation(line: 112, column: 27, scope: !143)
!786 = !DILocation(line: 114, column: 22, scope: !143)
!787 = !DILocation(line: 114, column: 25, scope: !143)
!788 = !DILocation(line: 114, column: 10, scope: !143)
!789 = !DILocation(line: 114, column: 3, scope: !143)
!790 = !DILocalVariable(name: "r12", scope: !149, file: !147, line: 25, type: !5)
!791 = !DILocation(line: 25, column: 11, scope: !149)
!792 = !DILocation(line: 34, column: 2, scope: !149)
!793 = !{i32 694}
!794 = !DILocation(line: 35, column: 40, scope: !149)
!795 = !DILocation(line: 35, column: 48, scope: !149)
!796 = !DILocation(line: 35, column: 2, scope: !149)
!797 = !{i32 764}
!798 = !DILocation(line: 38, column: 2, scope: !149)
!799 = !{i32 866}
!800 = !DILocation(line: 40, column: 2, scope: !149)
!801 = !{i32 942}
!802 = !DILocation(line: 41, column: 2, scope: !149)
!803 = !{i32 1020}
!804 = !DILocation(line: 44, column: 2, scope: !149)
!805 = !{i32 1183}
!806 = !DILocation(line: 45, column: 2, scope: !149)
!807 = !{i32 1221}
!808 = !DILocation(line: 46, column: 2, scope: !149)
!809 = !{i32 1269}
!810 = !DILocation(line: 47, column: 2, scope: !149)
!811 = !{i32 1307}
!812 = !DILocation(line: 48, column: 2, scope: !149)
!813 = !{i32 1346}
!814 = !DILocation(line: 49, column: 2, scope: !149)
!815 = !{i32 1385}
!816 = !DILocation(line: 50, column: 2, scope: !149)
!817 = !{i32 1424}
!818 = !DILocation(line: 51, column: 2, scope: !149)
!819 = !{i32 1463}
!820 = !DILocation(line: 52, column: 2, scope: !149)
!821 = !{i32 1503}
!822 = !DILocation(line: 62, column: 2, scope: !149)
!823 = !{i32 1880}
!824 = !DILocation(line: 65, column: 2, scope: !149)
!825 = !{i32 1947}
!826 = !DILocation(line: 66, column: 2, scope: !149)
!827 = !{i32 1992}
!828 = !DILocation(line: 71, column: 2, scope: !149)
!829 = !{i32 2189}
!830 = !DILocation(line: 72, column: 1, scope: !149)
!831 = !DILocalVariable(name: "prev_ctx", scope: !150, file: !147, line: 79, type: !162)
!832 = !DILocation(line: 79, column: 13, scope: !150)
!833 = !DILocalVariable(name: "pc", scope: !150, file: !147, line: 80, type: !5)
!834 = !DILocation(line: 80, column: 11, scope: !150)
!835 = !DILocation(line: 81, column: 7, scope: !836)
!836 = distinct !DILexicalBlock(scope: !150, file: !147, line: 81, column: 6)
!837 = !DILocation(line: 81, column: 6, scope: !150)
!838 = !DILocation(line: 82, column: 3, scope: !839)
!839 = distinct !DILexicalBlock(scope: !836, file: !147, line: 81, column: 25)
!840 = !DILocation(line: 82, column: 11, scope: !839)
!841 = !DILocation(line: 82, column: 19, scope: !839)
!842 = !DILocation(line: 83, column: 20, scope: !839)
!843 = !DILocation(line: 84, column: 3, scope: !839)
!844 = !DILocation(line: 86, column: 11, scope: !845)
!845 = distinct !DILexicalBlock(scope: !836, file: !147, line: 86, column: 11)
!846 = !DILocation(line: 86, column: 18, scope: !845)
!847 = !DILocation(line: 86, column: 11, scope: !836)
!848 = !DILocation(line: 87, column: 12, scope: !849)
!849 = distinct !DILexicalBlock(scope: !845, file: !147, line: 86, column: 33)
!850 = !DILocation(line: 88, column: 2, scope: !849)
!851 = !DILocation(line: 90, column: 12, scope: !852)
!852 = distinct !DILexicalBlock(scope: !845, file: !147, line: 89, column: 7)
!853 = !DILocation(line: 93, column: 40, scope: !150)
!854 = !DILocation(line: 93, column: 50, scope: !150)
!855 = !DILocation(line: 93, column: 2, scope: !150)
!856 = !{i32 2541}
!857 = !DILocation(line: 98, column: 2, scope: !150)
!858 = !{i32 2768}
!859 = !DILocation(line: 99, column: 2, scope: !150)
!860 = !{i32 2808}
!861 = !DILocation(line: 100, column: 2, scope: !150)
!862 = !{i32 2848}
!863 = !DILocation(line: 101, column: 2, scope: !150)
!864 = !{i32 2887}
!865 = !DILocation(line: 102, column: 2, scope: !150)
!866 = !{i32 2926}
!867 = !DILocation(line: 103, column: 2, scope: !150)
!868 = !{i32 2965}
!869 = !DILocation(line: 104, column: 2, scope: !150)
!870 = !{i32 3004}
!871 = !DILocation(line: 105, column: 2, scope: !150)
!872 = !{i32 3042}
!873 = !DILocation(line: 106, column: 2, scope: !150)
!874 = !{i32 3080}
!875 = !DILocation(line: 107, column: 2, scope: !150)
!876 = !{i32 3118}
!877 = !DILocation(line: 108, column: 2, scope: !150)
!878 = !{i32 3156}
!879 = !DILocation(line: 110, column: 2, scope: !150)
!880 = !{i32 3246}
!881 = !DILocation(line: 111, column: 1, scope: !150)
!882 = !DILocation(line: 111, column: 1, scope: !883)
!883 = !DILexicalBlockFile(scope: !150, file: !147, discriminator: 1)
