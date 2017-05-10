; ModuleID = 'main-ai.bc'
target datalayout = "e-m:e-p:16:16-i32:16:32-a:16-n8:16"
target triple = "msp430"

%struct.pubkey_t = type { [16 x i16], i16 }

@overflow = global i16 0, align 2
@"\010x03C0" = external global i16, align 2
@__vector_timer0_b1 = global void ()* @TimerB1_ISR, section "__interrupt_vector_timer0_b1", align 2
@.str = private unnamed_addr constant [6 x i8] c"%02x \00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"   \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"\0D\0A\00", align 1
@curtask = internal global i16 0, section ".nv_vars", align 2
@product = internal global [16 x i16] zeroinitializer, section ".nv_vars", align 2
@.str.5 = private unnamed_addr constant [39 x i8] c"reduce: normalizable: d=%u offset=%u\0D\0A\00", align 1
@.str.6 = private unnamed_addr constant [19 x i8] c"normalizable: %u\0D\0A\00", align 1
@.str.7 = private unnamed_addr constant [35 x i8] c"reduce: quotient: n_n=%x m[d]=%x\0D\0A\00", align 1
@.str.8 = private unnamed_addr constant [38 x i8] c"reduce quotient: m_dividend=%x q=%x\0D\0A\00", align 1
@.str.9 = private unnamed_addr constant [61 x i8] c"reduce: quotient: m[d]=%x m[d-1]=%x m[d-2]=%x n_q=%02x%02x\0D\0A\00", align 1
@.str.10 = private unnamed_addr constant [26 x i8] c"reduce: quotient: q0=%x\0D\0A\00", align 1
@.str.11 = private unnamed_addr constant [46 x i8] c"reduce: quotient: q=%x n_div=%x qn=%02x%02x\0D\0A\00", align 1
@.str.12 = private unnamed_addr constant [25 x i8] c"reduce: quotient: q=%x\0D\0A\00", align 1
@.str.13 = private unnamed_addr constant [30 x i8] c"reduce: multiply: offset=%u\0D\0A\00", align 1
@.str.14 = private unnamed_addr constant [35 x i8] c"reduce: subtract: d=%u offset=%u\0D\0A\00", align 1
@.str.15 = private unnamed_addr constant [26 x i8] c"reduce digits: p[%u]=%x\0D\0A\00", align 1
@.str.16 = private unnamed_addr constant [22 x i8] c"reduce digits: d=%x\0D\0A\00", align 1
@.str.17 = private unnamed_addr constant [34 x i8] c"reduce: done: message < modulus\0D\0A\00", align 1
@qxn = internal global [16 x i16] zeroinitializer, section ".nv_vars", align 2
@.str.18 = private unnamed_addr constant [16 x i8] c"mod exp: e=%x\0D\0A\00", align 1
@.str.19 = private unnamed_addr constant [17 x i8] c"Blk offset: %u\0D\0A\00", align 1
@in_block = internal global [16 x i16] zeroinitializer, section ".nv_vars", align 2
@PAD_DIGITS = internal constant [1 x i8] c"\01", section ".ro_nv_vars", align 1
@out_block = internal global [16 x i16] zeroinitializer, section ".nv_vars", align 2
@.str.20 = private unnamed_addr constant [7 x i8] c".%u.\0D\0A\00", align 1
@CYPHERTEXT = internal global [16 x i8] zeroinitializer, section ".nv_vars", align 1
@CYPHERTEXT_LEN = internal global i16 0, section ".nv_vars", align 2
@PLAINTEXT = internal constant [12 x i8] c".RRRSSSAAA.\00", section ".ro_nv_vars", align 1
@pubkey = internal constant %struct.pubkey_t { [16 x i16] [i16 21, i16 112, i16 246, i16 66, i16 14, i16 130, i16 113, i16 166, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0], i16 3 }, section ".ro_nv_vars", align 2
@.str.21 = private unnamed_addr constant [26 x i8] c"TIME end is 65536*%u+%u\0D\0A\00", align 1
@"\010x03D0" = external global i16, align 2
@.str.22 = private unnamed_addr constant [14 x i8] c"Cyphertext:\0D\0A\00", align 1
@"\010x0130" = external global i16, align 2
@llvm.used = appending global [1 x i8*] [i8* bitcast (void ()* @TimerB1_ISR to i8*)], section "llvm.metadata"

@__interrupt_vector_51 = alias void (), void ()* @TimerB1_ISR

; Function Attrs: noinline nounwind
define msp430_intrcc void @TimerB1_ISR() #0 {
entry:
  %0 = load volatile i16, i16* @"\010x03C0", align 2
  %and = and i16 %0, -3
  store volatile i16 %and, i16* @"\010x03C0", align 2
  %1 = load volatile i16, i16* @"\010x03C0", align 2
  %tobool = icmp ne i16 %1, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load i16, i16* @overflow, align 2
  %inc = add i16 %2, 1
  store i16 %inc, i16* @overflow, align 2
  %3 = load volatile i16, i16* @"\010x03C0", align 2
  %or = or i16 %3, 4
  store volatile i16 %or, i16* @"\010x03C0", align 2
  %4 = load volatile i16, i16* @"\010x03C0", align 2
  %or1 = or i16 %4, 2
  store volatile i16 %or1, i16* @"\010x03C0", align 2
  %5 = load volatile i16, i16* @"\010x03C0", align 2
  %and2 = and i16 %5, -2
  store volatile i16 %and2, i16* @"\010x03C0", align 2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @print_bigint(i16* %n, i16 %digits) #1 {
entry:
  %n.addr = alloca i16*, align 2
  %digits.addr = alloca i16, align 2
  %i = alloca i16, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %digits, i16* %digits.addr, align 2
  %0 = load i16, i16* %digits.addr, align 2
  %sub = sub i16 %0, 1
  store i16 %sub, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i16, i16* %i, align 2
  %cmp = icmp sge i16 %1, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i16, i16* %i, align 2
  %3 = load i16*, i16** %n.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %3, i16 %2
  %4 = load i16, i16* %arrayidx, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %4)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i16, i16* %i, align 2
  %dec = add nsw i16 %5, -1
  store i16 %dec, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare i16 @printf(i8*, ...) #2

; Function Attrs: alwaysinline nounwind
define void @log_bigint(i16* %n, i16 %digits) #1 {
entry:
  %n.addr = alloca i16*, align 2
  %digits.addr = alloca i16, align 2
  %i = alloca i16, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %digits, i16* %digits.addr, align 2
  %0 = load i16, i16* %digits.addr, align 2
  %sub = sub i16 %0, 1
  store i16 %sub, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i16, i16* %i, align 2
  %cmp = icmp sge i16 %1, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i16, i16* %i, align 2
  %3 = load i16*, i16** %n.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %3, i16 %2
  %4 = load i16, i16* %arrayidx, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %4)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i16, i16* %i, align 2
  %dec = add nsw i16 %5, -1
  store i16 %dec, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @print_hex_ascii(i8* %m, i16 %len) #1 {
entry:
  %m.addr = alloca i8*, align 2
  %len.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %j = alloca i16, align 2
  %c = alloca i8, align 1
  store i8* %m, i8** %m.addr, align 2
  store i16 %len, i16* %len.addr, align 2
  store i16 0, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc.38, %entry
  %0 = load i16, i16* %i, align 2
  %1 = load i16, i16* %len.addr, align 2
  %cmp = icmp ult i16 %0, %1
  br i1 %cmp, label %for.body, label %for.end.40

for.body:                                         ; preds = %for.cond
  store i16 0, i16* %j, align 2
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc, %for.body
  %2 = load i16, i16* %j, align 2
  %cmp2 = icmp slt i16 %2, 8
  br i1 %cmp2, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond.1
  %3 = load i16, i16* %i, align 2
  %4 = load i16, i16* %j, align 2
  %add = add nsw i16 %3, %4
  %5 = load i16, i16* %len.addr, align 2
  %cmp3 = icmp ult i16 %add, %5
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond.1
  %6 = phi i1 [ false, %for.cond.1 ], [ %cmp3, %land.rhs ]
  br i1 %6, label %for.body.4, label %for.end

for.body.4:                                       ; preds = %land.end
  %7 = load i16, i16* %i, align 2
  %8 = load i16, i16* %j, align 2
  %add5 = add nsw i16 %7, %8
  %9 = load i8*, i8** %m.addr, align 2
  %arrayidx = getelementptr inbounds i8, i8* %9, i16 %add5
  %10 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %10 to i16
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %conv)
  br label %for.inc

for.inc:                                          ; preds = %for.body.4
  %11 = load i16, i16* %j, align 2
  %inc = add nsw i16 %11, 1
  store i16 %inc, i16* %j, align 2
  br label %for.cond.1

for.end:                                          ; preds = %land.end
  br label %for.cond.6

for.cond.6:                                       ; preds = %for.inc.11, %for.end
  %12 = load i16, i16* %j, align 2
  %cmp7 = icmp slt i16 %12, 8
  br i1 %cmp7, label %for.body.9, label %for.end.13

for.body.9:                                       ; preds = %for.cond.6
  %call10 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0))
  br label %for.inc.11

for.inc.11:                                       ; preds = %for.body.9
  %13 = load i16, i16* %j, align 2
  %inc12 = add nsw i16 %13, 1
  store i16 %inc12, i16* %j, align 2
  br label %for.cond.6

for.end.13:                                       ; preds = %for.cond.6
  %call14 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i16 0, i16* %j, align 2
  br label %for.cond.15

for.cond.15:                                      ; preds = %for.inc.34, %for.end.13
  %14 = load i16, i16* %j, align 2
  %cmp16 = icmp slt i16 %14, 8
  br i1 %cmp16, label %land.rhs.18, label %land.end.22

land.rhs.18:                                      ; preds = %for.cond.15
  %15 = load i16, i16* %i, align 2
  %16 = load i16, i16* %j, align 2
  %add19 = add nsw i16 %15, %16
  %17 = load i16, i16* %len.addr, align 2
  %cmp20 = icmp ult i16 %add19, %17
  br label %land.end.22

land.end.22:                                      ; preds = %land.rhs.18, %for.cond.15
  %18 = phi i1 [ false, %for.cond.15 ], [ %cmp20, %land.rhs.18 ]
  br i1 %18, label %for.body.23, label %for.end.36

for.body.23:                                      ; preds = %land.end.22
  %19 = load i16, i16* %i, align 2
  %20 = load i16, i16* %j, align 2
  %add24 = add nsw i16 %19, %20
  %21 = load i8*, i8** %m.addr, align 2
  %arrayidx25 = getelementptr inbounds i8, i8* %21, i16 %add24
  %22 = load i8, i8* %arrayidx25, align 1
  store i8 %22, i8* %c, align 1
  %23 = load i8, i8* %c, align 1
  %conv26 = sext i8 %23 to i16
  %cmp27 = icmp sle i16 32, %conv26
  br i1 %cmp27, label %land.lhs.true, label %if.then

land.lhs.true:                                    ; preds = %for.body.23
  %24 = load i8, i8* %c, align 1
  %conv29 = sext i8 %24 to i16
  %cmp30 = icmp sle i16 %conv29, 127
  br i1 %cmp30, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %for.body.23
  store i8 46, i8* %c, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true
  %25 = load i8, i8* %c, align 1
  %conv32 = sext i8 %25 to i16
  %call33 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i16 %conv32)
  br label %for.inc.34

for.inc.34:                                       ; preds = %if.end
  %26 = load i16, i16* %j, align 2
  %inc35 = add nsw i16 %26, 1
  store i16 %inc35, i16* %j, align 2
  br label %for.cond.15

for.end.36:                                       ; preds = %land.end.22
  %call37 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
  br label %for.inc.38

for.inc.38:                                       ; preds = %for.end.36
  %27 = load i16, i16* %i, align 2
  %add39 = add nsw i16 %27, 8
  store i16 %add39, i16* %i, align 2
  br label %for.cond

for.end.40:                                       ; preds = %for.cond
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @mult(i16* %a, i16* %b) #1 {
entry:
  %a.addr = alloca i16*, align 2
  %b.addr = alloca i16*, align 2
  %i = alloca i16, align 2
  %digit = alloca i16, align 2
  %p = alloca i16, align 2
  %c = alloca i16, align 2
  %dp = alloca i16, align 2
  %carry = alloca i16, align 2
  store i16* %a, i16** %a.addr, align 2
  store i16* %b, i16** %b.addr, align 2
  store i16 0, i16* %carry, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc.13, %entry
  %0 = load i16, i16* %digit, align 2
  %cmp = icmp ult i16 %0, 16
  br i1 %cmp, label %for.body, label %for.end.15

for.body:                                         ; preds = %for.cond
  store i16 14, i16* @curtask, align 2
  %1 = load i16, i16* %carry, align 2
  store i16 %1, i16* %p, align 2
  store i16 0, i16* %c, align 2
  store i16 0, i16* %i, align 2
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc, %for.body
  %2 = load i16, i16* %i, align 2
  %cmp2 = icmp slt i16 %2, 8
  br i1 %cmp2, label %for.body.3, label %for.end

for.body.3:                                       ; preds = %for.cond.1
  %3 = load i16, i16* %i, align 2
  %4 = load i16, i16* %digit, align 2
  %cmp4 = icmp ule i16 %3, %4
  br i1 %cmp4, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body.3
  %5 = load i16, i16* %digit, align 2
  %6 = load i16, i16* %i, align 2
  %sub = sub i16 %5, %6
  %cmp5 = icmp ult i16 %sub, 8
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %7 = load i16, i16* %digit, align 2
  %8 = load i16, i16* %i, align 2
  %sub6 = sub i16 %7, %8
  %9 = load i16*, i16** %a.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %9, i16 %sub6
  %10 = load i16, i16* %arrayidx, align 2
  %11 = load i16, i16* %i, align 2
  %12 = load i16*, i16** %b.addr, align 2
  %arrayidx7 = getelementptr inbounds i16, i16* %12, i16 %11
  %13 = load i16, i16* %arrayidx7, align 2
  %mul = mul i16 %10, %13
  store i16 %mul, i16* %dp, align 2
  %14 = load i16, i16* %dp, align 2
  %shr = lshr i16 %14, 8
  %15 = load i16, i16* %c, align 2
  %add = add i16 %15, %shr
  store i16 %add, i16* %c, align 2
  %16 = load i16, i16* %dp, align 2
  %and = and i16 %16, 255
  %17 = load i16, i16* %p, align 2
  %add8 = add i16 %17, %and
  store i16 %add8, i16* %p, align 2
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body.3
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %18 = load i16, i16* %i, align 2
  %inc = add nsw i16 %18, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond.1

for.end:                                          ; preds = %for.cond.1
  %19 = load i16, i16* %p, align 2
  %shr9 = lshr i16 %19, 8
  %20 = load i16, i16* %c, align 2
  %add10 = add i16 %20, %shr9
  store i16 %add10, i16* %c, align 2
  %21 = load i16, i16* %p, align 2
  %and11 = and i16 %21, 255
  store i16 %and11, i16* %p, align 2
  %22 = load i16, i16* %p, align 2
  %23 = load i16, i16* %digit, align 2
  %arrayidx12 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %23
  store i16 %22, i16* %arrayidx12, align 2
  %24 = load i16, i16* %c, align 2
  store i16 %24, i16* %carry, align 2
  br label %for.inc.13

for.inc.13:                                       ; preds = %for.end
  %25 = load i16, i16* %digit, align 2
  %inc14 = add i16 %25, 1
  store i16 %inc14, i16* %digit, align 2
  br label %for.cond

for.end.15:                                       ; preds = %for.cond
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i, align 2
  br label %for.cond.16

for.cond.16:                                      ; preds = %for.inc.21, %for.end.15
  %26 = load i16, i16* %i, align 2
  %cmp17 = icmp slt i16 %26, 16
  br i1 %cmp17, label %for.body.18, label %for.end.23

for.body.18:                                      ; preds = %for.cond.16
  %27 = load i16, i16* %i, align 2
  %arrayidx19 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %27
  %28 = load i16, i16* %arrayidx19, align 2
  %29 = load i16, i16* %i, align 2
  %30 = load i16*, i16** %a.addr, align 2
  %arrayidx20 = getelementptr inbounds i16, i16* %30, i16 %29
  store i16 %28, i16* %arrayidx20, align 2
  br label %for.inc.21

for.inc.21:                                       ; preds = %for.body.18
  %31 = load i16, i16* %i, align 2
  %inc22 = add nsw i16 %31, 1
  store i16 %inc22, i16* %i, align 2
  br label %for.cond.16

for.end.23:                                       ; preds = %for.cond.16
  store i16 27, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define zeroext i1 @reduce_normalizable(i16* %m, i16* %n, i16 %d) #1 {
entry:
  %m.addr = alloca i16*, align 2
  %n.addr = alloca i16*, align 2
  %d.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %offset = alloca i16, align 2
  %n_d = alloca i16, align 2
  %m_d = alloca i16, align 2
  %normalizable = alloca i8, align 1
  store i16* %m, i16** %m.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %d, i16* %d.addr, align 2
  store i8 1, i8* %normalizable, align 1
  store i16 6, i16* @curtask, align 2
  %0 = load i16, i16* %d.addr, align 2
  %add = add i16 %0, 1
  %sub = sub i16 %add, 8
  store i16 %sub, i16* %offset, align 2
  %1 = load i16, i16* %d.addr, align 2
  %2 = load i16, i16* %offset, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %1, i16 %2)
  %3 = load i16, i16* %d.addr, align 2
  store i16 %3, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i16, i16* %i, align 2
  %cmp = icmp sge i16 %4, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load i16, i16* %i, align 2
  %6 = load i16*, i16** %m.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %6, i16 %5
  %7 = load i16, i16* %arrayidx, align 2
  store i16 %7, i16* %m_d, align 2
  %8 = load i16, i16* %i, align 2
  %9 = load i16, i16* %offset, align 2
  %sub1 = sub i16 %8, %9
  %10 = load i16*, i16** %n.addr, align 2
  %arrayidx2 = getelementptr inbounds i16, i16* %10, i16 %sub1
  %11 = load i16, i16* %arrayidx2, align 2
  store i16 %11, i16* %n_d, align 2
  %12 = load i16, i16* %m_d, align 2
  %13 = load i16, i16* %n_d, align 2
  %cmp3 = icmp ugt i16 %12, %13
  br i1 %cmp3, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  br label %for.end

if.else:                                          ; preds = %for.body
  %14 = load i16, i16* %m_d, align 2
  %15 = load i16, i16* %n_d, align 2
  %cmp4 = icmp ult i16 %14, %15
  br i1 %cmp4, label %if.then.5, label %if.end

if.then.5:                                        ; preds = %if.else
  store i8 0, i8* %normalizable, align 1
  br label %for.end

if.end:                                           ; preds = %if.else
  br label %if.end.6

if.end.6:                                         ; preds = %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end.6
  %16 = load i16, i16* %i, align 2
  %dec = add nsw i16 %16, -1
  store i16 %dec, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %if.then.5, %if.then, %for.cond
  %17 = load i8, i8* %normalizable, align 1
  %tobool = trunc i8 %17 to i1
  %conv = zext i1 %tobool to i16
  %call7 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv)
  store i16 30, i16* @curtask, align 2
  %18 = load i8, i8* %normalizable, align 1
  %tobool8 = trunc i8 %18 to i1
  ret i1 %tobool8
}

; Function Attrs: alwaysinline nounwind
define void @reduce_normalize(i16* %m, i16* %n, i16 %digit) #1 {
entry:
  %m.addr = alloca i16*, align 2
  %n.addr = alloca i16*, align 2
  %digit.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %d = alloca i16, align 2
  %s = alloca i16, align 2
  %m_d = alloca i16, align 2
  %n_d = alloca i16, align 2
  %borrow = alloca i16, align 2
  %offset = alloca i16, align 2
  store i16* %m, i16** %m.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %digit, i16* %digit.addr, align 2
  store i16 5, i16* @curtask, align 2
  %0 = load i16, i16* %digit.addr, align 2
  %add = add i16 %0, 1
  %sub = sub i16 %add, 8
  store i16 %sub, i16* %offset, align 2
  store i16 0, i16* %borrow, align 2
  store i16 0, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i16, i16* %i, align 2
  %cmp = icmp slt i16 %1, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 21, i16* @curtask, align 2
  %2 = load i16, i16* %i, align 2
  %3 = load i16, i16* %offset, align 2
  %add1 = add i16 %2, %3
  %4 = load i16*, i16** %m.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %4, i16 %add1
  %5 = load i16, i16* %arrayidx, align 2
  store i16 %5, i16* %m_d, align 2
  %6 = load i16, i16* %i, align 2
  %7 = load i16*, i16** %n.addr, align 2
  %arrayidx2 = getelementptr inbounds i16, i16* %7, i16 %6
  %8 = load i16, i16* %arrayidx2, align 2
  store i16 %8, i16* %n_d, align 2
  %9 = load i16, i16* %n_d, align 2
  %10 = load i16, i16* %borrow, align 2
  %add3 = add i16 %9, %10
  store i16 %add3, i16* %s, align 2
  %11 = load i16, i16* %m_d, align 2
  %12 = load i16, i16* %s, align 2
  %cmp4 = icmp ult i16 %11, %12
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i16, i16* %m_d, align 2
  %add5 = add i16 %13, 256
  store i16 %add5, i16* %m_d, align 2
  store i16 1, i16* %borrow, align 2
  br label %if.end

if.else:                                          ; preds = %for.body
  store i16 0, i16* %borrow, align 2
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %14 = load i16, i16* %m_d, align 2
  %15 = load i16, i16* %s, align 2
  %sub6 = sub i16 %14, %15
  store i16 %sub6, i16* %d, align 2
  %16 = load i16, i16* %d, align 2
  %17 = load i16, i16* %i, align 2
  %18 = load i16, i16* %offset, align 2
  %add7 = add i16 %17, %18
  %19 = load i16*, i16** %m.addr, align 2
  %arrayidx8 = getelementptr inbounds i16, i16* %19, i16 %add7
  store i16 %16, i16* %arrayidx8, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %20 = load i16, i16* %i, align 2
  %inc = add nsw i16 %20, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 29, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce_quotient(i16* %quotient, i16* %m, i16* %n, i16 %d) #1 {
entry:
  %quotient.addr = alloca i16*, align 2
  %m.addr = alloca i16*, align 2
  %n.addr = alloca i16*, align 2
  %d.addr = alloca i16, align 2
  %m_d = alloca [3 x i16], align 2
  %q = alloca i16, align 2
  %n_div = alloca i16, align 2
  %n_n = alloca i16, align 2
  %n_q = alloca i32, align 2
  %qn = alloca i32, align 2
  %m_dividend = alloca i16, align 2
  store i16* %quotient, i16** %quotient.addr, align 2
  store i16* %m, i16** %m.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %d, i16* %d.addr, align 2
  store i16 16, i16* @curtask, align 2
  %0 = load i16*, i16** %n.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %0, i16 7
  %1 = load i16, i16* %arrayidx, align 2
  %shl = shl i16 %1, 8
  %2 = load i16*, i16** %n.addr, align 2
  %arrayidx1 = getelementptr inbounds i16, i16* %2, i16 6
  %3 = load i16, i16* %arrayidx1, align 2
  %add = add i16 %shl, %3
  store i16 %add, i16* %n_div, align 2
  %4 = load i16*, i16** %n.addr, align 2
  %arrayidx2 = getelementptr inbounds i16, i16* %4, i16 7
  %5 = load i16, i16* %arrayidx2, align 2
  store i16 %5, i16* %n_n, align 2
  %6 = load i16, i16* %d.addr, align 2
  %7 = load i16*, i16** %m.addr, align 2
  %arrayidx3 = getelementptr inbounds i16, i16* %7, i16 %6
  %8 = load i16, i16* %arrayidx3, align 2
  %arrayidx4 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  store i16 %8, i16* %arrayidx4, align 2
  %9 = load i16, i16* %d.addr, align 2
  %sub = sub i16 %9, 1
  %10 = load i16*, i16** %m.addr, align 2
  %arrayidx5 = getelementptr inbounds i16, i16* %10, i16 %sub
  %11 = load i16, i16* %arrayidx5, align 2
  %arrayidx6 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  store i16 %11, i16* %arrayidx6, align 2
  %12 = load i16, i16* %d.addr, align 2
  %sub7 = sub i16 %12, 2
  %13 = load i16*, i16** %m.addr, align 2
  %arrayidx8 = getelementptr inbounds i16, i16* %13, i16 %sub7
  %14 = load i16, i16* %arrayidx8, align 2
  %arrayidx9 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  store i16 %14, i16* %arrayidx9, align 2
  %15 = load i16, i16* %n_n, align 2
  %16 = load i16*, i16** %m.addr, align 2
  %arrayidx10 = getelementptr inbounds i16, i16* %16, i16 2
  %17 = load i16, i16* %arrayidx10, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %15, i16 %17)
  store i16 17, i16* @curtask, align 2
  %arrayidx11 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %18 = load i16, i16* %arrayidx11, align 2
  %19 = load i16, i16* %n_n, align 2
  %cmp = icmp eq i16 %18, %19
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i16 255, i16* %q, align 2
  br label %if.end

if.else:                                          ; preds = %entry
  %arrayidx12 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %20 = load i16, i16* %arrayidx12, align 2
  %shl13 = shl i16 %20, 8
  %arrayidx14 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %21 = load i16, i16* %arrayidx14, align 2
  %add15 = add i16 %shl13, %21
  store i16 %add15, i16* %m_dividend, align 2
  %22 = load i16, i16* %m_dividend, align 2
  %23 = load i16, i16* %n_n, align 2
  %div = udiv i16 %22, %23
  store i16 %div, i16* %q, align 2
  %24 = load i16, i16* %m_dividend, align 2
  %25 = load i16, i16* %q, align 2
  %call16 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %24, i16 %25)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  store i16 18, i16* @curtask, align 2
  %arrayidx17 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %26 = load i16, i16* %arrayidx17, align 2
  %conv = zext i16 %26 to i32
  %shl18 = shl i32 %conv, 16
  %arrayidx19 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %27 = load i16, i16* %arrayidx19, align 2
  %shl20 = shl i16 %27, 8
  %conv21 = zext i16 %shl20 to i32
  %add22 = add i32 %shl18, %conv21
  %arrayidx23 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  %28 = load i16, i16* %arrayidx23, align 2
  %conv24 = zext i16 %28 to i32
  %add25 = add i32 %add22, %conv24
  store i32 %add25, i32* %n_q, align 2
  %arrayidx26 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %29 = load i16, i16* %arrayidx26, align 2
  %arrayidx27 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %30 = load i16, i16* %arrayidx27, align 2
  %arrayidx28 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  %31 = load i16, i16* %arrayidx28, align 2
  %32 = load i32, i32* %n_q, align 2
  %shr = lshr i32 %32, 16
  %and = and i32 %shr, 65535
  %conv29 = trunc i32 %and to i16
  %33 = load i32, i32* %n_q, align 2
  %and30 = and i32 %33, 65535
  %conv31 = trunc i32 %and30 to i16
  %call32 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %29, i16 %30, i16 %31, i16 %conv29, i16 %conv31)
  %34 = load i16, i16* %q, align 2
  %call33 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %34)
  %35 = load i16, i16* %q, align 2
  %inc = add i16 %35, 1
  store i16 %inc, i16* %q, align 2
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end
  store i16 19, i16* @curtask, align 2
  %36 = load i16, i16* %q, align 2
  %dec = add i16 %36, -1
  store i16 %dec, i16* %q, align 2
  %37 = load i16, i16* %n_div, align 2
  %38 = load i16, i16* %q, align 2
  %call34 = call i32 @mult16(i16 zeroext %37, i16 zeroext %38)
  store i32 %call34, i32* %qn, align 2
  %39 = load i16, i16* %q, align 2
  %40 = load i16, i16* %n_div, align 2
  %41 = load i32, i32* %qn, align 2
  %shr35 = lshr i32 %41, 16
  %and36 = and i32 %shr35, 65535
  %conv37 = trunc i32 %and36 to i16
  %42 = load i32, i32* %qn, align 2
  %and38 = and i32 %42, 65535
  %conv39 = trunc i32 %and38 to i16
  %call40 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %39, i16 %40, i16 %conv37, i16 %conv39)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %43 = load i32, i32* %qn, align 2
  %44 = load i32, i32* %n_q, align 2
  %cmp41 = icmp ugt i32 %43, %44
  br i1 %cmp41, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %45 = load i16, i16* %q, align 2
  %call43 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %45)
  %46 = load i16, i16* %q, align 2
  %47 = load i16*, i16** %quotient.addr, align 2
  store i16 %46, i16* %47, align 2
  store i16 32, i16* @curtask, align 2
  ret void
}

declare i32 @mult16(i16 zeroext, i16 zeroext) #2

; Function Attrs: alwaysinline nounwind
define void @reduce_multiply(i16* %product, i16 zeroext %q, i16* %n, i16 %d) #1 {
entry:
  %product.addr = alloca i16*, align 2
  %q.addr = alloca i16, align 2
  %n.addr = alloca i16*, align 2
  %d.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %offset = alloca i16, align 2
  %c = alloca i16, align 2
  %p = alloca i16, align 2
  %nd = alloca i16, align 2
  store i16* %product, i16** %product.addr, align 2
  store i16 %q, i16* %q.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 %d, i16* %d.addr, align 2
  store i16 9, i16* @curtask, align 2
  %0 = load i16, i16* %d.addr, align 2
  %sub = sub i16 %0, 8
  store i16 %sub, i16* %offset, align 2
  %1 = load i16, i16* %offset, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %1)
  store i16 0, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i16, i16* %i, align 2
  %3 = load i16, i16* %offset, align 2
  %cmp = icmp ult i16 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i16, i16* %i, align 2
  %5 = load i16*, i16** %product.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %5, i16 %4
  store i16 0, i16* %arrayidx, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i16, i16* %i, align 2
  %inc = add nsw i16 %6, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 0, i16* %c, align 2
  %7 = load i16, i16* %offset, align 2
  store i16 %7, i16* %i, align 2
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc.9, %for.end
  %8 = load i16, i16* %i, align 2
  %cmp2 = icmp slt i16 %8, 16
  br i1 %cmp2, label %for.body.3, label %for.end.11

for.body.3:                                       ; preds = %for.cond.1
  store i16 24, i16* @curtask, align 2
  %9 = load i16, i16* %c, align 2
  store i16 %9, i16* %p, align 2
  %10 = load i16, i16* %i, align 2
  %11 = load i16, i16* %offset, align 2
  %add = add i16 %11, 8
  %cmp4 = icmp ult i16 %10, %add
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body.3
  %12 = load i16, i16* %i, align 2
  %13 = load i16, i16* %offset, align 2
  %sub5 = sub i16 %12, %13
  %14 = load i16*, i16** %n.addr, align 2
  %arrayidx6 = getelementptr inbounds i16, i16* %14, i16 %sub5
  %15 = load i16, i16* %arrayidx6, align 2
  store i16 %15, i16* %nd, align 2
  %16 = load i16, i16* %q.addr, align 2
  %17 = load i16, i16* %nd, align 2
  %mul = mul i16 %16, %17
  %18 = load i16, i16* %p, align 2
  %add7 = add i16 %18, %mul
  store i16 %add7, i16* %p, align 2
  br label %if.end

if.else:                                          ; preds = %for.body.3
  store i16 0, i16* %nd, align 2
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %19 = load i16, i16* %p, align 2
  %shr = lshr i16 %19, 8
  store i16 %shr, i16* %c, align 2
  %20 = load i16, i16* %p, align 2
  %and = and i16 %20, 255
  store i16 %and, i16* %p, align 2
  %21 = load i16, i16* %p, align 2
  %22 = load i16, i16* %i, align 2
  %23 = load i16*, i16** %product.addr, align 2
  %arrayidx8 = getelementptr inbounds i16, i16* %23, i16 %22
  store i16 %21, i16* %arrayidx8, align 2
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.end
  %24 = load i16, i16* %i, align 2
  %inc10 = add nsw i16 %24, 1
  store i16 %inc10, i16* %i, align 2
  br label %for.cond.1

for.end.11:                                       ; preds = %for.cond.1
  store i16 33, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define i16 @reduce_compare(i16* %a, i16* %b) #1 {
entry:
  %a.addr = alloca i16*, align 2
  %b.addr = alloca i16*, align 2
  %i = alloca i16, align 2
  %relation = alloca i16, align 2
  store i16* %a, i16** %a.addr, align 2
  store i16* %b, i16** %b.addr, align 2
  store i16 0, i16* %relation, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i16, i16* %i, align 2
  %cmp = icmp sge i16 %0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i16*, i16** %a.addr, align 2
  %2 = load i16*, i16** %b.addr, align 2
  %cmp1 = icmp ugt i16* %1, %2
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  store i16 1, i16* %relation, align 2
  br label %for.end

if.else:                                          ; preds = %for.body
  %3 = load i16*, i16** %a.addr, align 2
  %4 = load i16*, i16** %b.addr, align 2
  %cmp2 = icmp ult i16* %3, %4
  br i1 %cmp2, label %if.then.3, label %if.end

if.then.3:                                        ; preds = %if.else
  store i16 -1, i16* %relation, align 2
  br label %for.end

if.end:                                           ; preds = %if.else
  br label %if.end.4

if.end.4:                                         ; preds = %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end.4
  %5 = load i16, i16* %i, align 2
  %dec = add nsw i16 %5, -1
  store i16 %dec, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %if.then.3, %if.then, %for.cond
  store i16 31, i16* @curtask, align 2
  %6 = load i16, i16* %relation, align 2
  ret i16 %6
}

; Function Attrs: alwaysinline nounwind
define void @reduce_add(i16* %a, i16* %b, i16 %d) #1 {
entry:
  %a.addr = alloca i16*, align 2
  %b.addr = alloca i16*, align 2
  %d.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %j = alloca i16, align 2
  %offset = alloca i16, align 2
  %c = alloca i16, align 2
  %r = alloca i16, align 2
  %m = alloca i16, align 2
  %n = alloca i16, align 2
  store i16* %a, i16** %a.addr, align 2
  store i16* %b, i16** %b.addr, align 2
  store i16 %d, i16* %d.addr, align 2
  store i16 10, i16* @curtask, align 2
  %0 = load i16, i16* %d.addr, align 2
  %sub = sub i16 %0, 8
  store i16 %sub, i16* %offset, align 2
  store i16 0, i16* %c, align 2
  %1 = load i16, i16* %offset, align 2
  store i16 %1, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i16, i16* %i, align 2
  %cmp = icmp slt i16 %2, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 22, i16* @curtask, align 2
  %3 = load i16, i16* %i, align 2
  %4 = load i16*, i16** %a.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %4, i16 %3
  %5 = load i16, i16* %arrayidx, align 2
  store i16 %5, i16* %m, align 2
  %6 = load i16, i16* %i, align 2
  %7 = load i16, i16* %offset, align 2
  %sub1 = sub i16 %6, %7
  store i16 %sub1, i16* %j, align 2
  %8 = load i16, i16* %i, align 2
  %9 = load i16, i16* %offset, align 2
  %add = add i16 %9, 8
  %cmp2 = icmp ult i16 %8, %add
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %10 = load i16, i16* %j, align 2
  %11 = load i16*, i16** %b.addr, align 2
  %arrayidx3 = getelementptr inbounds i16, i16* %11, i16 %10
  %12 = load i16, i16* %arrayidx3, align 2
  store i16 %12, i16* %n, align 2
  br label %if.end

if.else:                                          ; preds = %for.body
  store i16 0, i16* %n, align 2
  store i16 0, i16* %j, align 2
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %13 = load i16, i16* %c, align 2
  %14 = load i16, i16* %m, align 2
  %add4 = add i16 %13, %14
  %15 = load i16, i16* %n, align 2
  %add5 = add i16 %add4, %15
  store i16 %add5, i16* %r, align 2
  %16 = load i16, i16* %r, align 2
  %shr = lshr i16 %16, 8
  store i16 %shr, i16* %c, align 2
  %17 = load i16, i16* %r, align 2
  %and = and i16 %17, 255
  store i16 %and, i16* %r, align 2
  %18 = load i16, i16* %r, align 2
  %19 = load i16, i16* %i, align 2
  %20 = load i16*, i16** %a.addr, align 2
  %arrayidx6 = getelementptr inbounds i16, i16* %20, i16 %19
  store i16 %18, i16* %arrayidx6, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %21 = load i16, i16* %i, align 2
  %inc = add nsw i16 %21, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 34, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce_subtract(i16* %a, i16* %b, i16 %d) #1 {
entry:
  %a.addr = alloca i16*, align 2
  %b.addr = alloca i16*, align 2
  %d.addr = alloca i16, align 2
  %i = alloca i16, align 2
  %m = alloca i16, align 2
  %s = alloca i16, align 2
  %r = alloca i16, align 2
  %qn = alloca i16, align 2
  %borrow = alloca i16, align 2
  %offset = alloca i16, align 2
  store i16* %a, i16** %a.addr, align 2
  store i16* %b, i16** %b.addr, align 2
  store i16 %d, i16* %d.addr, align 2
  store i16 11, i16* @curtask, align 2
  %0 = load i16, i16* %d.addr, align 2
  %sub = sub i16 %0, 8
  store i16 %sub, i16* %offset, align 2
  %1 = load i16, i16* %d.addr, align 2
  %2 = load i16, i16* %offset, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %1, i16 %2)
  store i16 0, i16* %borrow, align 2
  %3 = load i16, i16* %offset, align 2
  store i16 %3, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i16, i16* %i, align 2
  %cmp = icmp slt i16 %4, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 23, i16* @curtask, align 2
  %5 = load i16, i16* %i, align 2
  %6 = load i16*, i16** %a.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %6, i16 %5
  %7 = load i16, i16* %arrayidx, align 2
  store i16 %7, i16* %m, align 2
  %8 = load i16, i16* %i, align 2
  %9 = load i16*, i16** %b.addr, align 2
  %arrayidx1 = getelementptr inbounds i16, i16* %9, i16 %8
  %10 = load i16, i16* %arrayidx1, align 2
  store i16 %10, i16* %qn, align 2
  %11 = load i16, i16* %qn, align 2
  %12 = load i16, i16* %borrow, align 2
  %add = add i16 %11, %12
  store i16 %add, i16* %s, align 2
  %13 = load i16, i16* %m, align 2
  %14 = load i16, i16* %s, align 2
  %cmp2 = icmp ult i16 %13, %14
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i16, i16* %m, align 2
  %add3 = add i16 %15, 256
  store i16 %add3, i16* %m, align 2
  store i16 1, i16* %borrow, align 2
  br label %if.end

if.else:                                          ; preds = %for.body
  store i16 0, i16* %borrow, align 2
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %16 = load i16, i16* %m, align 2
  %17 = load i16, i16* %s, align 2
  %sub4 = sub i16 %16, %17
  store i16 %sub4, i16* %r, align 2
  %18 = load i16, i16* %r, align 2
  %19 = load i16, i16* %i, align 2
  %20 = load i16*, i16** %a.addr, align 2
  %arrayidx5 = getelementptr inbounds i16, i16* %20, i16 %19
  store i16 %18, i16* %arrayidx5, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %21 = load i16, i16* %i, align 2
  %inc = add nsw i16 %21, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 35, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce(i16* %m, i16* %n) #1 {
entry:
  %a.addr.i.103 = alloca i16*, align 2
  %b.addr.i.104 = alloca i16*, align 2
  %d.addr.i.105 = alloca i16, align 2
  %i.i.106 = alloca i16, align 2
  %m.i.107 = alloca i16, align 2
  %s.i.108 = alloca i16, align 2
  %r.i.109 = alloca i16, align 2
  %qn.i.110 = alloca i16, align 2
  %borrow.i.111 = alloca i16, align 2
  %offset.i.112 = alloca i16, align 2
  %a.addr.i.79 = alloca i16*, align 2
  %b.addr.i.80 = alloca i16*, align 2
  %d.addr.i.81 = alloca i16, align 2
  %i.i.82 = alloca i16, align 2
  %j.i = alloca i16, align 2
  %offset.i.83 = alloca i16, align 2
  %c.i.84 = alloca i16, align 2
  %r.i = alloca i16, align 2
  %m.i = alloca i16, align 2
  %n.i = alloca i16, align 2
  %a.addr.i = alloca i16*, align 2
  %b.addr.i = alloca i16*, align 2
  %i.i.69 = alloca i16, align 2
  %relation.i = alloca i16, align 2
  %product.addr.i = alloca i16*, align 2
  %q.addr.i = alloca i16, align 2
  %n.addr.i.48 = alloca i16*, align 2
  %d.addr.i.49 = alloca i16, align 2
  %i.i.50 = alloca i16, align 2
  %offset.i.51 = alloca i16, align 2
  %c.i = alloca i16, align 2
  %p.i = alloca i16, align 2
  %nd.i = alloca i16, align 2
  %quotient.addr.i = alloca i16*, align 2
  %m.addr.i.31 = alloca i16*, align 2
  %n.addr.i.32 = alloca i16*, align 2
  %d.addr.i.33 = alloca i16, align 2
  %m_d.i.34 = alloca [3 x i16], align 2
  %q.i = alloca i16, align 2
  %n_div.i = alloca i16, align 2
  %n_n.i = alloca i16, align 2
  %n_q.i = alloca i32, align 2
  %qn.i = alloca i32, align 2
  %m_dividend.i = alloca i16, align 2
  %m.addr.i.14 = alloca i16*, align 2
  %n.addr.i.15 = alloca i16*, align 2
  %digit.addr.i = alloca i16, align 2
  %i.i.16 = alloca i16, align 2
  %d.i = alloca i16, align 2
  %s.i = alloca i16, align 2
  %m_d.i.17 = alloca i16, align 2
  %n_d.i.18 = alloca i16, align 2
  %borrow.i = alloca i16, align 2
  %offset.i.19 = alloca i16, align 2
  %m.addr.i = alloca i16*, align 2
  %n.addr.i = alloca i16*, align 2
  %d.addr.i = alloca i16, align 2
  %i.i = alloca i16, align 2
  %offset.i = alloca i16, align 2
  %n_d.i = alloca i16, align 2
  %m_d.i = alloca i16, align 2
  %normalizable.i = alloca i8, align 1
  %m.addr = alloca i16*, align 2
  %n.addr = alloca i16*, align 2
  %q = alloca i16, align 2
  %m_d = alloca i16, align 2
  %d = alloca i16, align 2
  store i16* %m, i16** %m.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d, align 2
  br label %do.body

do.body:                                          ; preds = %land.end, %entry
  %0 = load i16, i16* %d, align 2
  %dec = add i16 %0, -1
  store i16 %dec, i16* %d, align 2
  %1 = load i16, i16* %d, align 2
  %2 = load i16*, i16** %m.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %2, i16 %1
  %3 = load i16, i16* %arrayidx, align 2
  store i16 %3, i16* %m_d, align 2
  %4 = load i16, i16* %d, align 2
  %5 = load i16, i16* %m_d, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %4, i16 %5)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %6 = load i16, i16* %m_d, align 2
  %cmp = icmp eq i16 %6, 0
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %do.cond
  %7 = load i16, i16* %d, align 2
  %cmp1 = icmp ugt i16 %7, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %do.cond
  %8 = phi i1 [ false, %do.cond ], [ %cmp1, %land.rhs ]
  br i1 %8, label %do.body, label %do.end

do.end:                                           ; preds = %land.end
  %9 = load i16, i16* %d, align 2
  %call2 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %9)
  %10 = load i16*, i16** %m.addr, align 2
  %11 = load i16*, i16** %n.addr, align 2
  %12 = load i16, i16* %d, align 2
  store i16* %10, i16** %m.addr.i, align 2
  store i16* %11, i16** %n.addr.i, align 2
  store i16 %12, i16* %d.addr.i, align 2
  store i8 1, i8* %normalizable.i, align 1
  store i16 6, i16* @curtask, align 2
  %13 = load i16, i16* %d.addr.i, align 2
  %add.i = add i16 %13, 1
  %sub.i = sub i16 %add.i, 8
  store i16 %sub.i, i16* %offset.i, align 2
  %14 = load i16, i16* %d.addr.i, align 2
  %15 = load i16, i16* %offset.i, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %14, i16 %15) #4
  %16 = load i16, i16* %d.addr.i, align 2
  store i16 %16, i16* %i.i, align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %if.end.i, %do.end
  %17 = load i16, i16* %i.i, align 2
  %cmp.i = icmp sge i16 %17, 0
  br i1 %cmp.i, label %for.body.i, label %reduce_normalizable.exit

for.body.i:                                       ; preds = %for.cond.i
  %18 = load i16, i16* %i.i, align 2
  %19 = load i16*, i16** %m.addr.i, align 2
  %arrayidx.i = getelementptr inbounds i16, i16* %19, i16 %18
  %20 = load i16, i16* %arrayidx.i, align 2
  store i16 %20, i16* %m_d.i, align 2
  %21 = load i16, i16* %i.i, align 2
  %22 = load i16, i16* %offset.i, align 2
  %sub1.i = sub i16 %21, %22
  %23 = load i16*, i16** %n.addr.i, align 2
  %arrayidx2.i = getelementptr inbounds i16, i16* %23, i16 %sub1.i
  %24 = load i16, i16* %arrayidx2.i, align 2
  store i16 %24, i16* %n_d.i, align 2
  %25 = load i16, i16* %m_d.i, align 2
  %26 = load i16, i16* %n_d.i, align 2
  %cmp3.i = icmp ugt i16 %25, %26
  br i1 %cmp3.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %for.body.i
  br label %reduce_normalizable.exit

if.else.i:                                        ; preds = %for.body.i
  %27 = load i16, i16* %m_d.i, align 2
  %28 = load i16, i16* %n_d.i, align 2
  %cmp4.i = icmp ult i16 %27, %28
  br i1 %cmp4.i, label %if.then.5.i, label %if.end.i

if.then.5.i:                                      ; preds = %if.else.i
  store i8 0, i8* %normalizable.i, align 1
  br label %reduce_normalizable.exit

if.end.i:                                         ; preds = %if.else.i
  %29 = load i16, i16* %i.i, align 2
  %dec.i = add nsw i16 %29, -1
  store i16 %dec.i, i16* %i.i, align 2
  br label %for.cond.i

reduce_normalizable.exit:                         ; preds = %for.cond.i, %if.then.i, %if.then.5.i
  %30 = load i8, i8* %normalizable.i, align 1
  %tobool.i = trunc i8 %30 to i1
  %conv.i = zext i1 %tobool.i to i16
  %call7.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i) #4
  store i16 30, i16* @curtask, align 2
  %31 = load i8, i8* %normalizable.i, align 1
  %tobool8.i = trunc i8 %31 to i1
  br i1 %tobool8.i, label %if.then, label %if.else

if.then:                                          ; preds = %reduce_normalizable.exit
  %32 = load i16*, i16** %m.addr, align 2
  %33 = load i16*, i16** %n.addr, align 2
  %34 = load i16, i16* %d, align 2
  store i16* %32, i16** %m.addr.i.14, align 2
  store i16* %33, i16** %n.addr.i.15, align 2
  store i16 %34, i16* %digit.addr.i, align 2
  store i16 5, i16* @curtask, align 2
  %35 = load i16, i16* %digit.addr.i, align 2
  %add.i.20 = add i16 %35, 1
  %sub.i.21 = sub i16 %add.i.20, 8
  store i16 %sub.i.21, i16* %offset.i.19, align 2
  store i16 0, i16* %borrow.i, align 2
  store i16 0, i16* %i.i.16, align 2
  br label %for.cond.i.23

for.cond.i.23:                                    ; preds = %if.end.i.30, %if.then
  %36 = load i16, i16* %i.i.16, align 2
  %cmp.i.22 = icmp slt i16 %36, 8
  br i1 %cmp.i.22, label %for.body.i.27, label %reduce_normalize.exit

for.body.i.27:                                    ; preds = %for.cond.i.23
  store i16 21, i16* @curtask, align 2
  %37 = load i16, i16* %i.i.16, align 2
  %38 = load i16, i16* %offset.i.19, align 2
  %add1.i = add i16 %37, %38
  %39 = load i16*, i16** %m.addr.i.14, align 2
  %arrayidx.i.24 = getelementptr inbounds i16, i16* %39, i16 %add1.i
  %40 = load i16, i16* %arrayidx.i.24, align 2
  store i16 %40, i16* %m_d.i.17, align 2
  %41 = load i16, i16* %i.i.16, align 2
  %42 = load i16*, i16** %n.addr.i.15, align 2
  %arrayidx2.i.25 = getelementptr inbounds i16, i16* %42, i16 %41
  %43 = load i16, i16* %arrayidx2.i.25, align 2
  store i16 %43, i16* %n_d.i.18, align 2
  %44 = load i16, i16* %n_d.i.18, align 2
  %45 = load i16, i16* %borrow.i, align 2
  %add3.i = add i16 %44, %45
  store i16 %add3.i, i16* %s.i, align 2
  %46 = load i16, i16* %m_d.i.17, align 2
  %47 = load i16, i16* %s.i, align 2
  %cmp4.i.26 = icmp ult i16 %46, %47
  br i1 %cmp4.i.26, label %if.then.i.28, label %if.else.i.29

if.then.i.28:                                     ; preds = %for.body.i.27
  %48 = load i16, i16* %m_d.i.17, align 2
  %add5.i = add i16 %48, 256
  store i16 %add5.i, i16* %m_d.i.17, align 2
  store i16 1, i16* %borrow.i, align 2
  br label %if.end.i.30

if.else.i.29:                                     ; preds = %for.body.i.27
  store i16 0, i16* %borrow.i, align 2
  br label %if.end.i.30

if.end.i.30:                                      ; preds = %if.else.i.29, %if.then.i.28
  %49 = load i16, i16* %m_d.i.17, align 2
  %50 = load i16, i16* %s.i, align 2
  %sub6.i = sub i16 %49, %50
  store i16 %sub6.i, i16* %d.i, align 2
  %51 = load i16, i16* %d.i, align 2
  %52 = load i16, i16* %i.i.16, align 2
  %53 = load i16, i16* %offset.i.19, align 2
  %add7.i = add i16 %52, %53
  %54 = load i16*, i16** %m.addr.i.14, align 2
  %arrayidx8.i = getelementptr inbounds i16, i16* %54, i16 %add7.i
  store i16 %51, i16* %arrayidx8.i, align 2
  %55 = load i16, i16* %i.i.16, align 2
  %inc.i = add nsw i16 %55, 1
  store i16 %inc.i, i16* %i.i.16, align 2
  br label %for.cond.i.23

reduce_normalize.exit:                            ; preds = %for.cond.i.23
  store i16 29, i16* @curtask, align 2
  br label %if.end.7

if.else:                                          ; preds = %reduce_normalizable.exit
  %56 = load i16, i16* %d, align 2
  %cmp4 = icmp eq i16 %56, 7
  br i1 %cmp4, label %if.then.5, label %if.end

if.then.5:                                        ; preds = %if.else
  %call6 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0))
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end.7

if.end.7:                                         ; preds = %if.end, %reduce_normalize.exit
  br label %while.cond

while.cond:                                       ; preds = %reduce_subtract.exit, %if.end.7
  %57 = load i16, i16* %d, align 2
  %cmp8 = icmp uge i16 %57, 8
  br i1 %cmp8, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %58 = load i16*, i16** %m.addr, align 2
  %59 = load i16*, i16** %n.addr, align 2
  %60 = load i16, i16* %d, align 2
  store i16* %q, i16** %quotient.addr.i, align 2
  store i16* %58, i16** %m.addr.i.31, align 2
  store i16* %59, i16** %n.addr.i.32, align 2
  store i16 %60, i16* %d.addr.i.33, align 2
  store i16 16, i16* @curtask, align 2
  %61 = load i16*, i16** %n.addr.i.32, align 2
  %arrayidx.i.35 = getelementptr inbounds i16, i16* %61, i16 7
  %62 = load i16, i16* %arrayidx.i.35, align 2
  %shl.i = shl i16 %62, 8
  %63 = load i16*, i16** %n.addr.i.32, align 2
  %arrayidx1.i = getelementptr inbounds i16, i16* %63, i16 6
  %64 = load i16, i16* %arrayidx1.i, align 2
  %add.i.36 = add i16 %shl.i, %64
  store i16 %add.i.36, i16* %n_div.i, align 2
  %65 = load i16*, i16** %n.addr.i.32, align 2
  %arrayidx2.i.37 = getelementptr inbounds i16, i16* %65, i16 7
  %66 = load i16, i16* %arrayidx2.i.37, align 2
  store i16 %66, i16* %n_n.i, align 2
  %67 = load i16, i16* %d.addr.i.33, align 2
  %68 = load i16*, i16** %m.addr.i.31, align 2
  %arrayidx3.i = getelementptr inbounds i16, i16* %68, i16 %67
  %69 = load i16, i16* %arrayidx3.i, align 2
  %arrayidx4.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  store i16 %69, i16* %arrayidx4.i, align 2
  %70 = load i16, i16* %d.addr.i.33, align 2
  %sub.i.38 = sub i16 %70, 1
  %71 = load i16*, i16** %m.addr.i.31, align 2
  %arrayidx5.i = getelementptr inbounds i16, i16* %71, i16 %sub.i.38
  %72 = load i16, i16* %arrayidx5.i, align 2
  %arrayidx6.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  store i16 %72, i16* %arrayidx6.i, align 2
  %73 = load i16, i16* %d.addr.i.33, align 2
  %sub7.i = sub i16 %73, 2
  %74 = load i16*, i16** %m.addr.i.31, align 2
  %arrayidx8.i.39 = getelementptr inbounds i16, i16* %74, i16 %sub7.i
  %75 = load i16, i16* %arrayidx8.i.39, align 2
  %arrayidx9.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  store i16 %75, i16* %arrayidx9.i, align 2
  %76 = load i16, i16* %n_n.i, align 2
  %77 = load i16*, i16** %m.addr.i.31, align 2
  %arrayidx10.i = getelementptr inbounds i16, i16* %77, i16 2
  %78 = load i16, i16* %arrayidx10.i, align 2
  %call.i.40 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %76, i16 %78) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %79 = load i16, i16* %arrayidx11.i, align 2
  %80 = load i16, i16* %n_n.i, align 2
  %cmp.i.41 = icmp eq i16 %79, %80
  br i1 %cmp.i.41, label %if.then.i.42, label %if.else.i.43

if.then.i.42:                                     ; preds = %while.body
  store i16 255, i16* %q.i, align 2
  br label %if.end.i.46

if.else.i.43:                                     ; preds = %while.body
  %arrayidx12.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %81 = load i16, i16* %arrayidx12.i, align 2
  %shl13.i = shl i16 %81, 8
  %arrayidx14.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %82 = load i16, i16* %arrayidx14.i, align 2
  %add15.i = add i16 %shl13.i, %82
  store i16 %add15.i, i16* %m_dividend.i, align 2
  %83 = load i16, i16* %m_dividend.i, align 2
  %84 = load i16, i16* %n_n.i, align 2
  %div.i = udiv i16 %83, %84
  store i16 %div.i, i16* %q.i, align 2
  %85 = load i16, i16* %m_dividend.i, align 2
  %86 = load i16, i16* %q.i, align 2
  %call16.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %85, i16 %86) #4
  br label %if.end.i.46

if.end.i.46:                                      ; preds = %if.else.i.43, %if.then.i.42
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %87 = load i16, i16* %arrayidx17.i, align 2
  %conv.i.44 = zext i16 %87 to i32
  %shl18.i = shl i32 %conv.i.44, 16
  %arrayidx19.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %88 = load i16, i16* %arrayidx19.i, align 2
  %shl20.i = shl i16 %88, 8
  %conv21.i = zext i16 %shl20.i to i32
  %add22.i = add i32 %shl18.i, %conv21.i
  %arrayidx23.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  %89 = load i16, i16* %arrayidx23.i, align 2
  %conv24.i = zext i16 %89 to i32
  %add25.i = add i32 %add22.i, %conv24.i
  store i32 %add25.i, i32* %n_q.i, align 2
  %arrayidx26.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %90 = load i16, i16* %arrayidx26.i, align 2
  %arrayidx27.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %91 = load i16, i16* %arrayidx27.i, align 2
  %arrayidx28.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  %92 = load i16, i16* %arrayidx28.i, align 2
  %93 = load i32, i32* %n_q.i, align 2
  %shr.i = lshr i32 %93, 16
  %and.i = and i32 %shr.i, 65535
  %conv29.i = trunc i32 %and.i to i16
  %94 = load i32, i32* %n_q.i, align 2
  %and30.i = and i32 %94, 65535
  %conv31.i = trunc i32 %and30.i to i16
  %call32.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %90, i16 %91, i16 %92, i16 %conv29.i, i16 %conv31.i) #4
  %95 = load i16, i16* %q.i, align 2
  %call33.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %95) #4
  %96 = load i16, i16* %q.i, align 2
  %inc.i.45 = add i16 %96, 1
  store i16 %inc.i.45, i16* %q.i, align 2
  br label %do.body.i

do.body.i:                                        ; preds = %do.body.i, %if.end.i.46
  store i16 19, i16* @curtask, align 2
  %97 = load i16, i16* %q.i, align 2
  %dec.i.47 = add i16 %97, -1
  store i16 %dec.i.47, i16* %q.i, align 2
  %98 = load i16, i16* %n_div.i, align 2
  %99 = load i16, i16* %q.i, align 2
  %call34.i = call i32 @mult16(i16 zeroext %98, i16 zeroext %99) #4
  store i32 %call34.i, i32* %qn.i, align 2
  %100 = load i16, i16* %q.i, align 2
  %101 = load i16, i16* %n_div.i, align 2
  %102 = load i32, i32* %qn.i, align 2
  %shr35.i = lshr i32 %102, 16
  %and36.i = and i32 %shr35.i, 65535
  %conv37.i = trunc i32 %and36.i to i16
  %103 = load i32, i32* %qn.i, align 2
  %and38.i = and i32 %103, 65535
  %conv39.i = trunc i32 %and38.i to i16
  %call40.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %100, i16 %101, i16 %conv37.i, i16 %conv39.i) #4
  %104 = load i32, i32* %qn.i, align 2
  %105 = load i32, i32* %n_q.i, align 2
  %cmp41.i = icmp ugt i32 %104, %105
  br i1 %cmp41.i, label %do.body.i, label %reduce_quotient.exit

reduce_quotient.exit:                             ; preds = %do.body.i
  %106 = load i16, i16* %q.i, align 2
  %call43.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %106) #4
  %107 = load i16, i16* %q.i, align 2
  %108 = load i16*, i16** %quotient.addr.i, align 2
  store i16 %107, i16* %108, align 2
  store i16 32, i16* @curtask, align 2
  %109 = load i16, i16* %q, align 2
  %110 = load i16*, i16** %n.addr, align 2
  %111 = load i16, i16* %d, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i, align 2
  store i16 %109, i16* %q.addr.i, align 2
  store i16* %110, i16** %n.addr.i.48, align 2
  store i16 %111, i16* %d.addr.i.49, align 2
  store i16 9, i16* @curtask, align 2
  %112 = load i16, i16* %d.addr.i.49, align 2
  %sub.i.52 = sub i16 %112, 8
  store i16 %sub.i.52, i16* %offset.i.51, align 2
  %113 = load i16, i16* %offset.i.51, align 2
  %call.i.53 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %113) #4
  store i16 0, i16* %i.i.50, align 2
  br label %for.cond.i.55

for.cond.i.55:                                    ; preds = %for.body.i.57, %reduce_quotient.exit
  %114 = load i16, i16* %i.i.50, align 2
  %115 = load i16, i16* %offset.i.51, align 2
  %cmp.i.54 = icmp ult i16 %114, %115
  br i1 %cmp.i.54, label %for.body.i.57, label %for.end.i

for.body.i.57:                                    ; preds = %for.cond.i.55
  %116 = load i16, i16* %i.i.50, align 2
  %117 = load i16*, i16** %product.addr.i, align 2
  %arrayidx.i.56 = getelementptr inbounds i16, i16* %117, i16 %116
  store i16 0, i16* %arrayidx.i.56, align 2
  %118 = load i16, i16* %i.i.50, align 2
  %inc.i.58 = add nsw i16 %118, 1
  store i16 %inc.i.58, i16* %i.i.50, align 2
  br label %for.cond.i.55

for.end.i:                                        ; preds = %for.cond.i.55
  store i16 0, i16* %c.i, align 2
  %119 = load i16, i16* %offset.i.51, align 2
  store i16 %119, i16* %i.i.50, align 2
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %if.end.i.68, %for.end.i
  %120 = load i16, i16* %i.i.50, align 2
  %cmp2.i = icmp slt i16 %120, 16
  br i1 %cmp2.i, label %for.body.3.i, label %reduce_multiply.exit

for.body.3.i:                                     ; preds = %for.cond.1.i
  store i16 24, i16* @curtask, align 2
  %121 = load i16, i16* %c.i, align 2
  store i16 %121, i16* %p.i, align 2
  %122 = load i16, i16* %i.i.50, align 2
  %123 = load i16, i16* %offset.i.51, align 2
  %add.i.59 = add i16 %123, 8
  %cmp4.i.60 = icmp ult i16 %122, %add.i.59
  br i1 %cmp4.i.60, label %if.then.i.63, label %if.else.i.64

if.then.i.63:                                     ; preds = %for.body.3.i
  %124 = load i16, i16* %i.i.50, align 2
  %125 = load i16, i16* %offset.i.51, align 2
  %sub5.i = sub i16 %124, %125
  %126 = load i16*, i16** %n.addr.i.48, align 2
  %arrayidx6.i.61 = getelementptr inbounds i16, i16* %126, i16 %sub5.i
  %127 = load i16, i16* %arrayidx6.i.61, align 2
  store i16 %127, i16* %nd.i, align 2
  %128 = load i16, i16* %q.addr.i, align 2
  %129 = load i16, i16* %nd.i, align 2
  %mul.i = mul i16 %128, %129
  %130 = load i16, i16* %p.i, align 2
  %add7.i.62 = add i16 %130, %mul.i
  store i16 %add7.i.62, i16* %p.i, align 2
  br label %if.end.i.68

if.else.i.64:                                     ; preds = %for.body.3.i
  store i16 0, i16* %nd.i, align 2
  br label %if.end.i.68

if.end.i.68:                                      ; preds = %if.else.i.64, %if.then.i.63
  %131 = load i16, i16* %p.i, align 2
  %shr.i.65 = lshr i16 %131, 8
  store i16 %shr.i.65, i16* %c.i, align 2
  %132 = load i16, i16* %p.i, align 2
  %and.i.66 = and i16 %132, 255
  store i16 %and.i.66, i16* %p.i, align 2
  %133 = load i16, i16* %p.i, align 2
  %134 = load i16, i16* %i.i.50, align 2
  %135 = load i16*, i16** %product.addr.i, align 2
  %arrayidx8.i.67 = getelementptr inbounds i16, i16* %135, i16 %134
  store i16 %133, i16* %arrayidx8.i.67, align 2
  %136 = load i16, i16* %i.i.50, align 2
  %inc10.i = add nsw i16 %136, 1
  store i16 %inc10.i, i16* %i.i.50, align 2
  br label %for.cond.1.i

reduce_multiply.exit:                             ; preds = %for.cond.1.i
  store i16 33, i16* @curtask, align 2
  %137 = load i16*, i16** %m.addr, align 2
  store i16* %137, i16** %a.addr.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i, align 2
  store i16 0, i16* %relation.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69, align 2
  br label %for.cond.i.71

for.cond.i.71:                                    ; preds = %if.end.i.76, %reduce_multiply.exit
  %138 = load i16, i16* %i.i.69, align 2
  %cmp.i.70 = icmp sge i16 %138, 0
  br i1 %cmp.i.70, label %for.body.i.72, label %reduce_compare.exit

for.body.i.72:                                    ; preds = %for.cond.i.71
  %139 = load i16*, i16** %a.addr.i, align 2
  %140 = load i16*, i16** %b.addr.i, align 2
  %cmp1.i = icmp ugt i16* %139, %140
  br i1 %cmp1.i, label %if.then.i.73, label %if.else.i.75

if.then.i.73:                                     ; preds = %for.body.i.72
  store i16 1, i16* %relation.i, align 2
  br label %reduce_compare.exit

if.else.i.75:                                     ; preds = %for.body.i.72
  %141 = load i16*, i16** %a.addr.i, align 2
  %142 = load i16*, i16** %b.addr.i, align 2
  %cmp2.i.74 = icmp ult i16* %141, %142
  br i1 %cmp2.i.74, label %if.then.3.i, label %if.end.i.76

if.then.3.i:                                      ; preds = %if.else.i.75
  store i16 -1, i16* %relation.i, align 2
  br label %reduce_compare.exit

if.end.i.76:                                      ; preds = %if.else.i.75
  %143 = load i16, i16* %i.i.69, align 2
  %dec.i.77 = add nsw i16 %143, -1
  store i16 %dec.i.77, i16* %i.i.69, align 2
  br label %for.cond.i.71

reduce_compare.exit:                              ; preds = %for.cond.i.71, %if.then.i.73, %if.then.3.i
  store i16 31, i16* @curtask, align 2
  %144 = load i16, i16* %relation.i, align 2
  %cmp10 = icmp slt i16 %144, 0
  br i1 %cmp10, label %if.then.11, label %if.end.12

if.then.11:                                       ; preds = %reduce_compare.exit
  %145 = load i16*, i16** %m.addr, align 2
  %146 = load i16*, i16** %n.addr, align 2
  %147 = load i16, i16* %d, align 2
  store i16* %145, i16** %a.addr.i.79, align 2
  store i16* %146, i16** %b.addr.i.80, align 2
  store i16 %147, i16* %d.addr.i.81, align 2
  store i16 10, i16* @curtask, align 2
  %148 = load i16, i16* %d.addr.i.81, align 2
  %sub.i.85 = sub i16 %148, 8
  store i16 %sub.i.85, i16* %offset.i.83, align 2
  store i16 0, i16* %c.i.84, align 2
  %149 = load i16, i16* %offset.i.83, align 2
  store i16 %149, i16* %i.i.82, align 2
  br label %for.cond.i.87

for.cond.i.87:                                    ; preds = %if.end.i.100, %if.then.11
  %150 = load i16, i16* %i.i.82, align 2
  %cmp.i.86 = icmp slt i16 %150, 16
  br i1 %cmp.i.86, label %for.body.i.92, label %reduce_add.exit

for.body.i.92:                                    ; preds = %for.cond.i.87
  store i16 22, i16* @curtask, align 2
  %151 = load i16, i16* %i.i.82, align 2
  %152 = load i16*, i16** %a.addr.i.79, align 2
  %arrayidx.i.88 = getelementptr inbounds i16, i16* %152, i16 %151
  %153 = load i16, i16* %arrayidx.i.88, align 2
  store i16 %153, i16* %m.i, align 2
  %154 = load i16, i16* %i.i.82, align 2
  %155 = load i16, i16* %offset.i.83, align 2
  %sub1.i.89 = sub i16 %154, %155
  store i16 %sub1.i.89, i16* %j.i, align 2
  %156 = load i16, i16* %i.i.82, align 2
  %157 = load i16, i16* %offset.i.83, align 2
  %add.i.90 = add i16 %157, 8
  %cmp2.i.91 = icmp ult i16 %156, %add.i.90
  br i1 %cmp2.i.91, label %if.then.i.94, label %if.else.i.95

if.then.i.94:                                     ; preds = %for.body.i.92
  %158 = load i16, i16* %j.i, align 2
  %159 = load i16*, i16** %b.addr.i.80, align 2
  %arrayidx3.i.93 = getelementptr inbounds i16, i16* %159, i16 %158
  %160 = load i16, i16* %arrayidx3.i.93, align 2
  store i16 %160, i16* %n.i, align 2
  br label %if.end.i.100

if.else.i.95:                                     ; preds = %for.body.i.92
  store i16 0, i16* %n.i, align 2
  store i16 0, i16* %j.i, align 2
  br label %if.end.i.100

if.end.i.100:                                     ; preds = %if.else.i.95, %if.then.i.94
  %161 = load i16, i16* %c.i.84, align 2
  %162 = load i16, i16* %m.i, align 2
  %add4.i = add i16 %161, %162
  %163 = load i16, i16* %n.i, align 2
  %add5.i.96 = add i16 %add4.i, %163
  store i16 %add5.i.96, i16* %r.i, align 2
  %164 = load i16, i16* %r.i, align 2
  %shr.i.97 = lshr i16 %164, 8
  store i16 %shr.i.97, i16* %c.i.84, align 2
  %165 = load i16, i16* %r.i, align 2
  %and.i.98 = and i16 %165, 255
  store i16 %and.i.98, i16* %r.i, align 2
  %166 = load i16, i16* %r.i, align 2
  %167 = load i16, i16* %i.i.82, align 2
  %168 = load i16*, i16** %a.addr.i.79, align 2
  %arrayidx6.i.99 = getelementptr inbounds i16, i16* %168, i16 %167
  store i16 %166, i16* %arrayidx6.i.99, align 2
  %169 = load i16, i16* %i.i.82, align 2
  %inc.i.101 = add nsw i16 %169, 1
  store i16 %inc.i.101, i16* %i.i.82, align 2
  br label %for.cond.i.87

reduce_add.exit:                                  ; preds = %for.cond.i.87
  store i16 34, i16* @curtask, align 2
  br label %if.end.12

if.end.12:                                        ; preds = %reduce_add.exit, %reduce_compare.exit
  %170 = load i16*, i16** %m.addr, align 2
  %171 = load i16, i16* %d, align 2
  store i16* %170, i16** %a.addr.i.103, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104, align 2
  store i16 %171, i16* %d.addr.i.105, align 2
  store i16 11, i16* @curtask, align 2
  %172 = load i16, i16* %d.addr.i.105, align 2
  %sub.i.113 = sub i16 %172, 8
  store i16 %sub.i.113, i16* %offset.i.112, align 2
  %173 = load i16, i16* %d.addr.i.105, align 2
  %174 = load i16, i16* %offset.i.112, align 2
  %call.i.114 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %173, i16 %174) #4
  store i16 0, i16* %borrow.i.111, align 2
  %175 = load i16, i16* %offset.i.112, align 2
  store i16 %175, i16* %i.i.106, align 2
  br label %for.cond.i.116

for.cond.i.116:                                   ; preds = %if.end.i.126, %if.end.12
  %176 = load i16, i16* %i.i.106, align 2
  %cmp.i.115 = icmp slt i16 %176, 16
  br i1 %cmp.i.115, label %for.body.i.121, label %reduce_subtract.exit

for.body.i.121:                                   ; preds = %for.cond.i.116
  store i16 23, i16* @curtask, align 2
  %177 = load i16, i16* %i.i.106, align 2
  %178 = load i16*, i16** %a.addr.i.103, align 2
  %arrayidx.i.117 = getelementptr inbounds i16, i16* %178, i16 %177
  %179 = load i16, i16* %arrayidx.i.117, align 2
  store i16 %179, i16* %m.i.107, align 2
  %180 = load i16, i16* %i.i.106, align 2
  %181 = load i16*, i16** %b.addr.i.104, align 2
  %arrayidx1.i.118 = getelementptr inbounds i16, i16* %181, i16 %180
  %182 = load i16, i16* %arrayidx1.i.118, align 2
  store i16 %182, i16* %qn.i.110, align 2
  %183 = load i16, i16* %qn.i.110, align 2
  %184 = load i16, i16* %borrow.i.111, align 2
  %add.i.119 = add i16 %183, %184
  store i16 %add.i.119, i16* %s.i.108, align 2
  %185 = load i16, i16* %m.i.107, align 2
  %186 = load i16, i16* %s.i.108, align 2
  %cmp2.i.120 = icmp ult i16 %185, %186
  br i1 %cmp2.i.120, label %if.then.i.123, label %if.else.i.124

if.then.i.123:                                    ; preds = %for.body.i.121
  %187 = load i16, i16* %m.i.107, align 2
  %add3.i.122 = add i16 %187, 256
  store i16 %add3.i.122, i16* %m.i.107, align 2
  store i16 1, i16* %borrow.i.111, align 2
  br label %if.end.i.126

if.else.i.124:                                    ; preds = %for.body.i.121
  store i16 0, i16* %borrow.i.111, align 2
  br label %if.end.i.126

if.end.i.126:                                     ; preds = %if.else.i.124, %if.then.i.123
  %188 = load i16, i16* %m.i.107, align 2
  %189 = load i16, i16* %s.i.108, align 2
  %sub4.i = sub i16 %188, %189
  store i16 %sub4.i, i16* %r.i.109, align 2
  %190 = load i16, i16* %r.i.109, align 2
  %191 = load i16, i16* %i.i.106, align 2
  %192 = load i16*, i16** %a.addr.i.103, align 2
  %arrayidx5.i.125 = getelementptr inbounds i16, i16* %192, i16 %191
  store i16 %190, i16* %arrayidx5.i.125, align 2
  %193 = load i16, i16* %i.i.106, align 2
  %inc.i.127 = add nsw i16 %193, 1
  store i16 %inc.i.127, i16* %i.i.106, align 2
  br label %for.cond.i.116

reduce_subtract.exit:                             ; preds = %for.cond.i.116
  store i16 35, i16* @curtask, align 2
  %194 = load i16, i16* %d, align 2
  %dec13 = add i16 %194, -1
  store i16 %dec13, i16* %d, align 2
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i16 28, i16* @curtask, align 2
  br label %return

return:                                           ; preds = %while.end, %if.then.5
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @mod_mult(i16* %a, i16* %b, i16* %n) #1 {
entry:
  %a.addr.i.103.i = alloca i16*, align 2
  %b.addr.i.104.i = alloca i16*, align 2
  %d.addr.i.105.i = alloca i16, align 2
  %i.i.106.i = alloca i16, align 2
  %m.i.107.i = alloca i16, align 2
  %s.i.108.i = alloca i16, align 2
  %r.i.109.i = alloca i16, align 2
  %qn.i.110.i = alloca i16, align 2
  %borrow.i.111.i = alloca i16, align 2
  %offset.i.112.i = alloca i16, align 2
  %a.addr.i.79.i = alloca i16*, align 2
  %b.addr.i.80.i = alloca i16*, align 2
  %d.addr.i.81.i = alloca i16, align 2
  %i.i.82.i = alloca i16, align 2
  %j.i.i = alloca i16, align 2
  %offset.i.83.i = alloca i16, align 2
  %c.i.84.i = alloca i16, align 2
  %r.i.i = alloca i16, align 2
  %m.i.i = alloca i16, align 2
  %n.i.i = alloca i16, align 2
  %a.addr.i.i = alloca i16*, align 2
  %b.addr.i.i = alloca i16*, align 2
  %i.i.69.i = alloca i16, align 2
  %relation.i.i = alloca i16, align 2
  %product.addr.i.i = alloca i16*, align 2
  %q.addr.i.i = alloca i16, align 2
  %n.addr.i.48.i = alloca i16*, align 2
  %d.addr.i.49.i = alloca i16, align 2
  %i.i.50.i = alloca i16, align 2
  %offset.i.51.i = alloca i16, align 2
  %c.i.i = alloca i16, align 2
  %p.i.i = alloca i16, align 2
  %nd.i.i = alloca i16, align 2
  %quotient.addr.i.i = alloca i16*, align 2
  %m.addr.i.31.i = alloca i16*, align 2
  %n.addr.i.32.i = alloca i16*, align 2
  %d.addr.i.33.i = alloca i16, align 2
  %m_d.i.34.i = alloca [3 x i16], align 2
  %q.i.i = alloca i16, align 2
  %n_div.i.i = alloca i16, align 2
  %n_n.i.i = alloca i16, align 2
  %n_q.i.i = alloca i32, align 2
  %qn.i.i = alloca i32, align 2
  %m_dividend.i.i = alloca i16, align 2
  %m.addr.i.14.i = alloca i16*, align 2
  %n.addr.i.15.i = alloca i16*, align 2
  %digit.addr.i.i = alloca i16, align 2
  %i.i.16.i = alloca i16, align 2
  %d.i.i = alloca i16, align 2
  %s.i.i = alloca i16, align 2
  %m_d.i.17.i = alloca i16, align 2
  %n_d.i.18.i = alloca i16, align 2
  %borrow.i.i = alloca i16, align 2
  %offset.i.19.i = alloca i16, align 2
  %m.addr.i.i = alloca i16*, align 2
  %n.addr.i.i = alloca i16*, align 2
  %d.addr.i.i = alloca i16, align 2
  %i.i.i = alloca i16, align 2
  %offset.i.i = alloca i16, align 2
  %n_d.i.i = alloca i16, align 2
  %m_d.i.i = alloca i16, align 2
  %normalizable.i.i = alloca i8, align 1
  %m.addr.i = alloca i16*, align 2
  %n.addr.i = alloca i16*, align 2
  %q.i = alloca i16, align 2
  %m_d.i = alloca i16, align 2
  %d.i = alloca i16, align 2
  %a.addr.i = alloca i16*, align 2
  %b.addr.i = alloca i16*, align 2
  %i.i = alloca i16, align 2
  %digit.i = alloca i16, align 2
  %p.i = alloca i16, align 2
  %c.i = alloca i16, align 2
  %dp.i = alloca i16, align 2
  %carry.i = alloca i16, align 2
  %a.addr = alloca i16*, align 2
  %b.addr = alloca i16*, align 2
  %n.addr = alloca i16*, align 2
  store i16* %a, i16** %a.addr, align 2
  store i16* %b, i16** %b.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  %0 = load i16*, i16** %a.addr, align 2
  %1 = load i16*, i16** %b.addr, align 2
  store i16* %0, i16** %a.addr.i, align 2
  store i16* %1, i16** %b.addr.i, align 2
  store i16 0, i16* %carry.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i, align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.end.i, %entry
  %2 = load i16, i16* %digit.i, align 2
  %cmp.i = icmp ult i16 %2, 16
  br i1 %cmp.i, label %for.body.i, label %for.end.15.i

for.body.i:                                       ; preds = %for.cond.i
  store i16 14, i16* @curtask, align 2
  %3 = load i16, i16* %carry.i, align 2
  store i16 %3, i16* %p.i, align 2
  store i16 0, i16* %c.i, align 2
  store i16 0, i16* %i.i, align 2
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %if.end.i, %for.body.i
  %4 = load i16, i16* %i.i, align 2
  %cmp2.i = icmp slt i16 %4, 8
  br i1 %cmp2.i, label %for.body.3.i, label %for.end.i

for.body.3.i:                                     ; preds = %for.cond.1.i
  %5 = load i16, i16* %i.i, align 2
  %6 = load i16, i16* %digit.i, align 2
  %cmp4.i = icmp ule i16 %5, %6
  br i1 %cmp4.i, label %land.lhs.true.i, label %if.end.i

land.lhs.true.i:                                  ; preds = %for.body.3.i
  %7 = load i16, i16* %digit.i, align 2
  %8 = load i16, i16* %i.i, align 2
  %sub.i = sub i16 %7, %8
  %cmp5.i = icmp ult i16 %sub.i, 8
  br i1 %cmp5.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %land.lhs.true.i
  %9 = load i16, i16* %digit.i, align 2
  %10 = load i16, i16* %i.i, align 2
  %sub6.i = sub i16 %9, %10
  %11 = load i16*, i16** %a.addr.i, align 2
  %arrayidx.i = getelementptr inbounds i16, i16* %11, i16 %sub6.i
  %12 = load i16, i16* %arrayidx.i, align 2
  %13 = load i16, i16* %i.i, align 2
  %14 = load i16*, i16** %b.addr.i, align 2
  %arrayidx7.i = getelementptr inbounds i16, i16* %14, i16 %13
  %15 = load i16, i16* %arrayidx7.i, align 2
  %mul.i = mul i16 %12, %15
  store i16 %mul.i, i16* %dp.i, align 2
  %16 = load i16, i16* %dp.i, align 2
  %shr.i = lshr i16 %16, 8
  %17 = load i16, i16* %c.i, align 2
  %add.i = add i16 %17, %shr.i
  store i16 %add.i, i16* %c.i, align 2
  %18 = load i16, i16* %dp.i, align 2
  %and.i = and i16 %18, 255
  %19 = load i16, i16* %p.i, align 2
  %add8.i = add i16 %19, %and.i
  store i16 %add8.i, i16* %p.i, align 2
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %land.lhs.true.i, %for.body.3.i
  %20 = load i16, i16* %i.i, align 2
  %inc.i = add nsw i16 %20, 1
  store i16 %inc.i, i16* %i.i, align 2
  br label %for.cond.1.i

for.end.i:                                        ; preds = %for.cond.1.i
  %21 = load i16, i16* %p.i, align 2
  %shr9.i = lshr i16 %21, 8
  %22 = load i16, i16* %c.i, align 2
  %add10.i = add i16 %22, %shr9.i
  store i16 %add10.i, i16* %c.i, align 2
  %23 = load i16, i16* %p.i, align 2
  %and11.i = and i16 %23, 255
  store i16 %and11.i, i16* %p.i, align 2
  %24 = load i16, i16* %p.i, align 2
  %25 = load i16, i16* %digit.i, align 2
  %arrayidx12.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %25
  store i16 %24, i16* %arrayidx12.i, align 2
  %26 = load i16, i16* %c.i, align 2
  store i16 %26, i16* %carry.i, align 2
  %27 = load i16, i16* %digit.i, align 2
  %inc14.i = add i16 %27, 1
  store i16 %inc14.i, i16* %digit.i, align 2
  br label %for.cond.i

for.end.15.i:                                     ; preds = %for.cond.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i, align 2
  br label %for.cond.16.i

for.cond.16.i:                                    ; preds = %for.body.18.i, %for.end.15.i
  %28 = load i16, i16* %i.i, align 2
  %cmp17.i = icmp slt i16 %28, 16
  br i1 %cmp17.i, label %for.body.18.i, label %mult.exit

for.body.18.i:                                    ; preds = %for.cond.16.i
  %29 = load i16, i16* %i.i, align 2
  %arrayidx19.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %29
  %30 = load i16, i16* %arrayidx19.i, align 2
  %31 = load i16, i16* %i.i, align 2
  %32 = load i16*, i16** %a.addr.i, align 2
  %arrayidx20.i = getelementptr inbounds i16, i16* %32, i16 %31
  store i16 %30, i16* %arrayidx20.i, align 2
  %33 = load i16, i16* %i.i, align 2
  %inc22.i = add nsw i16 %33, 1
  store i16 %inc22.i, i16* %i.i, align 2
  br label %for.cond.16.i

mult.exit:                                        ; preds = %for.cond.16.i
  store i16 27, i16* @curtask, align 2
  %34 = load i16*, i16** %a.addr, align 2
  %35 = load i16*, i16** %n.addr, align 2
  store i16* %34, i16** %m.addr.i, align 2
  store i16* %35, i16** %n.addr.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i, align 2
  br label %do.body.i

do.body.i:                                        ; preds = %land.end.i, %mult.exit
  %36 = load i16, i16* %d.i, align 2
  %dec.i = add i16 %36, -1
  store i16 %dec.i, i16* %d.i, align 2
  %37 = load i16, i16* %d.i, align 2
  %38 = load i16*, i16** %m.addr.i, align 2
  %arrayidx.i.1 = getelementptr inbounds i16, i16* %38, i16 %37
  %39 = load i16, i16* %arrayidx.i.1, align 2
  store i16 %39, i16* %m_d.i, align 2
  %40 = load i16, i16* %d.i, align 2
  %41 = load i16, i16* %m_d.i, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %40, i16 %41) #4
  %42 = load i16, i16* %m_d.i, align 2
  %cmp.i.2 = icmp eq i16 %42, 0
  br i1 %cmp.i.2, label %land.rhs.i, label %land.end.i

land.rhs.i:                                       ; preds = %do.body.i
  %43 = load i16, i16* %d.i, align 2
  %cmp1.i = icmp ugt i16 %43, 0
  br label %land.end.i

land.end.i:                                       ; preds = %land.rhs.i, %do.body.i
  %44 = phi i1 [ false, %do.body.i ], [ %cmp1.i, %land.rhs.i ]
  br i1 %44, label %do.body.i, label %do.end.i

do.end.i:                                         ; preds = %land.end.i
  %45 = load i16, i16* %d.i, align 2
  %call2.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %45) #4
  %46 = load i16*, i16** %m.addr.i, align 2
  %47 = load i16*, i16** %n.addr.i, align 2
  %48 = load i16, i16* %d.i, align 2
  store i16* %46, i16** %m.addr.i.i, align 2
  store i16* %47, i16** %n.addr.i.i, align 2
  store i16 %48, i16* %d.addr.i.i, align 2
  store i8 1, i8* %normalizable.i.i, align 1
  store i16 6, i16* @curtask, align 2
  %49 = load i16, i16* %d.addr.i.i, align 2
  %add.i.i = add i16 %49, 1
  %sub.i.i = sub i16 %add.i.i, 8
  store i16 %sub.i.i, i16* %offset.i.i, align 2
  %50 = load i16, i16* %d.addr.i.i, align 2
  %51 = load i16, i16* %offset.i.i, align 2
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %50, i16 %51) #4
  %52 = load i16, i16* %d.addr.i.i, align 2
  store i16 %52, i16* %i.i.i, align 2
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %if.end.i.i, %do.end.i
  %53 = load i16, i16* %i.i.i, align 2
  %cmp.i.i = icmp sge i16 %53, 0
  br i1 %cmp.i.i, label %for.body.i.i, label %reduce_normalizable.exit.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  %54 = load i16, i16* %i.i.i, align 2
  %55 = load i16*, i16** %m.addr.i.i, align 2
  %arrayidx.i.i = getelementptr inbounds i16, i16* %55, i16 %54
  %56 = load i16, i16* %arrayidx.i.i, align 2
  store i16 %56, i16* %m_d.i.i, align 2
  %57 = load i16, i16* %i.i.i, align 2
  %58 = load i16, i16* %offset.i.i, align 2
  %sub1.i.i = sub i16 %57, %58
  %59 = load i16*, i16** %n.addr.i.i, align 2
  %arrayidx2.i.i = getelementptr inbounds i16, i16* %59, i16 %sub1.i.i
  %60 = load i16, i16* %arrayidx2.i.i, align 2
  store i16 %60, i16* %n_d.i.i, align 2
  %61 = load i16, i16* %m_d.i.i, align 2
  %62 = load i16, i16* %n_d.i.i, align 2
  %cmp3.i.i = icmp ugt i16 %61, %62
  br i1 %cmp3.i.i, label %if.then.i.i, label %if.else.i.i

if.then.i.i:                                      ; preds = %for.body.i.i
  br label %reduce_normalizable.exit.i

if.else.i.i:                                      ; preds = %for.body.i.i
  %63 = load i16, i16* %m_d.i.i, align 2
  %64 = load i16, i16* %n_d.i.i, align 2
  %cmp4.i.i = icmp ult i16 %63, %64
  br i1 %cmp4.i.i, label %if.then.5.i.i, label %if.end.i.i

if.then.5.i.i:                                    ; preds = %if.else.i.i
  store i8 0, i8* %normalizable.i.i, align 1
  br label %reduce_normalizable.exit.i

if.end.i.i:                                       ; preds = %if.else.i.i
  %65 = load i16, i16* %i.i.i, align 2
  %dec.i.i = add nsw i16 %65, -1
  store i16 %dec.i.i, i16* %i.i.i, align 2
  br label %for.cond.i.i

reduce_normalizable.exit.i:                       ; preds = %if.then.5.i.i, %if.then.i.i, %for.cond.i.i
  %66 = load i8, i8* %normalizable.i.i, align 1
  %tobool.i.i = trunc i8 %66 to i1
  %conv.i.i = zext i1 %tobool.i.i to i16
  %call7.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i) #4
  store i16 30, i16* @curtask, align 2
  %67 = load i8, i8* %normalizable.i.i, align 1
  %tobool8.i.i = trunc i8 %67 to i1
  br i1 %tobool8.i.i, label %if.then.i.3, label %if.else.i

if.then.i.3:                                      ; preds = %reduce_normalizable.exit.i
  %68 = load i16*, i16** %m.addr.i, align 2
  %69 = load i16*, i16** %n.addr.i, align 2
  %70 = load i16, i16* %d.i, align 2
  store i16* %68, i16** %m.addr.i.14.i, align 2
  store i16* %69, i16** %n.addr.i.15.i, align 2
  store i16 %70, i16* %digit.addr.i.i, align 2
  store i16 5, i16* @curtask, align 2
  %71 = load i16, i16* %digit.addr.i.i, align 2
  %add.i.20.i = add i16 %71, 1
  %sub.i.21.i = sub i16 %add.i.20.i, 8
  store i16 %sub.i.21.i, i16* %offset.i.19.i, align 2
  store i16 0, i16* %borrow.i.i, align 2
  store i16 0, i16* %i.i.16.i, align 2
  br label %for.cond.i.23.i

for.cond.i.23.i:                                  ; preds = %if.end.i.30.i, %if.then.i.3
  %72 = load i16, i16* %i.i.16.i, align 2
  %cmp.i.22.i = icmp slt i16 %72, 8
  br i1 %cmp.i.22.i, label %for.body.i.27.i, label %reduce_normalize.exit.i

for.body.i.27.i:                                  ; preds = %for.cond.i.23.i
  store i16 21, i16* @curtask, align 2
  %73 = load i16, i16* %i.i.16.i, align 2
  %74 = load i16, i16* %offset.i.19.i, align 2
  %add1.i.i = add i16 %73, %74
  %75 = load i16*, i16** %m.addr.i.14.i, align 2
  %arrayidx.i.24.i = getelementptr inbounds i16, i16* %75, i16 %add1.i.i
  %76 = load i16, i16* %arrayidx.i.24.i, align 2
  store i16 %76, i16* %m_d.i.17.i, align 2
  %77 = load i16, i16* %i.i.16.i, align 2
  %78 = load i16*, i16** %n.addr.i.15.i, align 2
  %arrayidx2.i.25.i = getelementptr inbounds i16, i16* %78, i16 %77
  %79 = load i16, i16* %arrayidx2.i.25.i, align 2
  store i16 %79, i16* %n_d.i.18.i, align 2
  %80 = load i16, i16* %n_d.i.18.i, align 2
  %81 = load i16, i16* %borrow.i.i, align 2
  %add3.i.i = add i16 %80, %81
  store i16 %add3.i.i, i16* %s.i.i, align 2
  %82 = load i16, i16* %m_d.i.17.i, align 2
  %83 = load i16, i16* %s.i.i, align 2
  %cmp4.i.26.i = icmp ult i16 %82, %83
  br i1 %cmp4.i.26.i, label %if.then.i.28.i, label %if.else.i.29.i

if.then.i.28.i:                                   ; preds = %for.body.i.27.i
  %84 = load i16, i16* %m_d.i.17.i, align 2
  %add5.i.i = add i16 %84, 256
  store i16 %add5.i.i, i16* %m_d.i.17.i, align 2
  store i16 1, i16* %borrow.i.i, align 2
  br label %if.end.i.30.i

if.else.i.29.i:                                   ; preds = %for.body.i.27.i
  store i16 0, i16* %borrow.i.i, align 2
  br label %if.end.i.30.i

if.end.i.30.i:                                    ; preds = %if.else.i.29.i, %if.then.i.28.i
  %85 = load i16, i16* %m_d.i.17.i, align 2
  %86 = load i16, i16* %s.i.i, align 2
  %sub6.i.i = sub i16 %85, %86
  store i16 %sub6.i.i, i16* %d.i.i, align 2
  %87 = load i16, i16* %d.i.i, align 2
  %88 = load i16, i16* %i.i.16.i, align 2
  %89 = load i16, i16* %offset.i.19.i, align 2
  %add7.i.i = add i16 %88, %89
  %90 = load i16*, i16** %m.addr.i.14.i, align 2
  %arrayidx8.i.i = getelementptr inbounds i16, i16* %90, i16 %add7.i.i
  store i16 %87, i16* %arrayidx8.i.i, align 2
  %91 = load i16, i16* %i.i.16.i, align 2
  %inc.i.i = add nsw i16 %91, 1
  store i16 %inc.i.i, i16* %i.i.16.i, align 2
  br label %for.cond.i.23.i

reduce_normalize.exit.i:                          ; preds = %for.cond.i.23.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i

if.else.i:                                        ; preds = %reduce_normalizable.exit.i
  %92 = load i16, i16* %d.i, align 2
  %cmp4.i.4 = icmp eq i16 %92, 7
  br i1 %cmp4.i.4, label %if.then.5.i, label %if.end.i.5

if.then.5.i:                                      ; preds = %if.else.i
  %call6.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %reduce.exit

if.end.i.5:                                       ; preds = %if.else.i
  br label %if.end.7.i

if.end.7.i:                                       ; preds = %if.end.i.5, %reduce_normalize.exit.i
  br label %while.cond.i

while.cond.i:                                     ; preds = %reduce_subtract.exit.i, %if.end.7.i
  %93 = load i16, i16* %d.i, align 2
  %cmp8.i = icmp uge i16 %93, 8
  br i1 %cmp8.i, label %while.body.i, label %while.end.i

while.body.i:                                     ; preds = %while.cond.i
  %94 = load i16*, i16** %m.addr.i, align 2
  %95 = load i16*, i16** %n.addr.i, align 2
  %96 = load i16, i16* %d.i, align 2
  store i16* %q.i, i16** %quotient.addr.i.i, align 2
  store i16* %94, i16** %m.addr.i.31.i, align 2
  store i16* %95, i16** %n.addr.i.32.i, align 2
  store i16 %96, i16* %d.addr.i.33.i, align 2
  store i16 16, i16* @curtask, align 2
  %97 = load i16*, i16** %n.addr.i.32.i, align 2
  %arrayidx.i.35.i = getelementptr inbounds i16, i16* %97, i16 7
  %98 = load i16, i16* %arrayidx.i.35.i, align 2
  %shl.i.i = shl i16 %98, 8
  %99 = load i16*, i16** %n.addr.i.32.i, align 2
  %arrayidx1.i.i = getelementptr inbounds i16, i16* %99, i16 6
  %100 = load i16, i16* %arrayidx1.i.i, align 2
  %add.i.36.i = add i16 %shl.i.i, %100
  store i16 %add.i.36.i, i16* %n_div.i.i, align 2
  %101 = load i16*, i16** %n.addr.i.32.i, align 2
  %arrayidx2.i.37.i = getelementptr inbounds i16, i16* %101, i16 7
  %102 = load i16, i16* %arrayidx2.i.37.i, align 2
  store i16 %102, i16* %n_n.i.i, align 2
  %103 = load i16, i16* %d.addr.i.33.i, align 2
  %104 = load i16*, i16** %m.addr.i.31.i, align 2
  %arrayidx3.i.i = getelementptr inbounds i16, i16* %104, i16 %103
  %105 = load i16, i16* %arrayidx3.i.i, align 2
  %arrayidx4.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  store i16 %105, i16* %arrayidx4.i.i, align 2
  %106 = load i16, i16* %d.addr.i.33.i, align 2
  %sub.i.38.i = sub i16 %106, 1
  %107 = load i16*, i16** %m.addr.i.31.i, align 2
  %arrayidx5.i.i = getelementptr inbounds i16, i16* %107, i16 %sub.i.38.i
  %108 = load i16, i16* %arrayidx5.i.i, align 2
  %arrayidx6.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  store i16 %108, i16* %arrayidx6.i.i, align 2
  %109 = load i16, i16* %d.addr.i.33.i, align 2
  %sub7.i.i = sub i16 %109, 2
  %110 = load i16*, i16** %m.addr.i.31.i, align 2
  %arrayidx8.i.39.i = getelementptr inbounds i16, i16* %110, i16 %sub7.i.i
  %111 = load i16, i16* %arrayidx8.i.39.i, align 2
  %arrayidx9.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  store i16 %111, i16* %arrayidx9.i.i, align 2
  %112 = load i16, i16* %n_n.i.i, align 2
  %113 = load i16*, i16** %m.addr.i.31.i, align 2
  %arrayidx10.i.i = getelementptr inbounds i16, i16* %113, i16 2
  %114 = load i16, i16* %arrayidx10.i.i, align 2
  %call.i.40.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %112, i16 %114) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %115 = load i16, i16* %arrayidx11.i.i, align 2
  %116 = load i16, i16* %n_n.i.i, align 2
  %cmp.i.41.i = icmp eq i16 %115, %116
  br i1 %cmp.i.41.i, label %if.then.i.42.i, label %if.else.i.43.i

if.then.i.42.i:                                   ; preds = %while.body.i
  store i16 255, i16* %q.i.i, align 2
  br label %if.end.i.46.i

if.else.i.43.i:                                   ; preds = %while.body.i
  %arrayidx12.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %117 = load i16, i16* %arrayidx12.i.i, align 2
  %shl13.i.i = shl i16 %117, 8
  %arrayidx14.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %118 = load i16, i16* %arrayidx14.i.i, align 2
  %add15.i.i = add i16 %shl13.i.i, %118
  store i16 %add15.i.i, i16* %m_dividend.i.i, align 2
  %119 = load i16, i16* %m_dividend.i.i, align 2
  %120 = load i16, i16* %n_n.i.i, align 2
  %div.i.i = udiv i16 %119, %120
  store i16 %div.i.i, i16* %q.i.i, align 2
  %121 = load i16, i16* %m_dividend.i.i, align 2
  %122 = load i16, i16* %q.i.i, align 2
  %call16.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %121, i16 %122) #4
  br label %if.end.i.46.i

if.end.i.46.i:                                    ; preds = %if.else.i.43.i, %if.then.i.42.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %123 = load i16, i16* %arrayidx17.i.i, align 2
  %conv.i.44.i = zext i16 %123 to i32
  %shl18.i.i = shl i32 %conv.i.44.i, 16
  %arrayidx19.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %124 = load i16, i16* %arrayidx19.i.i, align 2
  %shl20.i.i = shl i16 %124, 8
  %conv21.i.i = zext i16 %shl20.i.i to i32
  %add22.i.i = add i32 %shl18.i.i, %conv21.i.i
  %arrayidx23.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  %125 = load i16, i16* %arrayidx23.i.i, align 2
  %conv24.i.i = zext i16 %125 to i32
  %add25.i.i = add i32 %add22.i.i, %conv24.i.i
  store i32 %add25.i.i, i32* %n_q.i.i, align 2
  %arrayidx26.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %126 = load i16, i16* %arrayidx26.i.i, align 2
  %arrayidx27.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %127 = load i16, i16* %arrayidx27.i.i, align 2
  %arrayidx28.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  %128 = load i16, i16* %arrayidx28.i.i, align 2
  %129 = load i32, i32* %n_q.i.i, align 2
  %shr.i.i = lshr i32 %129, 16
  %and.i.i = and i32 %shr.i.i, 65535
  %conv29.i.i = trunc i32 %and.i.i to i16
  %130 = load i32, i32* %n_q.i.i, align 2
  %and30.i.i = and i32 %130, 65535
  %conv31.i.i = trunc i32 %and30.i.i to i16
  %call32.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %126, i16 %127, i16 %128, i16 %conv29.i.i, i16 %conv31.i.i) #4
  %131 = load i16, i16* %q.i.i, align 2
  %call33.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %131) #4
  %132 = load i16, i16* %q.i.i, align 2
  %inc.i.45.i = add i16 %132, 1
  store i16 %inc.i.45.i, i16* %q.i.i, align 2
  br label %do.body.i.i

do.body.i.i:                                      ; preds = %do.body.i.i, %if.end.i.46.i
  store i16 19, i16* @curtask, align 2
  %133 = load i16, i16* %q.i.i, align 2
  %dec.i.47.i = add i16 %133, -1
  store i16 %dec.i.47.i, i16* %q.i.i, align 2
  %134 = load i16, i16* %n_div.i.i, align 2
  %135 = load i16, i16* %q.i.i, align 2
  %call34.i.i = call i32 @mult16(i16 zeroext %134, i16 zeroext %135) #4
  store i32 %call34.i.i, i32* %qn.i.i, align 2
  %136 = load i16, i16* %q.i.i, align 2
  %137 = load i16, i16* %n_div.i.i, align 2
  %138 = load i32, i32* %qn.i.i, align 2
  %shr35.i.i = lshr i32 %138, 16
  %and36.i.i = and i32 %shr35.i.i, 65535
  %conv37.i.i = trunc i32 %and36.i.i to i16
  %139 = load i32, i32* %qn.i.i, align 2
  %and38.i.i = and i32 %139, 65535
  %conv39.i.i = trunc i32 %and38.i.i to i16
  %call40.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %136, i16 %137, i16 %conv37.i.i, i16 %conv39.i.i) #4
  %140 = load i32, i32* %qn.i.i, align 2
  %141 = load i32, i32* %n_q.i.i, align 2
  %cmp41.i.i = icmp ugt i32 %140, %141
  br i1 %cmp41.i.i, label %do.body.i.i, label %reduce_quotient.exit.i

reduce_quotient.exit.i:                           ; preds = %do.body.i.i
  %142 = load i16, i16* %q.i.i, align 2
  %call43.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %142) #4
  %143 = load i16, i16* %q.i.i, align 2
  %144 = load i16*, i16** %quotient.addr.i.i, align 2
  store i16 %143, i16* %144, align 2
  store i16 32, i16* @curtask, align 2
  %145 = load i16, i16* %q.i, align 2
  %146 = load i16*, i16** %n.addr.i, align 2
  %147 = load i16, i16* %d.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i, align 2
  store i16 %145, i16* %q.addr.i.i, align 2
  store i16* %146, i16** %n.addr.i.48.i, align 2
  store i16 %147, i16* %d.addr.i.49.i, align 2
  store i16 9, i16* @curtask, align 2
  %148 = load i16, i16* %d.addr.i.49.i, align 2
  %sub.i.52.i = sub i16 %148, 8
  store i16 %sub.i.52.i, i16* %offset.i.51.i, align 2
  %149 = load i16, i16* %offset.i.51.i, align 2
  %call.i.53.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %149) #4
  store i16 0, i16* %i.i.50.i, align 2
  br label %for.cond.i.55.i

for.cond.i.55.i:                                  ; preds = %for.body.i.57.i, %reduce_quotient.exit.i
  %150 = load i16, i16* %i.i.50.i, align 2
  %151 = load i16, i16* %offset.i.51.i, align 2
  %cmp.i.54.i = icmp ult i16 %150, %151
  br i1 %cmp.i.54.i, label %for.body.i.57.i, label %for.end.i.i

for.body.i.57.i:                                  ; preds = %for.cond.i.55.i
  %152 = load i16, i16* %i.i.50.i, align 2
  %153 = load i16*, i16** %product.addr.i.i, align 2
  %arrayidx.i.56.i = getelementptr inbounds i16, i16* %153, i16 %152
  store i16 0, i16* %arrayidx.i.56.i, align 2
  %154 = load i16, i16* %i.i.50.i, align 2
  %inc.i.58.i = add nsw i16 %154, 1
  store i16 %inc.i.58.i, i16* %i.i.50.i, align 2
  br label %for.cond.i.55.i

for.end.i.i:                                      ; preds = %for.cond.i.55.i
  store i16 0, i16* %c.i.i, align 2
  %155 = load i16, i16* %offset.i.51.i, align 2
  store i16 %155, i16* %i.i.50.i, align 2
  br label %for.cond.1.i.i

for.cond.1.i.i:                                   ; preds = %if.end.i.68.i, %for.end.i.i
  %156 = load i16, i16* %i.i.50.i, align 2
  %cmp2.i.i = icmp slt i16 %156, 16
  br i1 %cmp2.i.i, label %for.body.3.i.i, label %reduce_multiply.exit.i

for.body.3.i.i:                                   ; preds = %for.cond.1.i.i
  store i16 24, i16* @curtask, align 2
  %157 = load i16, i16* %c.i.i, align 2
  store i16 %157, i16* %p.i.i, align 2
  %158 = load i16, i16* %i.i.50.i, align 2
  %159 = load i16, i16* %offset.i.51.i, align 2
  %add.i.59.i = add i16 %159, 8
  %cmp4.i.60.i = icmp ult i16 %158, %add.i.59.i
  br i1 %cmp4.i.60.i, label %if.then.i.63.i, label %if.else.i.64.i

if.then.i.63.i:                                   ; preds = %for.body.3.i.i
  %160 = load i16, i16* %i.i.50.i, align 2
  %161 = load i16, i16* %offset.i.51.i, align 2
  %sub5.i.i = sub i16 %160, %161
  %162 = load i16*, i16** %n.addr.i.48.i, align 2
  %arrayidx6.i.61.i = getelementptr inbounds i16, i16* %162, i16 %sub5.i.i
  %163 = load i16, i16* %arrayidx6.i.61.i, align 2
  store i16 %163, i16* %nd.i.i, align 2
  %164 = load i16, i16* %q.addr.i.i, align 2
  %165 = load i16, i16* %nd.i.i, align 2
  %mul.i.i = mul i16 %164, %165
  %166 = load i16, i16* %p.i.i, align 2
  %add7.i.62.i = add i16 %166, %mul.i.i
  store i16 %add7.i.62.i, i16* %p.i.i, align 2
  br label %if.end.i.68.i

if.else.i.64.i:                                   ; preds = %for.body.3.i.i
  store i16 0, i16* %nd.i.i, align 2
  br label %if.end.i.68.i

if.end.i.68.i:                                    ; preds = %if.else.i.64.i, %if.then.i.63.i
  %167 = load i16, i16* %p.i.i, align 2
  %shr.i.65.i = lshr i16 %167, 8
  store i16 %shr.i.65.i, i16* %c.i.i, align 2
  %168 = load i16, i16* %p.i.i, align 2
  %and.i.66.i = and i16 %168, 255
  store i16 %and.i.66.i, i16* %p.i.i, align 2
  %169 = load i16, i16* %p.i.i, align 2
  %170 = load i16, i16* %i.i.50.i, align 2
  %171 = load i16*, i16** %product.addr.i.i, align 2
  %arrayidx8.i.67.i = getelementptr inbounds i16, i16* %171, i16 %170
  store i16 %169, i16* %arrayidx8.i.67.i, align 2
  %172 = load i16, i16* %i.i.50.i, align 2
  %inc10.i.i = add nsw i16 %172, 1
  store i16 %inc10.i.i, i16* %i.i.50.i, align 2
  br label %for.cond.1.i.i

reduce_multiply.exit.i:                           ; preds = %for.cond.1.i.i
  store i16 33, i16* @curtask, align 2
  %173 = load i16*, i16** %m.addr.i, align 2
  store i16* %173, i16** %a.addr.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i, align 2
  store i16 0, i16* %relation.i.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i, align 2
  br label %for.cond.i.71.i

for.cond.i.71.i:                                  ; preds = %if.end.i.76.i, %reduce_multiply.exit.i
  %174 = load i16, i16* %i.i.69.i, align 2
  %cmp.i.70.i = icmp sge i16 %174, 0
  br i1 %cmp.i.70.i, label %for.body.i.72.i, label %reduce_compare.exit.i

for.body.i.72.i:                                  ; preds = %for.cond.i.71.i
  %175 = load i16*, i16** %a.addr.i.i, align 2
  %176 = load i16*, i16** %b.addr.i.i, align 2
  %cmp1.i.i = icmp ugt i16* %175, %176
  br i1 %cmp1.i.i, label %if.then.i.73.i, label %if.else.i.75.i

if.then.i.73.i:                                   ; preds = %for.body.i.72.i
  store i16 1, i16* %relation.i.i, align 2
  br label %reduce_compare.exit.i

if.else.i.75.i:                                   ; preds = %for.body.i.72.i
  %177 = load i16*, i16** %a.addr.i.i, align 2
  %178 = load i16*, i16** %b.addr.i.i, align 2
  %cmp2.i.74.i = icmp ult i16* %177, %178
  br i1 %cmp2.i.74.i, label %if.then.3.i.i, label %if.end.i.76.i

if.then.3.i.i:                                    ; preds = %if.else.i.75.i
  store i16 -1, i16* %relation.i.i, align 2
  br label %reduce_compare.exit.i

if.end.i.76.i:                                    ; preds = %if.else.i.75.i
  %179 = load i16, i16* %i.i.69.i, align 2
  %dec.i.77.i = add nsw i16 %179, -1
  store i16 %dec.i.77.i, i16* %i.i.69.i, align 2
  br label %for.cond.i.71.i

reduce_compare.exit.i:                            ; preds = %if.then.3.i.i, %if.then.i.73.i, %for.cond.i.71.i
  store i16 31, i16* @curtask, align 2
  %180 = load i16, i16* %relation.i.i, align 2
  %cmp10.i = icmp slt i16 %180, 0
  br i1 %cmp10.i, label %if.then.11.i, label %if.end.12.i

if.then.11.i:                                     ; preds = %reduce_compare.exit.i
  %181 = load i16*, i16** %m.addr.i, align 2
  %182 = load i16*, i16** %n.addr.i, align 2
  %183 = load i16, i16* %d.i, align 2
  store i16* %181, i16** %a.addr.i.79.i, align 2
  store i16* %182, i16** %b.addr.i.80.i, align 2
  store i16 %183, i16* %d.addr.i.81.i, align 2
  store i16 10, i16* @curtask, align 2
  %184 = load i16, i16* %d.addr.i.81.i, align 2
  %sub.i.85.i = sub i16 %184, 8
  store i16 %sub.i.85.i, i16* %offset.i.83.i, align 2
  store i16 0, i16* %c.i.84.i, align 2
  %185 = load i16, i16* %offset.i.83.i, align 2
  store i16 %185, i16* %i.i.82.i, align 2
  br label %for.cond.i.87.i

for.cond.i.87.i:                                  ; preds = %if.end.i.100.i, %if.then.11.i
  %186 = load i16, i16* %i.i.82.i, align 2
  %cmp.i.86.i = icmp slt i16 %186, 16
  br i1 %cmp.i.86.i, label %for.body.i.92.i, label %reduce_add.exit.i

for.body.i.92.i:                                  ; preds = %for.cond.i.87.i
  store i16 22, i16* @curtask, align 2
  %187 = load i16, i16* %i.i.82.i, align 2
  %188 = load i16*, i16** %a.addr.i.79.i, align 2
  %arrayidx.i.88.i = getelementptr inbounds i16, i16* %188, i16 %187
  %189 = load i16, i16* %arrayidx.i.88.i, align 2
  store i16 %189, i16* %m.i.i, align 2
  %190 = load i16, i16* %i.i.82.i, align 2
  %191 = load i16, i16* %offset.i.83.i, align 2
  %sub1.i.89.i = sub i16 %190, %191
  store i16 %sub1.i.89.i, i16* %j.i.i, align 2
  %192 = load i16, i16* %i.i.82.i, align 2
  %193 = load i16, i16* %offset.i.83.i, align 2
  %add.i.90.i = add i16 %193, 8
  %cmp2.i.91.i = icmp ult i16 %192, %add.i.90.i
  br i1 %cmp2.i.91.i, label %if.then.i.94.i, label %if.else.i.95.i

if.then.i.94.i:                                   ; preds = %for.body.i.92.i
  %194 = load i16, i16* %j.i.i, align 2
  %195 = load i16*, i16** %b.addr.i.80.i, align 2
  %arrayidx3.i.93.i = getelementptr inbounds i16, i16* %195, i16 %194
  %196 = load i16, i16* %arrayidx3.i.93.i, align 2
  store i16 %196, i16* %n.i.i, align 2
  br label %if.end.i.100.i

if.else.i.95.i:                                   ; preds = %for.body.i.92.i
  store i16 0, i16* %n.i.i, align 2
  store i16 0, i16* %j.i.i, align 2
  br label %if.end.i.100.i

if.end.i.100.i:                                   ; preds = %if.else.i.95.i, %if.then.i.94.i
  %197 = load i16, i16* %c.i.84.i, align 2
  %198 = load i16, i16* %m.i.i, align 2
  %add4.i.i = add i16 %197, %198
  %199 = load i16, i16* %n.i.i, align 2
  %add5.i.96.i = add i16 %add4.i.i, %199
  store i16 %add5.i.96.i, i16* %r.i.i, align 2
  %200 = load i16, i16* %r.i.i, align 2
  %shr.i.97.i = lshr i16 %200, 8
  store i16 %shr.i.97.i, i16* %c.i.84.i, align 2
  %201 = load i16, i16* %r.i.i, align 2
  %and.i.98.i = and i16 %201, 255
  store i16 %and.i.98.i, i16* %r.i.i, align 2
  %202 = load i16, i16* %r.i.i, align 2
  %203 = load i16, i16* %i.i.82.i, align 2
  %204 = load i16*, i16** %a.addr.i.79.i, align 2
  %arrayidx6.i.99.i = getelementptr inbounds i16, i16* %204, i16 %203
  store i16 %202, i16* %arrayidx6.i.99.i, align 2
  %205 = load i16, i16* %i.i.82.i, align 2
  %inc.i.101.i = add nsw i16 %205, 1
  store i16 %inc.i.101.i, i16* %i.i.82.i, align 2
  br label %for.cond.i.87.i

reduce_add.exit.i:                                ; preds = %for.cond.i.87.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i

if.end.12.i:                                      ; preds = %reduce_add.exit.i, %reduce_compare.exit.i
  %206 = load i16*, i16** %m.addr.i, align 2
  %207 = load i16, i16* %d.i, align 2
  store i16* %206, i16** %a.addr.i.103.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i, align 2
  store i16 %207, i16* %d.addr.i.105.i, align 2
  store i16 11, i16* @curtask, align 2
  %208 = load i16, i16* %d.addr.i.105.i, align 2
  %sub.i.113.i = sub i16 %208, 8
  store i16 %sub.i.113.i, i16* %offset.i.112.i, align 2
  %209 = load i16, i16* %d.addr.i.105.i, align 2
  %210 = load i16, i16* %offset.i.112.i, align 2
  %call.i.114.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %209, i16 %210) #4
  store i16 0, i16* %borrow.i.111.i, align 2
  %211 = load i16, i16* %offset.i.112.i, align 2
  store i16 %211, i16* %i.i.106.i, align 2
  br label %for.cond.i.116.i

for.cond.i.116.i:                                 ; preds = %if.end.i.126.i, %if.end.12.i
  %212 = load i16, i16* %i.i.106.i, align 2
  %cmp.i.115.i = icmp slt i16 %212, 16
  br i1 %cmp.i.115.i, label %for.body.i.121.i, label %reduce_subtract.exit.i

for.body.i.121.i:                                 ; preds = %for.cond.i.116.i
  store i16 23, i16* @curtask, align 2
  %213 = load i16, i16* %i.i.106.i, align 2
  %214 = load i16*, i16** %a.addr.i.103.i, align 2
  %arrayidx.i.117.i = getelementptr inbounds i16, i16* %214, i16 %213
  %215 = load i16, i16* %arrayidx.i.117.i, align 2
  store i16 %215, i16* %m.i.107.i, align 2
  %216 = load i16, i16* %i.i.106.i, align 2
  %217 = load i16*, i16** %b.addr.i.104.i, align 2
  %arrayidx1.i.118.i = getelementptr inbounds i16, i16* %217, i16 %216
  %218 = load i16, i16* %arrayidx1.i.118.i, align 2
  store i16 %218, i16* %qn.i.110.i, align 2
  %219 = load i16, i16* %qn.i.110.i, align 2
  %220 = load i16, i16* %borrow.i.111.i, align 2
  %add.i.119.i = add i16 %219, %220
  store i16 %add.i.119.i, i16* %s.i.108.i, align 2
  %221 = load i16, i16* %m.i.107.i, align 2
  %222 = load i16, i16* %s.i.108.i, align 2
  %cmp2.i.120.i = icmp ult i16 %221, %222
  br i1 %cmp2.i.120.i, label %if.then.i.123.i, label %if.else.i.124.i

if.then.i.123.i:                                  ; preds = %for.body.i.121.i
  %223 = load i16, i16* %m.i.107.i, align 2
  %add3.i.122.i = add i16 %223, 256
  store i16 %add3.i.122.i, i16* %m.i.107.i, align 2
  store i16 1, i16* %borrow.i.111.i, align 2
  br label %if.end.i.126.i

if.else.i.124.i:                                  ; preds = %for.body.i.121.i
  store i16 0, i16* %borrow.i.111.i, align 2
  br label %if.end.i.126.i

if.end.i.126.i:                                   ; preds = %if.else.i.124.i, %if.then.i.123.i
  %224 = load i16, i16* %m.i.107.i, align 2
  %225 = load i16, i16* %s.i.108.i, align 2
  %sub4.i.i = sub i16 %224, %225
  store i16 %sub4.i.i, i16* %r.i.109.i, align 2
  %226 = load i16, i16* %r.i.109.i, align 2
  %227 = load i16, i16* %i.i.106.i, align 2
  %228 = load i16*, i16** %a.addr.i.103.i, align 2
  %arrayidx5.i.125.i = getelementptr inbounds i16, i16* %228, i16 %227
  store i16 %226, i16* %arrayidx5.i.125.i, align 2
  %229 = load i16, i16* %i.i.106.i, align 2
  %inc.i.127.i = add nsw i16 %229, 1
  store i16 %inc.i.127.i, i16* %i.i.106.i, align 2
  br label %for.cond.i.116.i

reduce_subtract.exit.i:                           ; preds = %for.cond.i.116.i
  store i16 35, i16* @curtask, align 2
  %230 = load i16, i16* %d.i, align 2
  %dec13.i = add i16 %230, -1
  store i16 %dec13.i, i16* %d.i, align 2
  br label %while.cond.i

while.end.i:                                      ; preds = %while.cond.i
  store i16 28, i16* @curtask, align 2
  br label %reduce.exit

reduce.exit:                                      ; preds = %if.then.5.i, %while.end.i
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @mod_exp(i16* %out_block, i16* %base, i16 zeroext %e, i16* %n) #1 {
entry:
  %a.addr.i.103.i.i.3 = alloca i16*, align 2
  %b.addr.i.104.i.i.4 = alloca i16*, align 2
  %d.addr.i.105.i.i.5 = alloca i16, align 2
  %i.i.106.i.i.6 = alloca i16, align 2
  %m.i.107.i.i.7 = alloca i16, align 2
  %s.i.108.i.i.8 = alloca i16, align 2
  %r.i.109.i.i.9 = alloca i16, align 2
  %qn.i.110.i.i.10 = alloca i16, align 2
  %borrow.i.111.i.i.11 = alloca i16, align 2
  %offset.i.112.i.i.12 = alloca i16, align 2
  %a.addr.i.79.i.i.13 = alloca i16*, align 2
  %b.addr.i.80.i.i.14 = alloca i16*, align 2
  %d.addr.i.81.i.i.15 = alloca i16, align 2
  %i.i.82.i.i.16 = alloca i16, align 2
  %j.i.i.i.17 = alloca i16, align 2
  %offset.i.83.i.i.18 = alloca i16, align 2
  %c.i.84.i.i.19 = alloca i16, align 2
  %r.i.i.i.20 = alloca i16, align 2
  %m.i.i.i.21 = alloca i16, align 2
  %n.i.i.i.22 = alloca i16, align 2
  %a.addr.i.i.i.23 = alloca i16*, align 2
  %b.addr.i.i.i.24 = alloca i16*, align 2
  %i.i.69.i.i.25 = alloca i16, align 2
  %relation.i.i.i.26 = alloca i16, align 2
  %product.addr.i.i.i.27 = alloca i16*, align 2
  %q.addr.i.i.i.28 = alloca i16, align 2
  %n.addr.i.48.i.i.29 = alloca i16*, align 2
  %d.addr.i.49.i.i.30 = alloca i16, align 2
  %i.i.50.i.i.31 = alloca i16, align 2
  %offset.i.51.i.i.32 = alloca i16, align 2
  %c.i.i.i.33 = alloca i16, align 2
  %p.i.i.i.34 = alloca i16, align 2
  %nd.i.i.i.35 = alloca i16, align 2
  %quotient.addr.i.i.i.36 = alloca i16*, align 2
  %m.addr.i.31.i.i.37 = alloca i16*, align 2
  %n.addr.i.32.i.i.38 = alloca i16*, align 2
  %d.addr.i.33.i.i.39 = alloca i16, align 2
  %q.i.i.i.41 = alloca i16, align 2
  %n_div.i.i.i.42 = alloca i16, align 2
  %n_n.i.i.i.43 = alloca i16, align 2
  %n_q.i.i.i.44 = alloca i32, align 2
  %qn.i.i.i.45 = alloca i32, align 2
  %m_dividend.i.i.i.46 = alloca i16, align 2
  %m.addr.i.14.i.i.47 = alloca i16*, align 2
  %n.addr.i.15.i.i.48 = alloca i16*, align 2
  %digit.addr.i.i.i.49 = alloca i16, align 2
  %i.i.16.i.i.50 = alloca i16, align 2
  %d.i.i.i.51 = alloca i16, align 2
  %s.i.i.i.52 = alloca i16, align 2
  %m_d.i.17.i.i.53 = alloca i16, align 2
  %n_d.i.18.i.i.54 = alloca i16, align 2
  %borrow.i.i.i.55 = alloca i16, align 2
  %offset.i.19.i.i.56 = alloca i16, align 2
  %m.addr.i.i.i.57 = alloca i16*, align 2
  %n.addr.i.i.i.58 = alloca i16*, align 2
  %d.addr.i.i.i.59 = alloca i16, align 2
  %i.i.i.i.60 = alloca i16, align 2
  %offset.i.i.i.61 = alloca i16, align 2
  %n_d.i.i.i.62 = alloca i16, align 2
  %m_d.i.i.i.63 = alloca i16, align 2
  %normalizable.i.i.i.64 = alloca i8, align 1
  %m.addr.i.i.65 = alloca i16*, align 2
  %n.addr.i.i.66 = alloca i16*, align 2
  %q.i.i.67 = alloca i16, align 2
  %m_d.i.i.68 = alloca i16, align 2
  %d.i.i.69 = alloca i16, align 2
  %a.addr.i.i.70 = alloca i16*, align 2
  %b.addr.i.i.71 = alloca i16*, align 2
  %i.i.i.72 = alloca i16, align 2
  %digit.i.i.73 = alloca i16, align 2
  %p.i.i.74 = alloca i16, align 2
  %c.i.i.75 = alloca i16, align 2
  %dp.i.i.76 = alloca i16, align 2
  %carry.i.i.77 = alloca i16, align 2
  %a.addr.i.78 = alloca i16*, align 2
  %b.addr.i.79 = alloca i16*, align 2
  %n.addr.i.80 = alloca i16*, align 2
  %a.addr.i.103.i.i = alloca i16*, align 2
  %b.addr.i.104.i.i = alloca i16*, align 2
  %d.addr.i.105.i.i = alloca i16, align 2
  %i.i.106.i.i = alloca i16, align 2
  %m.i.107.i.i = alloca i16, align 2
  %s.i.108.i.i = alloca i16, align 2
  %r.i.109.i.i = alloca i16, align 2
  %qn.i.110.i.i = alloca i16, align 2
  %borrow.i.111.i.i = alloca i16, align 2
  %offset.i.112.i.i = alloca i16, align 2
  %a.addr.i.79.i.i = alloca i16*, align 2
  %b.addr.i.80.i.i = alloca i16*, align 2
  %d.addr.i.81.i.i = alloca i16, align 2
  %i.i.82.i.i = alloca i16, align 2
  %j.i.i.i = alloca i16, align 2
  %offset.i.83.i.i = alloca i16, align 2
  %c.i.84.i.i = alloca i16, align 2
  %r.i.i.i = alloca i16, align 2
  %m.i.i.i = alloca i16, align 2
  %n.i.i.i = alloca i16, align 2
  %a.addr.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i = alloca i16*, align 2
  %i.i.69.i.i = alloca i16, align 2
  %relation.i.i.i = alloca i16, align 2
  %product.addr.i.i.i = alloca i16*, align 2
  %q.addr.i.i.i = alloca i16, align 2
  %n.addr.i.48.i.i = alloca i16*, align 2
  %d.addr.i.49.i.i = alloca i16, align 2
  %i.i.50.i.i = alloca i16, align 2
  %offset.i.51.i.i = alloca i16, align 2
  %c.i.i.i = alloca i16, align 2
  %p.i.i.i = alloca i16, align 2
  %nd.i.i.i = alloca i16, align 2
  %quotient.addr.i.i.i = alloca i16*, align 2
  %m.addr.i.31.i.i = alloca i16*, align 2
  %n.addr.i.32.i.i = alloca i16*, align 2
  %d.addr.i.33.i.i = alloca i16, align 2
  %m_d.i.34.i.i = alloca [3 x i16], align 2
  %q.i.i.i = alloca i16, align 2
  %n_div.i.i.i = alloca i16, align 2
  %n_n.i.i.i = alloca i16, align 2
  %n_q.i.i.i = alloca i32, align 2
  %qn.i.i.i = alloca i32, align 2
  %m_dividend.i.i.i = alloca i16, align 2
  %m.addr.i.14.i.i = alloca i16*, align 2
  %n.addr.i.15.i.i = alloca i16*, align 2
  %digit.addr.i.i.i = alloca i16, align 2
  %i.i.16.i.i = alloca i16, align 2
  %d.i.i.i = alloca i16, align 2
  %s.i.i.i = alloca i16, align 2
  %m_d.i.17.i.i = alloca i16, align 2
  %n_d.i.18.i.i = alloca i16, align 2
  %borrow.i.i.i = alloca i16, align 2
  %offset.i.19.i.i = alloca i16, align 2
  %m.addr.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i = alloca i16*, align 2
  %d.addr.i.i.i = alloca i16, align 2
  %i.i.i.i = alloca i16, align 2
  %offset.i.i.i = alloca i16, align 2
  %n_d.i.i.i = alloca i16, align 2
  %m_d.i.i.i = alloca i16, align 2
  %normalizable.i.i.i = alloca i8, align 1
  %m.addr.i.i = alloca i16*, align 2
  %n.addr.i.i = alloca i16*, align 2
  %q.i.i = alloca i16, align 2
  %m_d.i.i = alloca i16, align 2
  %d.i.i = alloca i16, align 2
  %a.addr.i.i = alloca i16*, align 2
  %b.addr.i.i = alloca i16*, align 2
  %i.i.i = alloca i16, align 2
  %digit.i.i = alloca i16, align 2
  %p.i.i = alloca i16, align 2
  %c.i.i = alloca i16, align 2
  %dp.i.i = alloca i16, align 2
  %carry.i.i = alloca i16, align 2
  %a.addr.i = alloca i16*, align 2
  %b.addr.i = alloca i16*, align 2
  %n.addr.i = alloca i16*, align 2
  %out_block.addr = alloca i16*, align 2
  %base.addr = alloca i16*, align 2
  %e.addr = alloca i16, align 2
  %n.addr = alloca i16*, align 2
  %i = alloca i16, align 2
  store i16* %out_block, i16** %out_block.addr, align 2
  store i16* %base, i16** %base.addr, align 2
  store i16 %e, i16* %e.addr, align 2
  store i16* %n, i16** %n.addr, align 2
  store i16 2, i16* @curtask, align 2
  %0 = load i16*, i16** %out_block.addr, align 2
  %arrayidx = getelementptr inbounds i16, i16* %0, i16 0
  store i16 1, i16* %arrayidx, align 2
  store i16 1, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i16, i16* %i, align 2
  %cmp = icmp slt i16 %1, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i16, i16* %i, align 2
  %3 = load i16*, i16** %out_block.addr, align 2
  %arrayidx1 = getelementptr inbounds i16, i16* %3, i16 %2
  store i16 0, i16* %arrayidx1, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i16, i16* %i, align 2
  %inc = add nsw i16 %4, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %while.cond

while.cond:                                       ; preds = %mod_mult.exit312, %for.end
  %5 = load i16, i16* %e.addr, align 2
  %cmp2 = icmp ugt i16 %5, 0
  br i1 %cmp2, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i16 13, i16* @curtask, align 2
  %6 = load i16, i16* %e.addr, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %6)
  %7 = load i16, i16* %e.addr, align 2
  %and = and i16 %7, 1
  %tobool = icmp ne i16 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %8 = load i16*, i16** %out_block.addr, align 2
  %9 = load i16*, i16** %base.addr, align 2
  %10 = load i16*, i16** %n.addr, align 2
  store i16* %8, i16** %a.addr.i, align 2
  store i16* %9, i16** %b.addr.i, align 2
  store i16* %10, i16** %n.addr.i, align 2
  %11 = load i16*, i16** %a.addr.i, align 2
  %12 = load i16*, i16** %b.addr.i, align 2
  store i16* %11, i16** %a.addr.i.i, align 2
  store i16* %12, i16** %b.addr.i.i, align 2
  store i16 0, i16* %carry.i.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i, align 2
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %for.end.i.i, %if.then
  %13 = load i16, i16* %digit.i.i, align 2
  %cmp.i.i = icmp ult i16 %13, 16
  br i1 %cmp.i.i, label %for.body.i.i, label %for.end.15.i.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  store i16 14, i16* @curtask, align 2
  %14 = load i16, i16* %carry.i.i, align 2
  store i16 %14, i16* %p.i.i, align 2
  store i16 0, i16* %c.i.i, align 2
  store i16 0, i16* %i.i.i, align 2
  br label %for.cond.1.i.i

for.cond.1.i.i:                                   ; preds = %if.end.i.i, %for.body.i.i
  %15 = load i16, i16* %i.i.i, align 2
  %cmp2.i.i = icmp slt i16 %15, 8
  br i1 %cmp2.i.i, label %for.body.3.i.i, label %for.end.i.i

for.body.3.i.i:                                   ; preds = %for.cond.1.i.i
  %16 = load i16, i16* %i.i.i, align 2
  %17 = load i16, i16* %digit.i.i, align 2
  %cmp4.i.i = icmp ule i16 %16, %17
  br i1 %cmp4.i.i, label %land.lhs.true.i.i, label %if.end.i.i

land.lhs.true.i.i:                                ; preds = %for.body.3.i.i
  %18 = load i16, i16* %digit.i.i, align 2
  %19 = load i16, i16* %i.i.i, align 2
  %sub.i.i = sub i16 %18, %19
  %cmp5.i.i = icmp ult i16 %sub.i.i, 8
  br i1 %cmp5.i.i, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %land.lhs.true.i.i
  %20 = load i16, i16* %digit.i.i, align 2
  %21 = load i16, i16* %i.i.i, align 2
  %sub6.i.i = sub i16 %20, %21
  %22 = load i16*, i16** %a.addr.i.i, align 2
  %arrayidx.i.i = getelementptr inbounds i16, i16* %22, i16 %sub6.i.i
  %23 = load i16, i16* %arrayidx.i.i, align 2
  %24 = load i16, i16* %i.i.i, align 2
  %25 = load i16*, i16** %b.addr.i.i, align 2
  %arrayidx7.i.i = getelementptr inbounds i16, i16* %25, i16 %24
  %26 = load i16, i16* %arrayidx7.i.i, align 2
  %mul.i.i = mul i16 %23, %26
  store i16 %mul.i.i, i16* %dp.i.i, align 2
  %27 = load i16, i16* %dp.i.i, align 2
  %shr.i.i = lshr i16 %27, 8
  %28 = load i16, i16* %c.i.i, align 2
  %add.i.i = add i16 %28, %shr.i.i
  store i16 %add.i.i, i16* %c.i.i, align 2
  %29 = load i16, i16* %dp.i.i, align 2
  %and.i.i = and i16 %29, 255
  %30 = load i16, i16* %p.i.i, align 2
  %add8.i.i = add i16 %30, %and.i.i
  store i16 %add8.i.i, i16* %p.i.i, align 2
  br label %if.end.i.i

if.end.i.i:                                       ; preds = %if.then.i.i, %land.lhs.true.i.i, %for.body.3.i.i
  %31 = load i16, i16* %i.i.i, align 2
  %inc.i.i = add nsw i16 %31, 1
  store i16 %inc.i.i, i16* %i.i.i, align 2
  br label %for.cond.1.i.i

for.end.i.i:                                      ; preds = %for.cond.1.i.i
  %32 = load i16, i16* %p.i.i, align 2
  %shr9.i.i = lshr i16 %32, 8
  %33 = load i16, i16* %c.i.i, align 2
  %add10.i.i = add i16 %33, %shr9.i.i
  store i16 %add10.i.i, i16* %c.i.i, align 2
  %34 = load i16, i16* %p.i.i, align 2
  %and11.i.i = and i16 %34, 255
  store i16 %and11.i.i, i16* %p.i.i, align 2
  %35 = load i16, i16* %p.i.i, align 2
  %36 = load i16, i16* %digit.i.i, align 2
  %arrayidx12.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %36
  store i16 %35, i16* %arrayidx12.i.i, align 2
  %37 = load i16, i16* %c.i.i, align 2
  store i16 %37, i16* %carry.i.i, align 2
  %38 = load i16, i16* %digit.i.i, align 2
  %inc14.i.i = add i16 %38, 1
  store i16 %inc14.i.i, i16* %digit.i.i, align 2
  br label %for.cond.i.i

for.end.15.i.i:                                   ; preds = %for.cond.i.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i, align 2
  br label %for.cond.16.i.i

for.cond.16.i.i:                                  ; preds = %for.body.18.i.i, %for.end.15.i.i
  %39 = load i16, i16* %i.i.i, align 2
  %cmp17.i.i = icmp slt i16 %39, 16
  br i1 %cmp17.i.i, label %for.body.18.i.i, label %mult.exit.i

for.body.18.i.i:                                  ; preds = %for.cond.16.i.i
  %40 = load i16, i16* %i.i.i, align 2
  %arrayidx19.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %40
  %41 = load i16, i16* %arrayidx19.i.i, align 2
  %42 = load i16, i16* %i.i.i, align 2
  %43 = load i16*, i16** %a.addr.i.i, align 2
  %arrayidx20.i.i = getelementptr inbounds i16, i16* %43, i16 %42
  store i16 %41, i16* %arrayidx20.i.i, align 2
  %44 = load i16, i16* %i.i.i, align 2
  %inc22.i.i = add nsw i16 %44, 1
  store i16 %inc22.i.i, i16* %i.i.i, align 2
  br label %for.cond.16.i.i

mult.exit.i:                                      ; preds = %for.cond.16.i.i
  store i16 27, i16* @curtask, align 2
  %45 = load i16*, i16** %a.addr.i, align 2
  %46 = load i16*, i16** %n.addr.i, align 2
  store i16* %45, i16** %m.addr.i.i, align 2
  store i16* %46, i16** %n.addr.i.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i, align 2
  br label %do.body.i.i

do.body.i.i:                                      ; preds = %land.end.i.i, %mult.exit.i
  %47 = load i16, i16* %d.i.i, align 2
  %dec.i.i = add i16 %47, -1
  store i16 %dec.i.i, i16* %d.i.i, align 2
  %48 = load i16, i16* %d.i.i, align 2
  %49 = load i16*, i16** %m.addr.i.i, align 2
  %arrayidx.i.1.i = getelementptr inbounds i16, i16* %49, i16 %48
  %50 = load i16, i16* %arrayidx.i.1.i, align 2
  store i16 %50, i16* %m_d.i.i, align 2
  %51 = load i16, i16* %d.i.i, align 2
  %52 = load i16, i16* %m_d.i.i, align 2
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %51, i16 %52) #4
  %53 = load i16, i16* %m_d.i.i, align 2
  %cmp.i.2.i = icmp eq i16 %53, 0
  br i1 %cmp.i.2.i, label %land.rhs.i.i, label %land.end.i.i

land.rhs.i.i:                                     ; preds = %do.body.i.i
  %54 = load i16, i16* %d.i.i, align 2
  %cmp1.i.i = icmp ugt i16 %54, 0
  br label %land.end.i.i

land.end.i.i:                                     ; preds = %land.rhs.i.i, %do.body.i.i
  %55 = phi i1 [ false, %do.body.i.i ], [ %cmp1.i.i, %land.rhs.i.i ]
  br i1 %55, label %do.body.i.i, label %do.end.i.i

do.end.i.i:                                       ; preds = %land.end.i.i
  %56 = load i16, i16* %d.i.i, align 2
  %call2.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %56) #4
  %57 = load i16*, i16** %m.addr.i.i, align 2
  %58 = load i16*, i16** %n.addr.i.i, align 2
  %59 = load i16, i16* %d.i.i, align 2
  store i16* %57, i16** %m.addr.i.i.i, align 2
  store i16* %58, i16** %n.addr.i.i.i, align 2
  store i16 %59, i16* %d.addr.i.i.i, align 2
  store i8 1, i8* %normalizable.i.i.i, align 1
  store i16 6, i16* @curtask, align 2
  %60 = load i16, i16* %d.addr.i.i.i, align 2
  %add.i.i.i = add i16 %60, 1
  %sub.i.i.i = sub i16 %add.i.i.i, 8
  store i16 %sub.i.i.i, i16* %offset.i.i.i, align 2
  %61 = load i16, i16* %d.addr.i.i.i, align 2
  %62 = load i16, i16* %offset.i.i.i, align 2
  %call.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %61, i16 %62) #4
  %63 = load i16, i16* %d.addr.i.i.i, align 2
  store i16 %63, i16* %i.i.i.i, align 2
  br label %for.cond.i.i.i

for.cond.i.i.i:                                   ; preds = %if.end.i.i.i, %do.end.i.i
  %64 = load i16, i16* %i.i.i.i, align 2
  %cmp.i.i.i = icmp sge i16 %64, 0
  br i1 %cmp.i.i.i, label %for.body.i.i.i, label %reduce_normalizable.exit.i.i

for.body.i.i.i:                                   ; preds = %for.cond.i.i.i
  %65 = load i16, i16* %i.i.i.i, align 2
  %66 = load i16*, i16** %m.addr.i.i.i, align 2
  %arrayidx.i.i.i = getelementptr inbounds i16, i16* %66, i16 %65
  %67 = load i16, i16* %arrayidx.i.i.i, align 2
  store i16 %67, i16* %m_d.i.i.i, align 2
  %68 = load i16, i16* %i.i.i.i, align 2
  %69 = load i16, i16* %offset.i.i.i, align 2
  %sub1.i.i.i = sub i16 %68, %69
  %70 = load i16*, i16** %n.addr.i.i.i, align 2
  %arrayidx2.i.i.i = getelementptr inbounds i16, i16* %70, i16 %sub1.i.i.i
  %71 = load i16, i16* %arrayidx2.i.i.i, align 2
  store i16 %71, i16* %n_d.i.i.i, align 2
  %72 = load i16, i16* %m_d.i.i.i, align 2
  %73 = load i16, i16* %n_d.i.i.i, align 2
  %cmp3.i.i.i = icmp ugt i16 %72, %73
  br i1 %cmp3.i.i.i, label %if.then.i.i.i, label %if.else.i.i.i

if.then.i.i.i:                                    ; preds = %for.body.i.i.i
  br label %reduce_normalizable.exit.i.i

if.else.i.i.i:                                    ; preds = %for.body.i.i.i
  %74 = load i16, i16* %m_d.i.i.i, align 2
  %75 = load i16, i16* %n_d.i.i.i, align 2
  %cmp4.i.i.i = icmp ult i16 %74, %75
  br i1 %cmp4.i.i.i, label %if.then.5.i.i.i, label %if.end.i.i.i

if.then.5.i.i.i:                                  ; preds = %if.else.i.i.i
  store i8 0, i8* %normalizable.i.i.i, align 1
  br label %reduce_normalizable.exit.i.i

if.end.i.i.i:                                     ; preds = %if.else.i.i.i
  %76 = load i16, i16* %i.i.i.i, align 2
  %dec.i.i.i = add nsw i16 %76, -1
  store i16 %dec.i.i.i, i16* %i.i.i.i, align 2
  br label %for.cond.i.i.i

reduce_normalizable.exit.i.i:                     ; preds = %if.then.5.i.i.i, %if.then.i.i.i, %for.cond.i.i.i
  %77 = load i8, i8* %normalizable.i.i.i, align 1
  %tobool.i.i.i = trunc i8 %77 to i1
  %conv.i.i.i = zext i1 %tobool.i.i.i to i16
  %call7.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %78 = load i8, i8* %normalizable.i.i.i, align 1
  %tobool8.i.i.i = trunc i8 %78 to i1
  br i1 %tobool8.i.i.i, label %if.then.i.3.i, label %if.else.i.i

if.then.i.3.i:                                    ; preds = %reduce_normalizable.exit.i.i
  %79 = load i16*, i16** %m.addr.i.i, align 2
  %80 = load i16*, i16** %n.addr.i.i, align 2
  %81 = load i16, i16* %d.i.i, align 2
  store i16* %79, i16** %m.addr.i.14.i.i, align 2
  store i16* %80, i16** %n.addr.i.15.i.i, align 2
  store i16 %81, i16* %digit.addr.i.i.i, align 2
  store i16 5, i16* @curtask, align 2
  %82 = load i16, i16* %digit.addr.i.i.i, align 2
  %add.i.20.i.i = add i16 %82, 1
  %sub.i.21.i.i = sub i16 %add.i.20.i.i, 8
  store i16 %sub.i.21.i.i, i16* %offset.i.19.i.i, align 2
  store i16 0, i16* %borrow.i.i.i, align 2
  store i16 0, i16* %i.i.16.i.i, align 2
  br label %for.cond.i.23.i.i

for.cond.i.23.i.i:                                ; preds = %if.end.i.30.i.i, %if.then.i.3.i
  %83 = load i16, i16* %i.i.16.i.i, align 2
  %cmp.i.22.i.i = icmp slt i16 %83, 8
  br i1 %cmp.i.22.i.i, label %for.body.i.27.i.i, label %reduce_normalize.exit.i.i

for.body.i.27.i.i:                                ; preds = %for.cond.i.23.i.i
  store i16 21, i16* @curtask, align 2
  %84 = load i16, i16* %i.i.16.i.i, align 2
  %85 = load i16, i16* %offset.i.19.i.i, align 2
  %add1.i.i.i = add i16 %84, %85
  %86 = load i16*, i16** %m.addr.i.14.i.i, align 2
  %arrayidx.i.24.i.i = getelementptr inbounds i16, i16* %86, i16 %add1.i.i.i
  %87 = load i16, i16* %arrayidx.i.24.i.i, align 2
  store i16 %87, i16* %m_d.i.17.i.i, align 2
  %88 = load i16, i16* %i.i.16.i.i, align 2
  %89 = load i16*, i16** %n.addr.i.15.i.i, align 2
  %arrayidx2.i.25.i.i = getelementptr inbounds i16, i16* %89, i16 %88
  %90 = load i16, i16* %arrayidx2.i.25.i.i, align 2
  store i16 %90, i16* %n_d.i.18.i.i, align 2
  %91 = load i16, i16* %n_d.i.18.i.i, align 2
  %92 = load i16, i16* %borrow.i.i.i, align 2
  %add3.i.i.i = add i16 %91, %92
  store i16 %add3.i.i.i, i16* %s.i.i.i, align 2
  %93 = load i16, i16* %m_d.i.17.i.i, align 2
  %94 = load i16, i16* %s.i.i.i, align 2
  %cmp4.i.26.i.i = icmp ult i16 %93, %94
  br i1 %cmp4.i.26.i.i, label %if.then.i.28.i.i, label %if.else.i.29.i.i

if.then.i.28.i.i:                                 ; preds = %for.body.i.27.i.i
  %95 = load i16, i16* %m_d.i.17.i.i, align 2
  %add5.i.i.i = add i16 %95, 256
  store i16 %add5.i.i.i, i16* %m_d.i.17.i.i, align 2
  store i16 1, i16* %borrow.i.i.i, align 2
  br label %if.end.i.30.i.i

if.else.i.29.i.i:                                 ; preds = %for.body.i.27.i.i
  store i16 0, i16* %borrow.i.i.i, align 2
  br label %if.end.i.30.i.i

if.end.i.30.i.i:                                  ; preds = %if.else.i.29.i.i, %if.then.i.28.i.i
  %96 = load i16, i16* %m_d.i.17.i.i, align 2
  %97 = load i16, i16* %s.i.i.i, align 2
  %sub6.i.i.i = sub i16 %96, %97
  store i16 %sub6.i.i.i, i16* %d.i.i.i, align 2
  %98 = load i16, i16* %d.i.i.i, align 2
  %99 = load i16, i16* %i.i.16.i.i, align 2
  %100 = load i16, i16* %offset.i.19.i.i, align 2
  %add7.i.i.i = add i16 %99, %100
  %101 = load i16*, i16** %m.addr.i.14.i.i, align 2
  %arrayidx8.i.i.i = getelementptr inbounds i16, i16* %101, i16 %add7.i.i.i
  store i16 %98, i16* %arrayidx8.i.i.i, align 2
  %102 = load i16, i16* %i.i.16.i.i, align 2
  %inc.i.i.i = add nsw i16 %102, 1
  store i16 %inc.i.i.i, i16* %i.i.16.i.i, align 2
  br label %for.cond.i.23.i.i

reduce_normalize.exit.i.i:                        ; preds = %for.cond.i.23.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i

if.else.i.i:                                      ; preds = %reduce_normalizable.exit.i.i
  %103 = load i16, i16* %d.i.i, align 2
  %cmp4.i.4.i = icmp eq i16 %103, 7
  br i1 %cmp4.i.4.i, label %if.then.5.i.i, label %if.end.i.5.i

if.then.5.i.i:                                    ; preds = %if.else.i.i
  %call6.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit

if.end.i.5.i:                                     ; preds = %if.else.i.i
  br label %if.end.7.i.i

if.end.7.i.i:                                     ; preds = %if.end.i.5.i, %reduce_normalize.exit.i.i
  br label %while.cond.i.i

while.cond.i.i:                                   ; preds = %reduce_subtract.exit.i.i, %if.end.7.i.i
  %104 = load i16, i16* %d.i.i, align 2
  %cmp8.i.i = icmp uge i16 %104, 8
  br i1 %cmp8.i.i, label %while.body.i.i, label %while.end.i.i

while.body.i.i:                                   ; preds = %while.cond.i.i
  %105 = load i16*, i16** %m.addr.i.i, align 2
  %106 = load i16*, i16** %n.addr.i.i, align 2
  %107 = load i16, i16* %d.i.i, align 2
  store i16* %q.i.i, i16** %quotient.addr.i.i.i, align 2
  store i16* %105, i16** %m.addr.i.31.i.i, align 2
  store i16* %106, i16** %n.addr.i.32.i.i, align 2
  store i16 %107, i16* %d.addr.i.33.i.i, align 2
  store i16 16, i16* @curtask, align 2
  %108 = load i16*, i16** %n.addr.i.32.i.i, align 2
  %arrayidx.i.35.i.i = getelementptr inbounds i16, i16* %108, i16 7
  %109 = load i16, i16* %arrayidx.i.35.i.i, align 2
  %shl.i.i.i = shl i16 %109, 8
  %110 = load i16*, i16** %n.addr.i.32.i.i, align 2
  %arrayidx1.i.i.i = getelementptr inbounds i16, i16* %110, i16 6
  %111 = load i16, i16* %arrayidx1.i.i.i, align 2
  %add.i.36.i.i = add i16 %shl.i.i.i, %111
  store i16 %add.i.36.i.i, i16* %n_div.i.i.i, align 2
  %112 = load i16*, i16** %n.addr.i.32.i.i, align 2
  %arrayidx2.i.37.i.i = getelementptr inbounds i16, i16* %112, i16 7
  %113 = load i16, i16* %arrayidx2.i.37.i.i, align 2
  store i16 %113, i16* %n_n.i.i.i, align 2
  %114 = load i16, i16* %d.addr.i.33.i.i, align 2
  %115 = load i16*, i16** %m.addr.i.31.i.i, align 2
  %arrayidx3.i.i.i = getelementptr inbounds i16, i16* %115, i16 %114
  %116 = load i16, i16* %arrayidx3.i.i.i, align 2
  %arrayidx4.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  store i16 %116, i16* %arrayidx4.i.i.i, align 2
  %117 = load i16, i16* %d.addr.i.33.i.i, align 2
  %sub.i.38.i.i = sub i16 %117, 1
  %118 = load i16*, i16** %m.addr.i.31.i.i, align 2
  %arrayidx5.i.i.i = getelementptr inbounds i16, i16* %118, i16 %sub.i.38.i.i
  %119 = load i16, i16* %arrayidx5.i.i.i, align 2
  %arrayidx6.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  store i16 %119, i16* %arrayidx6.i.i.i, align 2
  %120 = load i16, i16* %d.addr.i.33.i.i, align 2
  %sub7.i.i.i = sub i16 %120, 2
  %121 = load i16*, i16** %m.addr.i.31.i.i, align 2
  %arrayidx8.i.39.i.i = getelementptr inbounds i16, i16* %121, i16 %sub7.i.i.i
  %122 = load i16, i16* %arrayidx8.i.39.i.i, align 2
  %arrayidx9.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  store i16 %122, i16* %arrayidx9.i.i.i, align 2
  %123 = load i16, i16* %n_n.i.i.i, align 2
  %124 = load i16*, i16** %m.addr.i.31.i.i, align 2
  %arrayidx10.i.i.i = getelementptr inbounds i16, i16* %124, i16 2
  %125 = load i16, i16* %arrayidx10.i.i.i, align 2
  %call.i.40.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %123, i16 %125) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %126 = load i16, i16* %arrayidx11.i.i.i, align 2
  %127 = load i16, i16* %n_n.i.i.i, align 2
  %cmp.i.41.i.i = icmp eq i16 %126, %127
  br i1 %cmp.i.41.i.i, label %if.then.i.42.i.i, label %if.else.i.43.i.i

if.then.i.42.i.i:                                 ; preds = %while.body.i.i
  store i16 255, i16* %q.i.i.i, align 2
  br label %if.end.i.46.i.i

if.else.i.43.i.i:                                 ; preds = %while.body.i.i
  %arrayidx12.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %128 = load i16, i16* %arrayidx12.i.i.i, align 2
  %shl13.i.i.i = shl i16 %128, 8
  %arrayidx14.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %129 = load i16, i16* %arrayidx14.i.i.i, align 2
  %add15.i.i.i = add i16 %shl13.i.i.i, %129
  store i16 %add15.i.i.i, i16* %m_dividend.i.i.i, align 2
  %130 = load i16, i16* %m_dividend.i.i.i, align 2
  %131 = load i16, i16* %n_n.i.i.i, align 2
  %div.i.i.i = udiv i16 %130, %131
  store i16 %div.i.i.i, i16* %q.i.i.i, align 2
  %132 = load i16, i16* %m_dividend.i.i.i, align 2
  %133 = load i16, i16* %q.i.i.i, align 2
  %call16.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %132, i16 %133) #4
  br label %if.end.i.46.i.i

if.end.i.46.i.i:                                  ; preds = %if.else.i.43.i.i, %if.then.i.42.i.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %134 = load i16, i16* %arrayidx17.i.i.i, align 2
  %conv.i.44.i.i = zext i16 %134 to i32
  %shl18.i.i.i = shl i32 %conv.i.44.i.i, 16
  %arrayidx19.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %135 = load i16, i16* %arrayidx19.i.i.i, align 2
  %shl20.i.i.i = shl i16 %135, 8
  %conv21.i.i.i = zext i16 %shl20.i.i.i to i32
  %add22.i.i.i = add i32 %shl18.i.i.i, %conv21.i.i.i
  %arrayidx23.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %136 = load i16, i16* %arrayidx23.i.i.i, align 2
  %conv24.i.i.i = zext i16 %136 to i32
  %add25.i.i.i = add i32 %add22.i.i.i, %conv24.i.i.i
  store i32 %add25.i.i.i, i32* %n_q.i.i.i, align 2
  %arrayidx26.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %137 = load i16, i16* %arrayidx26.i.i.i, align 2
  %arrayidx27.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %138 = load i16, i16* %arrayidx27.i.i.i, align 2
  %arrayidx28.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %139 = load i16, i16* %arrayidx28.i.i.i, align 2
  %140 = load i32, i32* %n_q.i.i.i, align 2
  %shr.i.i.i = lshr i32 %140, 16
  %and.i.i.i = and i32 %shr.i.i.i, 65535
  %conv29.i.i.i = trunc i32 %and.i.i.i to i16
  %141 = load i32, i32* %n_q.i.i.i, align 2
  %and30.i.i.i = and i32 %141, 65535
  %conv31.i.i.i = trunc i32 %and30.i.i.i to i16
  %call32.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %137, i16 %138, i16 %139, i16 %conv29.i.i.i, i16 %conv31.i.i.i) #4
  %142 = load i16, i16* %q.i.i.i, align 2
  %call33.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %142) #4
  %143 = load i16, i16* %q.i.i.i, align 2
  %inc.i.45.i.i = add i16 %143, 1
  store i16 %inc.i.45.i.i, i16* %q.i.i.i, align 2
  br label %do.body.i.i.i

do.body.i.i.i:                                    ; preds = %do.body.i.i.i, %if.end.i.46.i.i
  store i16 19, i16* @curtask, align 2
  %144 = load i16, i16* %q.i.i.i, align 2
  %dec.i.47.i.i = add i16 %144, -1
  store i16 %dec.i.47.i.i, i16* %q.i.i.i, align 2
  %145 = load i16, i16* %n_div.i.i.i, align 2
  %146 = load i16, i16* %q.i.i.i, align 2
  %call34.i.i.i = call i32 @mult16(i16 zeroext %145, i16 zeroext %146) #4
  store i32 %call34.i.i.i, i32* %qn.i.i.i, align 2
  %147 = load i16, i16* %q.i.i.i, align 2
  %148 = load i16, i16* %n_div.i.i.i, align 2
  %149 = load i32, i32* %qn.i.i.i, align 2
  %shr35.i.i.i = lshr i32 %149, 16
  %and36.i.i.i = and i32 %shr35.i.i.i, 65535
  %conv37.i.i.i = trunc i32 %and36.i.i.i to i16
  %150 = load i32, i32* %qn.i.i.i, align 2
  %and38.i.i.i = and i32 %150, 65535
  %conv39.i.i.i = trunc i32 %and38.i.i.i to i16
  %call40.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %147, i16 %148, i16 %conv37.i.i.i, i16 %conv39.i.i.i) #4
  %151 = load i32, i32* %qn.i.i.i, align 2
  %152 = load i32, i32* %n_q.i.i.i, align 2
  %cmp41.i.i.i = icmp ugt i32 %151, %152
  br i1 %cmp41.i.i.i, label %do.body.i.i.i, label %reduce_quotient.exit.i.i

reduce_quotient.exit.i.i:                         ; preds = %do.body.i.i.i
  %153 = load i16, i16* %q.i.i.i, align 2
  %call43.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %153) #4
  %154 = load i16, i16* %q.i.i.i, align 2
  %155 = load i16*, i16** %quotient.addr.i.i.i, align 2
  store i16 %154, i16* %155, align 2
  store i16 32, i16* @curtask, align 2
  %156 = load i16, i16* %q.i.i, align 2
  %157 = load i16*, i16** %n.addr.i.i, align 2
  %158 = load i16, i16* %d.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i, align 2
  store i16 %156, i16* %q.addr.i.i.i, align 2
  store i16* %157, i16** %n.addr.i.48.i.i, align 2
  store i16 %158, i16* %d.addr.i.49.i.i, align 2
  store i16 9, i16* @curtask, align 2
  %159 = load i16, i16* %d.addr.i.49.i.i, align 2
  %sub.i.52.i.i = sub i16 %159, 8
  store i16 %sub.i.52.i.i, i16* %offset.i.51.i.i, align 2
  %160 = load i16, i16* %offset.i.51.i.i, align 2
  %call.i.53.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %160) #4
  store i16 0, i16* %i.i.50.i.i, align 2
  br label %for.cond.i.55.i.i

for.cond.i.55.i.i:                                ; preds = %for.body.i.57.i.i, %reduce_quotient.exit.i.i
  %161 = load i16, i16* %i.i.50.i.i, align 2
  %162 = load i16, i16* %offset.i.51.i.i, align 2
  %cmp.i.54.i.i = icmp ult i16 %161, %162
  br i1 %cmp.i.54.i.i, label %for.body.i.57.i.i, label %for.end.i.i.i

for.body.i.57.i.i:                                ; preds = %for.cond.i.55.i.i
  %163 = load i16, i16* %i.i.50.i.i, align 2
  %164 = load i16*, i16** %product.addr.i.i.i, align 2
  %arrayidx.i.56.i.i = getelementptr inbounds i16, i16* %164, i16 %163
  store i16 0, i16* %arrayidx.i.56.i.i, align 2
  %165 = load i16, i16* %i.i.50.i.i, align 2
  %inc.i.58.i.i = add nsw i16 %165, 1
  store i16 %inc.i.58.i.i, i16* %i.i.50.i.i, align 2
  br label %for.cond.i.55.i.i

for.end.i.i.i:                                    ; preds = %for.cond.i.55.i.i
  store i16 0, i16* %c.i.i.i, align 2
  %166 = load i16, i16* %offset.i.51.i.i, align 2
  store i16 %166, i16* %i.i.50.i.i, align 2
  br label %for.cond.1.i.i.i

for.cond.1.i.i.i:                                 ; preds = %if.end.i.68.i.i, %for.end.i.i.i
  %167 = load i16, i16* %i.i.50.i.i, align 2
  %cmp2.i.i.i = icmp slt i16 %167, 16
  br i1 %cmp2.i.i.i, label %for.body.3.i.i.i, label %reduce_multiply.exit.i.i

for.body.3.i.i.i:                                 ; preds = %for.cond.1.i.i.i
  store i16 24, i16* @curtask, align 2
  %168 = load i16, i16* %c.i.i.i, align 2
  store i16 %168, i16* %p.i.i.i, align 2
  %169 = load i16, i16* %i.i.50.i.i, align 2
  %170 = load i16, i16* %offset.i.51.i.i, align 2
  %add.i.59.i.i = add i16 %170, 8
  %cmp4.i.60.i.i = icmp ult i16 %169, %add.i.59.i.i
  br i1 %cmp4.i.60.i.i, label %if.then.i.63.i.i, label %if.else.i.64.i.i

if.then.i.63.i.i:                                 ; preds = %for.body.3.i.i.i
  %171 = load i16, i16* %i.i.50.i.i, align 2
  %172 = load i16, i16* %offset.i.51.i.i, align 2
  %sub5.i.i.i = sub i16 %171, %172
  %173 = load i16*, i16** %n.addr.i.48.i.i, align 2
  %arrayidx6.i.61.i.i = getelementptr inbounds i16, i16* %173, i16 %sub5.i.i.i
  %174 = load i16, i16* %arrayidx6.i.61.i.i, align 2
  store i16 %174, i16* %nd.i.i.i, align 2
  %175 = load i16, i16* %q.addr.i.i.i, align 2
  %176 = load i16, i16* %nd.i.i.i, align 2
  %mul.i.i.i = mul i16 %175, %176
  %177 = load i16, i16* %p.i.i.i, align 2
  %add7.i.62.i.i = add i16 %177, %mul.i.i.i
  store i16 %add7.i.62.i.i, i16* %p.i.i.i, align 2
  br label %if.end.i.68.i.i

if.else.i.64.i.i:                                 ; preds = %for.body.3.i.i.i
  store i16 0, i16* %nd.i.i.i, align 2
  br label %if.end.i.68.i.i

if.end.i.68.i.i:                                  ; preds = %if.else.i.64.i.i, %if.then.i.63.i.i
  %178 = load i16, i16* %p.i.i.i, align 2
  %shr.i.65.i.i = lshr i16 %178, 8
  store i16 %shr.i.65.i.i, i16* %c.i.i.i, align 2
  %179 = load i16, i16* %p.i.i.i, align 2
  %and.i.66.i.i = and i16 %179, 255
  store i16 %and.i.66.i.i, i16* %p.i.i.i, align 2
  %180 = load i16, i16* %p.i.i.i, align 2
  %181 = load i16, i16* %i.i.50.i.i, align 2
  %182 = load i16*, i16** %product.addr.i.i.i, align 2
  %arrayidx8.i.67.i.i = getelementptr inbounds i16, i16* %182, i16 %181
  store i16 %180, i16* %arrayidx8.i.67.i.i, align 2
  %183 = load i16, i16* %i.i.50.i.i, align 2
  %inc10.i.i.i = add nsw i16 %183, 1
  store i16 %inc10.i.i.i, i16* %i.i.50.i.i, align 2
  br label %for.cond.1.i.i.i

reduce_multiply.exit.i.i:                         ; preds = %for.cond.1.i.i.i
  store i16 33, i16* @curtask, align 2
  %184 = load i16*, i16** %m.addr.i.i, align 2
  store i16* %184, i16** %a.addr.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i, align 2
  store i16 0, i16* %relation.i.i.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i, align 2
  br label %for.cond.i.71.i.i

for.cond.i.71.i.i:                                ; preds = %if.end.i.76.i.i, %reduce_multiply.exit.i.i
  %185 = load i16, i16* %i.i.69.i.i, align 2
  %cmp.i.70.i.i = icmp sge i16 %185, 0
  br i1 %cmp.i.70.i.i, label %for.body.i.72.i.i, label %reduce_compare.exit.i.i

for.body.i.72.i.i:                                ; preds = %for.cond.i.71.i.i
  %186 = load i16*, i16** %a.addr.i.i.i, align 2
  %187 = load i16*, i16** %b.addr.i.i.i, align 2
  %cmp1.i.i.i = icmp ugt i16* %186, %187
  br i1 %cmp1.i.i.i, label %if.then.i.73.i.i, label %if.else.i.75.i.i

if.then.i.73.i.i:                                 ; preds = %for.body.i.72.i.i
  store i16 1, i16* %relation.i.i.i, align 2
  br label %reduce_compare.exit.i.i

if.else.i.75.i.i:                                 ; preds = %for.body.i.72.i.i
  %188 = load i16*, i16** %a.addr.i.i.i, align 2
  %189 = load i16*, i16** %b.addr.i.i.i, align 2
  %cmp2.i.74.i.i = icmp ult i16* %188, %189
  br i1 %cmp2.i.74.i.i, label %if.then.3.i.i.i, label %if.end.i.76.i.i

if.then.3.i.i.i:                                  ; preds = %if.else.i.75.i.i
  store i16 -1, i16* %relation.i.i.i, align 2
  br label %reduce_compare.exit.i.i

if.end.i.76.i.i:                                  ; preds = %if.else.i.75.i.i
  %190 = load i16, i16* %i.i.69.i.i, align 2
  %dec.i.77.i.i = add nsw i16 %190, -1
  store i16 %dec.i.77.i.i, i16* %i.i.69.i.i, align 2
  br label %for.cond.i.71.i.i

reduce_compare.exit.i.i:                          ; preds = %if.then.3.i.i.i, %if.then.i.73.i.i, %for.cond.i.71.i.i
  store i16 31, i16* @curtask, align 2
  %191 = load i16, i16* %relation.i.i.i, align 2
  %cmp10.i.i = icmp slt i16 %191, 0
  br i1 %cmp10.i.i, label %if.then.11.i.i, label %if.end.12.i.i

if.then.11.i.i:                                   ; preds = %reduce_compare.exit.i.i
  %192 = load i16*, i16** %m.addr.i.i, align 2
  %193 = load i16*, i16** %n.addr.i.i, align 2
  %194 = load i16, i16* %d.i.i, align 2
  store i16* %192, i16** %a.addr.i.79.i.i, align 2
  store i16* %193, i16** %b.addr.i.80.i.i, align 2
  store i16 %194, i16* %d.addr.i.81.i.i, align 2
  store i16 10, i16* @curtask, align 2
  %195 = load i16, i16* %d.addr.i.81.i.i, align 2
  %sub.i.85.i.i = sub i16 %195, 8
  store i16 %sub.i.85.i.i, i16* %offset.i.83.i.i, align 2
  store i16 0, i16* %c.i.84.i.i, align 2
  %196 = load i16, i16* %offset.i.83.i.i, align 2
  store i16 %196, i16* %i.i.82.i.i, align 2
  br label %for.cond.i.87.i.i

for.cond.i.87.i.i:                                ; preds = %if.end.i.100.i.i, %if.then.11.i.i
  %197 = load i16, i16* %i.i.82.i.i, align 2
  %cmp.i.86.i.i = icmp slt i16 %197, 16
  br i1 %cmp.i.86.i.i, label %for.body.i.92.i.i, label %reduce_add.exit.i.i

for.body.i.92.i.i:                                ; preds = %for.cond.i.87.i.i
  store i16 22, i16* @curtask, align 2
  %198 = load i16, i16* %i.i.82.i.i, align 2
  %199 = load i16*, i16** %a.addr.i.79.i.i, align 2
  %arrayidx.i.88.i.i = getelementptr inbounds i16, i16* %199, i16 %198
  %200 = load i16, i16* %arrayidx.i.88.i.i, align 2
  store i16 %200, i16* %m.i.i.i, align 2
  %201 = load i16, i16* %i.i.82.i.i, align 2
  %202 = load i16, i16* %offset.i.83.i.i, align 2
  %sub1.i.89.i.i = sub i16 %201, %202
  store i16 %sub1.i.89.i.i, i16* %j.i.i.i, align 2
  %203 = load i16, i16* %i.i.82.i.i, align 2
  %204 = load i16, i16* %offset.i.83.i.i, align 2
  %add.i.90.i.i = add i16 %204, 8
  %cmp2.i.91.i.i = icmp ult i16 %203, %add.i.90.i.i
  br i1 %cmp2.i.91.i.i, label %if.then.i.94.i.i, label %if.else.i.95.i.i

if.then.i.94.i.i:                                 ; preds = %for.body.i.92.i.i
  %205 = load i16, i16* %j.i.i.i, align 2
  %206 = load i16*, i16** %b.addr.i.80.i.i, align 2
  %arrayidx3.i.93.i.i = getelementptr inbounds i16, i16* %206, i16 %205
  %207 = load i16, i16* %arrayidx3.i.93.i.i, align 2
  store i16 %207, i16* %n.i.i.i, align 2
  br label %if.end.i.100.i.i

if.else.i.95.i.i:                                 ; preds = %for.body.i.92.i.i
  store i16 0, i16* %n.i.i.i, align 2
  store i16 0, i16* %j.i.i.i, align 2
  br label %if.end.i.100.i.i

if.end.i.100.i.i:                                 ; preds = %if.else.i.95.i.i, %if.then.i.94.i.i
  %208 = load i16, i16* %c.i.84.i.i, align 2
  %209 = load i16, i16* %m.i.i.i, align 2
  %add4.i.i.i = add i16 %208, %209
  %210 = load i16, i16* %n.i.i.i, align 2
  %add5.i.96.i.i = add i16 %add4.i.i.i, %210
  store i16 %add5.i.96.i.i, i16* %r.i.i.i, align 2
  %211 = load i16, i16* %r.i.i.i, align 2
  %shr.i.97.i.i = lshr i16 %211, 8
  store i16 %shr.i.97.i.i, i16* %c.i.84.i.i, align 2
  %212 = load i16, i16* %r.i.i.i, align 2
  %and.i.98.i.i = and i16 %212, 255
  store i16 %and.i.98.i.i, i16* %r.i.i.i, align 2
  %213 = load i16, i16* %r.i.i.i, align 2
  %214 = load i16, i16* %i.i.82.i.i, align 2
  %215 = load i16*, i16** %a.addr.i.79.i.i, align 2
  %arrayidx6.i.99.i.i = getelementptr inbounds i16, i16* %215, i16 %214
  store i16 %213, i16* %arrayidx6.i.99.i.i, align 2
  %216 = load i16, i16* %i.i.82.i.i, align 2
  %inc.i.101.i.i = add nsw i16 %216, 1
  store i16 %inc.i.101.i.i, i16* %i.i.82.i.i, align 2
  br label %for.cond.i.87.i.i

reduce_add.exit.i.i:                              ; preds = %for.cond.i.87.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i

if.end.12.i.i:                                    ; preds = %reduce_add.exit.i.i, %reduce_compare.exit.i.i
  %217 = load i16*, i16** %m.addr.i.i, align 2
  %218 = load i16, i16* %d.i.i, align 2
  store i16* %217, i16** %a.addr.i.103.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i, align 2
  store i16 %218, i16* %d.addr.i.105.i.i, align 2
  store i16 11, i16* @curtask, align 2
  %219 = load i16, i16* %d.addr.i.105.i.i, align 2
  %sub.i.113.i.i = sub i16 %219, 8
  store i16 %sub.i.113.i.i, i16* %offset.i.112.i.i, align 2
  %220 = load i16, i16* %d.addr.i.105.i.i, align 2
  %221 = load i16, i16* %offset.i.112.i.i, align 2
  %call.i.114.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %220, i16 %221) #4
  store i16 0, i16* %borrow.i.111.i.i, align 2
  %222 = load i16, i16* %offset.i.112.i.i, align 2
  store i16 %222, i16* %i.i.106.i.i, align 2
  br label %for.cond.i.116.i.i

for.cond.i.116.i.i:                               ; preds = %if.end.i.126.i.i, %if.end.12.i.i
  %223 = load i16, i16* %i.i.106.i.i, align 2
  %cmp.i.115.i.i = icmp slt i16 %223, 16
  br i1 %cmp.i.115.i.i, label %for.body.i.121.i.i, label %reduce_subtract.exit.i.i

for.body.i.121.i.i:                               ; preds = %for.cond.i.116.i.i
  store i16 23, i16* @curtask, align 2
  %224 = load i16, i16* %i.i.106.i.i, align 2
  %225 = load i16*, i16** %a.addr.i.103.i.i, align 2
  %arrayidx.i.117.i.i = getelementptr inbounds i16, i16* %225, i16 %224
  %226 = load i16, i16* %arrayidx.i.117.i.i, align 2
  store i16 %226, i16* %m.i.107.i.i, align 2
  %227 = load i16, i16* %i.i.106.i.i, align 2
  %228 = load i16*, i16** %b.addr.i.104.i.i, align 2
  %arrayidx1.i.118.i.i = getelementptr inbounds i16, i16* %228, i16 %227
  %229 = load i16, i16* %arrayidx1.i.118.i.i, align 2
  store i16 %229, i16* %qn.i.110.i.i, align 2
  %230 = load i16, i16* %qn.i.110.i.i, align 2
  %231 = load i16, i16* %borrow.i.111.i.i, align 2
  %add.i.119.i.i = add i16 %230, %231
  store i16 %add.i.119.i.i, i16* %s.i.108.i.i, align 2
  %232 = load i16, i16* %m.i.107.i.i, align 2
  %233 = load i16, i16* %s.i.108.i.i, align 2
  %cmp2.i.120.i.i = icmp ult i16 %232, %233
  br i1 %cmp2.i.120.i.i, label %if.then.i.123.i.i, label %if.else.i.124.i.i

if.then.i.123.i.i:                                ; preds = %for.body.i.121.i.i
  %234 = load i16, i16* %m.i.107.i.i, align 2
  %add3.i.122.i.i = add i16 %234, 256
  store i16 %add3.i.122.i.i, i16* %m.i.107.i.i, align 2
  store i16 1, i16* %borrow.i.111.i.i, align 2
  br label %if.end.i.126.i.i

if.else.i.124.i.i:                                ; preds = %for.body.i.121.i.i
  store i16 0, i16* %borrow.i.111.i.i, align 2
  br label %if.end.i.126.i.i

if.end.i.126.i.i:                                 ; preds = %if.else.i.124.i.i, %if.then.i.123.i.i
  %235 = load i16, i16* %m.i.107.i.i, align 2
  %236 = load i16, i16* %s.i.108.i.i, align 2
  %sub4.i.i.i = sub i16 %235, %236
  store i16 %sub4.i.i.i, i16* %r.i.109.i.i, align 2
  %237 = load i16, i16* %r.i.109.i.i, align 2
  %238 = load i16, i16* %i.i.106.i.i, align 2
  %239 = load i16*, i16** %a.addr.i.103.i.i, align 2
  %arrayidx5.i.125.i.i = getelementptr inbounds i16, i16* %239, i16 %238
  store i16 %237, i16* %arrayidx5.i.125.i.i, align 2
  %240 = load i16, i16* %i.i.106.i.i, align 2
  %inc.i.127.i.i = add nsw i16 %240, 1
  store i16 %inc.i.127.i.i, i16* %i.i.106.i.i, align 2
  br label %for.cond.i.116.i.i

reduce_subtract.exit.i.i:                         ; preds = %for.cond.i.116.i.i
  store i16 35, i16* @curtask, align 2
  %241 = load i16, i16* %d.i.i, align 2
  %dec13.i.i = add i16 %241, -1
  store i16 %dec13.i.i, i16* %d.i.i, align 2
  br label %while.cond.i.i

while.end.i.i:                                    ; preds = %while.cond.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit

mod_mult.exit:                                    ; preds = %if.then.5.i.i, %while.end.i.i
  br label %if.end

if.end:                                           ; preds = %mod_mult.exit, %while.body
  %242 = load i16*, i16** %base.addr, align 2
  %243 = load i16*, i16** %base.addr, align 2
  %244 = load i16*, i16** %n.addr, align 2
  store i16* %242, i16** %a.addr.i.78, align 2
  store i16* %243, i16** %b.addr.i.79, align 2
  store i16* %244, i16** %n.addr.i.80, align 2
  %245 = load i16*, i16** %a.addr.i.78, align 2
  %246 = load i16*, i16** %b.addr.i.79, align 2
  store i16* %245, i16** %a.addr.i.i.70, align 2
  store i16* %246, i16** %b.addr.i.i.71, align 2
  store i16 0, i16* %carry.i.i.77, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i.73, align 2
  br label %for.cond.i.i.82

for.cond.i.i.82:                                  ; preds = %for.end.i.i.107, %if.end
  %247 = load i16, i16* %digit.i.i.73, align 2
  %cmp.i.i.81 = icmp ult i16 %247, 16
  br i1 %cmp.i.i.81, label %for.body.i.i.83, label %for.end.15.i.i.108

for.body.i.i.83:                                  ; preds = %for.cond.i.i.82
  store i16 14, i16* @curtask, align 2
  %248 = load i16, i16* %carry.i.i.77, align 2
  store i16 %248, i16* %p.i.i.74, align 2
  store i16 0, i16* %c.i.i.75, align 2
  store i16 0, i16* %i.i.i.72, align 2
  br label %for.cond.1.i.i.85

for.cond.1.i.i.85:                                ; preds = %if.end.i.i.101, %for.body.i.i.83
  %249 = load i16, i16* %i.i.i.72, align 2
  %cmp2.i.i.84 = icmp slt i16 %249, 8
  br i1 %cmp2.i.i.84, label %for.body.3.i.i.87, label %for.end.i.i.107

for.body.3.i.i.87:                                ; preds = %for.cond.1.i.i.85
  %250 = load i16, i16* %i.i.i.72, align 2
  %251 = load i16, i16* %digit.i.i.73, align 2
  %cmp4.i.i.86 = icmp ule i16 %250, %251
  br i1 %cmp4.i.i.86, label %land.lhs.true.i.i.90, label %if.end.i.i.101

land.lhs.true.i.i.90:                             ; preds = %for.body.3.i.i.87
  %252 = load i16, i16* %digit.i.i.73, align 2
  %253 = load i16, i16* %i.i.i.72, align 2
  %sub.i.i.88 = sub i16 %252, %253
  %cmp5.i.i.89 = icmp ult i16 %sub.i.i.88, 8
  br i1 %cmp5.i.i.89, label %if.then.i.i.99, label %if.end.i.i.101

if.then.i.i.99:                                   ; preds = %land.lhs.true.i.i.90
  %254 = load i16, i16* %digit.i.i.73, align 2
  %255 = load i16, i16* %i.i.i.72, align 2
  %sub6.i.i.91 = sub i16 %254, %255
  %256 = load i16*, i16** %a.addr.i.i.70, align 2
  %arrayidx.i.i.92 = getelementptr inbounds i16, i16* %256, i16 %sub6.i.i.91
  %257 = load i16, i16* %arrayidx.i.i.92, align 2
  %258 = load i16, i16* %i.i.i.72, align 2
  %259 = load i16*, i16** %b.addr.i.i.71, align 2
  %arrayidx7.i.i.93 = getelementptr inbounds i16, i16* %259, i16 %258
  %260 = load i16, i16* %arrayidx7.i.i.93, align 2
  %mul.i.i.94 = mul i16 %257, %260
  store i16 %mul.i.i.94, i16* %dp.i.i.76, align 2
  %261 = load i16, i16* %dp.i.i.76, align 2
  %shr.i.i.95 = lshr i16 %261, 8
  %262 = load i16, i16* %c.i.i.75, align 2
  %add.i.i.96 = add i16 %262, %shr.i.i.95
  store i16 %add.i.i.96, i16* %c.i.i.75, align 2
  %263 = load i16, i16* %dp.i.i.76, align 2
  %and.i.i.97 = and i16 %263, 255
  %264 = load i16, i16* %p.i.i.74, align 2
  %add8.i.i.98 = add i16 %264, %and.i.i.97
  store i16 %add8.i.i.98, i16* %p.i.i.74, align 2
  br label %if.end.i.i.101

if.end.i.i.101:                                   ; preds = %if.then.i.i.99, %land.lhs.true.i.i.90, %for.body.3.i.i.87
  %265 = load i16, i16* %i.i.i.72, align 2
  %inc.i.i.100 = add nsw i16 %265, 1
  store i16 %inc.i.i.100, i16* %i.i.i.72, align 2
  br label %for.cond.1.i.i.85

for.end.i.i.107:                                  ; preds = %for.cond.1.i.i.85
  %266 = load i16, i16* %p.i.i.74, align 2
  %shr9.i.i.102 = lshr i16 %266, 8
  %267 = load i16, i16* %c.i.i.75, align 2
  %add10.i.i.103 = add i16 %267, %shr9.i.i.102
  store i16 %add10.i.i.103, i16* %c.i.i.75, align 2
  %268 = load i16, i16* %p.i.i.74, align 2
  %and11.i.i.104 = and i16 %268, 255
  store i16 %and11.i.i.104, i16* %p.i.i.74, align 2
  %269 = load i16, i16* %p.i.i.74, align 2
  %270 = load i16, i16* %digit.i.i.73, align 2
  %arrayidx12.i.i.105 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %270
  store i16 %269, i16* %arrayidx12.i.i.105, align 2
  %271 = load i16, i16* %c.i.i.75, align 2
  store i16 %271, i16* %carry.i.i.77, align 2
  %272 = load i16, i16* %digit.i.i.73, align 2
  %inc14.i.i.106 = add i16 %272, 1
  store i16 %inc14.i.i.106, i16* %digit.i.i.73, align 2
  br label %for.cond.i.i.82

for.end.15.i.i.108:                               ; preds = %for.cond.i.i.82
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i.72, align 2
  br label %for.cond.16.i.i.110

for.cond.16.i.i.110:                              ; preds = %for.body.18.i.i.114, %for.end.15.i.i.108
  %273 = load i16, i16* %i.i.i.72, align 2
  %cmp17.i.i.109 = icmp slt i16 %273, 16
  br i1 %cmp17.i.i.109, label %for.body.18.i.i.114, label %mult.exit.i.115

for.body.18.i.i.114:                              ; preds = %for.cond.16.i.i.110
  %274 = load i16, i16* %i.i.i.72, align 2
  %arrayidx19.i.i.111 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %274
  %275 = load i16, i16* %arrayidx19.i.i.111, align 2
  %276 = load i16, i16* %i.i.i.72, align 2
  %277 = load i16*, i16** %a.addr.i.i.70, align 2
  %arrayidx20.i.i.112 = getelementptr inbounds i16, i16* %277, i16 %276
  store i16 %275, i16* %arrayidx20.i.i.112, align 2
  %278 = load i16, i16* %i.i.i.72, align 2
  %inc22.i.i.113 = add nsw i16 %278, 1
  store i16 %inc22.i.i.113, i16* %i.i.i.72, align 2
  br label %for.cond.16.i.i.110

mult.exit.i.115:                                  ; preds = %for.cond.16.i.i.110
  store i16 27, i16* @curtask, align 2
  %279 = load i16*, i16** %a.addr.i.78, align 2
  %280 = load i16*, i16** %n.addr.i.80, align 2
  store i16* %279, i16** %m.addr.i.i.65, align 2
  store i16* %280, i16** %n.addr.i.i.66, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i.69, align 2
  br label %do.body.i.i.120

do.body.i.i.120:                                  ; preds = %land.end.i.i.123, %mult.exit.i.115
  %281 = load i16, i16* %d.i.i.69, align 2
  %dec.i.i.116 = add i16 %281, -1
  store i16 %dec.i.i.116, i16* %d.i.i.69, align 2
  %282 = load i16, i16* %d.i.i.69, align 2
  %283 = load i16*, i16** %m.addr.i.i.65, align 2
  %arrayidx.i.1.i.117 = getelementptr inbounds i16, i16* %283, i16 %282
  %284 = load i16, i16* %arrayidx.i.1.i.117, align 2
  store i16 %284, i16* %m_d.i.i.68, align 2
  %285 = load i16, i16* %d.i.i.69, align 2
  %286 = load i16, i16* %m_d.i.i.68, align 2
  %call.i.i.118 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %285, i16 %286) #4
  %287 = load i16, i16* %m_d.i.i.68, align 2
  %cmp.i.2.i.119 = icmp eq i16 %287, 0
  br i1 %cmp.i.2.i.119, label %land.rhs.i.i.122, label %land.end.i.i.123

land.rhs.i.i.122:                                 ; preds = %do.body.i.i.120
  %288 = load i16, i16* %d.i.i.69, align 2
  %cmp1.i.i.121 = icmp ugt i16 %288, 0
  br label %land.end.i.i.123

land.end.i.i.123:                                 ; preds = %land.rhs.i.i.122, %do.body.i.i.120
  %289 = phi i1 [ false, %do.body.i.i.120 ], [ %cmp1.i.i.121, %land.rhs.i.i.122 ]
  br i1 %289, label %do.body.i.i.120, label %do.end.i.i.128

do.end.i.i.128:                                   ; preds = %land.end.i.i.123
  %290 = load i16, i16* %d.i.i.69, align 2
  %call2.i.i.124 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %290) #4
  %291 = load i16*, i16** %m.addr.i.i.65, align 2
  %292 = load i16*, i16** %n.addr.i.i.66, align 2
  %293 = load i16, i16* %d.i.i.69, align 2
  store i16* %291, i16** %m.addr.i.i.i.57, align 2
  store i16* %292, i16** %n.addr.i.i.i.58, align 2
  store i16 %293, i16* %d.addr.i.i.i.59, align 2
  store i8 1, i8* %normalizable.i.i.i.64, align 1
  store i16 6, i16* @curtask, align 2
  %294 = load i16, i16* %d.addr.i.i.i.59, align 2
  %add.i.i.i.125 = add i16 %294, 1
  %sub.i.i.i.126 = sub i16 %add.i.i.i.125, 8
  store i16 %sub.i.i.i.126, i16* %offset.i.i.i.61, align 2
  %295 = load i16, i16* %d.addr.i.i.i.59, align 2
  %296 = load i16, i16* %offset.i.i.i.61, align 2
  %call.i.i.i.127 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %295, i16 %296) #4
  %297 = load i16, i16* %d.addr.i.i.i.59, align 2
  store i16 %297, i16* %i.i.i.i.60, align 2
  br label %for.cond.i.i.i.130

for.cond.i.i.i.130:                               ; preds = %if.end.i.i.i.141, %do.end.i.i.128
  %298 = load i16, i16* %i.i.i.i.60, align 2
  %cmp.i.i.i.129 = icmp sge i16 %298, 0
  br i1 %cmp.i.i.i.129, label %for.body.i.i.i.135, label %reduce_normalizable.exit.i.i.146

for.body.i.i.i.135:                               ; preds = %for.cond.i.i.i.130
  %299 = load i16, i16* %i.i.i.i.60, align 2
  %300 = load i16*, i16** %m.addr.i.i.i.57, align 2
  %arrayidx.i.i.i.131 = getelementptr inbounds i16, i16* %300, i16 %299
  %301 = load i16, i16* %arrayidx.i.i.i.131, align 2
  store i16 %301, i16* %m_d.i.i.i.63, align 2
  %302 = load i16, i16* %i.i.i.i.60, align 2
  %303 = load i16, i16* %offset.i.i.i.61, align 2
  %sub1.i.i.i.132 = sub i16 %302, %303
  %304 = load i16*, i16** %n.addr.i.i.i.58, align 2
  %arrayidx2.i.i.i.133 = getelementptr inbounds i16, i16* %304, i16 %sub1.i.i.i.132
  %305 = load i16, i16* %arrayidx2.i.i.i.133, align 2
  store i16 %305, i16* %n_d.i.i.i.62, align 2
  %306 = load i16, i16* %m_d.i.i.i.63, align 2
  %307 = load i16, i16* %n_d.i.i.i.62, align 2
  %cmp3.i.i.i.134 = icmp ugt i16 %306, %307
  br i1 %cmp3.i.i.i.134, label %if.then.i.i.i.136, label %if.else.i.i.i.138

if.then.i.i.i.136:                                ; preds = %for.body.i.i.i.135
  br label %reduce_normalizable.exit.i.i.146

if.else.i.i.i.138:                                ; preds = %for.body.i.i.i.135
  %308 = load i16, i16* %m_d.i.i.i.63, align 2
  %309 = load i16, i16* %n_d.i.i.i.62, align 2
  %cmp4.i.i.i.137 = icmp ult i16 %308, %309
  br i1 %cmp4.i.i.i.137, label %if.then.5.i.i.i.139, label %if.end.i.i.i.141

if.then.5.i.i.i.139:                              ; preds = %if.else.i.i.i.138
  store i8 0, i8* %normalizable.i.i.i.64, align 1
  br label %reduce_normalizable.exit.i.i.146

if.end.i.i.i.141:                                 ; preds = %if.else.i.i.i.138
  %310 = load i16, i16* %i.i.i.i.60, align 2
  %dec.i.i.i.140 = add nsw i16 %310, -1
  store i16 %dec.i.i.i.140, i16* %i.i.i.i.60, align 2
  br label %for.cond.i.i.i.130

reduce_normalizable.exit.i.i.146:                 ; preds = %if.then.5.i.i.i.139, %if.then.i.i.i.136, %for.cond.i.i.i.130
  %311 = load i8, i8* %normalizable.i.i.i.64, align 1
  %tobool.i.i.i.142 = trunc i8 %311 to i1
  %conv.i.i.i.143 = zext i1 %tobool.i.i.i.142 to i16
  %call7.i.i.i.144 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143) #4
  store i16 30, i16* @curtask, align 2
  %312 = load i8, i8* %normalizable.i.i.i.64, align 1
  %tobool8.i.i.i.145 = trunc i8 %312 to i1
  br i1 %tobool8.i.i.i.145, label %if.then.i.3.i.149, label %if.else.i.i.168

if.then.i.3.i.149:                                ; preds = %reduce_normalizable.exit.i.i.146
  %313 = load i16*, i16** %m.addr.i.i.65, align 2
  %314 = load i16*, i16** %n.addr.i.i.66, align 2
  %315 = load i16, i16* %d.i.i.69, align 2
  store i16* %313, i16** %m.addr.i.14.i.i.47, align 2
  store i16* %314, i16** %n.addr.i.15.i.i.48, align 2
  store i16 %315, i16* %digit.addr.i.i.i.49, align 2
  store i16 5, i16* @curtask, align 2
  %316 = load i16, i16* %digit.addr.i.i.i.49, align 2
  %add.i.20.i.i.147 = add i16 %316, 1
  %sub.i.21.i.i.148 = sub i16 %add.i.20.i.i.147, 8
  store i16 %sub.i.21.i.i.148, i16* %offset.i.19.i.i.56, align 2
  store i16 0, i16* %borrow.i.i.i.55, align 2
  store i16 0, i16* %i.i.16.i.i.50, align 2
  br label %for.cond.i.23.i.i.151

for.cond.i.23.i.i.151:                            ; preds = %if.end.i.30.i.i.165, %if.then.i.3.i.149
  %317 = load i16, i16* %i.i.16.i.i.50, align 2
  %cmp.i.22.i.i.150 = icmp slt i16 %317, 8
  br i1 %cmp.i.22.i.i.150, label %for.body.i.27.i.i.157, label %reduce_normalize.exit.i.i.166

for.body.i.27.i.i.157:                            ; preds = %for.cond.i.23.i.i.151
  store i16 21, i16* @curtask, align 2
  %318 = load i16, i16* %i.i.16.i.i.50, align 2
  %319 = load i16, i16* %offset.i.19.i.i.56, align 2
  %add1.i.i.i.152 = add i16 %318, %319
  %320 = load i16*, i16** %m.addr.i.14.i.i.47, align 2
  %arrayidx.i.24.i.i.153 = getelementptr inbounds i16, i16* %320, i16 %add1.i.i.i.152
  %321 = load i16, i16* %arrayidx.i.24.i.i.153, align 2
  store i16 %321, i16* %m_d.i.17.i.i.53, align 2
  %322 = load i16, i16* %i.i.16.i.i.50, align 2
  %323 = load i16*, i16** %n.addr.i.15.i.i.48, align 2
  %arrayidx2.i.25.i.i.154 = getelementptr inbounds i16, i16* %323, i16 %322
  %324 = load i16, i16* %arrayidx2.i.25.i.i.154, align 2
  store i16 %324, i16* %n_d.i.18.i.i.54, align 2
  %325 = load i16, i16* %n_d.i.18.i.i.54, align 2
  %326 = load i16, i16* %borrow.i.i.i.55, align 2
  %add3.i.i.i.155 = add i16 %325, %326
  store i16 %add3.i.i.i.155, i16* %s.i.i.i.52, align 2
  %327 = load i16, i16* %m_d.i.17.i.i.53, align 2
  %328 = load i16, i16* %s.i.i.i.52, align 2
  %cmp4.i.26.i.i.156 = icmp ult i16 %327, %328
  br i1 %cmp4.i.26.i.i.156, label %if.then.i.28.i.i.159, label %if.else.i.29.i.i.160

if.then.i.28.i.i.159:                             ; preds = %for.body.i.27.i.i.157
  %329 = load i16, i16* %m_d.i.17.i.i.53, align 2
  %add5.i.i.i.158 = add i16 %329, 256
  store i16 %add5.i.i.i.158, i16* %m_d.i.17.i.i.53, align 2
  store i16 1, i16* %borrow.i.i.i.55, align 2
  br label %if.end.i.30.i.i.165

if.else.i.29.i.i.160:                             ; preds = %for.body.i.27.i.i.157
  store i16 0, i16* %borrow.i.i.i.55, align 2
  br label %if.end.i.30.i.i.165

if.end.i.30.i.i.165:                              ; preds = %if.else.i.29.i.i.160, %if.then.i.28.i.i.159
  %330 = load i16, i16* %m_d.i.17.i.i.53, align 2
  %331 = load i16, i16* %s.i.i.i.52, align 2
  %sub6.i.i.i.161 = sub i16 %330, %331
  store i16 %sub6.i.i.i.161, i16* %d.i.i.i.51, align 2
  %332 = load i16, i16* %d.i.i.i.51, align 2
  %333 = load i16, i16* %i.i.16.i.i.50, align 2
  %334 = load i16, i16* %offset.i.19.i.i.56, align 2
  %add7.i.i.i.162 = add i16 %333, %334
  %335 = load i16*, i16** %m.addr.i.14.i.i.47, align 2
  %arrayidx8.i.i.i.163 = getelementptr inbounds i16, i16* %335, i16 %add7.i.i.i.162
  store i16 %332, i16* %arrayidx8.i.i.i.163, align 2
  %336 = load i16, i16* %i.i.16.i.i.50, align 2
  %inc.i.i.i.164 = add nsw i16 %336, 1
  store i16 %inc.i.i.i.164, i16* %i.i.16.i.i.50, align 2
  br label %for.cond.i.23.i.i.151

reduce_normalize.exit.i.i.166:                    ; preds = %for.cond.i.23.i.i.151
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172

if.else.i.i.168:                                  ; preds = %reduce_normalizable.exit.i.i.146
  %337 = load i16, i16* %d.i.i.69, align 2
  %cmp4.i.4.i.167 = icmp eq i16 %337, 7
  br i1 %cmp4.i.4.i.167, label %if.then.5.i.i.170, label %if.end.i.5.i.171

if.then.5.i.i.170:                                ; preds = %if.else.i.i.168
  %call6.i.i.169 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312

if.end.i.5.i.171:                                 ; preds = %if.else.i.i.168
  br label %if.end.7.i.i.172

if.end.7.i.i.172:                                 ; preds = %if.end.i.5.i.171, %reduce_normalize.exit.i.i.166
  br label %while.cond.i.i.174

while.cond.i.i.174:                               ; preds = %reduce_subtract.exit.i.i.310, %if.end.7.i.i.172
  %338 = load i16, i16* %d.i.i.69, align 2
  %cmp8.i.i.173 = icmp uge i16 %338, 8
  br i1 %cmp8.i.i.173, label %while.body.i.i.192, label %while.end.i.i.311

while.body.i.i.192:                               ; preds = %while.cond.i.i.174
  %339 = load i16*, i16** %m.addr.i.i.65, align 2
  %340 = load i16*, i16** %n.addr.i.i.66, align 2
  %341 = load i16, i16* %d.i.i.69, align 2
  store i16* %q.i.i.67, i16** %quotient.addr.i.i.i.36, align 2
  store i16* %339, i16** %m.addr.i.31.i.i.37, align 2
  store i16* %340, i16** %n.addr.i.32.i.i.38, align 2
  store i16 %341, i16* %d.addr.i.33.i.i.39, align 2
  store i16 16, i16* @curtask, align 2
  %342 = load i16*, i16** %n.addr.i.32.i.i.38, align 2
  %arrayidx.i.35.i.i.175 = getelementptr inbounds i16, i16* %342, i16 7
  %343 = load i16, i16* %arrayidx.i.35.i.i.175, align 2
  %shl.i.i.i.176 = shl i16 %343, 8
  %344 = load i16*, i16** %n.addr.i.32.i.i.38, align 2
  %arrayidx1.i.i.i.177 = getelementptr inbounds i16, i16* %344, i16 6
  %345 = load i16, i16* %arrayidx1.i.i.i.177, align 2
  %add.i.36.i.i.178 = add i16 %shl.i.i.i.176, %345
  store i16 %add.i.36.i.i.178, i16* %n_div.i.i.i.42, align 2
  %346 = load i16*, i16** %n.addr.i.32.i.i.38, align 2
  %arrayidx2.i.37.i.i.179 = getelementptr inbounds i16, i16* %346, i16 7
  %347 = load i16, i16* %arrayidx2.i.37.i.i.179, align 2
  store i16 %347, i16* %n_n.i.i.i.43, align 2
  %348 = load i16, i16* %d.addr.i.33.i.i.39, align 2
  %349 = load i16*, i16** %m.addr.i.31.i.i.37, align 2
  %arrayidx3.i.i.i.180 = getelementptr inbounds i16, i16* %349, i16 %348
  %350 = load i16, i16* %arrayidx3.i.i.i.180, align 2
  %arrayidx4.i.i.i.181 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  store i16 %350, i16* %arrayidx4.i.i.i.181, align 2
  %351 = load i16, i16* %d.addr.i.33.i.i.39, align 2
  %sub.i.38.i.i.182 = sub i16 %351, 1
  %352 = load i16*, i16** %m.addr.i.31.i.i.37, align 2
  %arrayidx5.i.i.i.183 = getelementptr inbounds i16, i16* %352, i16 %sub.i.38.i.i.182
  %353 = load i16, i16* %arrayidx5.i.i.i.183, align 2
  %arrayidx6.i.i.i.184 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  store i16 %353, i16* %arrayidx6.i.i.i.184, align 2
  %354 = load i16, i16* %d.addr.i.33.i.i.39, align 2
  %sub7.i.i.i.185 = sub i16 %354, 2
  %355 = load i16*, i16** %m.addr.i.31.i.i.37, align 2
  %arrayidx8.i.39.i.i.186 = getelementptr inbounds i16, i16* %355, i16 %sub7.i.i.i.185
  %356 = load i16, i16* %arrayidx8.i.39.i.i.186, align 2
  %arrayidx9.i.i.i.187 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  store i16 %356, i16* %arrayidx9.i.i.i.187, align 2
  %357 = load i16, i16* %n_n.i.i.i.43, align 2
  %358 = load i16*, i16** %m.addr.i.31.i.i.37, align 2
  %arrayidx10.i.i.i.188 = getelementptr inbounds i16, i16* %358, i16 2
  %359 = load i16, i16* %arrayidx10.i.i.i.188, align 2
  %call.i.40.i.i.189 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %357, i16 %359) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %360 = load i16, i16* %arrayidx11.i.i.i.190, align 2
  %361 = load i16, i16* %n_n.i.i.i.43, align 2
  %cmp.i.41.i.i.191 = icmp eq i16 %360, %361
  br i1 %cmp.i.41.i.i.191, label %if.then.i.42.i.i.193, label %if.else.i.43.i.i.200

if.then.i.42.i.i.193:                             ; preds = %while.body.i.i.192
  store i16 255, i16* %q.i.i.i.41, align 2
  br label %if.end.i.46.i.i.222

if.else.i.43.i.i.200:                             ; preds = %while.body.i.i.192
  %arrayidx12.i.i.i.194 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %362 = load i16, i16* %arrayidx12.i.i.i.194, align 2
  %shl13.i.i.i.195 = shl i16 %362, 8
  %arrayidx14.i.i.i.196 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %363 = load i16, i16* %arrayidx14.i.i.i.196, align 2
  %add15.i.i.i.197 = add i16 %shl13.i.i.i.195, %363
  store i16 %add15.i.i.i.197, i16* %m_dividend.i.i.i.46, align 2
  %364 = load i16, i16* %m_dividend.i.i.i.46, align 2
  %365 = load i16, i16* %n_n.i.i.i.43, align 2
  %div.i.i.i.198 = udiv i16 %364, %365
  store i16 %div.i.i.i.198, i16* %q.i.i.i.41, align 2
  %366 = load i16, i16* %m_dividend.i.i.i.46, align 2
  %367 = load i16, i16* %q.i.i.i.41, align 2
  %call16.i.i.i.199 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %366, i16 %367) #4
  br label %if.end.i.46.i.i.222

if.end.i.46.i.i.222:                              ; preds = %if.else.i.43.i.i.200, %if.then.i.42.i.i.193
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %368 = load i16, i16* %arrayidx17.i.i.i.201, align 2
  %conv.i.44.i.i.202 = zext i16 %368 to i32
  %shl18.i.i.i.203 = shl i32 %conv.i.44.i.i.202, 16
  %arrayidx19.i.i.i.204 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %369 = load i16, i16* %arrayidx19.i.i.i.204, align 2
  %shl20.i.i.i.205 = shl i16 %369, 8
  %conv21.i.i.i.206 = zext i16 %shl20.i.i.i.205 to i32
  %add22.i.i.i.207 = add i32 %shl18.i.i.i.203, %conv21.i.i.i.206
  %arrayidx23.i.i.i.208 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %370 = load i16, i16* %arrayidx23.i.i.i.208, align 2
  %conv24.i.i.i.209 = zext i16 %370 to i32
  %add25.i.i.i.210 = add i32 %add22.i.i.i.207, %conv24.i.i.i.209
  store i32 %add25.i.i.i.210, i32* %n_q.i.i.i.44, align 2
  %arrayidx26.i.i.i.211 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %371 = load i16, i16* %arrayidx26.i.i.i.211, align 2
  %arrayidx27.i.i.i.212 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %372 = load i16, i16* %arrayidx27.i.i.i.212, align 2
  %arrayidx28.i.i.i.213 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %373 = load i16, i16* %arrayidx28.i.i.i.213, align 2
  %374 = load i32, i32* %n_q.i.i.i.44, align 2
  %shr.i.i.i.214 = lshr i32 %374, 16
  %and.i.i.i.215 = and i32 %shr.i.i.i.214, 65535
  %conv29.i.i.i.216 = trunc i32 %and.i.i.i.215 to i16
  %375 = load i32, i32* %n_q.i.i.i.44, align 2
  %and30.i.i.i.217 = and i32 %375, 65535
  %conv31.i.i.i.218 = trunc i32 %and30.i.i.i.217 to i16
  %call32.i.i.i.219 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %371, i16 %372, i16 %373, i16 %conv29.i.i.i.216, i16 %conv31.i.i.i.218) #4
  %376 = load i16, i16* %q.i.i.i.41, align 2
  %call33.i.i.i.220 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %376) #4
  %377 = load i16, i16* %q.i.i.i.41, align 2
  %inc.i.45.i.i.221 = add i16 %377, 1
  store i16 %inc.i.45.i.i.221, i16* %q.i.i.i.41, align 2
  br label %do.body.i.i.i.232

do.body.i.i.i.232:                                ; preds = %do.body.i.i.i.232, %if.end.i.46.i.i.222
  store i16 19, i16* @curtask, align 2
  %378 = load i16, i16* %q.i.i.i.41, align 2
  %dec.i.47.i.i.223 = add i16 %378, -1
  store i16 %dec.i.47.i.i.223, i16* %q.i.i.i.41, align 2
  %379 = load i16, i16* %n_div.i.i.i.42, align 2
  %380 = load i16, i16* %q.i.i.i.41, align 2
  %call34.i.i.i.224 = call i32 @mult16(i16 zeroext %379, i16 zeroext %380) #4
  store i32 %call34.i.i.i.224, i32* %qn.i.i.i.45, align 2
  %381 = load i16, i16* %q.i.i.i.41, align 2
  %382 = load i16, i16* %n_div.i.i.i.42, align 2
  %383 = load i32, i32* %qn.i.i.i.45, align 2
  %shr35.i.i.i.225 = lshr i32 %383, 16
  %and36.i.i.i.226 = and i32 %shr35.i.i.i.225, 65535
  %conv37.i.i.i.227 = trunc i32 %and36.i.i.i.226 to i16
  %384 = load i32, i32* %qn.i.i.i.45, align 2
  %and38.i.i.i.228 = and i32 %384, 65535
  %conv39.i.i.i.229 = trunc i32 %and38.i.i.i.228 to i16
  %call40.i.i.i.230 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %381, i16 %382, i16 %conv37.i.i.i.227, i16 %conv39.i.i.i.229) #4
  %385 = load i32, i32* %qn.i.i.i.45, align 2
  %386 = load i32, i32* %n_q.i.i.i.44, align 2
  %cmp41.i.i.i.231 = icmp ugt i32 %385, %386
  br i1 %cmp41.i.i.i.231, label %do.body.i.i.i.232, label %reduce_quotient.exit.i.i.236

reduce_quotient.exit.i.i.236:                     ; preds = %do.body.i.i.i.232
  %387 = load i16, i16* %q.i.i.i.41, align 2
  %call43.i.i.i.233 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %387) #4
  %388 = load i16, i16* %q.i.i.i.41, align 2
  %389 = load i16*, i16** %quotient.addr.i.i.i.36, align 2
  store i16 %388, i16* %389, align 2
  store i16 32, i16* @curtask, align 2
  %390 = load i16, i16* %q.i.i.67, align 2
  %391 = load i16*, i16** %n.addr.i.i.66, align 2
  %392 = load i16, i16* %d.i.i.69, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i.27, align 2
  store i16 %390, i16* %q.addr.i.i.i.28, align 2
  store i16* %391, i16** %n.addr.i.48.i.i.29, align 2
  store i16 %392, i16* %d.addr.i.49.i.i.30, align 2
  store i16 9, i16* @curtask, align 2
  %393 = load i16, i16* %d.addr.i.49.i.i.30, align 2
  %sub.i.52.i.i.234 = sub i16 %393, 8
  store i16 %sub.i.52.i.i.234, i16* %offset.i.51.i.i.32, align 2
  %394 = load i16, i16* %offset.i.51.i.i.32, align 2
  %call.i.53.i.i.235 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %394) #4
  store i16 0, i16* %i.i.50.i.i.31, align 2
  br label %for.cond.i.55.i.i.238

for.cond.i.55.i.i.238:                            ; preds = %for.body.i.57.i.i.241, %reduce_quotient.exit.i.i.236
  %395 = load i16, i16* %i.i.50.i.i.31, align 2
  %396 = load i16, i16* %offset.i.51.i.i.32, align 2
  %cmp.i.54.i.i.237 = icmp ult i16 %395, %396
  br i1 %cmp.i.54.i.i.237, label %for.body.i.57.i.i.241, label %for.end.i.i.i.242

for.body.i.57.i.i.241:                            ; preds = %for.cond.i.55.i.i.238
  %397 = load i16, i16* %i.i.50.i.i.31, align 2
  %398 = load i16*, i16** %product.addr.i.i.i.27, align 2
  %arrayidx.i.56.i.i.239 = getelementptr inbounds i16, i16* %398, i16 %397
  store i16 0, i16* %arrayidx.i.56.i.i.239, align 2
  %399 = load i16, i16* %i.i.50.i.i.31, align 2
  %inc.i.58.i.i.240 = add nsw i16 %399, 1
  store i16 %inc.i.58.i.i.240, i16* %i.i.50.i.i.31, align 2
  br label %for.cond.i.55.i.i.238

for.end.i.i.i.242:                                ; preds = %for.cond.i.55.i.i.238
  store i16 0, i16* %c.i.i.i.33, align 2
  %400 = load i16, i16* %offset.i.51.i.i.32, align 2
  store i16 %400, i16* %i.i.50.i.i.31, align 2
  br label %for.cond.1.i.i.i.244

for.cond.1.i.i.i.244:                             ; preds = %if.end.i.68.i.i.258, %for.end.i.i.i.242
  %401 = load i16, i16* %i.i.50.i.i.31, align 2
  %cmp2.i.i.i.243 = icmp slt i16 %401, 16
  br i1 %cmp2.i.i.i.243, label %for.body.3.i.i.i.247, label %reduce_multiply.exit.i.i.259

for.body.3.i.i.i.247:                             ; preds = %for.cond.1.i.i.i.244
  store i16 24, i16* @curtask, align 2
  %402 = load i16, i16* %c.i.i.i.33, align 2
  store i16 %402, i16* %p.i.i.i.34, align 2
  %403 = load i16, i16* %i.i.50.i.i.31, align 2
  %404 = load i16, i16* %offset.i.51.i.i.32, align 2
  %add.i.59.i.i.245 = add i16 %404, 8
  %cmp4.i.60.i.i.246 = icmp ult i16 %403, %add.i.59.i.i.245
  br i1 %cmp4.i.60.i.i.246, label %if.then.i.63.i.i.252, label %if.else.i.64.i.i.253

if.then.i.63.i.i.252:                             ; preds = %for.body.3.i.i.i.247
  %405 = load i16, i16* %i.i.50.i.i.31, align 2
  %406 = load i16, i16* %offset.i.51.i.i.32, align 2
  %sub5.i.i.i.248 = sub i16 %405, %406
  %407 = load i16*, i16** %n.addr.i.48.i.i.29, align 2
  %arrayidx6.i.61.i.i.249 = getelementptr inbounds i16, i16* %407, i16 %sub5.i.i.i.248
  %408 = load i16, i16* %arrayidx6.i.61.i.i.249, align 2
  store i16 %408, i16* %nd.i.i.i.35, align 2
  %409 = load i16, i16* %q.addr.i.i.i.28, align 2
  %410 = load i16, i16* %nd.i.i.i.35, align 2
  %mul.i.i.i.250 = mul i16 %409, %410
  %411 = load i16, i16* %p.i.i.i.34, align 2
  %add7.i.62.i.i.251 = add i16 %411, %mul.i.i.i.250
  store i16 %add7.i.62.i.i.251, i16* %p.i.i.i.34, align 2
  br label %if.end.i.68.i.i.258

if.else.i.64.i.i.253:                             ; preds = %for.body.3.i.i.i.247
  store i16 0, i16* %nd.i.i.i.35, align 2
  br label %if.end.i.68.i.i.258

if.end.i.68.i.i.258:                              ; preds = %if.else.i.64.i.i.253, %if.then.i.63.i.i.252
  %412 = load i16, i16* %p.i.i.i.34, align 2
  %shr.i.65.i.i.254 = lshr i16 %412, 8
  store i16 %shr.i.65.i.i.254, i16* %c.i.i.i.33, align 2
  %413 = load i16, i16* %p.i.i.i.34, align 2
  %and.i.66.i.i.255 = and i16 %413, 255
  store i16 %and.i.66.i.i.255, i16* %p.i.i.i.34, align 2
  %414 = load i16, i16* %p.i.i.i.34, align 2
  %415 = load i16, i16* %i.i.50.i.i.31, align 2
  %416 = load i16*, i16** %product.addr.i.i.i.27, align 2
  %arrayidx8.i.67.i.i.256 = getelementptr inbounds i16, i16* %416, i16 %415
  store i16 %414, i16* %arrayidx8.i.67.i.i.256, align 2
  %417 = load i16, i16* %i.i.50.i.i.31, align 2
  %inc10.i.i.i.257 = add nsw i16 %417, 1
  store i16 %inc10.i.i.i.257, i16* %i.i.50.i.i.31, align 2
  br label %for.cond.1.i.i.i.244

reduce_multiply.exit.i.i.259:                     ; preds = %for.cond.1.i.i.i.244
  store i16 33, i16* @curtask, align 2
  %418 = load i16*, i16** %m.addr.i.i.65, align 2
  store i16* %418, i16** %a.addr.i.i.i.23, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i.24, align 2
  store i16 0, i16* %relation.i.i.i.26, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i.25, align 2
  br label %for.cond.i.71.i.i.261

for.cond.i.71.i.i.261:                            ; preds = %if.end.i.76.i.i.269, %reduce_multiply.exit.i.i.259
  %419 = load i16, i16* %i.i.69.i.i.25, align 2
  %cmp.i.70.i.i.260 = icmp sge i16 %419, 0
  br i1 %cmp.i.70.i.i.260, label %for.body.i.72.i.i.263, label %reduce_compare.exit.i.i.271

for.body.i.72.i.i.263:                            ; preds = %for.cond.i.71.i.i.261
  %420 = load i16*, i16** %a.addr.i.i.i.23, align 2
  %421 = load i16*, i16** %b.addr.i.i.i.24, align 2
  %cmp1.i.i.i.262 = icmp ugt i16* %420, %421
  br i1 %cmp1.i.i.i.262, label %if.then.i.73.i.i.264, label %if.else.i.75.i.i.266

if.then.i.73.i.i.264:                             ; preds = %for.body.i.72.i.i.263
  store i16 1, i16* %relation.i.i.i.26, align 2
  br label %reduce_compare.exit.i.i.271

if.else.i.75.i.i.266:                             ; preds = %for.body.i.72.i.i.263
  %422 = load i16*, i16** %a.addr.i.i.i.23, align 2
  %423 = load i16*, i16** %b.addr.i.i.i.24, align 2
  %cmp2.i.74.i.i.265 = icmp ult i16* %422, %423
  br i1 %cmp2.i.74.i.i.265, label %if.then.3.i.i.i.267, label %if.end.i.76.i.i.269

if.then.3.i.i.i.267:                              ; preds = %if.else.i.75.i.i.266
  store i16 -1, i16* %relation.i.i.i.26, align 2
  br label %reduce_compare.exit.i.i.271

if.end.i.76.i.i.269:                              ; preds = %if.else.i.75.i.i.266
  %424 = load i16, i16* %i.i.69.i.i.25, align 2
  %dec.i.77.i.i.268 = add nsw i16 %424, -1
  store i16 %dec.i.77.i.i.268, i16* %i.i.69.i.i.25, align 2
  br label %for.cond.i.71.i.i.261

reduce_compare.exit.i.i.271:                      ; preds = %if.then.3.i.i.i.267, %if.then.i.73.i.i.264, %for.cond.i.71.i.i.261
  store i16 31, i16* @curtask, align 2
  %425 = load i16, i16* %relation.i.i.i.26, align 2
  %cmp10.i.i.270 = icmp slt i16 %425, 0
  br i1 %cmp10.i.i.270, label %if.then.11.i.i.273, label %if.end.12.i.i.294

if.then.11.i.i.273:                               ; preds = %reduce_compare.exit.i.i.271
  %426 = load i16*, i16** %m.addr.i.i.65, align 2
  %427 = load i16*, i16** %n.addr.i.i.66, align 2
  %428 = load i16, i16* %d.i.i.69, align 2
  store i16* %426, i16** %a.addr.i.79.i.i.13, align 2
  store i16* %427, i16** %b.addr.i.80.i.i.14, align 2
  store i16 %428, i16* %d.addr.i.81.i.i.15, align 2
  store i16 10, i16* @curtask, align 2
  %429 = load i16, i16* %d.addr.i.81.i.i.15, align 2
  %sub.i.85.i.i.272 = sub i16 %429, 8
  store i16 %sub.i.85.i.i.272, i16* %offset.i.83.i.i.18, align 2
  store i16 0, i16* %c.i.84.i.i.19, align 2
  %430 = load i16, i16* %offset.i.83.i.i.18, align 2
  store i16 %430, i16* %i.i.82.i.i.16, align 2
  br label %for.cond.i.87.i.i.275

for.cond.i.87.i.i.275:                            ; preds = %if.end.i.100.i.i.290, %if.then.11.i.i.273
  %431 = load i16, i16* %i.i.82.i.i.16, align 2
  %cmp.i.86.i.i.274 = icmp slt i16 %431, 16
  br i1 %cmp.i.86.i.i.274, label %for.body.i.92.i.i.280, label %reduce_add.exit.i.i.291

for.body.i.92.i.i.280:                            ; preds = %for.cond.i.87.i.i.275
  store i16 22, i16* @curtask, align 2
  %432 = load i16, i16* %i.i.82.i.i.16, align 2
  %433 = load i16*, i16** %a.addr.i.79.i.i.13, align 2
  %arrayidx.i.88.i.i.276 = getelementptr inbounds i16, i16* %433, i16 %432
  %434 = load i16, i16* %arrayidx.i.88.i.i.276, align 2
  store i16 %434, i16* %m.i.i.i.21, align 2
  %435 = load i16, i16* %i.i.82.i.i.16, align 2
  %436 = load i16, i16* %offset.i.83.i.i.18, align 2
  %sub1.i.89.i.i.277 = sub i16 %435, %436
  store i16 %sub1.i.89.i.i.277, i16* %j.i.i.i.17, align 2
  %437 = load i16, i16* %i.i.82.i.i.16, align 2
  %438 = load i16, i16* %offset.i.83.i.i.18, align 2
  %add.i.90.i.i.278 = add i16 %438, 8
  %cmp2.i.91.i.i.279 = icmp ult i16 %437, %add.i.90.i.i.278
  br i1 %cmp2.i.91.i.i.279, label %if.then.i.94.i.i.282, label %if.else.i.95.i.i.283

if.then.i.94.i.i.282:                             ; preds = %for.body.i.92.i.i.280
  %439 = load i16, i16* %j.i.i.i.17, align 2
  %440 = load i16*, i16** %b.addr.i.80.i.i.14, align 2
  %arrayidx3.i.93.i.i.281 = getelementptr inbounds i16, i16* %440, i16 %439
  %441 = load i16, i16* %arrayidx3.i.93.i.i.281, align 2
  store i16 %441, i16* %n.i.i.i.22, align 2
  br label %if.end.i.100.i.i.290

if.else.i.95.i.i.283:                             ; preds = %for.body.i.92.i.i.280
  store i16 0, i16* %n.i.i.i.22, align 2
  store i16 0, i16* %j.i.i.i.17, align 2
  br label %if.end.i.100.i.i.290

if.end.i.100.i.i.290:                             ; preds = %if.else.i.95.i.i.283, %if.then.i.94.i.i.282
  %442 = load i16, i16* %c.i.84.i.i.19, align 2
  %443 = load i16, i16* %m.i.i.i.21, align 2
  %add4.i.i.i.284 = add i16 %442, %443
  %444 = load i16, i16* %n.i.i.i.22, align 2
  %add5.i.96.i.i.285 = add i16 %add4.i.i.i.284, %444
  store i16 %add5.i.96.i.i.285, i16* %r.i.i.i.20, align 2
  %445 = load i16, i16* %r.i.i.i.20, align 2
  %shr.i.97.i.i.286 = lshr i16 %445, 8
  store i16 %shr.i.97.i.i.286, i16* %c.i.84.i.i.19, align 2
  %446 = load i16, i16* %r.i.i.i.20, align 2
  %and.i.98.i.i.287 = and i16 %446, 255
  store i16 %and.i.98.i.i.287, i16* %r.i.i.i.20, align 2
  %447 = load i16, i16* %r.i.i.i.20, align 2
  %448 = load i16, i16* %i.i.82.i.i.16, align 2
  %449 = load i16*, i16** %a.addr.i.79.i.i.13, align 2
  %arrayidx6.i.99.i.i.288 = getelementptr inbounds i16, i16* %449, i16 %448
  store i16 %447, i16* %arrayidx6.i.99.i.i.288, align 2
  %450 = load i16, i16* %i.i.82.i.i.16, align 2
  %inc.i.101.i.i.289 = add nsw i16 %450, 1
  store i16 %inc.i.101.i.i.289, i16* %i.i.82.i.i.16, align 2
  br label %for.cond.i.87.i.i.275

reduce_add.exit.i.i.291:                          ; preds = %for.cond.i.87.i.i.275
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294

if.end.12.i.i.294:                                ; preds = %reduce_add.exit.i.i.291, %reduce_compare.exit.i.i.271
  %451 = load i16*, i16** %m.addr.i.i.65, align 2
  %452 = load i16, i16* %d.i.i.69, align 2
  store i16* %451, i16** %a.addr.i.103.i.i.3, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i.4, align 2
  store i16 %452, i16* %d.addr.i.105.i.i.5, align 2
  store i16 11, i16* @curtask, align 2
  %453 = load i16, i16* %d.addr.i.105.i.i.5, align 2
  %sub.i.113.i.i.292 = sub i16 %453, 8
  store i16 %sub.i.113.i.i.292, i16* %offset.i.112.i.i.12, align 2
  %454 = load i16, i16* %d.addr.i.105.i.i.5, align 2
  %455 = load i16, i16* %offset.i.112.i.i.12, align 2
  %call.i.114.i.i.293 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %454, i16 %455) #4
  store i16 0, i16* %borrow.i.111.i.i.11, align 2
  %456 = load i16, i16* %offset.i.112.i.i.12, align 2
  store i16 %456, i16* %i.i.106.i.i.6, align 2
  br label %for.cond.i.116.i.i.296

for.cond.i.116.i.i.296:                           ; preds = %if.end.i.126.i.i.308, %if.end.12.i.i.294
  %457 = load i16, i16* %i.i.106.i.i.6, align 2
  %cmp.i.115.i.i.295 = icmp slt i16 %457, 16
  br i1 %cmp.i.115.i.i.295, label %for.body.i.121.i.i.301, label %reduce_subtract.exit.i.i.310

for.body.i.121.i.i.301:                           ; preds = %for.cond.i.116.i.i.296
  store i16 23, i16* @curtask, align 2
  %458 = load i16, i16* %i.i.106.i.i.6, align 2
  %459 = load i16*, i16** %a.addr.i.103.i.i.3, align 2
  %arrayidx.i.117.i.i.297 = getelementptr inbounds i16, i16* %459, i16 %458
  %460 = load i16, i16* %arrayidx.i.117.i.i.297, align 2
  store i16 %460, i16* %m.i.107.i.i.7, align 2
  %461 = load i16, i16* %i.i.106.i.i.6, align 2
  %462 = load i16*, i16** %b.addr.i.104.i.i.4, align 2
  %arrayidx1.i.118.i.i.298 = getelementptr inbounds i16, i16* %462, i16 %461
  %463 = load i16, i16* %arrayidx1.i.118.i.i.298, align 2
  store i16 %463, i16* %qn.i.110.i.i.10, align 2
  %464 = load i16, i16* %qn.i.110.i.i.10, align 2
  %465 = load i16, i16* %borrow.i.111.i.i.11, align 2
  %add.i.119.i.i.299 = add i16 %464, %465
  store i16 %add.i.119.i.i.299, i16* %s.i.108.i.i.8, align 2
  %466 = load i16, i16* %m.i.107.i.i.7, align 2
  %467 = load i16, i16* %s.i.108.i.i.8, align 2
  %cmp2.i.120.i.i.300 = icmp ult i16 %466, %467
  br i1 %cmp2.i.120.i.i.300, label %if.then.i.123.i.i.303, label %if.else.i.124.i.i.304

if.then.i.123.i.i.303:                            ; preds = %for.body.i.121.i.i.301
  %468 = load i16, i16* %m.i.107.i.i.7, align 2
  %add3.i.122.i.i.302 = add i16 %468, 256
  store i16 %add3.i.122.i.i.302, i16* %m.i.107.i.i.7, align 2
  store i16 1, i16* %borrow.i.111.i.i.11, align 2
  br label %if.end.i.126.i.i.308

if.else.i.124.i.i.304:                            ; preds = %for.body.i.121.i.i.301
  store i16 0, i16* %borrow.i.111.i.i.11, align 2
  br label %if.end.i.126.i.i.308

if.end.i.126.i.i.308:                             ; preds = %if.else.i.124.i.i.304, %if.then.i.123.i.i.303
  %469 = load i16, i16* %m.i.107.i.i.7, align 2
  %470 = load i16, i16* %s.i.108.i.i.8, align 2
  %sub4.i.i.i.305 = sub i16 %469, %470
  store i16 %sub4.i.i.i.305, i16* %r.i.109.i.i.9, align 2
  %471 = load i16, i16* %r.i.109.i.i.9, align 2
  %472 = load i16, i16* %i.i.106.i.i.6, align 2
  %473 = load i16*, i16** %a.addr.i.103.i.i.3, align 2
  %arrayidx5.i.125.i.i.306 = getelementptr inbounds i16, i16* %473, i16 %472
  store i16 %471, i16* %arrayidx5.i.125.i.i.306, align 2
  %474 = load i16, i16* %i.i.106.i.i.6, align 2
  %inc.i.127.i.i.307 = add nsw i16 %474, 1
  store i16 %inc.i.127.i.i.307, i16* %i.i.106.i.i.6, align 2
  br label %for.cond.i.116.i.i.296

reduce_subtract.exit.i.i.310:                     ; preds = %for.cond.i.116.i.i.296
  store i16 35, i16* @curtask, align 2
  %475 = load i16, i16* %d.i.i.69, align 2
  %dec13.i.i.309 = add i16 %475, -1
  store i16 %dec13.i.i.309, i16* %d.i.i.69, align 2
  br label %while.cond.i.i.174

while.end.i.i.311:                                ; preds = %while.cond.i.i.174
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312

mod_mult.exit312:                                 ; preds = %if.then.5.i.i.170, %while.end.i.i.311
  %476 = load i16, i16* %e.addr, align 2
  %shr = lshr i16 %476, 1
  store i16 %shr, i16* %e.addr, align 2
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i16 26, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @encrypt(i8* %cyphertext, i16* %cyphertext_len, i8* %message, i16 %message_length, %struct.pubkey_t* %k) #1 {
entry:
  %a.addr.i.103.i.i.3.i = alloca i16*, align 2
  %b.addr.i.104.i.i.4.i = alloca i16*, align 2
  %d.addr.i.105.i.i.5.i = alloca i16, align 2
  %i.i.106.i.i.6.i = alloca i16, align 2
  %m.i.107.i.i.7.i = alloca i16, align 2
  %s.i.108.i.i.8.i = alloca i16, align 2
  %r.i.109.i.i.9.i = alloca i16, align 2
  %qn.i.110.i.i.10.i = alloca i16, align 2
  %borrow.i.111.i.i.11.i = alloca i16, align 2
  %offset.i.112.i.i.12.i = alloca i16, align 2
  %a.addr.i.79.i.i.13.i = alloca i16*, align 2
  %b.addr.i.80.i.i.14.i = alloca i16*, align 2
  %d.addr.i.81.i.i.15.i = alloca i16, align 2
  %i.i.82.i.i.16.i = alloca i16, align 2
  %j.i.i.i.17.i = alloca i16, align 2
  %offset.i.83.i.i.18.i = alloca i16, align 2
  %c.i.84.i.i.19.i = alloca i16, align 2
  %r.i.i.i.20.i = alloca i16, align 2
  %m.i.i.i.21.i = alloca i16, align 2
  %n.i.i.i.22.i = alloca i16, align 2
  %a.addr.i.i.i.23.i = alloca i16*, align 2
  %b.addr.i.i.i.24.i = alloca i16*, align 2
  %i.i.69.i.i.25.i = alloca i16, align 2
  %relation.i.i.i.26.i = alloca i16, align 2
  %product.addr.i.i.i.27.i = alloca i16*, align 2
  %q.addr.i.i.i.28.i = alloca i16, align 2
  %n.addr.i.48.i.i.29.i = alloca i16*, align 2
  %d.addr.i.49.i.i.30.i = alloca i16, align 2
  %i.i.50.i.i.31.i = alloca i16, align 2
  %offset.i.51.i.i.32.i = alloca i16, align 2
  %c.i.i.i.33.i = alloca i16, align 2
  %p.i.i.i.34.i = alloca i16, align 2
  %nd.i.i.i.35.i = alloca i16, align 2
  %quotient.addr.i.i.i.36.i = alloca i16*, align 2
  %m.addr.i.31.i.i.37.i = alloca i16*, align 2
  %n.addr.i.32.i.i.38.i = alloca i16*, align 2
  %d.addr.i.33.i.i.39.i = alloca i16, align 2
  %q.i.i.i.41.i = alloca i16, align 2
  %n_div.i.i.i.42.i = alloca i16, align 2
  %n_n.i.i.i.43.i = alloca i16, align 2
  %n_q.i.i.i.44.i = alloca i32, align 2
  %qn.i.i.i.45.i = alloca i32, align 2
  %m_dividend.i.i.i.46.i = alloca i16, align 2
  %m.addr.i.14.i.i.47.i = alloca i16*, align 2
  %n.addr.i.15.i.i.48.i = alloca i16*, align 2
  %digit.addr.i.i.i.49.i = alloca i16, align 2
  %i.i.16.i.i.50.i = alloca i16, align 2
  %d.i.i.i.51.i = alloca i16, align 2
  %s.i.i.i.52.i = alloca i16, align 2
  %m_d.i.17.i.i.53.i = alloca i16, align 2
  %n_d.i.18.i.i.54.i = alloca i16, align 2
  %borrow.i.i.i.55.i = alloca i16, align 2
  %offset.i.19.i.i.56.i = alloca i16, align 2
  %m.addr.i.i.i.57.i = alloca i16*, align 2
  %n.addr.i.i.i.58.i = alloca i16*, align 2
  %d.addr.i.i.i.59.i = alloca i16, align 2
  %i.i.i.i.60.i = alloca i16, align 2
  %offset.i.i.i.61.i = alloca i16, align 2
  %n_d.i.i.i.62.i = alloca i16, align 2
  %m_d.i.i.i.63.i = alloca i16, align 2
  %normalizable.i.i.i.64.i = alloca i8, align 1
  %m.addr.i.i.65.i = alloca i16*, align 2
  %n.addr.i.i.66.i = alloca i16*, align 2
  %q.i.i.67.i = alloca i16, align 2
  %m_d.i.i.68.i = alloca i16, align 2
  %d.i.i.69.i = alloca i16, align 2
  %a.addr.i.i.70.i = alloca i16*, align 2
  %b.addr.i.i.71.i = alloca i16*, align 2
  %i.i.i.72.i = alloca i16, align 2
  %digit.i.i.73.i = alloca i16, align 2
  %p.i.i.74.i = alloca i16, align 2
  %c.i.i.75.i = alloca i16, align 2
  %dp.i.i.76.i = alloca i16, align 2
  %carry.i.i.77.i = alloca i16, align 2
  %a.addr.i.78.i = alloca i16*, align 2
  %b.addr.i.79.i = alloca i16*, align 2
  %n.addr.i.80.i = alloca i16*, align 2
  %a.addr.i.103.i.i.i = alloca i16*, align 2
  %b.addr.i.104.i.i.i = alloca i16*, align 2
  %d.addr.i.105.i.i.i = alloca i16, align 2
  %i.i.106.i.i.i = alloca i16, align 2
  %m.i.107.i.i.i = alloca i16, align 2
  %s.i.108.i.i.i = alloca i16, align 2
  %r.i.109.i.i.i = alloca i16, align 2
  %qn.i.110.i.i.i = alloca i16, align 2
  %borrow.i.111.i.i.i = alloca i16, align 2
  %offset.i.112.i.i.i = alloca i16, align 2
  %a.addr.i.79.i.i.i = alloca i16*, align 2
  %b.addr.i.80.i.i.i = alloca i16*, align 2
  %d.addr.i.81.i.i.i = alloca i16, align 2
  %i.i.82.i.i.i = alloca i16, align 2
  %j.i.i.i.i = alloca i16, align 2
  %offset.i.83.i.i.i = alloca i16, align 2
  %c.i.84.i.i.i = alloca i16, align 2
  %r.i.i.i.i = alloca i16, align 2
  %m.i.i.i.i = alloca i16, align 2
  %n.i.i.i.i = alloca i16, align 2
  %a.addr.i.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i.i = alloca i16*, align 2
  %i.i.69.i.i.i = alloca i16, align 2
  %relation.i.i.i.i = alloca i16, align 2
  %product.addr.i.i.i.i = alloca i16*, align 2
  %q.addr.i.i.i.i = alloca i16, align 2
  %n.addr.i.48.i.i.i = alloca i16*, align 2
  %d.addr.i.49.i.i.i = alloca i16, align 2
  %i.i.50.i.i.i = alloca i16, align 2
  %offset.i.51.i.i.i = alloca i16, align 2
  %c.i.i.i.i = alloca i16, align 2
  %p.i.i.i.i = alloca i16, align 2
  %nd.i.i.i.i = alloca i16, align 2
  %quotient.addr.i.i.i.i = alloca i16*, align 2
  %m.addr.i.31.i.i.i = alloca i16*, align 2
  %n.addr.i.32.i.i.i = alloca i16*, align 2
  %d.addr.i.33.i.i.i = alloca i16, align 2
  %m_d.i.34.i.i.i = alloca [3 x i16], align 2
  %q.i.i.i.i = alloca i16, align 2
  %n_div.i.i.i.i = alloca i16, align 2
  %n_n.i.i.i.i = alloca i16, align 2
  %n_q.i.i.i.i = alloca i32, align 2
  %qn.i.i.i.i = alloca i32, align 2
  %m_dividend.i.i.i.i = alloca i16, align 2
  %m.addr.i.14.i.i.i = alloca i16*, align 2
  %n.addr.i.15.i.i.i = alloca i16*, align 2
  %digit.addr.i.i.i.i = alloca i16, align 2
  %i.i.16.i.i.i = alloca i16, align 2
  %d.i.i.i.i = alloca i16, align 2
  %s.i.i.i.i = alloca i16, align 2
  %m_d.i.17.i.i.i = alloca i16, align 2
  %n_d.i.18.i.i.i = alloca i16, align 2
  %borrow.i.i.i.i = alloca i16, align 2
  %offset.i.19.i.i.i = alloca i16, align 2
  %m.addr.i.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i.i = alloca i16*, align 2
  %d.addr.i.i.i.i = alloca i16, align 2
  %i.i.i.i.i = alloca i16, align 2
  %offset.i.i.i.i = alloca i16, align 2
  %n_d.i.i.i.i = alloca i16, align 2
  %m_d.i.i.i.i = alloca i16, align 2
  %normalizable.i.i.i.i = alloca i8, align 1
  %m.addr.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i = alloca i16*, align 2
  %q.i.i.i = alloca i16, align 2
  %m_d.i.i.i = alloca i16, align 2
  %d.i.i.i = alloca i16, align 2
  %a.addr.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i = alloca i16*, align 2
  %i.i.i.i = alloca i16, align 2
  %digit.i.i.i = alloca i16, align 2
  %p.i.i.i = alloca i16, align 2
  %c.i.i.i = alloca i16, align 2
  %dp.i.i.i = alloca i16, align 2
  %carry.i.i.i = alloca i16, align 2
  %a.addr.i.i = alloca i16*, align 2
  %b.addr.i.i = alloca i16*, align 2
  %n.addr.i.i = alloca i16*, align 2
  %out_block.addr.i = alloca i16*, align 2
  %base.addr.i = alloca i16*, align 2
  %e.addr.i = alloca i16, align 2
  %n.addr.i = alloca i16*, align 2
  %i.i = alloca i16, align 2
  %cyphertext.addr = alloca i8*, align 2
  %cyphertext_len.addr = alloca i16*, align 2
  %message.addr = alloca i8*, align 2
  %message_length.addr = alloca i16, align 2
  %k.addr = alloca %struct.pubkey_t*, align 2
  %i = alloca i16, align 2
  %in_block_offset = alloca i16, align 2
  %out_block_offset = alloca i16, align 2
  store i8* %cyphertext, i8** %cyphertext.addr, align 2
  store i16* %cyphertext_len, i16** %cyphertext_len.addr, align 2
  store i8* %message, i8** %message.addr, align 2
  store i16 %message_length, i16* %message_length.addr, align 2
  store %struct.pubkey_t* %k, %struct.pubkey_t** %k.addr, align 2
  store i16 0, i16* %in_block_offset, align 2
  store i16 0, i16* %out_block_offset, align 2
  br label %while.cond

while.cond:                                       ; preds = %for.end.26, %entry
  %0 = load i16, i16* %in_block_offset, align 2
  %1 = load i16, i16* %message_length.addr, align 2
  %cmp = icmp ult i16 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i16 1, i16* @curtask, align 2
  %2 = load i16, i16* %in_block_offset, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.19, i32 0, i32 0), i16 %2)
  store i16 0, i16* %i, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %while.body
  %3 = load i16, i16* %i, align 2
  %cmp1 = icmp ult i16 %3, 7
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i16, i16* %in_block_offset, align 2
  %5 = load i16, i16* %i, align 2
  %add = add i16 %4, %5
  %6 = load i16, i16* %message_length.addr, align 2
  %cmp2 = icmp ult i16 %add, %6
  br i1 %cmp2, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.body
  %7 = load i16, i16* %in_block_offset, align 2
  %8 = load i16, i16* %i, align 2
  %add3 = add i16 %7, %8
  %9 = load i8*, i8** %message.addr, align 2
  %arrayidx = getelementptr inbounds i8, i8* %9, i16 %add3
  %10 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %10 to i16
  br label %cond.end

cond.false:                                       ; preds = %for.body
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i16 [ %conv, %cond.true ], [ 255, %cond.false ]
  %11 = load i16, i16* %i, align 2
  %arrayidx4 = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %11
  store i16 %cond, i16* %arrayidx4, align 2
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %12 = load i16, i16* %i, align 2
  %inc = add nsw i16 %12, 1
  store i16 %inc, i16* %i, align 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 0, i16* %i, align 2
  br label %for.cond.5

for.cond.5:                                       ; preds = %for.inc.13, %for.end
  %13 = load i16, i16* %i, align 2
  %cmp6 = icmp ult i16 %13, 1
  br i1 %cmp6, label %for.body.8, label %for.end.15

for.body.8:                                       ; preds = %for.cond.5
  %14 = load i16, i16* %i, align 2
  %arrayidx9 = getelementptr inbounds [1 x i8], [1 x i8]* @PAD_DIGITS, i16 0, i16 %14
  %15 = load i8, i8* %arrayidx9, align 1
  %conv10 = zext i8 %15 to i16
  %16 = load i16, i16* %i, align 2
  %add11 = add i16 7, %16
  %arrayidx12 = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %add11
  store i16 %conv10, i16* %arrayidx12, align 2
  br label %for.inc.13

for.inc.13:                                       ; preds = %for.body.8
  %17 = load i16, i16* %i, align 2
  %inc14 = add nsw i16 %17, 1
  store i16 %inc14, i16* %i, align 2
  br label %for.cond.5

for.end.15:                                       ; preds = %for.cond.5
  %18 = load %struct.pubkey_t*, %struct.pubkey_t** %k.addr, align 2
  %e = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %18, i32 0, i32 1
  %19 = load i16, i16* %e, align 2
  %20 = load %struct.pubkey_t*, %struct.pubkey_t** %k.addr, align 2
  %n = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %20, i32 0, i32 0
  %arraydecay = getelementptr inbounds [16 x i16], [16 x i16]* %n, i32 0, i32 0
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16** %out_block.addr.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16** %base.addr.i, align 2
  store i16 %19, i16* %e.addr.i, align 2
  store i16* %arraydecay, i16** %n.addr.i, align 2
  store i16 2, i16* @curtask, align 2
  %21 = load i16*, i16** %out_block.addr.i, align 2
  store i16 1, i16* %21, align 2
  store i16 1, i16* %i.i, align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.body.i, %for.end.15
  %22 = load i16, i16* %i.i, align 2
  %cmp.i = icmp slt i16 %22, 8
  br i1 %cmp.i, label %for.body.i, label %for.end.i

for.body.i:                                       ; preds = %for.cond.i
  %23 = load i16, i16* %i.i, align 2
  %24 = load i16*, i16** %out_block.addr.i, align 2
  %arrayidx1.i = getelementptr inbounds i16, i16* %24, i16 %23
  store i16 0, i16* %arrayidx1.i, align 2
  %25 = load i16, i16* %i.i, align 2
  %inc.i = add nsw i16 %25, 1
  store i16 %inc.i, i16* %i.i, align 2
  br label %for.cond.i

for.end.i:                                        ; preds = %for.cond.i
  br label %while.cond.i

while.cond.i:                                     ; preds = %mod_mult.exit312.i, %for.end.i
  %26 = load i16, i16* %e.addr.i, align 2
  %cmp2.i = icmp ugt i16 %26, 0
  br i1 %cmp2.i, label %while.body.i, label %mod_exp.exit

while.body.i:                                     ; preds = %while.cond.i
  store i16 13, i16* @curtask, align 2
  %27 = load i16, i16* %e.addr.i, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %27) #4
  %28 = load i16, i16* %e.addr.i, align 2
  %and.i = and i16 %28, 1
  %tobool.i = icmp ne i16 %and.i, 0
  br i1 %tobool.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %while.body.i
  %29 = load i16*, i16** %out_block.addr.i, align 2
  %30 = load i16*, i16** %base.addr.i, align 2
  %31 = load i16*, i16** %n.addr.i, align 2
  store i16* %29, i16** %a.addr.i.i, align 2
  store i16* %30, i16** %b.addr.i.i, align 2
  store i16* %31, i16** %n.addr.i.i, align 2
  %32 = load i16*, i16** %a.addr.i.i, align 2
  %33 = load i16*, i16** %b.addr.i.i, align 2
  store i16* %32, i16** %a.addr.i.i.i, align 2
  store i16* %33, i16** %b.addr.i.i.i, align 2
  store i16 0, i16* %carry.i.i.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i.i, align 2
  br label %for.cond.i.i.i

for.cond.i.i.i:                                   ; preds = %for.end.i.i.i, %if.then.i
  %34 = load i16, i16* %digit.i.i.i, align 2
  %cmp.i.i.i = icmp ult i16 %34, 16
  br i1 %cmp.i.i.i, label %for.body.i.i.i, label %for.end.15.i.i.i

for.body.i.i.i:                                   ; preds = %for.cond.i.i.i
  store i16 14, i16* @curtask, align 2
  %35 = load i16, i16* %carry.i.i.i, align 2
  store i16 %35, i16* %p.i.i.i, align 2
  store i16 0, i16* %c.i.i.i, align 2
  store i16 0, i16* %i.i.i.i, align 2
  br label %for.cond.1.i.i.i

for.cond.1.i.i.i:                                 ; preds = %if.end.i.i.i, %for.body.i.i.i
  %36 = load i16, i16* %i.i.i.i, align 2
  %cmp2.i.i.i = icmp slt i16 %36, 8
  br i1 %cmp2.i.i.i, label %for.body.3.i.i.i, label %for.end.i.i.i

for.body.3.i.i.i:                                 ; preds = %for.cond.1.i.i.i
  %37 = load i16, i16* %i.i.i.i, align 2
  %38 = load i16, i16* %digit.i.i.i, align 2
  %cmp4.i.i.i = icmp ule i16 %37, %38
  br i1 %cmp4.i.i.i, label %land.lhs.true.i.i.i, label %if.end.i.i.i

land.lhs.true.i.i.i:                              ; preds = %for.body.3.i.i.i
  %39 = load i16, i16* %digit.i.i.i, align 2
  %40 = load i16, i16* %i.i.i.i, align 2
  %sub.i.i.i = sub i16 %39, %40
  %cmp5.i.i.i = icmp ult i16 %sub.i.i.i, 8
  br i1 %cmp5.i.i.i, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %land.lhs.true.i.i.i
  %41 = load i16, i16* %digit.i.i.i, align 2
  %42 = load i16, i16* %i.i.i.i, align 2
  %sub6.i.i.i = sub i16 %41, %42
  %43 = load i16*, i16** %a.addr.i.i.i, align 2
  %arrayidx.i.i.i = getelementptr inbounds i16, i16* %43, i16 %sub6.i.i.i
  %44 = load i16, i16* %arrayidx.i.i.i, align 2
  %45 = load i16, i16* %i.i.i.i, align 2
  %46 = load i16*, i16** %b.addr.i.i.i, align 2
  %arrayidx7.i.i.i = getelementptr inbounds i16, i16* %46, i16 %45
  %47 = load i16, i16* %arrayidx7.i.i.i, align 2
  %mul.i.i.i = mul i16 %44, %47
  store i16 %mul.i.i.i, i16* %dp.i.i.i, align 2
  %48 = load i16, i16* %dp.i.i.i, align 2
  %shr.i.i.i = lshr i16 %48, 8
  %49 = load i16, i16* %c.i.i.i, align 2
  %add.i.i.i = add i16 %49, %shr.i.i.i
  store i16 %add.i.i.i, i16* %c.i.i.i, align 2
  %50 = load i16, i16* %dp.i.i.i, align 2
  %and.i.i.i = and i16 %50, 255
  %51 = load i16, i16* %p.i.i.i, align 2
  %add8.i.i.i = add i16 %51, %and.i.i.i
  store i16 %add8.i.i.i, i16* %p.i.i.i, align 2
  br label %if.end.i.i.i

if.end.i.i.i:                                     ; preds = %if.then.i.i.i, %land.lhs.true.i.i.i, %for.body.3.i.i.i
  %52 = load i16, i16* %i.i.i.i, align 2
  %inc.i.i.i = add nsw i16 %52, 1
  store i16 %inc.i.i.i, i16* %i.i.i.i, align 2
  br label %for.cond.1.i.i.i

for.end.i.i.i:                                    ; preds = %for.cond.1.i.i.i
  %53 = load i16, i16* %p.i.i.i, align 2
  %shr9.i.i.i = lshr i16 %53, 8
  %54 = load i16, i16* %c.i.i.i, align 2
  %add10.i.i.i = add i16 %54, %shr9.i.i.i
  store i16 %add10.i.i.i, i16* %c.i.i.i, align 2
  %55 = load i16, i16* %p.i.i.i, align 2
  %and11.i.i.i = and i16 %55, 255
  store i16 %and11.i.i.i, i16* %p.i.i.i, align 2
  %56 = load i16, i16* %p.i.i.i, align 2
  %57 = load i16, i16* %digit.i.i.i, align 2
  %arrayidx12.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %57
  store i16 %56, i16* %arrayidx12.i.i.i, align 2
  %58 = load i16, i16* %c.i.i.i, align 2
  store i16 %58, i16* %carry.i.i.i, align 2
  %59 = load i16, i16* %digit.i.i.i, align 2
  %inc14.i.i.i = add i16 %59, 1
  store i16 %inc14.i.i.i, i16* %digit.i.i.i, align 2
  br label %for.cond.i.i.i

for.end.15.i.i.i:                                 ; preds = %for.cond.i.i.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i.i, align 2
  br label %for.cond.16.i.i.i

for.cond.16.i.i.i:                                ; preds = %for.body.18.i.i.i, %for.end.15.i.i.i
  %60 = load i16, i16* %i.i.i.i, align 2
  %cmp17.i.i.i = icmp slt i16 %60, 16
  br i1 %cmp17.i.i.i, label %for.body.18.i.i.i, label %mult.exit.i.i

for.body.18.i.i.i:                                ; preds = %for.cond.16.i.i.i
  %61 = load i16, i16* %i.i.i.i, align 2
  %arrayidx19.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %61
  %62 = load i16, i16* %arrayidx19.i.i.i, align 2
  %63 = load i16, i16* %i.i.i.i, align 2
  %64 = load i16*, i16** %a.addr.i.i.i, align 2
  %arrayidx20.i.i.i = getelementptr inbounds i16, i16* %64, i16 %63
  store i16 %62, i16* %arrayidx20.i.i.i, align 2
  %65 = load i16, i16* %i.i.i.i, align 2
  %inc22.i.i.i = add nsw i16 %65, 1
  store i16 %inc22.i.i.i, i16* %i.i.i.i, align 2
  br label %for.cond.16.i.i.i

mult.exit.i.i:                                    ; preds = %for.cond.16.i.i.i
  store i16 27, i16* @curtask, align 2
  %66 = load i16*, i16** %a.addr.i.i, align 2
  %67 = load i16*, i16** %n.addr.i.i, align 2
  store i16* %66, i16** %m.addr.i.i.i, align 2
  store i16* %67, i16** %n.addr.i.i.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i.i, align 2
  br label %do.body.i.i.i

do.body.i.i.i:                                    ; preds = %land.end.i.i.i, %mult.exit.i.i
  %68 = load i16, i16* %d.i.i.i, align 2
  %dec.i.i.i = add i16 %68, -1
  store i16 %dec.i.i.i, i16* %d.i.i.i, align 2
  %69 = load i16, i16* %d.i.i.i, align 2
  %70 = load i16*, i16** %m.addr.i.i.i, align 2
  %arrayidx.i.1.i.i = getelementptr inbounds i16, i16* %70, i16 %69
  %71 = load i16, i16* %arrayidx.i.1.i.i, align 2
  store i16 %71, i16* %m_d.i.i.i, align 2
  %72 = load i16, i16* %d.i.i.i, align 2
  %73 = load i16, i16* %m_d.i.i.i, align 2
  %call.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %72, i16 %73) #4
  %74 = load i16, i16* %m_d.i.i.i, align 2
  %cmp.i.2.i.i = icmp eq i16 %74, 0
  br i1 %cmp.i.2.i.i, label %land.rhs.i.i.i, label %land.end.i.i.i

land.rhs.i.i.i:                                   ; preds = %do.body.i.i.i
  %75 = load i16, i16* %d.i.i.i, align 2
  %cmp1.i.i.i = icmp ugt i16 %75, 0
  br label %land.end.i.i.i

land.end.i.i.i:                                   ; preds = %land.rhs.i.i.i, %do.body.i.i.i
  %76 = phi i1 [ false, %do.body.i.i.i ], [ %cmp1.i.i.i, %land.rhs.i.i.i ]
  br i1 %76, label %do.body.i.i.i, label %do.end.i.i.i

do.end.i.i.i:                                     ; preds = %land.end.i.i.i
  %77 = load i16, i16* %d.i.i.i, align 2
  %call2.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %77) #4
  %78 = load i16*, i16** %m.addr.i.i.i, align 2
  %79 = load i16*, i16** %n.addr.i.i.i, align 2
  %80 = load i16, i16* %d.i.i.i, align 2
  store i16* %78, i16** %m.addr.i.i.i.i, align 2
  store i16* %79, i16** %n.addr.i.i.i.i, align 2
  store i16 %80, i16* %d.addr.i.i.i.i, align 2
  store i8 1, i8* %normalizable.i.i.i.i, align 1
  store i16 6, i16* @curtask, align 2
  %81 = load i16, i16* %d.addr.i.i.i.i, align 2
  %add.i.i.i.i = add i16 %81, 1
  %sub.i.i.i.i = sub i16 %add.i.i.i.i, 8
  store i16 %sub.i.i.i.i, i16* %offset.i.i.i.i, align 2
  %82 = load i16, i16* %d.addr.i.i.i.i, align 2
  %83 = load i16, i16* %offset.i.i.i.i, align 2
  %call.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %82, i16 %83) #4
  %84 = load i16, i16* %d.addr.i.i.i.i, align 2
  store i16 %84, i16* %i.i.i.i.i, align 2
  br label %for.cond.i.i.i.i

for.cond.i.i.i.i:                                 ; preds = %if.end.i.i.i.i, %do.end.i.i.i
  %85 = load i16, i16* %i.i.i.i.i, align 2
  %cmp.i.i.i.i = icmp sge i16 %85, 0
  br i1 %cmp.i.i.i.i, label %for.body.i.i.i.i, label %reduce_normalizable.exit.i.i.i

for.body.i.i.i.i:                                 ; preds = %for.cond.i.i.i.i
  %86 = load i16, i16* %i.i.i.i.i, align 2
  %87 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %arrayidx.i.i.i.i = getelementptr inbounds i16, i16* %87, i16 %86
  %88 = load i16, i16* %arrayidx.i.i.i.i, align 2
  store i16 %88, i16* %m_d.i.i.i.i, align 2
  %89 = load i16, i16* %i.i.i.i.i, align 2
  %90 = load i16, i16* %offset.i.i.i.i, align 2
  %sub1.i.i.i.i = sub i16 %89, %90
  %91 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %arrayidx2.i.i.i.i = getelementptr inbounds i16, i16* %91, i16 %sub1.i.i.i.i
  %92 = load i16, i16* %arrayidx2.i.i.i.i, align 2
  store i16 %92, i16* %n_d.i.i.i.i, align 2
  %93 = load i16, i16* %m_d.i.i.i.i, align 2
  %94 = load i16, i16* %n_d.i.i.i.i, align 2
  %cmp3.i.i.i.i = icmp ugt i16 %93, %94
  br i1 %cmp3.i.i.i.i, label %if.then.i.i.i.i, label %if.else.i.i.i.i

if.then.i.i.i.i:                                  ; preds = %for.body.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i

if.else.i.i.i.i:                                  ; preds = %for.body.i.i.i.i
  %95 = load i16, i16* %m_d.i.i.i.i, align 2
  %96 = load i16, i16* %n_d.i.i.i.i, align 2
  %cmp4.i.i.i.i = icmp ult i16 %95, %96
  br i1 %cmp4.i.i.i.i, label %if.then.5.i.i.i.i, label %if.end.i.i.i.i

if.then.5.i.i.i.i:                                ; preds = %if.else.i.i.i.i
  store i8 0, i8* %normalizable.i.i.i.i, align 1
  br label %reduce_normalizable.exit.i.i.i

if.end.i.i.i.i:                                   ; preds = %if.else.i.i.i.i
  %97 = load i16, i16* %i.i.i.i.i, align 2
  %dec.i.i.i.i = add nsw i16 %97, -1
  store i16 %dec.i.i.i.i, i16* %i.i.i.i.i, align 2
  br label %for.cond.i.i.i.i

reduce_normalizable.exit.i.i.i:                   ; preds = %if.then.5.i.i.i.i, %if.then.i.i.i.i, %for.cond.i.i.i.i
  %98 = load i8, i8* %normalizable.i.i.i.i, align 1
  %tobool.i.i.i.i = trunc i8 %98 to i1
  %conv.i.i.i.i = zext i1 %tobool.i.i.i.i to i16
  %call7.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %99 = load i8, i8* %normalizable.i.i.i.i, align 1
  %tobool8.i.i.i.i = trunc i8 %99 to i1
  br i1 %tobool8.i.i.i.i, label %if.then.i.3.i.i, label %if.else.i.i.i

if.then.i.3.i.i:                                  ; preds = %reduce_normalizable.exit.i.i.i
  %100 = load i16*, i16** %m.addr.i.i.i, align 2
  %101 = load i16*, i16** %n.addr.i.i.i, align 2
  %102 = load i16, i16* %d.i.i.i, align 2
  store i16* %100, i16** %m.addr.i.14.i.i.i, align 2
  store i16* %101, i16** %n.addr.i.15.i.i.i, align 2
  store i16 %102, i16* %digit.addr.i.i.i.i, align 2
  store i16 5, i16* @curtask, align 2
  %103 = load i16, i16* %digit.addr.i.i.i.i, align 2
  %add.i.20.i.i.i = add i16 %103, 1
  %sub.i.21.i.i.i = sub i16 %add.i.20.i.i.i, 8
  store i16 %sub.i.21.i.i.i, i16* %offset.i.19.i.i.i, align 2
  store i16 0, i16* %borrow.i.i.i.i, align 2
  store i16 0, i16* %i.i.16.i.i.i, align 2
  br label %for.cond.i.23.i.i.i

for.cond.i.23.i.i.i:                              ; preds = %if.end.i.30.i.i.i, %if.then.i.3.i.i
  %104 = load i16, i16* %i.i.16.i.i.i, align 2
  %cmp.i.22.i.i.i = icmp slt i16 %104, 8
  br i1 %cmp.i.22.i.i.i, label %for.body.i.27.i.i.i, label %reduce_normalize.exit.i.i.i

for.body.i.27.i.i.i:                              ; preds = %for.cond.i.23.i.i.i
  store i16 21, i16* @curtask, align 2
  %105 = load i16, i16* %i.i.16.i.i.i, align 2
  %106 = load i16, i16* %offset.i.19.i.i.i, align 2
  %add1.i.i.i.i = add i16 %105, %106
  %107 = load i16*, i16** %m.addr.i.14.i.i.i, align 2
  %arrayidx.i.24.i.i.i = getelementptr inbounds i16, i16* %107, i16 %add1.i.i.i.i
  %108 = load i16, i16* %arrayidx.i.24.i.i.i, align 2
  store i16 %108, i16* %m_d.i.17.i.i.i, align 2
  %109 = load i16, i16* %i.i.16.i.i.i, align 2
  %110 = load i16*, i16** %n.addr.i.15.i.i.i, align 2
  %arrayidx2.i.25.i.i.i = getelementptr inbounds i16, i16* %110, i16 %109
  %111 = load i16, i16* %arrayidx2.i.25.i.i.i, align 2
  store i16 %111, i16* %n_d.i.18.i.i.i, align 2
  %112 = load i16, i16* %n_d.i.18.i.i.i, align 2
  %113 = load i16, i16* %borrow.i.i.i.i, align 2
  %add3.i.i.i.i = add i16 %112, %113
  store i16 %add3.i.i.i.i, i16* %s.i.i.i.i, align 2
  %114 = load i16, i16* %m_d.i.17.i.i.i, align 2
  %115 = load i16, i16* %s.i.i.i.i, align 2
  %cmp4.i.26.i.i.i = icmp ult i16 %114, %115
  br i1 %cmp4.i.26.i.i.i, label %if.then.i.28.i.i.i, label %if.else.i.29.i.i.i

if.then.i.28.i.i.i:                               ; preds = %for.body.i.27.i.i.i
  %116 = load i16, i16* %m_d.i.17.i.i.i, align 2
  %add5.i.i.i.i = add i16 %116, 256
  store i16 %add5.i.i.i.i, i16* %m_d.i.17.i.i.i, align 2
  store i16 1, i16* %borrow.i.i.i.i, align 2
  br label %if.end.i.30.i.i.i

if.else.i.29.i.i.i:                               ; preds = %for.body.i.27.i.i.i
  store i16 0, i16* %borrow.i.i.i.i, align 2
  br label %if.end.i.30.i.i.i

if.end.i.30.i.i.i:                                ; preds = %if.else.i.29.i.i.i, %if.then.i.28.i.i.i
  %117 = load i16, i16* %m_d.i.17.i.i.i, align 2
  %118 = load i16, i16* %s.i.i.i.i, align 2
  %sub6.i.i.i.i = sub i16 %117, %118
  store i16 %sub6.i.i.i.i, i16* %d.i.i.i.i, align 2
  %119 = load i16, i16* %d.i.i.i.i, align 2
  %120 = load i16, i16* %i.i.16.i.i.i, align 2
  %121 = load i16, i16* %offset.i.19.i.i.i, align 2
  %add7.i.i.i.i = add i16 %120, %121
  %122 = load i16*, i16** %m.addr.i.14.i.i.i, align 2
  %arrayidx8.i.i.i.i = getelementptr inbounds i16, i16* %122, i16 %add7.i.i.i.i
  store i16 %119, i16* %arrayidx8.i.i.i.i, align 2
  %123 = load i16, i16* %i.i.16.i.i.i, align 2
  %inc.i.i.i.i = add nsw i16 %123, 1
  store i16 %inc.i.i.i.i, i16* %i.i.16.i.i.i, align 2
  br label %for.cond.i.23.i.i.i

reduce_normalize.exit.i.i.i:                      ; preds = %for.cond.i.23.i.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.i

if.else.i.i.i:                                    ; preds = %reduce_normalizable.exit.i.i.i
  %124 = load i16, i16* %d.i.i.i, align 2
  %cmp4.i.4.i.i = icmp eq i16 %124, 7
  br i1 %cmp4.i.4.i.i, label %if.then.5.i.i.i, label %if.end.i.5.i.i

if.then.5.i.i.i:                                  ; preds = %if.else.i.i.i
  %call6.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit.i

if.end.i.5.i.i:                                   ; preds = %if.else.i.i.i
  br label %if.end.7.i.i.i

if.end.7.i.i.i:                                   ; preds = %if.end.i.5.i.i, %reduce_normalize.exit.i.i.i
  br label %while.cond.i.i.i

while.cond.i.i.i:                                 ; preds = %reduce_subtract.exit.i.i.i, %if.end.7.i.i.i
  %125 = load i16, i16* %d.i.i.i, align 2
  %cmp8.i.i.i = icmp uge i16 %125, 8
  br i1 %cmp8.i.i.i, label %while.body.i.i.i, label %while.end.i.i.i

while.body.i.i.i:                                 ; preds = %while.cond.i.i.i
  %126 = load i16*, i16** %m.addr.i.i.i, align 2
  %127 = load i16*, i16** %n.addr.i.i.i, align 2
  %128 = load i16, i16* %d.i.i.i, align 2
  store i16* %q.i.i.i, i16** %quotient.addr.i.i.i.i, align 2
  store i16* %126, i16** %m.addr.i.31.i.i.i, align 2
  store i16* %127, i16** %n.addr.i.32.i.i.i, align 2
  store i16 %128, i16* %d.addr.i.33.i.i.i, align 2
  store i16 16, i16* @curtask, align 2
  %129 = load i16*, i16** %n.addr.i.32.i.i.i, align 2
  %arrayidx.i.35.i.i.i = getelementptr inbounds i16, i16* %129, i16 7
  %130 = load i16, i16* %arrayidx.i.35.i.i.i, align 2
  %shl.i.i.i.i = shl i16 %130, 8
  %131 = load i16*, i16** %n.addr.i.32.i.i.i, align 2
  %arrayidx1.i.i.i.i = getelementptr inbounds i16, i16* %131, i16 6
  %132 = load i16, i16* %arrayidx1.i.i.i.i, align 2
  %add.i.36.i.i.i = add i16 %shl.i.i.i.i, %132
  store i16 %add.i.36.i.i.i, i16* %n_div.i.i.i.i, align 2
  %133 = load i16*, i16** %n.addr.i.32.i.i.i, align 2
  %arrayidx2.i.37.i.i.i = getelementptr inbounds i16, i16* %133, i16 7
  %134 = load i16, i16* %arrayidx2.i.37.i.i.i, align 2
  store i16 %134, i16* %n_n.i.i.i.i, align 2
  %135 = load i16, i16* %d.addr.i.33.i.i.i, align 2
  %136 = load i16*, i16** %m.addr.i.31.i.i.i, align 2
  %arrayidx3.i.i.i.i = getelementptr inbounds i16, i16* %136, i16 %135
  %137 = load i16, i16* %arrayidx3.i.i.i.i, align 2
  %arrayidx4.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  store i16 %137, i16* %arrayidx4.i.i.i.i, align 2
  %138 = load i16, i16* %d.addr.i.33.i.i.i, align 2
  %sub.i.38.i.i.i = sub i16 %138, 1
  %139 = load i16*, i16** %m.addr.i.31.i.i.i, align 2
  %arrayidx5.i.i.i.i = getelementptr inbounds i16, i16* %139, i16 %sub.i.38.i.i.i
  %140 = load i16, i16* %arrayidx5.i.i.i.i, align 2
  %arrayidx6.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  store i16 %140, i16* %arrayidx6.i.i.i.i, align 2
  %141 = load i16, i16* %d.addr.i.33.i.i.i, align 2
  %sub7.i.i.i.i = sub i16 %141, 2
  %142 = load i16*, i16** %m.addr.i.31.i.i.i, align 2
  %arrayidx8.i.39.i.i.i = getelementptr inbounds i16, i16* %142, i16 %sub7.i.i.i.i
  %143 = load i16, i16* %arrayidx8.i.39.i.i.i, align 2
  %arrayidx9.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  store i16 %143, i16* %arrayidx9.i.i.i.i, align 2
  %144 = load i16, i16* %n_n.i.i.i.i, align 2
  %145 = load i16*, i16** %m.addr.i.31.i.i.i, align 2
  %arrayidx10.i.i.i.i = getelementptr inbounds i16, i16* %145, i16 2
  %146 = load i16, i16* %arrayidx10.i.i.i.i, align 2
  %call.i.40.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %144, i16 %146) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %147 = load i16, i16* %arrayidx11.i.i.i.i, align 2
  %148 = load i16, i16* %n_n.i.i.i.i, align 2
  %cmp.i.41.i.i.i = icmp eq i16 %147, %148
  br i1 %cmp.i.41.i.i.i, label %if.then.i.42.i.i.i, label %if.else.i.43.i.i.i

if.then.i.42.i.i.i:                               ; preds = %while.body.i.i.i
  store i16 255, i16* %q.i.i.i.i, align 2
  br label %if.end.i.46.i.i.i

if.else.i.43.i.i.i:                               ; preds = %while.body.i.i.i
  %arrayidx12.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %149 = load i16, i16* %arrayidx12.i.i.i.i, align 2
  %shl13.i.i.i.i = shl i16 %149, 8
  %arrayidx14.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %150 = load i16, i16* %arrayidx14.i.i.i.i, align 2
  %add15.i.i.i.i = add i16 %shl13.i.i.i.i, %150
  store i16 %add15.i.i.i.i, i16* %m_dividend.i.i.i.i, align 2
  %151 = load i16, i16* %m_dividend.i.i.i.i, align 2
  %152 = load i16, i16* %n_n.i.i.i.i, align 2
  %div.i.i.i.i = udiv i16 %151, %152
  store i16 %div.i.i.i.i, i16* %q.i.i.i.i, align 2
  %153 = load i16, i16* %m_dividend.i.i.i.i, align 2
  %154 = load i16, i16* %q.i.i.i.i, align 2
  %call16.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %153, i16 %154) #4
  br label %if.end.i.46.i.i.i

if.end.i.46.i.i.i:                                ; preds = %if.else.i.43.i.i.i, %if.then.i.42.i.i.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %155 = load i16, i16* %arrayidx17.i.i.i.i, align 2
  %conv.i.44.i.i.i = zext i16 %155 to i32
  %shl18.i.i.i.i = shl i32 %conv.i.44.i.i.i, 16
  %arrayidx19.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %156 = load i16, i16* %arrayidx19.i.i.i.i, align 2
  %shl20.i.i.i.i = shl i16 %156, 8
  %conv21.i.i.i.i = zext i16 %shl20.i.i.i.i to i32
  %add22.i.i.i.i = add i32 %shl18.i.i.i.i, %conv21.i.i.i.i
  %arrayidx23.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %157 = load i16, i16* %arrayidx23.i.i.i.i, align 2
  %conv24.i.i.i.i = zext i16 %157 to i32
  %add25.i.i.i.i = add i32 %add22.i.i.i.i, %conv24.i.i.i.i
  store i32 %add25.i.i.i.i, i32* %n_q.i.i.i.i, align 2
  %arrayidx26.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %158 = load i16, i16* %arrayidx26.i.i.i.i, align 2
  %arrayidx27.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %159 = load i16, i16* %arrayidx27.i.i.i.i, align 2
  %arrayidx28.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %160 = load i16, i16* %arrayidx28.i.i.i.i, align 2
  %161 = load i32, i32* %n_q.i.i.i.i, align 2
  %shr.i.i.i.i = lshr i32 %161, 16
  %and.i.i.i.i = and i32 %shr.i.i.i.i, 65535
  %conv29.i.i.i.i = trunc i32 %and.i.i.i.i to i16
  %162 = load i32, i32* %n_q.i.i.i.i, align 2
  %and30.i.i.i.i = and i32 %162, 65535
  %conv31.i.i.i.i = trunc i32 %and30.i.i.i.i to i16
  %call32.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %158, i16 %159, i16 %160, i16 %conv29.i.i.i.i, i16 %conv31.i.i.i.i) #4
  %163 = load i16, i16* %q.i.i.i.i, align 2
  %call33.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %163) #4
  %164 = load i16, i16* %q.i.i.i.i, align 2
  %inc.i.45.i.i.i = add i16 %164, 1
  store i16 %inc.i.45.i.i.i, i16* %q.i.i.i.i, align 2
  br label %do.body.i.i.i.i

do.body.i.i.i.i:                                  ; preds = %do.body.i.i.i.i, %if.end.i.46.i.i.i
  store i16 19, i16* @curtask, align 2
  %165 = load i16, i16* %q.i.i.i.i, align 2
  %dec.i.47.i.i.i = add i16 %165, -1
  store i16 %dec.i.47.i.i.i, i16* %q.i.i.i.i, align 2
  %166 = load i16, i16* %n_div.i.i.i.i, align 2
  %167 = load i16, i16* %q.i.i.i.i, align 2
  %call34.i.i.i.i = call i32 @mult16(i16 zeroext %166, i16 zeroext %167) #4
  store i32 %call34.i.i.i.i, i32* %qn.i.i.i.i, align 2
  %168 = load i16, i16* %q.i.i.i.i, align 2
  %169 = load i16, i16* %n_div.i.i.i.i, align 2
  %170 = load i32, i32* %qn.i.i.i.i, align 2
  %shr35.i.i.i.i = lshr i32 %170, 16
  %and36.i.i.i.i = and i32 %shr35.i.i.i.i, 65535
  %conv37.i.i.i.i = trunc i32 %and36.i.i.i.i to i16
  %171 = load i32, i32* %qn.i.i.i.i, align 2
  %and38.i.i.i.i = and i32 %171, 65535
  %conv39.i.i.i.i = trunc i32 %and38.i.i.i.i to i16
  %call40.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %168, i16 %169, i16 %conv37.i.i.i.i, i16 %conv39.i.i.i.i) #4
  %172 = load i32, i32* %qn.i.i.i.i, align 2
  %173 = load i32, i32* %n_q.i.i.i.i, align 2
  %cmp41.i.i.i.i = icmp ugt i32 %172, %173
  br i1 %cmp41.i.i.i.i, label %do.body.i.i.i.i, label %reduce_quotient.exit.i.i.i

reduce_quotient.exit.i.i.i:                       ; preds = %do.body.i.i.i.i
  %174 = load i16, i16* %q.i.i.i.i, align 2
  %call43.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %174) #4
  %175 = load i16, i16* %q.i.i.i.i, align 2
  %176 = load i16*, i16** %quotient.addr.i.i.i.i, align 2
  store i16 %175, i16* %176, align 2
  store i16 32, i16* @curtask, align 2
  %177 = load i16, i16* %q.i.i.i, align 2
  %178 = load i16*, i16** %n.addr.i.i.i, align 2
  %179 = load i16, i16* %d.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i.i, align 2
  store i16 %177, i16* %q.addr.i.i.i.i, align 2
  store i16* %178, i16** %n.addr.i.48.i.i.i, align 2
  store i16 %179, i16* %d.addr.i.49.i.i.i, align 2
  store i16 9, i16* @curtask, align 2
  %180 = load i16, i16* %d.addr.i.49.i.i.i, align 2
  %sub.i.52.i.i.i = sub i16 %180, 8
  store i16 %sub.i.52.i.i.i, i16* %offset.i.51.i.i.i, align 2
  %181 = load i16, i16* %offset.i.51.i.i.i, align 2
  %call.i.53.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %181) #4
  store i16 0, i16* %i.i.50.i.i.i, align 2
  br label %for.cond.i.55.i.i.i

for.cond.i.55.i.i.i:                              ; preds = %for.body.i.57.i.i.i, %reduce_quotient.exit.i.i.i
  %182 = load i16, i16* %i.i.50.i.i.i, align 2
  %183 = load i16, i16* %offset.i.51.i.i.i, align 2
  %cmp.i.54.i.i.i = icmp ult i16 %182, %183
  br i1 %cmp.i.54.i.i.i, label %for.body.i.57.i.i.i, label %for.end.i.i.i.i

for.body.i.57.i.i.i:                              ; preds = %for.cond.i.55.i.i.i
  %184 = load i16, i16* %i.i.50.i.i.i, align 2
  %185 = load i16*, i16** %product.addr.i.i.i.i, align 2
  %arrayidx.i.56.i.i.i = getelementptr inbounds i16, i16* %185, i16 %184
  store i16 0, i16* %arrayidx.i.56.i.i.i, align 2
  %186 = load i16, i16* %i.i.50.i.i.i, align 2
  %inc.i.58.i.i.i = add nsw i16 %186, 1
  store i16 %inc.i.58.i.i.i, i16* %i.i.50.i.i.i, align 2
  br label %for.cond.i.55.i.i.i

for.end.i.i.i.i:                                  ; preds = %for.cond.i.55.i.i.i
  store i16 0, i16* %c.i.i.i.i, align 2
  %187 = load i16, i16* %offset.i.51.i.i.i, align 2
  store i16 %187, i16* %i.i.50.i.i.i, align 2
  br label %for.cond.1.i.i.i.i

for.cond.1.i.i.i.i:                               ; preds = %if.end.i.68.i.i.i, %for.end.i.i.i.i
  %188 = load i16, i16* %i.i.50.i.i.i, align 2
  %cmp2.i.i.i.i = icmp slt i16 %188, 16
  br i1 %cmp2.i.i.i.i, label %for.body.3.i.i.i.i, label %reduce_multiply.exit.i.i.i

for.body.3.i.i.i.i:                               ; preds = %for.cond.1.i.i.i.i
  store i16 24, i16* @curtask, align 2
  %189 = load i16, i16* %c.i.i.i.i, align 2
  store i16 %189, i16* %p.i.i.i.i, align 2
  %190 = load i16, i16* %i.i.50.i.i.i, align 2
  %191 = load i16, i16* %offset.i.51.i.i.i, align 2
  %add.i.59.i.i.i = add i16 %191, 8
  %cmp4.i.60.i.i.i = icmp ult i16 %190, %add.i.59.i.i.i
  br i1 %cmp4.i.60.i.i.i, label %if.then.i.63.i.i.i, label %if.else.i.64.i.i.i

if.then.i.63.i.i.i:                               ; preds = %for.body.3.i.i.i.i
  %192 = load i16, i16* %i.i.50.i.i.i, align 2
  %193 = load i16, i16* %offset.i.51.i.i.i, align 2
  %sub5.i.i.i.i = sub i16 %192, %193
  %194 = load i16*, i16** %n.addr.i.48.i.i.i, align 2
  %arrayidx6.i.61.i.i.i = getelementptr inbounds i16, i16* %194, i16 %sub5.i.i.i.i
  %195 = load i16, i16* %arrayidx6.i.61.i.i.i, align 2
  store i16 %195, i16* %nd.i.i.i.i, align 2
  %196 = load i16, i16* %q.addr.i.i.i.i, align 2
  %197 = load i16, i16* %nd.i.i.i.i, align 2
  %mul.i.i.i.i = mul i16 %196, %197
  %198 = load i16, i16* %p.i.i.i.i, align 2
  %add7.i.62.i.i.i = add i16 %198, %mul.i.i.i.i
  store i16 %add7.i.62.i.i.i, i16* %p.i.i.i.i, align 2
  br label %if.end.i.68.i.i.i

if.else.i.64.i.i.i:                               ; preds = %for.body.3.i.i.i.i
  store i16 0, i16* %nd.i.i.i.i, align 2
  br label %if.end.i.68.i.i.i

if.end.i.68.i.i.i:                                ; preds = %if.else.i.64.i.i.i, %if.then.i.63.i.i.i
  %199 = load i16, i16* %p.i.i.i.i, align 2
  %shr.i.65.i.i.i = lshr i16 %199, 8
  store i16 %shr.i.65.i.i.i, i16* %c.i.i.i.i, align 2
  %200 = load i16, i16* %p.i.i.i.i, align 2
  %and.i.66.i.i.i = and i16 %200, 255
  store i16 %and.i.66.i.i.i, i16* %p.i.i.i.i, align 2
  %201 = load i16, i16* %p.i.i.i.i, align 2
  %202 = load i16, i16* %i.i.50.i.i.i, align 2
  %203 = load i16*, i16** %product.addr.i.i.i.i, align 2
  %arrayidx8.i.67.i.i.i = getelementptr inbounds i16, i16* %203, i16 %202
  store i16 %201, i16* %arrayidx8.i.67.i.i.i, align 2
  %204 = load i16, i16* %i.i.50.i.i.i, align 2
  %inc10.i.i.i.i = add nsw i16 %204, 1
  store i16 %inc10.i.i.i.i, i16* %i.i.50.i.i.i, align 2
  br label %for.cond.1.i.i.i.i

reduce_multiply.exit.i.i.i:                       ; preds = %for.cond.1.i.i.i.i
  store i16 33, i16* @curtask, align 2
  %205 = load i16*, i16** %m.addr.i.i.i, align 2
  store i16* %205, i16** %a.addr.i.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i.i, align 2
  store i16 0, i16* %relation.i.i.i.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i.i, align 2
  br label %for.cond.i.71.i.i.i

for.cond.i.71.i.i.i:                              ; preds = %if.end.i.76.i.i.i, %reduce_multiply.exit.i.i.i
  %206 = load i16, i16* %i.i.69.i.i.i, align 2
  %cmp.i.70.i.i.i = icmp sge i16 %206, 0
  br i1 %cmp.i.70.i.i.i, label %for.body.i.72.i.i.i, label %reduce_compare.exit.i.i.i

for.body.i.72.i.i.i:                              ; preds = %for.cond.i.71.i.i.i
  %207 = load i16*, i16** %a.addr.i.i.i.i, align 2
  %208 = load i16*, i16** %b.addr.i.i.i.i, align 2
  %cmp1.i.i.i.i = icmp ugt i16* %207, %208
  br i1 %cmp1.i.i.i.i, label %if.then.i.73.i.i.i, label %if.else.i.75.i.i.i

if.then.i.73.i.i.i:                               ; preds = %for.body.i.72.i.i.i
  store i16 1, i16* %relation.i.i.i.i, align 2
  br label %reduce_compare.exit.i.i.i

if.else.i.75.i.i.i:                               ; preds = %for.body.i.72.i.i.i
  %209 = load i16*, i16** %a.addr.i.i.i.i, align 2
  %210 = load i16*, i16** %b.addr.i.i.i.i, align 2
  %cmp2.i.74.i.i.i = icmp ult i16* %209, %210
  br i1 %cmp2.i.74.i.i.i, label %if.then.3.i.i.i.i, label %if.end.i.76.i.i.i

if.then.3.i.i.i.i:                                ; preds = %if.else.i.75.i.i.i
  store i16 -1, i16* %relation.i.i.i.i, align 2
  br label %reduce_compare.exit.i.i.i

if.end.i.76.i.i.i:                                ; preds = %if.else.i.75.i.i.i
  %211 = load i16, i16* %i.i.69.i.i.i, align 2
  %dec.i.77.i.i.i = add nsw i16 %211, -1
  store i16 %dec.i.77.i.i.i, i16* %i.i.69.i.i.i, align 2
  br label %for.cond.i.71.i.i.i

reduce_compare.exit.i.i.i:                        ; preds = %if.then.3.i.i.i.i, %if.then.i.73.i.i.i, %for.cond.i.71.i.i.i
  store i16 31, i16* @curtask, align 2
  %212 = load i16, i16* %relation.i.i.i.i, align 2
  %cmp10.i.i.i = icmp slt i16 %212, 0
  br i1 %cmp10.i.i.i, label %if.then.11.i.i.i, label %if.end.12.i.i.i

if.then.11.i.i.i:                                 ; preds = %reduce_compare.exit.i.i.i
  %213 = load i16*, i16** %m.addr.i.i.i, align 2
  %214 = load i16*, i16** %n.addr.i.i.i, align 2
  %215 = load i16, i16* %d.i.i.i, align 2
  store i16* %213, i16** %a.addr.i.79.i.i.i, align 2
  store i16* %214, i16** %b.addr.i.80.i.i.i, align 2
  store i16 %215, i16* %d.addr.i.81.i.i.i, align 2
  store i16 10, i16* @curtask, align 2
  %216 = load i16, i16* %d.addr.i.81.i.i.i, align 2
  %sub.i.85.i.i.i = sub i16 %216, 8
  store i16 %sub.i.85.i.i.i, i16* %offset.i.83.i.i.i, align 2
  store i16 0, i16* %c.i.84.i.i.i, align 2
  %217 = load i16, i16* %offset.i.83.i.i.i, align 2
  store i16 %217, i16* %i.i.82.i.i.i, align 2
  br label %for.cond.i.87.i.i.i

for.cond.i.87.i.i.i:                              ; preds = %if.end.i.100.i.i.i, %if.then.11.i.i.i
  %218 = load i16, i16* %i.i.82.i.i.i, align 2
  %cmp.i.86.i.i.i = icmp slt i16 %218, 16
  br i1 %cmp.i.86.i.i.i, label %for.body.i.92.i.i.i, label %reduce_add.exit.i.i.i

for.body.i.92.i.i.i:                              ; preds = %for.cond.i.87.i.i.i
  store i16 22, i16* @curtask, align 2
  %219 = load i16, i16* %i.i.82.i.i.i, align 2
  %220 = load i16*, i16** %a.addr.i.79.i.i.i, align 2
  %arrayidx.i.88.i.i.i = getelementptr inbounds i16, i16* %220, i16 %219
  %221 = load i16, i16* %arrayidx.i.88.i.i.i, align 2
  store i16 %221, i16* %m.i.i.i.i, align 2
  %222 = load i16, i16* %i.i.82.i.i.i, align 2
  %223 = load i16, i16* %offset.i.83.i.i.i, align 2
  %sub1.i.89.i.i.i = sub i16 %222, %223
  store i16 %sub1.i.89.i.i.i, i16* %j.i.i.i.i, align 2
  %224 = load i16, i16* %i.i.82.i.i.i, align 2
  %225 = load i16, i16* %offset.i.83.i.i.i, align 2
  %add.i.90.i.i.i = add i16 %225, 8
  %cmp2.i.91.i.i.i = icmp ult i16 %224, %add.i.90.i.i.i
  br i1 %cmp2.i.91.i.i.i, label %if.then.i.94.i.i.i, label %if.else.i.95.i.i.i

if.then.i.94.i.i.i:                               ; preds = %for.body.i.92.i.i.i
  %226 = load i16, i16* %j.i.i.i.i, align 2
  %227 = load i16*, i16** %b.addr.i.80.i.i.i, align 2
  %arrayidx3.i.93.i.i.i = getelementptr inbounds i16, i16* %227, i16 %226
  %228 = load i16, i16* %arrayidx3.i.93.i.i.i, align 2
  store i16 %228, i16* %n.i.i.i.i, align 2
  br label %if.end.i.100.i.i.i

if.else.i.95.i.i.i:                               ; preds = %for.body.i.92.i.i.i
  store i16 0, i16* %n.i.i.i.i, align 2
  store i16 0, i16* %j.i.i.i.i, align 2
  br label %if.end.i.100.i.i.i

if.end.i.100.i.i.i:                               ; preds = %if.else.i.95.i.i.i, %if.then.i.94.i.i.i
  %229 = load i16, i16* %c.i.84.i.i.i, align 2
  %230 = load i16, i16* %m.i.i.i.i, align 2
  %add4.i.i.i.i = add i16 %229, %230
  %231 = load i16, i16* %n.i.i.i.i, align 2
  %add5.i.96.i.i.i = add i16 %add4.i.i.i.i, %231
  store i16 %add5.i.96.i.i.i, i16* %r.i.i.i.i, align 2
  %232 = load i16, i16* %r.i.i.i.i, align 2
  %shr.i.97.i.i.i = lshr i16 %232, 8
  store i16 %shr.i.97.i.i.i, i16* %c.i.84.i.i.i, align 2
  %233 = load i16, i16* %r.i.i.i.i, align 2
  %and.i.98.i.i.i = and i16 %233, 255
  store i16 %and.i.98.i.i.i, i16* %r.i.i.i.i, align 2
  %234 = load i16, i16* %r.i.i.i.i, align 2
  %235 = load i16, i16* %i.i.82.i.i.i, align 2
  %236 = load i16*, i16** %a.addr.i.79.i.i.i, align 2
  %arrayidx6.i.99.i.i.i = getelementptr inbounds i16, i16* %236, i16 %235
  store i16 %234, i16* %arrayidx6.i.99.i.i.i, align 2
  %237 = load i16, i16* %i.i.82.i.i.i, align 2
  %inc.i.101.i.i.i = add nsw i16 %237, 1
  store i16 %inc.i.101.i.i.i, i16* %i.i.82.i.i.i, align 2
  br label %for.cond.i.87.i.i.i

reduce_add.exit.i.i.i:                            ; preds = %for.cond.i.87.i.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.i

if.end.12.i.i.i:                                  ; preds = %reduce_add.exit.i.i.i, %reduce_compare.exit.i.i.i
  %238 = load i16*, i16** %m.addr.i.i.i, align 2
  %239 = load i16, i16* %d.i.i.i, align 2
  store i16* %238, i16** %a.addr.i.103.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i.i, align 2
  store i16 %239, i16* %d.addr.i.105.i.i.i, align 2
  store i16 11, i16* @curtask, align 2
  %240 = load i16, i16* %d.addr.i.105.i.i.i, align 2
  %sub.i.113.i.i.i = sub i16 %240, 8
  store i16 %sub.i.113.i.i.i, i16* %offset.i.112.i.i.i, align 2
  %241 = load i16, i16* %d.addr.i.105.i.i.i, align 2
  %242 = load i16, i16* %offset.i.112.i.i.i, align 2
  %call.i.114.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %241, i16 %242) #4
  store i16 0, i16* %borrow.i.111.i.i.i, align 2
  %243 = load i16, i16* %offset.i.112.i.i.i, align 2
  store i16 %243, i16* %i.i.106.i.i.i, align 2
  br label %for.cond.i.116.i.i.i

for.cond.i.116.i.i.i:                             ; preds = %if.end.i.126.i.i.i, %if.end.12.i.i.i
  %244 = load i16, i16* %i.i.106.i.i.i, align 2
  %cmp.i.115.i.i.i = icmp slt i16 %244, 16
  br i1 %cmp.i.115.i.i.i, label %for.body.i.121.i.i.i, label %reduce_subtract.exit.i.i.i

for.body.i.121.i.i.i:                             ; preds = %for.cond.i.116.i.i.i
  store i16 23, i16* @curtask, align 2
  %245 = load i16, i16* %i.i.106.i.i.i, align 2
  %246 = load i16*, i16** %a.addr.i.103.i.i.i, align 2
  %arrayidx.i.117.i.i.i = getelementptr inbounds i16, i16* %246, i16 %245
  %247 = load i16, i16* %arrayidx.i.117.i.i.i, align 2
  store i16 %247, i16* %m.i.107.i.i.i, align 2
  %248 = load i16, i16* %i.i.106.i.i.i, align 2
  %249 = load i16*, i16** %b.addr.i.104.i.i.i, align 2
  %arrayidx1.i.118.i.i.i = getelementptr inbounds i16, i16* %249, i16 %248
  %250 = load i16, i16* %arrayidx1.i.118.i.i.i, align 2
  store i16 %250, i16* %qn.i.110.i.i.i, align 2
  %251 = load i16, i16* %qn.i.110.i.i.i, align 2
  %252 = load i16, i16* %borrow.i.111.i.i.i, align 2
  %add.i.119.i.i.i = add i16 %251, %252
  store i16 %add.i.119.i.i.i, i16* %s.i.108.i.i.i, align 2
  %253 = load i16, i16* %m.i.107.i.i.i, align 2
  %254 = load i16, i16* %s.i.108.i.i.i, align 2
  %cmp2.i.120.i.i.i = icmp ult i16 %253, %254
  br i1 %cmp2.i.120.i.i.i, label %if.then.i.123.i.i.i, label %if.else.i.124.i.i.i

if.then.i.123.i.i.i:                              ; preds = %for.body.i.121.i.i.i
  %255 = load i16, i16* %m.i.107.i.i.i, align 2
  %add3.i.122.i.i.i = add i16 %255, 256
  store i16 %add3.i.122.i.i.i, i16* %m.i.107.i.i.i, align 2
  store i16 1, i16* %borrow.i.111.i.i.i, align 2
  br label %if.end.i.126.i.i.i

if.else.i.124.i.i.i:                              ; preds = %for.body.i.121.i.i.i
  store i16 0, i16* %borrow.i.111.i.i.i, align 2
  br label %if.end.i.126.i.i.i

if.end.i.126.i.i.i:                               ; preds = %if.else.i.124.i.i.i, %if.then.i.123.i.i.i
  %256 = load i16, i16* %m.i.107.i.i.i, align 2
  %257 = load i16, i16* %s.i.108.i.i.i, align 2
  %sub4.i.i.i.i = sub i16 %256, %257
  store i16 %sub4.i.i.i.i, i16* %r.i.109.i.i.i, align 2
  %258 = load i16, i16* %r.i.109.i.i.i, align 2
  %259 = load i16, i16* %i.i.106.i.i.i, align 2
  %260 = load i16*, i16** %a.addr.i.103.i.i.i, align 2
  %arrayidx5.i.125.i.i.i = getelementptr inbounds i16, i16* %260, i16 %259
  store i16 %258, i16* %arrayidx5.i.125.i.i.i, align 2
  %261 = load i16, i16* %i.i.106.i.i.i, align 2
  %inc.i.127.i.i.i = add nsw i16 %261, 1
  store i16 %inc.i.127.i.i.i, i16* %i.i.106.i.i.i, align 2
  br label %for.cond.i.116.i.i.i

reduce_subtract.exit.i.i.i:                       ; preds = %for.cond.i.116.i.i.i
  store i16 35, i16* @curtask, align 2
  %262 = load i16, i16* %d.i.i.i, align 2
  %dec13.i.i.i = add i16 %262, -1
  store i16 %dec13.i.i.i, i16* %d.i.i.i, align 2
  br label %while.cond.i.i.i

while.end.i.i.i:                                  ; preds = %while.cond.i.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit.i

mod_mult.exit.i:                                  ; preds = %while.end.i.i.i, %if.then.5.i.i.i
  br label %if.end.i

if.end.i:                                         ; preds = %mod_mult.exit.i, %while.body.i
  %263 = load i16*, i16** %base.addr.i, align 2
  %264 = load i16*, i16** %base.addr.i, align 2
  %265 = load i16*, i16** %n.addr.i, align 2
  store i16* %263, i16** %a.addr.i.78.i, align 2
  store i16* %264, i16** %b.addr.i.79.i, align 2
  store i16* %265, i16** %n.addr.i.80.i, align 2
  %266 = load i16*, i16** %a.addr.i.78.i, align 2
  %267 = load i16*, i16** %b.addr.i.79.i, align 2
  store i16* %266, i16** %a.addr.i.i.70.i, align 2
  store i16* %267, i16** %b.addr.i.i.71.i, align 2
  store i16 0, i16* %carry.i.i.77.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i.73.i, align 2
  br label %for.cond.i.i.82.i

for.cond.i.i.82.i:                                ; preds = %for.end.i.i.107.i, %if.end.i
  %268 = load i16, i16* %digit.i.i.73.i, align 2
  %cmp.i.i.81.i = icmp ult i16 %268, 16
  br i1 %cmp.i.i.81.i, label %for.body.i.i.83.i, label %for.end.15.i.i.108.i

for.body.i.i.83.i:                                ; preds = %for.cond.i.i.82.i
  store i16 14, i16* @curtask, align 2
  %269 = load i16, i16* %carry.i.i.77.i, align 2
  store i16 %269, i16* %p.i.i.74.i, align 2
  store i16 0, i16* %c.i.i.75.i, align 2
  store i16 0, i16* %i.i.i.72.i, align 2
  br label %for.cond.1.i.i.85.i

for.cond.1.i.i.85.i:                              ; preds = %if.end.i.i.101.i, %for.body.i.i.83.i
  %270 = load i16, i16* %i.i.i.72.i, align 2
  %cmp2.i.i.84.i = icmp slt i16 %270, 8
  br i1 %cmp2.i.i.84.i, label %for.body.3.i.i.87.i, label %for.end.i.i.107.i

for.body.3.i.i.87.i:                              ; preds = %for.cond.1.i.i.85.i
  %271 = load i16, i16* %i.i.i.72.i, align 2
  %272 = load i16, i16* %digit.i.i.73.i, align 2
  %cmp4.i.i.86.i = icmp ule i16 %271, %272
  br i1 %cmp4.i.i.86.i, label %land.lhs.true.i.i.90.i, label %if.end.i.i.101.i

land.lhs.true.i.i.90.i:                           ; preds = %for.body.3.i.i.87.i
  %273 = load i16, i16* %digit.i.i.73.i, align 2
  %274 = load i16, i16* %i.i.i.72.i, align 2
  %sub.i.i.88.i = sub i16 %273, %274
  %cmp5.i.i.89.i = icmp ult i16 %sub.i.i.88.i, 8
  br i1 %cmp5.i.i.89.i, label %if.then.i.i.99.i, label %if.end.i.i.101.i

if.then.i.i.99.i:                                 ; preds = %land.lhs.true.i.i.90.i
  %275 = load i16, i16* %digit.i.i.73.i, align 2
  %276 = load i16, i16* %i.i.i.72.i, align 2
  %sub6.i.i.91.i = sub i16 %275, %276
  %277 = load i16*, i16** %a.addr.i.i.70.i, align 2
  %arrayidx.i.i.92.i = getelementptr inbounds i16, i16* %277, i16 %sub6.i.i.91.i
  %278 = load i16, i16* %arrayidx.i.i.92.i, align 2
  %279 = load i16, i16* %i.i.i.72.i, align 2
  %280 = load i16*, i16** %b.addr.i.i.71.i, align 2
  %arrayidx7.i.i.93.i = getelementptr inbounds i16, i16* %280, i16 %279
  %281 = load i16, i16* %arrayidx7.i.i.93.i, align 2
  %mul.i.i.94.i = mul i16 %278, %281
  store i16 %mul.i.i.94.i, i16* %dp.i.i.76.i, align 2
  %282 = load i16, i16* %dp.i.i.76.i, align 2
  %shr.i.i.95.i = lshr i16 %282, 8
  %283 = load i16, i16* %c.i.i.75.i, align 2
  %add.i.i.96.i = add i16 %283, %shr.i.i.95.i
  store i16 %add.i.i.96.i, i16* %c.i.i.75.i, align 2
  %284 = load i16, i16* %dp.i.i.76.i, align 2
  %and.i.i.97.i = and i16 %284, 255
  %285 = load i16, i16* %p.i.i.74.i, align 2
  %add8.i.i.98.i = add i16 %285, %and.i.i.97.i
  store i16 %add8.i.i.98.i, i16* %p.i.i.74.i, align 2
  br label %if.end.i.i.101.i

if.end.i.i.101.i:                                 ; preds = %if.then.i.i.99.i, %land.lhs.true.i.i.90.i, %for.body.3.i.i.87.i
  %286 = load i16, i16* %i.i.i.72.i, align 2
  %inc.i.i.100.i = add nsw i16 %286, 1
  store i16 %inc.i.i.100.i, i16* %i.i.i.72.i, align 2
  br label %for.cond.1.i.i.85.i

for.end.i.i.107.i:                                ; preds = %for.cond.1.i.i.85.i
  %287 = load i16, i16* %p.i.i.74.i, align 2
  %shr9.i.i.102.i = lshr i16 %287, 8
  %288 = load i16, i16* %c.i.i.75.i, align 2
  %add10.i.i.103.i = add i16 %288, %shr9.i.i.102.i
  store i16 %add10.i.i.103.i, i16* %c.i.i.75.i, align 2
  %289 = load i16, i16* %p.i.i.74.i, align 2
  %and11.i.i.104.i = and i16 %289, 255
  store i16 %and11.i.i.104.i, i16* %p.i.i.74.i, align 2
  %290 = load i16, i16* %p.i.i.74.i, align 2
  %291 = load i16, i16* %digit.i.i.73.i, align 2
  %arrayidx12.i.i.105.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %291
  store i16 %290, i16* %arrayidx12.i.i.105.i, align 2
  %292 = load i16, i16* %c.i.i.75.i, align 2
  store i16 %292, i16* %carry.i.i.77.i, align 2
  %293 = load i16, i16* %digit.i.i.73.i, align 2
  %inc14.i.i.106.i = add i16 %293, 1
  store i16 %inc14.i.i.106.i, i16* %digit.i.i.73.i, align 2
  br label %for.cond.i.i.82.i

for.end.15.i.i.108.i:                             ; preds = %for.cond.i.i.82.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i.72.i, align 2
  br label %for.cond.16.i.i.110.i

for.cond.16.i.i.110.i:                            ; preds = %for.body.18.i.i.114.i, %for.end.15.i.i.108.i
  %294 = load i16, i16* %i.i.i.72.i, align 2
  %cmp17.i.i.109.i = icmp slt i16 %294, 16
  br i1 %cmp17.i.i.109.i, label %for.body.18.i.i.114.i, label %mult.exit.i.115.i

for.body.18.i.i.114.i:                            ; preds = %for.cond.16.i.i.110.i
  %295 = load i16, i16* %i.i.i.72.i, align 2
  %arrayidx19.i.i.111.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %295
  %296 = load i16, i16* %arrayidx19.i.i.111.i, align 2
  %297 = load i16, i16* %i.i.i.72.i, align 2
  %298 = load i16*, i16** %a.addr.i.i.70.i, align 2
  %arrayidx20.i.i.112.i = getelementptr inbounds i16, i16* %298, i16 %297
  store i16 %296, i16* %arrayidx20.i.i.112.i, align 2
  %299 = load i16, i16* %i.i.i.72.i, align 2
  %inc22.i.i.113.i = add nsw i16 %299, 1
  store i16 %inc22.i.i.113.i, i16* %i.i.i.72.i, align 2
  br label %for.cond.16.i.i.110.i

mult.exit.i.115.i:                                ; preds = %for.cond.16.i.i.110.i
  store i16 27, i16* @curtask, align 2
  %300 = load i16*, i16** %a.addr.i.78.i, align 2
  %301 = load i16*, i16** %n.addr.i.80.i, align 2
  store i16* %300, i16** %m.addr.i.i.65.i, align 2
  store i16* %301, i16** %n.addr.i.i.66.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i.69.i, align 2
  br label %do.body.i.i.120.i

do.body.i.i.120.i:                                ; preds = %land.end.i.i.123.i, %mult.exit.i.115.i
  %302 = load i16, i16* %d.i.i.69.i, align 2
  %dec.i.i.116.i = add i16 %302, -1
  store i16 %dec.i.i.116.i, i16* %d.i.i.69.i, align 2
  %303 = load i16, i16* %d.i.i.69.i, align 2
  %304 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %arrayidx.i.1.i.117.i = getelementptr inbounds i16, i16* %304, i16 %303
  %305 = load i16, i16* %arrayidx.i.1.i.117.i, align 2
  store i16 %305, i16* %m_d.i.i.68.i, align 2
  %306 = load i16, i16* %d.i.i.69.i, align 2
  %307 = load i16, i16* %m_d.i.i.68.i, align 2
  %call.i.i.118.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %306, i16 %307) #4
  %308 = load i16, i16* %m_d.i.i.68.i, align 2
  %cmp.i.2.i.119.i = icmp eq i16 %308, 0
  br i1 %cmp.i.2.i.119.i, label %land.rhs.i.i.122.i, label %land.end.i.i.123.i

land.rhs.i.i.122.i:                               ; preds = %do.body.i.i.120.i
  %309 = load i16, i16* %d.i.i.69.i, align 2
  %cmp1.i.i.121.i = icmp ugt i16 %309, 0
  br label %land.end.i.i.123.i

land.end.i.i.123.i:                               ; preds = %land.rhs.i.i.122.i, %do.body.i.i.120.i
  %310 = phi i1 [ false, %do.body.i.i.120.i ], [ %cmp1.i.i.121.i, %land.rhs.i.i.122.i ]
  br i1 %310, label %do.body.i.i.120.i, label %do.end.i.i.128.i

do.end.i.i.128.i:                                 ; preds = %land.end.i.i.123.i
  %311 = load i16, i16* %d.i.i.69.i, align 2
  %call2.i.i.124.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %311) #4
  %312 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %313 = load i16*, i16** %n.addr.i.i.66.i, align 2
  %314 = load i16, i16* %d.i.i.69.i, align 2
  store i16* %312, i16** %m.addr.i.i.i.57.i, align 2
  store i16* %313, i16** %n.addr.i.i.i.58.i, align 2
  store i16 %314, i16* %d.addr.i.i.i.59.i, align 2
  store i8 1, i8* %normalizable.i.i.i.64.i, align 1
  store i16 6, i16* @curtask, align 2
  %315 = load i16, i16* %d.addr.i.i.i.59.i, align 2
  %add.i.i.i.125.i = add i16 %315, 1
  %sub.i.i.i.126.i = sub i16 %add.i.i.i.125.i, 8
  store i16 %sub.i.i.i.126.i, i16* %offset.i.i.i.61.i, align 2
  %316 = load i16, i16* %d.addr.i.i.i.59.i, align 2
  %317 = load i16, i16* %offset.i.i.i.61.i, align 2
  %call.i.i.i.127.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %316, i16 %317) #4
  %318 = load i16, i16* %d.addr.i.i.i.59.i, align 2
  store i16 %318, i16* %i.i.i.i.60.i, align 2
  br label %for.cond.i.i.i.130.i

for.cond.i.i.i.130.i:                             ; preds = %if.end.i.i.i.141.i, %do.end.i.i.128.i
  %319 = load i16, i16* %i.i.i.i.60.i, align 2
  %cmp.i.i.i.129.i = icmp sge i16 %319, 0
  br i1 %cmp.i.i.i.129.i, label %for.body.i.i.i.135.i, label %reduce_normalizable.exit.i.i.146.i

for.body.i.i.i.135.i:                             ; preds = %for.cond.i.i.i.130.i
  %320 = load i16, i16* %i.i.i.i.60.i, align 2
  %321 = load i16*, i16** %m.addr.i.i.i.57.i, align 2
  %arrayidx.i.i.i.131.i = getelementptr inbounds i16, i16* %321, i16 %320
  %322 = load i16, i16* %arrayidx.i.i.i.131.i, align 2
  store i16 %322, i16* %m_d.i.i.i.63.i, align 2
  %323 = load i16, i16* %i.i.i.i.60.i, align 2
  %324 = load i16, i16* %offset.i.i.i.61.i, align 2
  %sub1.i.i.i.132.i = sub i16 %323, %324
  %325 = load i16*, i16** %n.addr.i.i.i.58.i, align 2
  %arrayidx2.i.i.i.133.i = getelementptr inbounds i16, i16* %325, i16 %sub1.i.i.i.132.i
  %326 = load i16, i16* %arrayidx2.i.i.i.133.i, align 2
  store i16 %326, i16* %n_d.i.i.i.62.i, align 2
  %327 = load i16, i16* %m_d.i.i.i.63.i, align 2
  %328 = load i16, i16* %n_d.i.i.i.62.i, align 2
  %cmp3.i.i.i.134.i = icmp ugt i16 %327, %328
  br i1 %cmp3.i.i.i.134.i, label %if.then.i.i.i.136.i, label %if.else.i.i.i.138.i

if.then.i.i.i.136.i:                              ; preds = %for.body.i.i.i.135.i
  br label %reduce_normalizable.exit.i.i.146.i

if.else.i.i.i.138.i:                              ; preds = %for.body.i.i.i.135.i
  %329 = load i16, i16* %m_d.i.i.i.63.i, align 2
  %330 = load i16, i16* %n_d.i.i.i.62.i, align 2
  %cmp4.i.i.i.137.i = icmp ult i16 %329, %330
  br i1 %cmp4.i.i.i.137.i, label %if.then.5.i.i.i.139.i, label %if.end.i.i.i.141.i

if.then.5.i.i.i.139.i:                            ; preds = %if.else.i.i.i.138.i
  store i8 0, i8* %normalizable.i.i.i.64.i, align 1
  br label %reduce_normalizable.exit.i.i.146.i

if.end.i.i.i.141.i:                               ; preds = %if.else.i.i.i.138.i
  %331 = load i16, i16* %i.i.i.i.60.i, align 2
  %dec.i.i.i.140.i = add nsw i16 %331, -1
  store i16 %dec.i.i.i.140.i, i16* %i.i.i.i.60.i, align 2
  br label %for.cond.i.i.i.130.i

reduce_normalizable.exit.i.i.146.i:               ; preds = %if.then.5.i.i.i.139.i, %if.then.i.i.i.136.i, %for.cond.i.i.i.130.i
  %332 = load i8, i8* %normalizable.i.i.i.64.i, align 1
  %tobool.i.i.i.142.i = trunc i8 %332 to i1
  %conv.i.i.i.143.i = zext i1 %tobool.i.i.i.142.i to i16
  %call7.i.i.i.144.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143.i) #4
  store i16 30, i16* @curtask, align 2
  %333 = load i8, i8* %normalizable.i.i.i.64.i, align 1
  %tobool8.i.i.i.145.i = trunc i8 %333 to i1
  br i1 %tobool8.i.i.i.145.i, label %if.then.i.3.i.149.i, label %if.else.i.i.168.i

if.then.i.3.i.149.i:                              ; preds = %reduce_normalizable.exit.i.i.146.i
  %334 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %335 = load i16*, i16** %n.addr.i.i.66.i, align 2
  %336 = load i16, i16* %d.i.i.69.i, align 2
  store i16* %334, i16** %m.addr.i.14.i.i.47.i, align 2
  store i16* %335, i16** %n.addr.i.15.i.i.48.i, align 2
  store i16 %336, i16* %digit.addr.i.i.i.49.i, align 2
  store i16 5, i16* @curtask, align 2
  %337 = load i16, i16* %digit.addr.i.i.i.49.i, align 2
  %add.i.20.i.i.147.i = add i16 %337, 1
  %sub.i.21.i.i.148.i = sub i16 %add.i.20.i.i.147.i, 8
  store i16 %sub.i.21.i.i.148.i, i16* %offset.i.19.i.i.56.i, align 2
  store i16 0, i16* %borrow.i.i.i.55.i, align 2
  store i16 0, i16* %i.i.16.i.i.50.i, align 2
  br label %for.cond.i.23.i.i.151.i

for.cond.i.23.i.i.151.i:                          ; preds = %if.end.i.30.i.i.165.i, %if.then.i.3.i.149.i
  %338 = load i16, i16* %i.i.16.i.i.50.i, align 2
  %cmp.i.22.i.i.150.i = icmp slt i16 %338, 8
  br i1 %cmp.i.22.i.i.150.i, label %for.body.i.27.i.i.157.i, label %reduce_normalize.exit.i.i.166.i

for.body.i.27.i.i.157.i:                          ; preds = %for.cond.i.23.i.i.151.i
  store i16 21, i16* @curtask, align 2
  %339 = load i16, i16* %i.i.16.i.i.50.i, align 2
  %340 = load i16, i16* %offset.i.19.i.i.56.i, align 2
  %add1.i.i.i.152.i = add i16 %339, %340
  %341 = load i16*, i16** %m.addr.i.14.i.i.47.i, align 2
  %arrayidx.i.24.i.i.153.i = getelementptr inbounds i16, i16* %341, i16 %add1.i.i.i.152.i
  %342 = load i16, i16* %arrayidx.i.24.i.i.153.i, align 2
  store i16 %342, i16* %m_d.i.17.i.i.53.i, align 2
  %343 = load i16, i16* %i.i.16.i.i.50.i, align 2
  %344 = load i16*, i16** %n.addr.i.15.i.i.48.i, align 2
  %arrayidx2.i.25.i.i.154.i = getelementptr inbounds i16, i16* %344, i16 %343
  %345 = load i16, i16* %arrayidx2.i.25.i.i.154.i, align 2
  store i16 %345, i16* %n_d.i.18.i.i.54.i, align 2
  %346 = load i16, i16* %n_d.i.18.i.i.54.i, align 2
  %347 = load i16, i16* %borrow.i.i.i.55.i, align 2
  %add3.i.i.i.155.i = add i16 %346, %347
  store i16 %add3.i.i.i.155.i, i16* %s.i.i.i.52.i, align 2
  %348 = load i16, i16* %m_d.i.17.i.i.53.i, align 2
  %349 = load i16, i16* %s.i.i.i.52.i, align 2
  %cmp4.i.26.i.i.156.i = icmp ult i16 %348, %349
  br i1 %cmp4.i.26.i.i.156.i, label %if.then.i.28.i.i.159.i, label %if.else.i.29.i.i.160.i

if.then.i.28.i.i.159.i:                           ; preds = %for.body.i.27.i.i.157.i
  %350 = load i16, i16* %m_d.i.17.i.i.53.i, align 2
  %add5.i.i.i.158.i = add i16 %350, 256
  store i16 %add5.i.i.i.158.i, i16* %m_d.i.17.i.i.53.i, align 2
  store i16 1, i16* %borrow.i.i.i.55.i, align 2
  br label %if.end.i.30.i.i.165.i

if.else.i.29.i.i.160.i:                           ; preds = %for.body.i.27.i.i.157.i
  store i16 0, i16* %borrow.i.i.i.55.i, align 2
  br label %if.end.i.30.i.i.165.i

if.end.i.30.i.i.165.i:                            ; preds = %if.else.i.29.i.i.160.i, %if.then.i.28.i.i.159.i
  %351 = load i16, i16* %m_d.i.17.i.i.53.i, align 2
  %352 = load i16, i16* %s.i.i.i.52.i, align 2
  %sub6.i.i.i.161.i = sub i16 %351, %352
  store i16 %sub6.i.i.i.161.i, i16* %d.i.i.i.51.i, align 2
  %353 = load i16, i16* %d.i.i.i.51.i, align 2
  %354 = load i16, i16* %i.i.16.i.i.50.i, align 2
  %355 = load i16, i16* %offset.i.19.i.i.56.i, align 2
  %add7.i.i.i.162.i = add i16 %354, %355
  %356 = load i16*, i16** %m.addr.i.14.i.i.47.i, align 2
  %arrayidx8.i.i.i.163.i = getelementptr inbounds i16, i16* %356, i16 %add7.i.i.i.162.i
  store i16 %353, i16* %arrayidx8.i.i.i.163.i, align 2
  %357 = load i16, i16* %i.i.16.i.i.50.i, align 2
  %inc.i.i.i.164.i = add nsw i16 %357, 1
  store i16 %inc.i.i.i.164.i, i16* %i.i.16.i.i.50.i, align 2
  br label %for.cond.i.23.i.i.151.i

reduce_normalize.exit.i.i.166.i:                  ; preds = %for.cond.i.23.i.i.151.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172.i

if.else.i.i.168.i:                                ; preds = %reduce_normalizable.exit.i.i.146.i
  %358 = load i16, i16* %d.i.i.69.i, align 2
  %cmp4.i.4.i.167.i = icmp eq i16 %358, 7
  br i1 %cmp4.i.4.i.167.i, label %if.then.5.i.i.170.i, label %if.end.i.5.i.171.i

if.then.5.i.i.170.i:                              ; preds = %if.else.i.i.168.i
  %call6.i.i.169.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312.i

if.end.i.5.i.171.i:                               ; preds = %if.else.i.i.168.i
  br label %if.end.7.i.i.172.i

if.end.7.i.i.172.i:                               ; preds = %if.end.i.5.i.171.i, %reduce_normalize.exit.i.i.166.i
  br label %while.cond.i.i.174.i

while.cond.i.i.174.i:                             ; preds = %reduce_subtract.exit.i.i.310.i, %if.end.7.i.i.172.i
  %359 = load i16, i16* %d.i.i.69.i, align 2
  %cmp8.i.i.173.i = icmp uge i16 %359, 8
  br i1 %cmp8.i.i.173.i, label %while.body.i.i.192.i, label %while.end.i.i.311.i

while.body.i.i.192.i:                             ; preds = %while.cond.i.i.174.i
  %360 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %361 = load i16*, i16** %n.addr.i.i.66.i, align 2
  %362 = load i16, i16* %d.i.i.69.i, align 2
  store i16* %q.i.i.67.i, i16** %quotient.addr.i.i.i.36.i, align 2
  store i16* %360, i16** %m.addr.i.31.i.i.37.i, align 2
  store i16* %361, i16** %n.addr.i.32.i.i.38.i, align 2
  store i16 %362, i16* %d.addr.i.33.i.i.39.i, align 2
  store i16 16, i16* @curtask, align 2
  %363 = load i16*, i16** %n.addr.i.32.i.i.38.i, align 2
  %arrayidx.i.35.i.i.175.i = getelementptr inbounds i16, i16* %363, i16 7
  %364 = load i16, i16* %arrayidx.i.35.i.i.175.i, align 2
  %shl.i.i.i.176.i = shl i16 %364, 8
  %365 = load i16*, i16** %n.addr.i.32.i.i.38.i, align 2
  %arrayidx1.i.i.i.177.i = getelementptr inbounds i16, i16* %365, i16 6
  %366 = load i16, i16* %arrayidx1.i.i.i.177.i, align 2
  %add.i.36.i.i.178.i = add i16 %shl.i.i.i.176.i, %366
  store i16 %add.i.36.i.i.178.i, i16* %n_div.i.i.i.42.i, align 2
  %367 = load i16*, i16** %n.addr.i.32.i.i.38.i, align 2
  %arrayidx2.i.37.i.i.179.i = getelementptr inbounds i16, i16* %367, i16 7
  %368 = load i16, i16* %arrayidx2.i.37.i.i.179.i, align 2
  store i16 %368, i16* %n_n.i.i.i.43.i, align 2
  %369 = load i16, i16* %d.addr.i.33.i.i.39.i, align 2
  %370 = load i16*, i16** %m.addr.i.31.i.i.37.i, align 2
  %arrayidx3.i.i.i.180.i = getelementptr inbounds i16, i16* %370, i16 %369
  %371 = load i16, i16* %arrayidx3.i.i.i.180.i, align 2
  %arrayidx4.i.i.i.181.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  store i16 %371, i16* %arrayidx4.i.i.i.181.i, align 2
  %372 = load i16, i16* %d.addr.i.33.i.i.39.i, align 2
  %sub.i.38.i.i.182.i = sub i16 %372, 1
  %373 = load i16*, i16** %m.addr.i.31.i.i.37.i, align 2
  %arrayidx5.i.i.i.183.i = getelementptr inbounds i16, i16* %373, i16 %sub.i.38.i.i.182.i
  %374 = load i16, i16* %arrayidx5.i.i.i.183.i, align 2
  %arrayidx6.i.i.i.184.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  store i16 %374, i16* %arrayidx6.i.i.i.184.i, align 2
  %375 = load i16, i16* %d.addr.i.33.i.i.39.i, align 2
  %sub7.i.i.i.185.i = sub i16 %375, 2
  %376 = load i16*, i16** %m.addr.i.31.i.i.37.i, align 2
  %arrayidx8.i.39.i.i.186.i = getelementptr inbounds i16, i16* %376, i16 %sub7.i.i.i.185.i
  %377 = load i16, i16* %arrayidx8.i.39.i.i.186.i, align 2
  %arrayidx9.i.i.i.187.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  store i16 %377, i16* %arrayidx9.i.i.i.187.i, align 2
  %378 = load i16, i16* %n_n.i.i.i.43.i, align 2
  %379 = load i16*, i16** %m.addr.i.31.i.i.37.i, align 2
  %arrayidx10.i.i.i.188.i = getelementptr inbounds i16, i16* %379, i16 2
  %380 = load i16, i16* %arrayidx10.i.i.i.188.i, align 2
  %call.i.40.i.i.189.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %378, i16 %380) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %381 = load i16, i16* %arrayidx11.i.i.i.190.i, align 2
  %382 = load i16, i16* %n_n.i.i.i.43.i, align 2
  %cmp.i.41.i.i.191.i = icmp eq i16 %381, %382
  br i1 %cmp.i.41.i.i.191.i, label %if.then.i.42.i.i.193.i, label %if.else.i.43.i.i.200.i

if.then.i.42.i.i.193.i:                           ; preds = %while.body.i.i.192.i
  store i16 255, i16* %q.i.i.i.41.i, align 2
  br label %if.end.i.46.i.i.222.i

if.else.i.43.i.i.200.i:                           ; preds = %while.body.i.i.192.i
  %arrayidx12.i.i.i.194.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %383 = load i16, i16* %arrayidx12.i.i.i.194.i, align 2
  %shl13.i.i.i.195.i = shl i16 %383, 8
  %arrayidx14.i.i.i.196.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %384 = load i16, i16* %arrayidx14.i.i.i.196.i, align 2
  %add15.i.i.i.197.i = add i16 %shl13.i.i.i.195.i, %384
  store i16 %add15.i.i.i.197.i, i16* %m_dividend.i.i.i.46.i, align 2
  %385 = load i16, i16* %m_dividend.i.i.i.46.i, align 2
  %386 = load i16, i16* %n_n.i.i.i.43.i, align 2
  %div.i.i.i.198.i = udiv i16 %385, %386
  store i16 %div.i.i.i.198.i, i16* %q.i.i.i.41.i, align 2
  %387 = load i16, i16* %m_dividend.i.i.i.46.i, align 2
  %388 = load i16, i16* %q.i.i.i.41.i, align 2
  %call16.i.i.i.199.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %387, i16 %388) #4
  br label %if.end.i.46.i.i.222.i

if.end.i.46.i.i.222.i:                            ; preds = %if.else.i.43.i.i.200.i, %if.then.i.42.i.i.193.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %389 = load i16, i16* %arrayidx17.i.i.i.201.i, align 2
  %conv.i.44.i.i.202.i = zext i16 %389 to i32
  %shl18.i.i.i.203.i = shl i32 %conv.i.44.i.i.202.i, 16
  %arrayidx19.i.i.i.204.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %390 = load i16, i16* %arrayidx19.i.i.i.204.i, align 2
  %shl20.i.i.i.205.i = shl i16 %390, 8
  %conv21.i.i.i.206.i = zext i16 %shl20.i.i.i.205.i to i32
  %add22.i.i.i.207.i = add i32 %shl18.i.i.i.203.i, %conv21.i.i.i.206.i
  %arrayidx23.i.i.i.208.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %391 = load i16, i16* %arrayidx23.i.i.i.208.i, align 2
  %conv24.i.i.i.209.i = zext i16 %391 to i32
  %add25.i.i.i.210.i = add i32 %add22.i.i.i.207.i, %conv24.i.i.i.209.i
  store i32 %add25.i.i.i.210.i, i32* %n_q.i.i.i.44.i, align 2
  %arrayidx26.i.i.i.211.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %392 = load i16, i16* %arrayidx26.i.i.i.211.i, align 2
  %arrayidx27.i.i.i.212.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %393 = load i16, i16* %arrayidx27.i.i.i.212.i, align 2
  %arrayidx28.i.i.i.213.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %394 = load i16, i16* %arrayidx28.i.i.i.213.i, align 2
  %395 = load i32, i32* %n_q.i.i.i.44.i, align 2
  %shr.i.i.i.214.i = lshr i32 %395, 16
  %and.i.i.i.215.i = and i32 %shr.i.i.i.214.i, 65535
  %conv29.i.i.i.216.i = trunc i32 %and.i.i.i.215.i to i16
  %396 = load i32, i32* %n_q.i.i.i.44.i, align 2
  %and30.i.i.i.217.i = and i32 %396, 65535
  %conv31.i.i.i.218.i = trunc i32 %and30.i.i.i.217.i to i16
  %call32.i.i.i.219.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %392, i16 %393, i16 %394, i16 %conv29.i.i.i.216.i, i16 %conv31.i.i.i.218.i) #4
  %397 = load i16, i16* %q.i.i.i.41.i, align 2
  %call33.i.i.i.220.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %397) #4
  %398 = load i16, i16* %q.i.i.i.41.i, align 2
  %inc.i.45.i.i.221.i = add i16 %398, 1
  store i16 %inc.i.45.i.i.221.i, i16* %q.i.i.i.41.i, align 2
  br label %do.body.i.i.i.232.i

do.body.i.i.i.232.i:                              ; preds = %do.body.i.i.i.232.i, %if.end.i.46.i.i.222.i
  store i16 19, i16* @curtask, align 2
  %399 = load i16, i16* %q.i.i.i.41.i, align 2
  %dec.i.47.i.i.223.i = add i16 %399, -1
  store i16 %dec.i.47.i.i.223.i, i16* %q.i.i.i.41.i, align 2
  %400 = load i16, i16* %n_div.i.i.i.42.i, align 2
  %401 = load i16, i16* %q.i.i.i.41.i, align 2
  %call34.i.i.i.224.i = call i32 @mult16(i16 zeroext %400, i16 zeroext %401) #4
  store i32 %call34.i.i.i.224.i, i32* %qn.i.i.i.45.i, align 2
  %402 = load i16, i16* %q.i.i.i.41.i, align 2
  %403 = load i16, i16* %n_div.i.i.i.42.i, align 2
  %404 = load i32, i32* %qn.i.i.i.45.i, align 2
  %shr35.i.i.i.225.i = lshr i32 %404, 16
  %and36.i.i.i.226.i = and i32 %shr35.i.i.i.225.i, 65535
  %conv37.i.i.i.227.i = trunc i32 %and36.i.i.i.226.i to i16
  %405 = load i32, i32* %qn.i.i.i.45.i, align 2
  %and38.i.i.i.228.i = and i32 %405, 65535
  %conv39.i.i.i.229.i = trunc i32 %and38.i.i.i.228.i to i16
  %call40.i.i.i.230.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %402, i16 %403, i16 %conv37.i.i.i.227.i, i16 %conv39.i.i.i.229.i) #4
  %406 = load i32, i32* %qn.i.i.i.45.i, align 2
  %407 = load i32, i32* %n_q.i.i.i.44.i, align 2
  %cmp41.i.i.i.231.i = icmp ugt i32 %406, %407
  br i1 %cmp41.i.i.i.231.i, label %do.body.i.i.i.232.i, label %reduce_quotient.exit.i.i.236.i

reduce_quotient.exit.i.i.236.i:                   ; preds = %do.body.i.i.i.232.i
  %408 = load i16, i16* %q.i.i.i.41.i, align 2
  %call43.i.i.i.233.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %408) #4
  %409 = load i16, i16* %q.i.i.i.41.i, align 2
  %410 = load i16*, i16** %quotient.addr.i.i.i.36.i, align 2
  store i16 %409, i16* %410, align 2
  store i16 32, i16* @curtask, align 2
  %411 = load i16, i16* %q.i.i.67.i, align 2
  %412 = load i16*, i16** %n.addr.i.i.66.i, align 2
  %413 = load i16, i16* %d.i.i.69.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i.27.i, align 2
  store i16 %411, i16* %q.addr.i.i.i.28.i, align 2
  store i16* %412, i16** %n.addr.i.48.i.i.29.i, align 2
  store i16 %413, i16* %d.addr.i.49.i.i.30.i, align 2
  store i16 9, i16* @curtask, align 2
  %414 = load i16, i16* %d.addr.i.49.i.i.30.i, align 2
  %sub.i.52.i.i.234.i = sub i16 %414, 8
  store i16 %sub.i.52.i.i.234.i, i16* %offset.i.51.i.i.32.i, align 2
  %415 = load i16, i16* %offset.i.51.i.i.32.i, align 2
  %call.i.53.i.i.235.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %415) #4
  store i16 0, i16* %i.i.50.i.i.31.i, align 2
  br label %for.cond.i.55.i.i.238.i

for.cond.i.55.i.i.238.i:                          ; preds = %for.body.i.57.i.i.241.i, %reduce_quotient.exit.i.i.236.i
  %416 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %417 = load i16, i16* %offset.i.51.i.i.32.i, align 2
  %cmp.i.54.i.i.237.i = icmp ult i16 %416, %417
  br i1 %cmp.i.54.i.i.237.i, label %for.body.i.57.i.i.241.i, label %for.end.i.i.i.242.i

for.body.i.57.i.i.241.i:                          ; preds = %for.cond.i.55.i.i.238.i
  %418 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %419 = load i16*, i16** %product.addr.i.i.i.27.i, align 2
  %arrayidx.i.56.i.i.239.i = getelementptr inbounds i16, i16* %419, i16 %418
  store i16 0, i16* %arrayidx.i.56.i.i.239.i, align 2
  %420 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %inc.i.58.i.i.240.i = add nsw i16 %420, 1
  store i16 %inc.i.58.i.i.240.i, i16* %i.i.50.i.i.31.i, align 2
  br label %for.cond.i.55.i.i.238.i

for.end.i.i.i.242.i:                              ; preds = %for.cond.i.55.i.i.238.i
  store i16 0, i16* %c.i.i.i.33.i, align 2
  %421 = load i16, i16* %offset.i.51.i.i.32.i, align 2
  store i16 %421, i16* %i.i.50.i.i.31.i, align 2
  br label %for.cond.1.i.i.i.244.i

for.cond.1.i.i.i.244.i:                           ; preds = %if.end.i.68.i.i.258.i, %for.end.i.i.i.242.i
  %422 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %cmp2.i.i.i.243.i = icmp slt i16 %422, 16
  br i1 %cmp2.i.i.i.243.i, label %for.body.3.i.i.i.247.i, label %reduce_multiply.exit.i.i.259.i

for.body.3.i.i.i.247.i:                           ; preds = %for.cond.1.i.i.i.244.i
  store i16 24, i16* @curtask, align 2
  %423 = load i16, i16* %c.i.i.i.33.i, align 2
  store i16 %423, i16* %p.i.i.i.34.i, align 2
  %424 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %425 = load i16, i16* %offset.i.51.i.i.32.i, align 2
  %add.i.59.i.i.245.i = add i16 %425, 8
  %cmp4.i.60.i.i.246.i = icmp ult i16 %424, %add.i.59.i.i.245.i
  br i1 %cmp4.i.60.i.i.246.i, label %if.then.i.63.i.i.252.i, label %if.else.i.64.i.i.253.i

if.then.i.63.i.i.252.i:                           ; preds = %for.body.3.i.i.i.247.i
  %426 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %427 = load i16, i16* %offset.i.51.i.i.32.i, align 2
  %sub5.i.i.i.248.i = sub i16 %426, %427
  %428 = load i16*, i16** %n.addr.i.48.i.i.29.i, align 2
  %arrayidx6.i.61.i.i.249.i = getelementptr inbounds i16, i16* %428, i16 %sub5.i.i.i.248.i
  %429 = load i16, i16* %arrayidx6.i.61.i.i.249.i, align 2
  store i16 %429, i16* %nd.i.i.i.35.i, align 2
  %430 = load i16, i16* %q.addr.i.i.i.28.i, align 2
  %431 = load i16, i16* %nd.i.i.i.35.i, align 2
  %mul.i.i.i.250.i = mul i16 %430, %431
  %432 = load i16, i16* %p.i.i.i.34.i, align 2
  %add7.i.62.i.i.251.i = add i16 %432, %mul.i.i.i.250.i
  store i16 %add7.i.62.i.i.251.i, i16* %p.i.i.i.34.i, align 2
  br label %if.end.i.68.i.i.258.i

if.else.i.64.i.i.253.i:                           ; preds = %for.body.3.i.i.i.247.i
  store i16 0, i16* %nd.i.i.i.35.i, align 2
  br label %if.end.i.68.i.i.258.i

if.end.i.68.i.i.258.i:                            ; preds = %if.else.i.64.i.i.253.i, %if.then.i.63.i.i.252.i
  %433 = load i16, i16* %p.i.i.i.34.i, align 2
  %shr.i.65.i.i.254.i = lshr i16 %433, 8
  store i16 %shr.i.65.i.i.254.i, i16* %c.i.i.i.33.i, align 2
  %434 = load i16, i16* %p.i.i.i.34.i, align 2
  %and.i.66.i.i.255.i = and i16 %434, 255
  store i16 %and.i.66.i.i.255.i, i16* %p.i.i.i.34.i, align 2
  %435 = load i16, i16* %p.i.i.i.34.i, align 2
  %436 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %437 = load i16*, i16** %product.addr.i.i.i.27.i, align 2
  %arrayidx8.i.67.i.i.256.i = getelementptr inbounds i16, i16* %437, i16 %436
  store i16 %435, i16* %arrayidx8.i.67.i.i.256.i, align 2
  %438 = load i16, i16* %i.i.50.i.i.31.i, align 2
  %inc10.i.i.i.257.i = add nsw i16 %438, 1
  store i16 %inc10.i.i.i.257.i, i16* %i.i.50.i.i.31.i, align 2
  br label %for.cond.1.i.i.i.244.i

reduce_multiply.exit.i.i.259.i:                   ; preds = %for.cond.1.i.i.i.244.i
  store i16 33, i16* @curtask, align 2
  %439 = load i16*, i16** %m.addr.i.i.65.i, align 2
  store i16* %439, i16** %a.addr.i.i.i.23.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i.24.i, align 2
  store i16 0, i16* %relation.i.i.i.26.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i.25.i, align 2
  br label %for.cond.i.71.i.i.261.i

for.cond.i.71.i.i.261.i:                          ; preds = %if.end.i.76.i.i.269.i, %reduce_multiply.exit.i.i.259.i
  %440 = load i16, i16* %i.i.69.i.i.25.i, align 2
  %cmp.i.70.i.i.260.i = icmp sge i16 %440, 0
  br i1 %cmp.i.70.i.i.260.i, label %for.body.i.72.i.i.263.i, label %reduce_compare.exit.i.i.271.i

for.body.i.72.i.i.263.i:                          ; preds = %for.cond.i.71.i.i.261.i
  %441 = load i16*, i16** %a.addr.i.i.i.23.i, align 2
  %442 = load i16*, i16** %b.addr.i.i.i.24.i, align 2
  %cmp1.i.i.i.262.i = icmp ugt i16* %441, %442
  br i1 %cmp1.i.i.i.262.i, label %if.then.i.73.i.i.264.i, label %if.else.i.75.i.i.266.i

if.then.i.73.i.i.264.i:                           ; preds = %for.body.i.72.i.i.263.i
  store i16 1, i16* %relation.i.i.i.26.i, align 2
  br label %reduce_compare.exit.i.i.271.i

if.else.i.75.i.i.266.i:                           ; preds = %for.body.i.72.i.i.263.i
  %443 = load i16*, i16** %a.addr.i.i.i.23.i, align 2
  %444 = load i16*, i16** %b.addr.i.i.i.24.i, align 2
  %cmp2.i.74.i.i.265.i = icmp ult i16* %443, %444
  br i1 %cmp2.i.74.i.i.265.i, label %if.then.3.i.i.i.267.i, label %if.end.i.76.i.i.269.i

if.then.3.i.i.i.267.i:                            ; preds = %if.else.i.75.i.i.266.i
  store i16 -1, i16* %relation.i.i.i.26.i, align 2
  br label %reduce_compare.exit.i.i.271.i

if.end.i.76.i.i.269.i:                            ; preds = %if.else.i.75.i.i.266.i
  %445 = load i16, i16* %i.i.69.i.i.25.i, align 2
  %dec.i.77.i.i.268.i = add nsw i16 %445, -1
  store i16 %dec.i.77.i.i.268.i, i16* %i.i.69.i.i.25.i, align 2
  br label %for.cond.i.71.i.i.261.i

reduce_compare.exit.i.i.271.i:                    ; preds = %if.then.3.i.i.i.267.i, %if.then.i.73.i.i.264.i, %for.cond.i.71.i.i.261.i
  store i16 31, i16* @curtask, align 2
  %446 = load i16, i16* %relation.i.i.i.26.i, align 2
  %cmp10.i.i.270.i = icmp slt i16 %446, 0
  br i1 %cmp10.i.i.270.i, label %if.then.11.i.i.273.i, label %if.end.12.i.i.294.i

if.then.11.i.i.273.i:                             ; preds = %reduce_compare.exit.i.i.271.i
  %447 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %448 = load i16*, i16** %n.addr.i.i.66.i, align 2
  %449 = load i16, i16* %d.i.i.69.i, align 2
  store i16* %447, i16** %a.addr.i.79.i.i.13.i, align 2
  store i16* %448, i16** %b.addr.i.80.i.i.14.i, align 2
  store i16 %449, i16* %d.addr.i.81.i.i.15.i, align 2
  store i16 10, i16* @curtask, align 2
  %450 = load i16, i16* %d.addr.i.81.i.i.15.i, align 2
  %sub.i.85.i.i.272.i = sub i16 %450, 8
  store i16 %sub.i.85.i.i.272.i, i16* %offset.i.83.i.i.18.i, align 2
  store i16 0, i16* %c.i.84.i.i.19.i, align 2
  %451 = load i16, i16* %offset.i.83.i.i.18.i, align 2
  store i16 %451, i16* %i.i.82.i.i.16.i, align 2
  br label %for.cond.i.87.i.i.275.i

for.cond.i.87.i.i.275.i:                          ; preds = %if.end.i.100.i.i.290.i, %if.then.11.i.i.273.i
  %452 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %cmp.i.86.i.i.274.i = icmp slt i16 %452, 16
  br i1 %cmp.i.86.i.i.274.i, label %for.body.i.92.i.i.280.i, label %reduce_add.exit.i.i.291.i

for.body.i.92.i.i.280.i:                          ; preds = %for.cond.i.87.i.i.275.i
  store i16 22, i16* @curtask, align 2
  %453 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %454 = load i16*, i16** %a.addr.i.79.i.i.13.i, align 2
  %arrayidx.i.88.i.i.276.i = getelementptr inbounds i16, i16* %454, i16 %453
  %455 = load i16, i16* %arrayidx.i.88.i.i.276.i, align 2
  store i16 %455, i16* %m.i.i.i.21.i, align 2
  %456 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %457 = load i16, i16* %offset.i.83.i.i.18.i, align 2
  %sub1.i.89.i.i.277.i = sub i16 %456, %457
  store i16 %sub1.i.89.i.i.277.i, i16* %j.i.i.i.17.i, align 2
  %458 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %459 = load i16, i16* %offset.i.83.i.i.18.i, align 2
  %add.i.90.i.i.278.i = add i16 %459, 8
  %cmp2.i.91.i.i.279.i = icmp ult i16 %458, %add.i.90.i.i.278.i
  br i1 %cmp2.i.91.i.i.279.i, label %if.then.i.94.i.i.282.i, label %if.else.i.95.i.i.283.i

if.then.i.94.i.i.282.i:                           ; preds = %for.body.i.92.i.i.280.i
  %460 = load i16, i16* %j.i.i.i.17.i, align 2
  %461 = load i16*, i16** %b.addr.i.80.i.i.14.i, align 2
  %arrayidx3.i.93.i.i.281.i = getelementptr inbounds i16, i16* %461, i16 %460
  %462 = load i16, i16* %arrayidx3.i.93.i.i.281.i, align 2
  store i16 %462, i16* %n.i.i.i.22.i, align 2
  br label %if.end.i.100.i.i.290.i

if.else.i.95.i.i.283.i:                           ; preds = %for.body.i.92.i.i.280.i
  store i16 0, i16* %n.i.i.i.22.i, align 2
  store i16 0, i16* %j.i.i.i.17.i, align 2
  br label %if.end.i.100.i.i.290.i

if.end.i.100.i.i.290.i:                           ; preds = %if.else.i.95.i.i.283.i, %if.then.i.94.i.i.282.i
  %463 = load i16, i16* %c.i.84.i.i.19.i, align 2
  %464 = load i16, i16* %m.i.i.i.21.i, align 2
  %add4.i.i.i.284.i = add i16 %463, %464
  %465 = load i16, i16* %n.i.i.i.22.i, align 2
  %add5.i.96.i.i.285.i = add i16 %add4.i.i.i.284.i, %465
  store i16 %add5.i.96.i.i.285.i, i16* %r.i.i.i.20.i, align 2
  %466 = load i16, i16* %r.i.i.i.20.i, align 2
  %shr.i.97.i.i.286.i = lshr i16 %466, 8
  store i16 %shr.i.97.i.i.286.i, i16* %c.i.84.i.i.19.i, align 2
  %467 = load i16, i16* %r.i.i.i.20.i, align 2
  %and.i.98.i.i.287.i = and i16 %467, 255
  store i16 %and.i.98.i.i.287.i, i16* %r.i.i.i.20.i, align 2
  %468 = load i16, i16* %r.i.i.i.20.i, align 2
  %469 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %470 = load i16*, i16** %a.addr.i.79.i.i.13.i, align 2
  %arrayidx6.i.99.i.i.288.i = getelementptr inbounds i16, i16* %470, i16 %469
  store i16 %468, i16* %arrayidx6.i.99.i.i.288.i, align 2
  %471 = load i16, i16* %i.i.82.i.i.16.i, align 2
  %inc.i.101.i.i.289.i = add nsw i16 %471, 1
  store i16 %inc.i.101.i.i.289.i, i16* %i.i.82.i.i.16.i, align 2
  br label %for.cond.i.87.i.i.275.i

reduce_add.exit.i.i.291.i:                        ; preds = %for.cond.i.87.i.i.275.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294.i

if.end.12.i.i.294.i:                              ; preds = %reduce_add.exit.i.i.291.i, %reduce_compare.exit.i.i.271.i
  %472 = load i16*, i16** %m.addr.i.i.65.i, align 2
  %473 = load i16, i16* %d.i.i.69.i, align 2
  store i16* %472, i16** %a.addr.i.103.i.i.3.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i.4.i, align 2
  store i16 %473, i16* %d.addr.i.105.i.i.5.i, align 2
  store i16 11, i16* @curtask, align 2
  %474 = load i16, i16* %d.addr.i.105.i.i.5.i, align 2
  %sub.i.113.i.i.292.i = sub i16 %474, 8
  store i16 %sub.i.113.i.i.292.i, i16* %offset.i.112.i.i.12.i, align 2
  %475 = load i16, i16* %d.addr.i.105.i.i.5.i, align 2
  %476 = load i16, i16* %offset.i.112.i.i.12.i, align 2
  %call.i.114.i.i.293.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %475, i16 %476) #4
  store i16 0, i16* %borrow.i.111.i.i.11.i, align 2
  %477 = load i16, i16* %offset.i.112.i.i.12.i, align 2
  store i16 %477, i16* %i.i.106.i.i.6.i, align 2
  br label %for.cond.i.116.i.i.296.i

for.cond.i.116.i.i.296.i:                         ; preds = %if.end.i.126.i.i.308.i, %if.end.12.i.i.294.i
  %478 = load i16, i16* %i.i.106.i.i.6.i, align 2
  %cmp.i.115.i.i.295.i = icmp slt i16 %478, 16
  br i1 %cmp.i.115.i.i.295.i, label %for.body.i.121.i.i.301.i, label %reduce_subtract.exit.i.i.310.i

for.body.i.121.i.i.301.i:                         ; preds = %for.cond.i.116.i.i.296.i
  store i16 23, i16* @curtask, align 2
  %479 = load i16, i16* %i.i.106.i.i.6.i, align 2
  %480 = load i16*, i16** %a.addr.i.103.i.i.3.i, align 2
  %arrayidx.i.117.i.i.297.i = getelementptr inbounds i16, i16* %480, i16 %479
  %481 = load i16, i16* %arrayidx.i.117.i.i.297.i, align 2
  store i16 %481, i16* %m.i.107.i.i.7.i, align 2
  %482 = load i16, i16* %i.i.106.i.i.6.i, align 2
  %483 = load i16*, i16** %b.addr.i.104.i.i.4.i, align 2
  %arrayidx1.i.118.i.i.298.i = getelementptr inbounds i16, i16* %483, i16 %482
  %484 = load i16, i16* %arrayidx1.i.118.i.i.298.i, align 2
  store i16 %484, i16* %qn.i.110.i.i.10.i, align 2
  %485 = load i16, i16* %qn.i.110.i.i.10.i, align 2
  %486 = load i16, i16* %borrow.i.111.i.i.11.i, align 2
  %add.i.119.i.i.299.i = add i16 %485, %486
  store i16 %add.i.119.i.i.299.i, i16* %s.i.108.i.i.8.i, align 2
  %487 = load i16, i16* %m.i.107.i.i.7.i, align 2
  %488 = load i16, i16* %s.i.108.i.i.8.i, align 2
  %cmp2.i.120.i.i.300.i = icmp ult i16 %487, %488
  br i1 %cmp2.i.120.i.i.300.i, label %if.then.i.123.i.i.303.i, label %if.else.i.124.i.i.304.i

if.then.i.123.i.i.303.i:                          ; preds = %for.body.i.121.i.i.301.i
  %489 = load i16, i16* %m.i.107.i.i.7.i, align 2
  %add3.i.122.i.i.302.i = add i16 %489, 256
  store i16 %add3.i.122.i.i.302.i, i16* %m.i.107.i.i.7.i, align 2
  store i16 1, i16* %borrow.i.111.i.i.11.i, align 2
  br label %if.end.i.126.i.i.308.i

if.else.i.124.i.i.304.i:                          ; preds = %for.body.i.121.i.i.301.i
  store i16 0, i16* %borrow.i.111.i.i.11.i, align 2
  br label %if.end.i.126.i.i.308.i

if.end.i.126.i.i.308.i:                           ; preds = %if.else.i.124.i.i.304.i, %if.then.i.123.i.i.303.i
  %490 = load i16, i16* %m.i.107.i.i.7.i, align 2
  %491 = load i16, i16* %s.i.108.i.i.8.i, align 2
  %sub4.i.i.i.305.i = sub i16 %490, %491
  store i16 %sub4.i.i.i.305.i, i16* %r.i.109.i.i.9.i, align 2
  %492 = load i16, i16* %r.i.109.i.i.9.i, align 2
  %493 = load i16, i16* %i.i.106.i.i.6.i, align 2
  %494 = load i16*, i16** %a.addr.i.103.i.i.3.i, align 2
  %arrayidx5.i.125.i.i.306.i = getelementptr inbounds i16, i16* %494, i16 %493
  store i16 %492, i16* %arrayidx5.i.125.i.i.306.i, align 2
  %495 = load i16, i16* %i.i.106.i.i.6.i, align 2
  %inc.i.127.i.i.307.i = add nsw i16 %495, 1
  store i16 %inc.i.127.i.i.307.i, i16* %i.i.106.i.i.6.i, align 2
  br label %for.cond.i.116.i.i.296.i

reduce_subtract.exit.i.i.310.i:                   ; preds = %for.cond.i.116.i.i.296.i
  store i16 35, i16* @curtask, align 2
  %496 = load i16, i16* %d.i.i.69.i, align 2
  %dec13.i.i.309.i = add i16 %496, -1
  store i16 %dec13.i.i.309.i, i16* %d.i.i.69.i, align 2
  br label %while.cond.i.i.174.i

while.end.i.i.311.i:                              ; preds = %while.cond.i.i.174.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312.i

mod_mult.exit312.i:                               ; preds = %while.end.i.i.311.i, %if.then.5.i.i.170.i
  %497 = load i16, i16* %e.addr.i, align 2
  %shr.i = lshr i16 %497, 1
  store i16 %shr.i, i16* %e.addr.i, align 2
  br label %while.cond.i

mod_exp.exit:                                     ; preds = %while.cond.i
  store i16 26, i16* @curtask, align 2
  store i16 0, i16* %i, align 2
  br label %for.cond.16

for.cond.16:                                      ; preds = %for.inc.24, %mod_exp.exit
  %498 = load i16, i16* %i, align 2
  %cmp17 = icmp slt i16 %498, 8
  br i1 %cmp17, label %for.body.19, label %for.end.26

for.body.19:                                      ; preds = %for.cond.16
  %499 = load i16, i16* %i, align 2
  %arrayidx20 = getelementptr inbounds [16 x i16], [16 x i16]* @out_block, i16 0, i16 %499
  %500 = load i16, i16* %arrayidx20, align 2
  %conv21 = trunc i16 %500 to i8
  %501 = load i16, i16* %out_block_offset, align 2
  %502 = load i16, i16* %i, align 2
  %add22 = add i16 %501, %502
  %503 = load i8*, i8** %cyphertext.addr, align 2
  %arrayidx23 = getelementptr inbounds i8, i8* %503, i16 %add22
  store i8 %conv21, i8* %arrayidx23, align 1
  br label %for.inc.24

for.inc.24:                                       ; preds = %for.body.19
  %504 = load i16, i16* %i, align 2
  %inc25 = add nsw i16 %504, 1
  store i16 %inc25, i16* %i, align 2
  br label %for.cond.16

for.end.26:                                       ; preds = %for.cond.16
  %505 = load i16, i16* %in_block_offset, align 2
  %add27 = add i16 %505, 7
  store i16 %add27, i16* %in_block_offset, align 2
  %506 = load i16, i16* %out_block_offset, align 2
  %add28 = add i16 %506, 8
  store i16 %add28, i16* %out_block_offset, align 2
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %507 = load i16, i16* %out_block_offset, align 2
  %508 = load i16*, i16** %cyphertext_len.addr, align 2
  store i16 %507, i16* %508, align 2
  store i16 25, i16* @curtask, align 2
  ret void
}

; Function Attrs: nounwind
define void @init() #3 {
entry:
  call void @init_hw()
  call void bitcast (void (...)* @mspconsole_init to void ()*)()
  call void asm sideeffect "eint { nop", ""() #4, !srcloc !1
  %0 = load i16, i16* @curtask, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.20, i32 0, i32 0), i16 %0)
  ret void
}

declare void @mspconsole_init(...) #2

; Function Attrs: nounwind
define i16 @main() #3 {
entry:
  %m.addr.i = alloca i8*, align 2
  %len.addr.i = alloca i16, align 2
  %i.i.3 = alloca i16, align 2
  %j.i = alloca i16, align 2
  %c.i = alloca i8, align 1
  %a.addr.i.103.i.i.3.i.i = alloca i16*, align 2
  %b.addr.i.104.i.i.4.i.i = alloca i16*, align 2
  %d.addr.i.105.i.i.5.i.i = alloca i16, align 2
  %i.i.106.i.i.6.i.i = alloca i16, align 2
  %m.i.107.i.i.7.i.i = alloca i16, align 2
  %s.i.108.i.i.8.i.i = alloca i16, align 2
  %r.i.109.i.i.9.i.i = alloca i16, align 2
  %qn.i.110.i.i.10.i.i = alloca i16, align 2
  %borrow.i.111.i.i.11.i.i = alloca i16, align 2
  %offset.i.112.i.i.12.i.i = alloca i16, align 2
  %a.addr.i.79.i.i.13.i.i = alloca i16*, align 2
  %b.addr.i.80.i.i.14.i.i = alloca i16*, align 2
  %d.addr.i.81.i.i.15.i.i = alloca i16, align 2
  %i.i.82.i.i.16.i.i = alloca i16, align 2
  %j.i.i.i.17.i.i = alloca i16, align 2
  %offset.i.83.i.i.18.i.i = alloca i16, align 2
  %c.i.84.i.i.19.i.i = alloca i16, align 2
  %r.i.i.i.20.i.i = alloca i16, align 2
  %m.i.i.i.21.i.i = alloca i16, align 2
  %n.i.i.i.22.i.i = alloca i16, align 2
  %a.addr.i.i.i.23.i.i = alloca i16*, align 2
  %b.addr.i.i.i.24.i.i = alloca i16*, align 2
  %i.i.69.i.i.25.i.i = alloca i16, align 2
  %relation.i.i.i.26.i.i = alloca i16, align 2
  %product.addr.i.i.i.27.i.i = alloca i16*, align 2
  %q.addr.i.i.i.28.i.i = alloca i16, align 2
  %n.addr.i.48.i.i.29.i.i = alloca i16*, align 2
  %d.addr.i.49.i.i.30.i.i = alloca i16, align 2
  %i.i.50.i.i.31.i.i = alloca i16, align 2
  %offset.i.51.i.i.32.i.i = alloca i16, align 2
  %c.i.i.i.33.i.i = alloca i16, align 2
  %p.i.i.i.34.i.i = alloca i16, align 2
  %nd.i.i.i.35.i.i = alloca i16, align 2
  %quotient.addr.i.i.i.36.i.i = alloca i16*, align 2
  %m.addr.i.31.i.i.37.i.i = alloca i16*, align 2
  %n.addr.i.32.i.i.38.i.i = alloca i16*, align 2
  %d.addr.i.33.i.i.39.i.i = alloca i16, align 2
  %q.i.i.i.41.i.i = alloca i16, align 2
  %n_div.i.i.i.42.i.i = alloca i16, align 2
  %n_n.i.i.i.43.i.i = alloca i16, align 2
  %n_q.i.i.i.44.i.i = alloca i32, align 2
  %qn.i.i.i.45.i.i = alloca i32, align 2
  %m_dividend.i.i.i.46.i.i = alloca i16, align 2
  %m.addr.i.14.i.i.47.i.i = alloca i16*, align 2
  %n.addr.i.15.i.i.48.i.i = alloca i16*, align 2
  %digit.addr.i.i.i.49.i.i = alloca i16, align 2
  %i.i.16.i.i.50.i.i = alloca i16, align 2
  %d.i.i.i.51.i.i = alloca i16, align 2
  %s.i.i.i.52.i.i = alloca i16, align 2
  %m_d.i.17.i.i.53.i.i = alloca i16, align 2
  %n_d.i.18.i.i.54.i.i = alloca i16, align 2
  %borrow.i.i.i.55.i.i = alloca i16, align 2
  %offset.i.19.i.i.56.i.i = alloca i16, align 2
  %m.addr.i.i.i.57.i.i = alloca i16*, align 2
  %n.addr.i.i.i.58.i.i = alloca i16*, align 2
  %d.addr.i.i.i.59.i.i = alloca i16, align 2
  %i.i.i.i.60.i.i = alloca i16, align 2
  %offset.i.i.i.61.i.i = alloca i16, align 2
  %n_d.i.i.i.62.i.i = alloca i16, align 2
  %m_d.i.i.i.63.i.i = alloca i16, align 2
  %normalizable.i.i.i.64.i.i = alloca i8, align 1
  %m.addr.i.i.65.i.i = alloca i16*, align 2
  %n.addr.i.i.66.i.i = alloca i16*, align 2
  %q.i.i.67.i.i = alloca i16, align 2
  %m_d.i.i.68.i.i = alloca i16, align 2
  %d.i.i.69.i.i = alloca i16, align 2
  %a.addr.i.i.70.i.i = alloca i16*, align 2
  %b.addr.i.i.71.i.i = alloca i16*, align 2
  %i.i.i.72.i.i = alloca i16, align 2
  %digit.i.i.73.i.i = alloca i16, align 2
  %p.i.i.74.i.i = alloca i16, align 2
  %c.i.i.75.i.i = alloca i16, align 2
  %dp.i.i.76.i.i = alloca i16, align 2
  %carry.i.i.77.i.i = alloca i16, align 2
  %a.addr.i.78.i.i = alloca i16*, align 2
  %b.addr.i.79.i.i = alloca i16*, align 2
  %n.addr.i.80.i.i = alloca i16*, align 2
  %a.addr.i.103.i.i.i.i = alloca i16*, align 2
  %b.addr.i.104.i.i.i.i = alloca i16*, align 2
  %d.addr.i.105.i.i.i.i = alloca i16, align 2
  %i.i.106.i.i.i.i = alloca i16, align 2
  %m.i.107.i.i.i.i = alloca i16, align 2
  %s.i.108.i.i.i.i = alloca i16, align 2
  %r.i.109.i.i.i.i = alloca i16, align 2
  %qn.i.110.i.i.i.i = alloca i16, align 2
  %borrow.i.111.i.i.i.i = alloca i16, align 2
  %offset.i.112.i.i.i.i = alloca i16, align 2
  %a.addr.i.79.i.i.i.i = alloca i16*, align 2
  %b.addr.i.80.i.i.i.i = alloca i16*, align 2
  %d.addr.i.81.i.i.i.i = alloca i16, align 2
  %i.i.82.i.i.i.i = alloca i16, align 2
  %j.i.i.i.i.i = alloca i16, align 2
  %offset.i.83.i.i.i.i = alloca i16, align 2
  %c.i.84.i.i.i.i = alloca i16, align 2
  %r.i.i.i.i.i = alloca i16, align 2
  %m.i.i.i.i.i = alloca i16, align 2
  %n.i.i.i.i.i = alloca i16, align 2
  %a.addr.i.i.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i.i.i = alloca i16*, align 2
  %i.i.69.i.i.i.i = alloca i16, align 2
  %relation.i.i.i.i.i = alloca i16, align 2
  %product.addr.i.i.i.i.i = alloca i16*, align 2
  %q.addr.i.i.i.i.i = alloca i16, align 2
  %n.addr.i.48.i.i.i.i = alloca i16*, align 2
  %d.addr.i.49.i.i.i.i = alloca i16, align 2
  %i.i.50.i.i.i.i = alloca i16, align 2
  %offset.i.51.i.i.i.i = alloca i16, align 2
  %c.i.i.i.i.i = alloca i16, align 2
  %p.i.i.i.i.i = alloca i16, align 2
  %nd.i.i.i.i.i = alloca i16, align 2
  %quotient.addr.i.i.i.i.i = alloca i16*, align 2
  %m.addr.i.31.i.i.i.i = alloca i16*, align 2
  %n.addr.i.32.i.i.i.i = alloca i16*, align 2
  %d.addr.i.33.i.i.i.i = alloca i16, align 2
  %m_d.i.34.i.i.i.i = alloca [3 x i16], align 2
  %q.i.i.i.i.i = alloca i16, align 2
  %n_div.i.i.i.i.i = alloca i16, align 2
  %n_n.i.i.i.i.i = alloca i16, align 2
  %n_q.i.i.i.i.i = alloca i32, align 2
  %qn.i.i.i.i.i = alloca i32, align 2
  %m_dividend.i.i.i.i.i = alloca i16, align 2
  %m.addr.i.14.i.i.i.i = alloca i16*, align 2
  %n.addr.i.15.i.i.i.i = alloca i16*, align 2
  %digit.addr.i.i.i.i.i = alloca i16, align 2
  %i.i.16.i.i.i.i = alloca i16, align 2
  %d.i.i.i.i.i = alloca i16, align 2
  %s.i.i.i.i.i = alloca i16, align 2
  %m_d.i.17.i.i.i.i = alloca i16, align 2
  %n_d.i.18.i.i.i.i = alloca i16, align 2
  %borrow.i.i.i.i.i = alloca i16, align 2
  %offset.i.19.i.i.i.i = alloca i16, align 2
  %m.addr.i.i.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i.i.i = alloca i16*, align 2
  %d.addr.i.i.i.i.i = alloca i16, align 2
  %i.i.i.i.i.i = alloca i16, align 2
  %offset.i.i.i.i.i = alloca i16, align 2
  %n_d.i.i.i.i.i = alloca i16, align 2
  %m_d.i.i.i.i.i = alloca i16, align 2
  %normalizable.i.i.i.i.i = alloca i8, align 1
  %m.addr.i.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i.i = alloca i16*, align 2
  %q.i.i.i.i = alloca i16, align 2
  %m_d.i.i.i.i = alloca i16, align 2
  %d.i.i.i.i = alloca i16, align 2
  %a.addr.i.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i.i = alloca i16*, align 2
  %i.i.i.i.i = alloca i16, align 2
  %digit.i.i.i.i = alloca i16, align 2
  %p.i.i.i.i = alloca i16, align 2
  %c.i.i.i.i = alloca i16, align 2
  %dp.i.i.i.i = alloca i16, align 2
  %carry.i.i.i.i = alloca i16, align 2
  %a.addr.i.i.i = alloca i16*, align 2
  %b.addr.i.i.i = alloca i16*, align 2
  %n.addr.i.i.i = alloca i16*, align 2
  %out_block.addr.i.i = alloca i16*, align 2
  %base.addr.i.i = alloca i16*, align 2
  %e.addr.i.i = alloca i16, align 2
  %n.addr.i.i = alloca i16*, align 2
  %i.i.i = alloca i16, align 2
  %cyphertext.addr.i = alloca i8*, align 2
  %cyphertext_len.addr.i = alloca i16*, align 2
  %message.addr.i = alloca i8*, align 2
  %message_length.addr.i = alloca i16, align 2
  %k.addr.i = alloca %struct.pubkey_t*, align 2
  %i.i = alloca i16, align 2
  %in_block_offset.i = alloca i16, align 2
  %out_block_offset.i = alloca i16, align 2
  %retval = alloca i16, align 2
  %message_length = alloca i16, align 2
  store i16 0, i16* %retval, align 2
  call void @init()
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  store i16 0, i16* @curtask, align 2
  store i16 11, i16* %message_length, align 2
  %0 = load i16, i16* %message_length, align 2
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @CYPHERTEXT, i32 0, i32 0), i8** %cyphertext.addr.i, align 2
  store i16* @CYPHERTEXT_LEN, i16** %cyphertext_len.addr.i, align 2
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @PLAINTEXT, i32 0, i32 0), i8** %message.addr.i, align 2
  store i16 %0, i16* %message_length.addr.i, align 2
  store %struct.pubkey_t* @pubkey, %struct.pubkey_t** %k.addr.i, align 2
  store i16 0, i16* %in_block_offset.i, align 2
  store i16 0, i16* %out_block_offset.i, align 2
  br label %while.cond.i

while.cond.i:                                     ; preds = %for.end.26.i, %do.body
  %1 = load i16, i16* %in_block_offset.i, align 2
  %2 = load i16, i16* %message_length.addr.i, align 2
  %cmp.i = icmp ult i16 %1, %2
  br i1 %cmp.i, label %while.body.i, label %encrypt.exit

while.body.i:                                     ; preds = %while.cond.i
  store i16 1, i16* @curtask, align 2
  %3 = load i16, i16* %in_block_offset.i, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.19, i32 0, i32 0), i16 %3) #4
  store i16 0, i16* %i.i, align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %cond.end.i, %while.body.i
  %4 = load i16, i16* %i.i, align 2
  %cmp1.i = icmp ult i16 %4, 7
  br i1 %cmp1.i, label %for.body.i, label %for.end.i

for.body.i:                                       ; preds = %for.cond.i
  %5 = load i16, i16* %in_block_offset.i, align 2
  %6 = load i16, i16* %i.i, align 2
  %add.i = add i16 %5, %6
  %7 = load i16, i16* %message_length.addr.i, align 2
  %cmp2.i = icmp ult i16 %add.i, %7
  br i1 %cmp2.i, label %cond.true.i, label %cond.false.i

cond.true.i:                                      ; preds = %for.body.i
  %8 = load i16, i16* %in_block_offset.i, align 2
  %9 = load i16, i16* %i.i, align 2
  %add3.i = add i16 %8, %9
  %10 = load i8*, i8** %message.addr.i, align 2
  %arrayidx.i = getelementptr inbounds i8, i8* %10, i16 %add3.i
  %11 = load i8, i8* %arrayidx.i, align 1
  %conv.i = zext i8 %11 to i16
  br label %cond.end.i

cond.false.i:                                     ; preds = %for.body.i
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %cond.true.i
  %cond.i = phi i16 [ %conv.i, %cond.true.i ], [ 255, %cond.false.i ]
  %12 = load i16, i16* %i.i, align 2
  %arrayidx4.i = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %12
  store i16 %cond.i, i16* %arrayidx4.i, align 2
  %13 = load i16, i16* %i.i, align 2
  %inc.i = add nsw i16 %13, 1
  store i16 %inc.i, i16* %i.i, align 2
  br label %for.cond.i

for.end.i:                                        ; preds = %for.cond.i
  store i16 0, i16* %i.i, align 2
  br label %for.cond.5.i

for.cond.5.i:                                     ; preds = %for.body.8.i, %for.end.i
  %14 = load i16, i16* %i.i, align 2
  %cmp6.i = icmp ult i16 %14, 1
  br i1 %cmp6.i, label %for.body.8.i, label %for.end.15.i

for.body.8.i:                                     ; preds = %for.cond.5.i
  %15 = load i16, i16* %i.i, align 2
  %arrayidx9.i = getelementptr inbounds [1 x i8], [1 x i8]* @PAD_DIGITS, i16 0, i16 %15
  %16 = load i8, i8* %arrayidx9.i, align 1
  %conv10.i = zext i8 %16 to i16
  %17 = load i16, i16* %i.i, align 2
  %add11.i = add i16 7, %17
  %arrayidx12.i = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %add11.i
  store i16 %conv10.i, i16* %arrayidx12.i, align 2
  %18 = load i16, i16* %i.i, align 2
  %inc14.i = add nsw i16 %18, 1
  store i16 %inc14.i, i16* %i.i, align 2
  br label %for.cond.5.i

for.end.15.i:                                     ; preds = %for.cond.5.i
  %19 = load %struct.pubkey_t*, %struct.pubkey_t** %k.addr.i, align 2
  %e.i = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %19, i32 0, i32 1
  %20 = load i16, i16* %e.i, align 2
  %21 = load %struct.pubkey_t*, %struct.pubkey_t** %k.addr.i, align 2
  %n.i = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %21, i32 0, i32 0
  %arraydecay.i = getelementptr inbounds [16 x i16], [16 x i16]* %n.i, i32 0, i32 0
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16** %out_block.addr.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16** %base.addr.i.i, align 2
  store i16 %20, i16* %e.addr.i.i, align 2
  store i16* %arraydecay.i, i16** %n.addr.i.i, align 2
  store i16 2, i16* @curtask, align 2
  %22 = load i16*, i16** %out_block.addr.i.i, align 2
  store i16 1, i16* %22, align 2
  store i16 1, i16* %i.i.i, align 2
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %for.body.i.i, %for.end.15.i
  %23 = load i16, i16* %i.i.i, align 2
  %cmp.i.i = icmp slt i16 %23, 8
  br i1 %cmp.i.i, label %for.body.i.i, label %for.end.i.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  %24 = load i16, i16* %i.i.i, align 2
  %25 = load i16*, i16** %out_block.addr.i.i, align 2
  %arrayidx1.i.i = getelementptr inbounds i16, i16* %25, i16 %24
  store i16 0, i16* %arrayidx1.i.i, align 2
  %26 = load i16, i16* %i.i.i, align 2
  %inc.i.i = add nsw i16 %26, 1
  store i16 %inc.i.i, i16* %i.i.i, align 2
  br label %for.cond.i.i

for.end.i.i:                                      ; preds = %for.cond.i.i
  br label %while.cond.i.i

while.cond.i.i:                                   ; preds = %mod_mult.exit312.i.i, %for.end.i.i
  %27 = load i16, i16* %e.addr.i.i, align 2
  %cmp2.i.i = icmp ugt i16 %27, 0
  br i1 %cmp2.i.i, label %while.body.i.i, label %mod_exp.exit.i

while.body.i.i:                                   ; preds = %while.cond.i.i
  store i16 13, i16* @curtask, align 2
  %28 = load i16, i16* %e.addr.i.i, align 2
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %28) #4
  %29 = load i16, i16* %e.addr.i.i, align 2
  %and.i.i = and i16 %29, 1
  %tobool.i.i = icmp ne i16 %and.i.i, 0
  br i1 %tobool.i.i, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.body.i.i
  %30 = load i16*, i16** %out_block.addr.i.i, align 2
  %31 = load i16*, i16** %base.addr.i.i, align 2
  %32 = load i16*, i16** %n.addr.i.i, align 2
  store i16* %30, i16** %a.addr.i.i.i, align 2
  store i16* %31, i16** %b.addr.i.i.i, align 2
  store i16* %32, i16** %n.addr.i.i.i, align 2
  %33 = load i16*, i16** %a.addr.i.i.i, align 2
  %34 = load i16*, i16** %b.addr.i.i.i, align 2
  store i16* %33, i16** %a.addr.i.i.i.i, align 2
  store i16* %34, i16** %b.addr.i.i.i.i, align 2
  store i16 0, i16* %carry.i.i.i.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i.i.i, align 2
  br label %for.cond.i.i.i.i

for.cond.i.i.i.i:                                 ; preds = %for.end.i.i.i.i, %if.then.i.i
  %35 = load i16, i16* %digit.i.i.i.i, align 2
  %cmp.i.i.i.i = icmp ult i16 %35, 16
  br i1 %cmp.i.i.i.i, label %for.body.i.i.i.i, label %for.end.15.i.i.i.i

for.body.i.i.i.i:                                 ; preds = %for.cond.i.i.i.i
  store i16 14, i16* @curtask, align 2
  %36 = load i16, i16* %carry.i.i.i.i, align 2
  store i16 %36, i16* %p.i.i.i.i, align 2
  store i16 0, i16* %c.i.i.i.i, align 2
  store i16 0, i16* %i.i.i.i.i, align 2
  br label %for.cond.1.i.i.i.i

for.cond.1.i.i.i.i:                               ; preds = %if.end.i.i.i.i, %for.body.i.i.i.i
  %37 = load i16, i16* %i.i.i.i.i, align 2
  %cmp2.i.i.i.i = icmp slt i16 %37, 8
  br i1 %cmp2.i.i.i.i, label %for.body.3.i.i.i.i, label %for.end.i.i.i.i

for.body.3.i.i.i.i:                               ; preds = %for.cond.1.i.i.i.i
  %38 = load i16, i16* %i.i.i.i.i, align 2
  %39 = load i16, i16* %digit.i.i.i.i, align 2
  %cmp4.i.i.i.i = icmp ule i16 %38, %39
  br i1 %cmp4.i.i.i.i, label %land.lhs.true.i.i.i.i, label %if.end.i.i.i.i

land.lhs.true.i.i.i.i:                            ; preds = %for.body.3.i.i.i.i
  %40 = load i16, i16* %digit.i.i.i.i, align 2
  %41 = load i16, i16* %i.i.i.i.i, align 2
  %sub.i.i.i.i = sub i16 %40, %41
  %cmp5.i.i.i.i = icmp ult i16 %sub.i.i.i.i, 8
  br i1 %cmp5.i.i.i.i, label %if.then.i.i.i.i, label %if.end.i.i.i.i

if.then.i.i.i.i:                                  ; preds = %land.lhs.true.i.i.i.i
  %42 = load i16, i16* %digit.i.i.i.i, align 2
  %43 = load i16, i16* %i.i.i.i.i, align 2
  %sub6.i.i.i.i = sub i16 %42, %43
  %44 = load i16*, i16** %a.addr.i.i.i.i, align 2
  %arrayidx.i.i.i.i = getelementptr inbounds i16, i16* %44, i16 %sub6.i.i.i.i
  %45 = load i16, i16* %arrayidx.i.i.i.i, align 2
  %46 = load i16, i16* %i.i.i.i.i, align 2
  %47 = load i16*, i16** %b.addr.i.i.i.i, align 2
  %arrayidx7.i.i.i.i = getelementptr inbounds i16, i16* %47, i16 %46
  %48 = load i16, i16* %arrayidx7.i.i.i.i, align 2
  %mul.i.i.i.i = mul i16 %45, %48
  store i16 %mul.i.i.i.i, i16* %dp.i.i.i.i, align 2
  %49 = load i16, i16* %dp.i.i.i.i, align 2
  %shr.i.i.i.i = lshr i16 %49, 8
  %50 = load i16, i16* %c.i.i.i.i, align 2
  %add.i.i.i.i = add i16 %50, %shr.i.i.i.i
  store i16 %add.i.i.i.i, i16* %c.i.i.i.i, align 2
  %51 = load i16, i16* %dp.i.i.i.i, align 2
  %and.i.i.i.i = and i16 %51, 255
  %52 = load i16, i16* %p.i.i.i.i, align 2
  %add8.i.i.i.i = add i16 %52, %and.i.i.i.i
  store i16 %add8.i.i.i.i, i16* %p.i.i.i.i, align 2
  br label %if.end.i.i.i.i

if.end.i.i.i.i:                                   ; preds = %if.then.i.i.i.i, %land.lhs.true.i.i.i.i, %for.body.3.i.i.i.i
  %53 = load i16, i16* %i.i.i.i.i, align 2
  %inc.i.i.i.i = add nsw i16 %53, 1
  store i16 %inc.i.i.i.i, i16* %i.i.i.i.i, align 2
  br label %for.cond.1.i.i.i.i

for.end.i.i.i.i:                                  ; preds = %for.cond.1.i.i.i.i
  %54 = load i16, i16* %p.i.i.i.i, align 2
  %shr9.i.i.i.i = lshr i16 %54, 8
  %55 = load i16, i16* %c.i.i.i.i, align 2
  %add10.i.i.i.i = add i16 %55, %shr9.i.i.i.i
  store i16 %add10.i.i.i.i, i16* %c.i.i.i.i, align 2
  %56 = load i16, i16* %p.i.i.i.i, align 2
  %and11.i.i.i.i = and i16 %56, 255
  store i16 %and11.i.i.i.i, i16* %p.i.i.i.i, align 2
  %57 = load i16, i16* %p.i.i.i.i, align 2
  %58 = load i16, i16* %digit.i.i.i.i, align 2
  %arrayidx12.i.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %58
  store i16 %57, i16* %arrayidx12.i.i.i.i, align 2
  %59 = load i16, i16* %c.i.i.i.i, align 2
  store i16 %59, i16* %carry.i.i.i.i, align 2
  %60 = load i16, i16* %digit.i.i.i.i, align 2
  %inc14.i.i.i.i = add i16 %60, 1
  store i16 %inc14.i.i.i.i, i16* %digit.i.i.i.i, align 2
  br label %for.cond.i.i.i.i

for.end.15.i.i.i.i:                               ; preds = %for.cond.i.i.i.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i.i.i, align 2
  br label %for.cond.16.i.i.i.i

for.cond.16.i.i.i.i:                              ; preds = %for.body.18.i.i.i.i, %for.end.15.i.i.i.i
  %61 = load i16, i16* %i.i.i.i.i, align 2
  %cmp17.i.i.i.i = icmp slt i16 %61, 16
  br i1 %cmp17.i.i.i.i, label %for.body.18.i.i.i.i, label %mult.exit.i.i.i

for.body.18.i.i.i.i:                              ; preds = %for.cond.16.i.i.i.i
  %62 = load i16, i16* %i.i.i.i.i, align 2
  %arrayidx19.i.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %62
  %63 = load i16, i16* %arrayidx19.i.i.i.i, align 2
  %64 = load i16, i16* %i.i.i.i.i, align 2
  %65 = load i16*, i16** %a.addr.i.i.i.i, align 2
  %arrayidx20.i.i.i.i = getelementptr inbounds i16, i16* %65, i16 %64
  store i16 %63, i16* %arrayidx20.i.i.i.i, align 2
  %66 = load i16, i16* %i.i.i.i.i, align 2
  %inc22.i.i.i.i = add nsw i16 %66, 1
  store i16 %inc22.i.i.i.i, i16* %i.i.i.i.i, align 2
  br label %for.cond.16.i.i.i.i

mult.exit.i.i.i:                                  ; preds = %for.cond.16.i.i.i.i
  store i16 27, i16* @curtask, align 2
  %67 = load i16*, i16** %a.addr.i.i.i, align 2
  %68 = load i16*, i16** %n.addr.i.i.i, align 2
  store i16* %67, i16** %m.addr.i.i.i.i, align 2
  store i16* %68, i16** %n.addr.i.i.i.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i.i.i, align 2
  br label %do.body.i.i.i.i

do.body.i.i.i.i:                                  ; preds = %land.end.i.i.i.i, %mult.exit.i.i.i
  %69 = load i16, i16* %d.i.i.i.i, align 2
  %dec.i.i.i.i = add i16 %69, -1
  store i16 %dec.i.i.i.i, i16* %d.i.i.i.i, align 2
  %70 = load i16, i16* %d.i.i.i.i, align 2
  %71 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %arrayidx.i.1.i.i.i = getelementptr inbounds i16, i16* %71, i16 %70
  %72 = load i16, i16* %arrayidx.i.1.i.i.i, align 2
  store i16 %72, i16* %m_d.i.i.i.i, align 2
  %73 = load i16, i16* %d.i.i.i.i, align 2
  %74 = load i16, i16* %m_d.i.i.i.i, align 2
  %call.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %73, i16 %74) #4
  %75 = load i16, i16* %m_d.i.i.i.i, align 2
  %cmp.i.2.i.i.i = icmp eq i16 %75, 0
  br i1 %cmp.i.2.i.i.i, label %land.rhs.i.i.i.i, label %land.end.i.i.i.i

land.rhs.i.i.i.i:                                 ; preds = %do.body.i.i.i.i
  %76 = load i16, i16* %d.i.i.i.i, align 2
  %cmp1.i.i.i.i = icmp ugt i16 %76, 0
  br label %land.end.i.i.i.i

land.end.i.i.i.i:                                 ; preds = %land.rhs.i.i.i.i, %do.body.i.i.i.i
  %77 = phi i1 [ false, %do.body.i.i.i.i ], [ %cmp1.i.i.i.i, %land.rhs.i.i.i.i ]
  br i1 %77, label %do.body.i.i.i.i, label %do.end.i.i.i.i

do.end.i.i.i.i:                                   ; preds = %land.end.i.i.i.i
  %78 = load i16, i16* %d.i.i.i.i, align 2
  %call2.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %78) #4
  %79 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %80 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %81 = load i16, i16* %d.i.i.i.i, align 2
  store i16* %79, i16** %m.addr.i.i.i.i.i, align 2
  store i16* %80, i16** %n.addr.i.i.i.i.i, align 2
  store i16 %81, i16* %d.addr.i.i.i.i.i, align 2
  store i8 1, i8* %normalizable.i.i.i.i.i, align 1
  store i16 6, i16* @curtask, align 2
  %82 = load i16, i16* %d.addr.i.i.i.i.i, align 2
  %add.i.i.i.i.i = add i16 %82, 1
  %sub.i.i.i.i.i = sub i16 %add.i.i.i.i.i, 8
  store i16 %sub.i.i.i.i.i, i16* %offset.i.i.i.i.i, align 2
  %83 = load i16, i16* %d.addr.i.i.i.i.i, align 2
  %84 = load i16, i16* %offset.i.i.i.i.i, align 2
  %call.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %83, i16 %84) #4
  %85 = load i16, i16* %d.addr.i.i.i.i.i, align 2
  store i16 %85, i16* %i.i.i.i.i.i, align 2
  br label %for.cond.i.i.i.i.i

for.cond.i.i.i.i.i:                               ; preds = %if.end.i.i.i.i.i, %do.end.i.i.i.i
  %86 = load i16, i16* %i.i.i.i.i.i, align 2
  %cmp.i.i.i.i.i = icmp sge i16 %86, 0
  br i1 %cmp.i.i.i.i.i, label %for.body.i.i.i.i.i, label %reduce_normalizable.exit.i.i.i.i

for.body.i.i.i.i.i:                               ; preds = %for.cond.i.i.i.i.i
  %87 = load i16, i16* %i.i.i.i.i.i, align 2
  %88 = load i16*, i16** %m.addr.i.i.i.i.i, align 2
  %arrayidx.i.i.i.i.i = getelementptr inbounds i16, i16* %88, i16 %87
  %89 = load i16, i16* %arrayidx.i.i.i.i.i, align 2
  store i16 %89, i16* %m_d.i.i.i.i.i, align 2
  %90 = load i16, i16* %i.i.i.i.i.i, align 2
  %91 = load i16, i16* %offset.i.i.i.i.i, align 2
  %sub1.i.i.i.i.i = sub i16 %90, %91
  %92 = load i16*, i16** %n.addr.i.i.i.i.i, align 2
  %arrayidx2.i.i.i.i.i = getelementptr inbounds i16, i16* %92, i16 %sub1.i.i.i.i.i
  %93 = load i16, i16* %arrayidx2.i.i.i.i.i, align 2
  store i16 %93, i16* %n_d.i.i.i.i.i, align 2
  %94 = load i16, i16* %m_d.i.i.i.i.i, align 2
  %95 = load i16, i16* %n_d.i.i.i.i.i, align 2
  %cmp3.i.i.i.i.i = icmp ugt i16 %94, %95
  br i1 %cmp3.i.i.i.i.i, label %if.then.i.i.i.i.i, label %if.else.i.i.i.i.i

if.then.i.i.i.i.i:                                ; preds = %for.body.i.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i.i

if.else.i.i.i.i.i:                                ; preds = %for.body.i.i.i.i.i
  %96 = load i16, i16* %m_d.i.i.i.i.i, align 2
  %97 = load i16, i16* %n_d.i.i.i.i.i, align 2
  %cmp4.i.i.i.i.i = icmp ult i16 %96, %97
  br i1 %cmp4.i.i.i.i.i, label %if.then.5.i.i.i.i.i, label %if.end.i.i.i.i.i

if.then.5.i.i.i.i.i:                              ; preds = %if.else.i.i.i.i.i
  store i8 0, i8* %normalizable.i.i.i.i.i, align 1
  br label %reduce_normalizable.exit.i.i.i.i

if.end.i.i.i.i.i:                                 ; preds = %if.else.i.i.i.i.i
  %98 = load i16, i16* %i.i.i.i.i.i, align 2
  %dec.i.i.i.i.i = add nsw i16 %98, -1
  store i16 %dec.i.i.i.i.i, i16* %i.i.i.i.i.i, align 2
  br label %for.cond.i.i.i.i.i

reduce_normalizable.exit.i.i.i.i:                 ; preds = %if.then.5.i.i.i.i.i, %if.then.i.i.i.i.i, %for.cond.i.i.i.i.i
  %99 = load i8, i8* %normalizable.i.i.i.i.i, align 1
  %tobool.i.i.i.i.i = trunc i8 %99 to i1
  %conv.i.i.i.i.i = zext i1 %tobool.i.i.i.i.i to i16
  %call7.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %100 = load i8, i8* %normalizable.i.i.i.i.i, align 1
  %tobool8.i.i.i.i.i = trunc i8 %100 to i1
  br i1 %tobool8.i.i.i.i.i, label %if.then.i.3.i.i.i, label %if.else.i.i.i.i

if.then.i.3.i.i.i:                                ; preds = %reduce_normalizable.exit.i.i.i.i
  %101 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %102 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %103 = load i16, i16* %d.i.i.i.i, align 2
  store i16* %101, i16** %m.addr.i.14.i.i.i.i, align 2
  store i16* %102, i16** %n.addr.i.15.i.i.i.i, align 2
  store i16 %103, i16* %digit.addr.i.i.i.i.i, align 2
  store i16 5, i16* @curtask, align 2
  %104 = load i16, i16* %digit.addr.i.i.i.i.i, align 2
  %add.i.20.i.i.i.i = add i16 %104, 1
  %sub.i.21.i.i.i.i = sub i16 %add.i.20.i.i.i.i, 8
  store i16 %sub.i.21.i.i.i.i, i16* %offset.i.19.i.i.i.i, align 2
  store i16 0, i16* %borrow.i.i.i.i.i, align 2
  store i16 0, i16* %i.i.16.i.i.i.i, align 2
  br label %for.cond.i.23.i.i.i.i

for.cond.i.23.i.i.i.i:                            ; preds = %if.end.i.30.i.i.i.i, %if.then.i.3.i.i.i
  %105 = load i16, i16* %i.i.16.i.i.i.i, align 2
  %cmp.i.22.i.i.i.i = icmp slt i16 %105, 8
  br i1 %cmp.i.22.i.i.i.i, label %for.body.i.27.i.i.i.i, label %reduce_normalize.exit.i.i.i.i

for.body.i.27.i.i.i.i:                            ; preds = %for.cond.i.23.i.i.i.i
  store i16 21, i16* @curtask, align 2
  %106 = load i16, i16* %i.i.16.i.i.i.i, align 2
  %107 = load i16, i16* %offset.i.19.i.i.i.i, align 2
  %add1.i.i.i.i.i = add i16 %106, %107
  %108 = load i16*, i16** %m.addr.i.14.i.i.i.i, align 2
  %arrayidx.i.24.i.i.i.i = getelementptr inbounds i16, i16* %108, i16 %add1.i.i.i.i.i
  %109 = load i16, i16* %arrayidx.i.24.i.i.i.i, align 2
  store i16 %109, i16* %m_d.i.17.i.i.i.i, align 2
  %110 = load i16, i16* %i.i.16.i.i.i.i, align 2
  %111 = load i16*, i16** %n.addr.i.15.i.i.i.i, align 2
  %arrayidx2.i.25.i.i.i.i = getelementptr inbounds i16, i16* %111, i16 %110
  %112 = load i16, i16* %arrayidx2.i.25.i.i.i.i, align 2
  store i16 %112, i16* %n_d.i.18.i.i.i.i, align 2
  %113 = load i16, i16* %n_d.i.18.i.i.i.i, align 2
  %114 = load i16, i16* %borrow.i.i.i.i.i, align 2
  %add3.i.i.i.i.i = add i16 %113, %114
  store i16 %add3.i.i.i.i.i, i16* %s.i.i.i.i.i, align 2
  %115 = load i16, i16* %m_d.i.17.i.i.i.i, align 2
  %116 = load i16, i16* %s.i.i.i.i.i, align 2
  %cmp4.i.26.i.i.i.i = icmp ult i16 %115, %116
  br i1 %cmp4.i.26.i.i.i.i, label %if.then.i.28.i.i.i.i, label %if.else.i.29.i.i.i.i

if.then.i.28.i.i.i.i:                             ; preds = %for.body.i.27.i.i.i.i
  %117 = load i16, i16* %m_d.i.17.i.i.i.i, align 2
  %add5.i.i.i.i.i = add i16 %117, 256
  store i16 %add5.i.i.i.i.i, i16* %m_d.i.17.i.i.i.i, align 2
  store i16 1, i16* %borrow.i.i.i.i.i, align 2
  br label %if.end.i.30.i.i.i.i

if.else.i.29.i.i.i.i:                             ; preds = %for.body.i.27.i.i.i.i
  store i16 0, i16* %borrow.i.i.i.i.i, align 2
  br label %if.end.i.30.i.i.i.i

if.end.i.30.i.i.i.i:                              ; preds = %if.else.i.29.i.i.i.i, %if.then.i.28.i.i.i.i
  %118 = load i16, i16* %m_d.i.17.i.i.i.i, align 2
  %119 = load i16, i16* %s.i.i.i.i.i, align 2
  %sub6.i.i.i.i.i = sub i16 %118, %119
  store i16 %sub6.i.i.i.i.i, i16* %d.i.i.i.i.i, align 2
  %120 = load i16, i16* %d.i.i.i.i.i, align 2
  %121 = load i16, i16* %i.i.16.i.i.i.i, align 2
  %122 = load i16, i16* %offset.i.19.i.i.i.i, align 2
  %add7.i.i.i.i.i = add i16 %121, %122
  %123 = load i16*, i16** %m.addr.i.14.i.i.i.i, align 2
  %arrayidx8.i.i.i.i.i = getelementptr inbounds i16, i16* %123, i16 %add7.i.i.i.i.i
  store i16 %120, i16* %arrayidx8.i.i.i.i.i, align 2
  %124 = load i16, i16* %i.i.16.i.i.i.i, align 2
  %inc.i.i.i.i.i = add nsw i16 %124, 1
  store i16 %inc.i.i.i.i.i, i16* %i.i.16.i.i.i.i, align 2
  br label %for.cond.i.23.i.i.i.i

reduce_normalize.exit.i.i.i.i:                    ; preds = %for.cond.i.23.i.i.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.i.i

if.else.i.i.i.i:                                  ; preds = %reduce_normalizable.exit.i.i.i.i
  %125 = load i16, i16* %d.i.i.i.i, align 2
  %cmp4.i.4.i.i.i = icmp eq i16 %125, 7
  br i1 %cmp4.i.4.i.i.i, label %if.then.5.i.i.i.i, label %if.end.i.5.i.i.i

if.then.5.i.i.i.i:                                ; preds = %if.else.i.i.i.i
  %call6.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit.i.i

if.end.i.5.i.i.i:                                 ; preds = %if.else.i.i.i.i
  br label %if.end.7.i.i.i.i

if.end.7.i.i.i.i:                                 ; preds = %if.end.i.5.i.i.i, %reduce_normalize.exit.i.i.i.i
  br label %while.cond.i.i.i.i

while.cond.i.i.i.i:                               ; preds = %reduce_subtract.exit.i.i.i.i, %if.end.7.i.i.i.i
  %126 = load i16, i16* %d.i.i.i.i, align 2
  %cmp8.i.i.i.i = icmp uge i16 %126, 8
  br i1 %cmp8.i.i.i.i, label %while.body.i.i.i.i, label %while.end.i.i.i.i

while.body.i.i.i.i:                               ; preds = %while.cond.i.i.i.i
  %127 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %128 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %129 = load i16, i16* %d.i.i.i.i, align 2
  store i16* %q.i.i.i.i, i16** %quotient.addr.i.i.i.i.i, align 2
  store i16* %127, i16** %m.addr.i.31.i.i.i.i, align 2
  store i16* %128, i16** %n.addr.i.32.i.i.i.i, align 2
  store i16 %129, i16* %d.addr.i.33.i.i.i.i, align 2
  store i16 16, i16* @curtask, align 2
  %130 = load i16*, i16** %n.addr.i.32.i.i.i.i, align 2
  %arrayidx.i.35.i.i.i.i = getelementptr inbounds i16, i16* %130, i16 7
  %131 = load i16, i16* %arrayidx.i.35.i.i.i.i, align 2
  %shl.i.i.i.i.i = shl i16 %131, 8
  %132 = load i16*, i16** %n.addr.i.32.i.i.i.i, align 2
  %arrayidx1.i.i.i.i.i = getelementptr inbounds i16, i16* %132, i16 6
  %133 = load i16, i16* %arrayidx1.i.i.i.i.i, align 2
  %add.i.36.i.i.i.i = add i16 %shl.i.i.i.i.i, %133
  store i16 %add.i.36.i.i.i.i, i16* %n_div.i.i.i.i.i, align 2
  %134 = load i16*, i16** %n.addr.i.32.i.i.i.i, align 2
  %arrayidx2.i.37.i.i.i.i = getelementptr inbounds i16, i16* %134, i16 7
  %135 = load i16, i16* %arrayidx2.i.37.i.i.i.i, align 2
  store i16 %135, i16* %n_n.i.i.i.i.i, align 2
  %136 = load i16, i16* %d.addr.i.33.i.i.i.i, align 2
  %137 = load i16*, i16** %m.addr.i.31.i.i.i.i, align 2
  %arrayidx3.i.i.i.i.i = getelementptr inbounds i16, i16* %137, i16 %136
  %138 = load i16, i16* %arrayidx3.i.i.i.i.i, align 2
  %arrayidx4.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  store i16 %138, i16* %arrayidx4.i.i.i.i.i, align 2
  %139 = load i16, i16* %d.addr.i.33.i.i.i.i, align 2
  %sub.i.38.i.i.i.i = sub i16 %139, 1
  %140 = load i16*, i16** %m.addr.i.31.i.i.i.i, align 2
  %arrayidx5.i.i.i.i.i = getelementptr inbounds i16, i16* %140, i16 %sub.i.38.i.i.i.i
  %141 = load i16, i16* %arrayidx5.i.i.i.i.i, align 2
  %arrayidx6.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  store i16 %141, i16* %arrayidx6.i.i.i.i.i, align 2
  %142 = load i16, i16* %d.addr.i.33.i.i.i.i, align 2
  %sub7.i.i.i.i.i = sub i16 %142, 2
  %143 = load i16*, i16** %m.addr.i.31.i.i.i.i, align 2
  %arrayidx8.i.39.i.i.i.i = getelementptr inbounds i16, i16* %143, i16 %sub7.i.i.i.i.i
  %144 = load i16, i16* %arrayidx8.i.39.i.i.i.i, align 2
  %arrayidx9.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  store i16 %144, i16* %arrayidx9.i.i.i.i.i, align 2
  %145 = load i16, i16* %n_n.i.i.i.i.i, align 2
  %146 = load i16*, i16** %m.addr.i.31.i.i.i.i, align 2
  %arrayidx10.i.i.i.i.i = getelementptr inbounds i16, i16* %146, i16 2
  %147 = load i16, i16* %arrayidx10.i.i.i.i.i, align 2
  %call.i.40.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %145, i16 %147) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %148 = load i16, i16* %arrayidx11.i.i.i.i.i, align 2
  %149 = load i16, i16* %n_n.i.i.i.i.i, align 2
  %cmp.i.41.i.i.i.i = icmp eq i16 %148, %149
  br i1 %cmp.i.41.i.i.i.i, label %if.then.i.42.i.i.i.i, label %if.else.i.43.i.i.i.i

if.then.i.42.i.i.i.i:                             ; preds = %while.body.i.i.i.i
  store i16 255, i16* %q.i.i.i.i.i, align 2
  br label %if.end.i.46.i.i.i.i

if.else.i.43.i.i.i.i:                             ; preds = %while.body.i.i.i.i
  %arrayidx12.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %150 = load i16, i16* %arrayidx12.i.i.i.i.i, align 2
  %shl13.i.i.i.i.i = shl i16 %150, 8
  %arrayidx14.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %151 = load i16, i16* %arrayidx14.i.i.i.i.i, align 2
  %add15.i.i.i.i.i = add i16 %shl13.i.i.i.i.i, %151
  store i16 %add15.i.i.i.i.i, i16* %m_dividend.i.i.i.i.i, align 2
  %152 = load i16, i16* %m_dividend.i.i.i.i.i, align 2
  %153 = load i16, i16* %n_n.i.i.i.i.i, align 2
  %div.i.i.i.i.i = udiv i16 %152, %153
  store i16 %div.i.i.i.i.i, i16* %q.i.i.i.i.i, align 2
  %154 = load i16, i16* %m_dividend.i.i.i.i.i, align 2
  %155 = load i16, i16* %q.i.i.i.i.i, align 2
  %call16.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %154, i16 %155) #4
  br label %if.end.i.46.i.i.i.i

if.end.i.46.i.i.i.i:                              ; preds = %if.else.i.43.i.i.i.i, %if.then.i.42.i.i.i.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %156 = load i16, i16* %arrayidx17.i.i.i.i.i, align 2
  %conv.i.44.i.i.i.i = zext i16 %156 to i32
  %shl18.i.i.i.i.i = shl i32 %conv.i.44.i.i.i.i, 16
  %arrayidx19.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %157 = load i16, i16* %arrayidx19.i.i.i.i.i, align 2
  %shl20.i.i.i.i.i = shl i16 %157, 8
  %conv21.i.i.i.i.i = zext i16 %shl20.i.i.i.i.i to i32
  %add22.i.i.i.i.i = add i32 %shl18.i.i.i.i.i, %conv21.i.i.i.i.i
  %arrayidx23.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %158 = load i16, i16* %arrayidx23.i.i.i.i.i, align 2
  %conv24.i.i.i.i.i = zext i16 %158 to i32
  %add25.i.i.i.i.i = add i32 %add22.i.i.i.i.i, %conv24.i.i.i.i.i
  store i32 %add25.i.i.i.i.i, i32* %n_q.i.i.i.i.i, align 2
  %arrayidx26.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %159 = load i16, i16* %arrayidx26.i.i.i.i.i, align 2
  %arrayidx27.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %160 = load i16, i16* %arrayidx27.i.i.i.i.i, align 2
  %arrayidx28.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %161 = load i16, i16* %arrayidx28.i.i.i.i.i, align 2
  %162 = load i32, i32* %n_q.i.i.i.i.i, align 2
  %shr.i.i.i.i.i = lshr i32 %162, 16
  %and.i.i.i.i.i = and i32 %shr.i.i.i.i.i, 65535
  %conv29.i.i.i.i.i = trunc i32 %and.i.i.i.i.i to i16
  %163 = load i32, i32* %n_q.i.i.i.i.i, align 2
  %and30.i.i.i.i.i = and i32 %163, 65535
  %conv31.i.i.i.i.i = trunc i32 %and30.i.i.i.i.i to i16
  %call32.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %159, i16 %160, i16 %161, i16 %conv29.i.i.i.i.i, i16 %conv31.i.i.i.i.i) #4
  %164 = load i16, i16* %q.i.i.i.i.i, align 2
  %call33.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %164) #4
  %165 = load i16, i16* %q.i.i.i.i.i, align 2
  %inc.i.45.i.i.i.i = add i16 %165, 1
  store i16 %inc.i.45.i.i.i.i, i16* %q.i.i.i.i.i, align 2
  br label %do.body.i.i.i.i.i

do.body.i.i.i.i.i:                                ; preds = %do.body.i.i.i.i.i, %if.end.i.46.i.i.i.i
  store i16 19, i16* @curtask, align 2
  %166 = load i16, i16* %q.i.i.i.i.i, align 2
  %dec.i.47.i.i.i.i = add i16 %166, -1
  store i16 %dec.i.47.i.i.i.i, i16* %q.i.i.i.i.i, align 2
  %167 = load i16, i16* %n_div.i.i.i.i.i, align 2
  %168 = load i16, i16* %q.i.i.i.i.i, align 2
  %call34.i.i.i.i.i = call i32 @mult16(i16 zeroext %167, i16 zeroext %168) #4
  store i32 %call34.i.i.i.i.i, i32* %qn.i.i.i.i.i, align 2
  %169 = load i16, i16* %q.i.i.i.i.i, align 2
  %170 = load i16, i16* %n_div.i.i.i.i.i, align 2
  %171 = load i32, i32* %qn.i.i.i.i.i, align 2
  %shr35.i.i.i.i.i = lshr i32 %171, 16
  %and36.i.i.i.i.i = and i32 %shr35.i.i.i.i.i, 65535
  %conv37.i.i.i.i.i = trunc i32 %and36.i.i.i.i.i to i16
  %172 = load i32, i32* %qn.i.i.i.i.i, align 2
  %and38.i.i.i.i.i = and i32 %172, 65535
  %conv39.i.i.i.i.i = trunc i32 %and38.i.i.i.i.i to i16
  %call40.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %169, i16 %170, i16 %conv37.i.i.i.i.i, i16 %conv39.i.i.i.i.i) #4
  %173 = load i32, i32* %qn.i.i.i.i.i, align 2
  %174 = load i32, i32* %n_q.i.i.i.i.i, align 2
  %cmp41.i.i.i.i.i = icmp ugt i32 %173, %174
  br i1 %cmp41.i.i.i.i.i, label %do.body.i.i.i.i.i, label %reduce_quotient.exit.i.i.i.i

reduce_quotient.exit.i.i.i.i:                     ; preds = %do.body.i.i.i.i.i
  %175 = load i16, i16* %q.i.i.i.i.i, align 2
  %call43.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %175) #4
  %176 = load i16, i16* %q.i.i.i.i.i, align 2
  %177 = load i16*, i16** %quotient.addr.i.i.i.i.i, align 2
  store i16 %176, i16* %177, align 2
  store i16 32, i16* @curtask, align 2
  %178 = load i16, i16* %q.i.i.i.i, align 2
  %179 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %180 = load i16, i16* %d.i.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i.i.i, align 2
  store i16 %178, i16* %q.addr.i.i.i.i.i, align 2
  store i16* %179, i16** %n.addr.i.48.i.i.i.i, align 2
  store i16 %180, i16* %d.addr.i.49.i.i.i.i, align 2
  store i16 9, i16* @curtask, align 2
  %181 = load i16, i16* %d.addr.i.49.i.i.i.i, align 2
  %sub.i.52.i.i.i.i = sub i16 %181, 8
  store i16 %sub.i.52.i.i.i.i, i16* %offset.i.51.i.i.i.i, align 2
  %182 = load i16, i16* %offset.i.51.i.i.i.i, align 2
  %call.i.53.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %182) #4
  store i16 0, i16* %i.i.50.i.i.i.i, align 2
  br label %for.cond.i.55.i.i.i.i

for.cond.i.55.i.i.i.i:                            ; preds = %for.body.i.57.i.i.i.i, %reduce_quotient.exit.i.i.i.i
  %183 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %184 = load i16, i16* %offset.i.51.i.i.i.i, align 2
  %cmp.i.54.i.i.i.i = icmp ult i16 %183, %184
  br i1 %cmp.i.54.i.i.i.i, label %for.body.i.57.i.i.i.i, label %for.end.i.i.i.i.i

for.body.i.57.i.i.i.i:                            ; preds = %for.cond.i.55.i.i.i.i
  %185 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %186 = load i16*, i16** %product.addr.i.i.i.i.i, align 2
  %arrayidx.i.56.i.i.i.i = getelementptr inbounds i16, i16* %186, i16 %185
  store i16 0, i16* %arrayidx.i.56.i.i.i.i, align 2
  %187 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %inc.i.58.i.i.i.i = add nsw i16 %187, 1
  store i16 %inc.i.58.i.i.i.i, i16* %i.i.50.i.i.i.i, align 2
  br label %for.cond.i.55.i.i.i.i

for.end.i.i.i.i.i:                                ; preds = %for.cond.i.55.i.i.i.i
  store i16 0, i16* %c.i.i.i.i.i, align 2
  %188 = load i16, i16* %offset.i.51.i.i.i.i, align 2
  store i16 %188, i16* %i.i.50.i.i.i.i, align 2
  br label %for.cond.1.i.i.i.i.i

for.cond.1.i.i.i.i.i:                             ; preds = %if.end.i.68.i.i.i.i, %for.end.i.i.i.i.i
  %189 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %cmp2.i.i.i.i.i = icmp slt i16 %189, 16
  br i1 %cmp2.i.i.i.i.i, label %for.body.3.i.i.i.i.i, label %reduce_multiply.exit.i.i.i.i

for.body.3.i.i.i.i.i:                             ; preds = %for.cond.1.i.i.i.i.i
  store i16 24, i16* @curtask, align 2
  %190 = load i16, i16* %c.i.i.i.i.i, align 2
  store i16 %190, i16* %p.i.i.i.i.i, align 2
  %191 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %192 = load i16, i16* %offset.i.51.i.i.i.i, align 2
  %add.i.59.i.i.i.i = add i16 %192, 8
  %cmp4.i.60.i.i.i.i = icmp ult i16 %191, %add.i.59.i.i.i.i
  br i1 %cmp4.i.60.i.i.i.i, label %if.then.i.63.i.i.i.i, label %if.else.i.64.i.i.i.i

if.then.i.63.i.i.i.i:                             ; preds = %for.body.3.i.i.i.i.i
  %193 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %194 = load i16, i16* %offset.i.51.i.i.i.i, align 2
  %sub5.i.i.i.i.i = sub i16 %193, %194
  %195 = load i16*, i16** %n.addr.i.48.i.i.i.i, align 2
  %arrayidx6.i.61.i.i.i.i = getelementptr inbounds i16, i16* %195, i16 %sub5.i.i.i.i.i
  %196 = load i16, i16* %arrayidx6.i.61.i.i.i.i, align 2
  store i16 %196, i16* %nd.i.i.i.i.i, align 2
  %197 = load i16, i16* %q.addr.i.i.i.i.i, align 2
  %198 = load i16, i16* %nd.i.i.i.i.i, align 2
  %mul.i.i.i.i.i = mul i16 %197, %198
  %199 = load i16, i16* %p.i.i.i.i.i, align 2
  %add7.i.62.i.i.i.i = add i16 %199, %mul.i.i.i.i.i
  store i16 %add7.i.62.i.i.i.i, i16* %p.i.i.i.i.i, align 2
  br label %if.end.i.68.i.i.i.i

if.else.i.64.i.i.i.i:                             ; preds = %for.body.3.i.i.i.i.i
  store i16 0, i16* %nd.i.i.i.i.i, align 2
  br label %if.end.i.68.i.i.i.i

if.end.i.68.i.i.i.i:                              ; preds = %if.else.i.64.i.i.i.i, %if.then.i.63.i.i.i.i
  %200 = load i16, i16* %p.i.i.i.i.i, align 2
  %shr.i.65.i.i.i.i = lshr i16 %200, 8
  store i16 %shr.i.65.i.i.i.i, i16* %c.i.i.i.i.i, align 2
  %201 = load i16, i16* %p.i.i.i.i.i, align 2
  %and.i.66.i.i.i.i = and i16 %201, 255
  store i16 %and.i.66.i.i.i.i, i16* %p.i.i.i.i.i, align 2
  %202 = load i16, i16* %p.i.i.i.i.i, align 2
  %203 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %204 = load i16*, i16** %product.addr.i.i.i.i.i, align 2
  %arrayidx8.i.67.i.i.i.i = getelementptr inbounds i16, i16* %204, i16 %203
  store i16 %202, i16* %arrayidx8.i.67.i.i.i.i, align 2
  %205 = load i16, i16* %i.i.50.i.i.i.i, align 2
  %inc10.i.i.i.i.i = add nsw i16 %205, 1
  store i16 %inc10.i.i.i.i.i, i16* %i.i.50.i.i.i.i, align 2
  br label %for.cond.1.i.i.i.i.i

reduce_multiply.exit.i.i.i.i:                     ; preds = %for.cond.1.i.i.i.i.i
  store i16 33, i16* @curtask, align 2
  %206 = load i16*, i16** %m.addr.i.i.i.i, align 2
  store i16* %206, i16** %a.addr.i.i.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i.i.i, align 2
  store i16 0, i16* %relation.i.i.i.i.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i.i.i, align 2
  br label %for.cond.i.71.i.i.i.i

for.cond.i.71.i.i.i.i:                            ; preds = %if.end.i.76.i.i.i.i, %reduce_multiply.exit.i.i.i.i
  %207 = load i16, i16* %i.i.69.i.i.i.i, align 2
  %cmp.i.70.i.i.i.i = icmp sge i16 %207, 0
  br i1 %cmp.i.70.i.i.i.i, label %for.body.i.72.i.i.i.i, label %reduce_compare.exit.i.i.i.i

for.body.i.72.i.i.i.i:                            ; preds = %for.cond.i.71.i.i.i.i
  %208 = load i16*, i16** %a.addr.i.i.i.i.i, align 2
  %209 = load i16*, i16** %b.addr.i.i.i.i.i, align 2
  %cmp1.i.i.i.i.i = icmp ugt i16* %208, %209
  br i1 %cmp1.i.i.i.i.i, label %if.then.i.73.i.i.i.i, label %if.else.i.75.i.i.i.i

if.then.i.73.i.i.i.i:                             ; preds = %for.body.i.72.i.i.i.i
  store i16 1, i16* %relation.i.i.i.i.i, align 2
  br label %reduce_compare.exit.i.i.i.i

if.else.i.75.i.i.i.i:                             ; preds = %for.body.i.72.i.i.i.i
  %210 = load i16*, i16** %a.addr.i.i.i.i.i, align 2
  %211 = load i16*, i16** %b.addr.i.i.i.i.i, align 2
  %cmp2.i.74.i.i.i.i = icmp ult i16* %210, %211
  br i1 %cmp2.i.74.i.i.i.i, label %if.then.3.i.i.i.i.i, label %if.end.i.76.i.i.i.i

if.then.3.i.i.i.i.i:                              ; preds = %if.else.i.75.i.i.i.i
  store i16 -1, i16* %relation.i.i.i.i.i, align 2
  br label %reduce_compare.exit.i.i.i.i

if.end.i.76.i.i.i.i:                              ; preds = %if.else.i.75.i.i.i.i
  %212 = load i16, i16* %i.i.69.i.i.i.i, align 2
  %dec.i.77.i.i.i.i = add nsw i16 %212, -1
  store i16 %dec.i.77.i.i.i.i, i16* %i.i.69.i.i.i.i, align 2
  br label %for.cond.i.71.i.i.i.i

reduce_compare.exit.i.i.i.i:                      ; preds = %if.then.3.i.i.i.i.i, %if.then.i.73.i.i.i.i, %for.cond.i.71.i.i.i.i
  store i16 31, i16* @curtask, align 2
  %213 = load i16, i16* %relation.i.i.i.i.i, align 2
  %cmp10.i.i.i.i = icmp slt i16 %213, 0
  br i1 %cmp10.i.i.i.i, label %if.then.11.i.i.i.i, label %if.end.12.i.i.i.i

if.then.11.i.i.i.i:                               ; preds = %reduce_compare.exit.i.i.i.i
  %214 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %215 = load i16*, i16** %n.addr.i.i.i.i, align 2
  %216 = load i16, i16* %d.i.i.i.i, align 2
  store i16* %214, i16** %a.addr.i.79.i.i.i.i, align 2
  store i16* %215, i16** %b.addr.i.80.i.i.i.i, align 2
  store i16 %216, i16* %d.addr.i.81.i.i.i.i, align 2
  store i16 10, i16* @curtask, align 2
  %217 = load i16, i16* %d.addr.i.81.i.i.i.i, align 2
  %sub.i.85.i.i.i.i = sub i16 %217, 8
  store i16 %sub.i.85.i.i.i.i, i16* %offset.i.83.i.i.i.i, align 2
  store i16 0, i16* %c.i.84.i.i.i.i, align 2
  %218 = load i16, i16* %offset.i.83.i.i.i.i, align 2
  store i16 %218, i16* %i.i.82.i.i.i.i, align 2
  br label %for.cond.i.87.i.i.i.i

for.cond.i.87.i.i.i.i:                            ; preds = %if.end.i.100.i.i.i.i, %if.then.11.i.i.i.i
  %219 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %cmp.i.86.i.i.i.i = icmp slt i16 %219, 16
  br i1 %cmp.i.86.i.i.i.i, label %for.body.i.92.i.i.i.i, label %reduce_add.exit.i.i.i.i

for.body.i.92.i.i.i.i:                            ; preds = %for.cond.i.87.i.i.i.i
  store i16 22, i16* @curtask, align 2
  %220 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %221 = load i16*, i16** %a.addr.i.79.i.i.i.i, align 2
  %arrayidx.i.88.i.i.i.i = getelementptr inbounds i16, i16* %221, i16 %220
  %222 = load i16, i16* %arrayidx.i.88.i.i.i.i, align 2
  store i16 %222, i16* %m.i.i.i.i.i, align 2
  %223 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %224 = load i16, i16* %offset.i.83.i.i.i.i, align 2
  %sub1.i.89.i.i.i.i = sub i16 %223, %224
  store i16 %sub1.i.89.i.i.i.i, i16* %j.i.i.i.i.i, align 2
  %225 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %226 = load i16, i16* %offset.i.83.i.i.i.i, align 2
  %add.i.90.i.i.i.i = add i16 %226, 8
  %cmp2.i.91.i.i.i.i = icmp ult i16 %225, %add.i.90.i.i.i.i
  br i1 %cmp2.i.91.i.i.i.i, label %if.then.i.94.i.i.i.i, label %if.else.i.95.i.i.i.i

if.then.i.94.i.i.i.i:                             ; preds = %for.body.i.92.i.i.i.i
  %227 = load i16, i16* %j.i.i.i.i.i, align 2
  %228 = load i16*, i16** %b.addr.i.80.i.i.i.i, align 2
  %arrayidx3.i.93.i.i.i.i = getelementptr inbounds i16, i16* %228, i16 %227
  %229 = load i16, i16* %arrayidx3.i.93.i.i.i.i, align 2
  store i16 %229, i16* %n.i.i.i.i.i, align 2
  br label %if.end.i.100.i.i.i.i

if.else.i.95.i.i.i.i:                             ; preds = %for.body.i.92.i.i.i.i
  store i16 0, i16* %n.i.i.i.i.i, align 2
  store i16 0, i16* %j.i.i.i.i.i, align 2
  br label %if.end.i.100.i.i.i.i

if.end.i.100.i.i.i.i:                             ; preds = %if.else.i.95.i.i.i.i, %if.then.i.94.i.i.i.i
  %230 = load i16, i16* %c.i.84.i.i.i.i, align 2
  %231 = load i16, i16* %m.i.i.i.i.i, align 2
  %add4.i.i.i.i.i = add i16 %230, %231
  %232 = load i16, i16* %n.i.i.i.i.i, align 2
  %add5.i.96.i.i.i.i = add i16 %add4.i.i.i.i.i, %232
  store i16 %add5.i.96.i.i.i.i, i16* %r.i.i.i.i.i, align 2
  %233 = load i16, i16* %r.i.i.i.i.i, align 2
  %shr.i.97.i.i.i.i = lshr i16 %233, 8
  store i16 %shr.i.97.i.i.i.i, i16* %c.i.84.i.i.i.i, align 2
  %234 = load i16, i16* %r.i.i.i.i.i, align 2
  %and.i.98.i.i.i.i = and i16 %234, 255
  store i16 %and.i.98.i.i.i.i, i16* %r.i.i.i.i.i, align 2
  %235 = load i16, i16* %r.i.i.i.i.i, align 2
  %236 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %237 = load i16*, i16** %a.addr.i.79.i.i.i.i, align 2
  %arrayidx6.i.99.i.i.i.i = getelementptr inbounds i16, i16* %237, i16 %236
  store i16 %235, i16* %arrayidx6.i.99.i.i.i.i, align 2
  %238 = load i16, i16* %i.i.82.i.i.i.i, align 2
  %inc.i.101.i.i.i.i = add nsw i16 %238, 1
  store i16 %inc.i.101.i.i.i.i, i16* %i.i.82.i.i.i.i, align 2
  br label %for.cond.i.87.i.i.i.i

reduce_add.exit.i.i.i.i:                          ; preds = %for.cond.i.87.i.i.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.i.i

if.end.12.i.i.i.i:                                ; preds = %reduce_add.exit.i.i.i.i, %reduce_compare.exit.i.i.i.i
  %239 = load i16*, i16** %m.addr.i.i.i.i, align 2
  %240 = load i16, i16* %d.i.i.i.i, align 2
  store i16* %239, i16** %a.addr.i.103.i.i.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i.i.i, align 2
  store i16 %240, i16* %d.addr.i.105.i.i.i.i, align 2
  store i16 11, i16* @curtask, align 2
  %241 = load i16, i16* %d.addr.i.105.i.i.i.i, align 2
  %sub.i.113.i.i.i.i = sub i16 %241, 8
  store i16 %sub.i.113.i.i.i.i, i16* %offset.i.112.i.i.i.i, align 2
  %242 = load i16, i16* %d.addr.i.105.i.i.i.i, align 2
  %243 = load i16, i16* %offset.i.112.i.i.i.i, align 2
  %call.i.114.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %242, i16 %243) #4
  store i16 0, i16* %borrow.i.111.i.i.i.i, align 2
  %244 = load i16, i16* %offset.i.112.i.i.i.i, align 2
  store i16 %244, i16* %i.i.106.i.i.i.i, align 2
  br label %for.cond.i.116.i.i.i.i

for.cond.i.116.i.i.i.i:                           ; preds = %if.end.i.126.i.i.i.i, %if.end.12.i.i.i.i
  %245 = load i16, i16* %i.i.106.i.i.i.i, align 2
  %cmp.i.115.i.i.i.i = icmp slt i16 %245, 16
  br i1 %cmp.i.115.i.i.i.i, label %for.body.i.121.i.i.i.i, label %reduce_subtract.exit.i.i.i.i

for.body.i.121.i.i.i.i:                           ; preds = %for.cond.i.116.i.i.i.i
  store i16 23, i16* @curtask, align 2
  %246 = load i16, i16* %i.i.106.i.i.i.i, align 2
  %247 = load i16*, i16** %a.addr.i.103.i.i.i.i, align 2
  %arrayidx.i.117.i.i.i.i = getelementptr inbounds i16, i16* %247, i16 %246
  %248 = load i16, i16* %arrayidx.i.117.i.i.i.i, align 2
  store i16 %248, i16* %m.i.107.i.i.i.i, align 2
  %249 = load i16, i16* %i.i.106.i.i.i.i, align 2
  %250 = load i16*, i16** %b.addr.i.104.i.i.i.i, align 2
  %arrayidx1.i.118.i.i.i.i = getelementptr inbounds i16, i16* %250, i16 %249
  %251 = load i16, i16* %arrayidx1.i.118.i.i.i.i, align 2
  store i16 %251, i16* %qn.i.110.i.i.i.i, align 2
  %252 = load i16, i16* %qn.i.110.i.i.i.i, align 2
  %253 = load i16, i16* %borrow.i.111.i.i.i.i, align 2
  %add.i.119.i.i.i.i = add i16 %252, %253
  store i16 %add.i.119.i.i.i.i, i16* %s.i.108.i.i.i.i, align 2
  %254 = load i16, i16* %m.i.107.i.i.i.i, align 2
  %255 = load i16, i16* %s.i.108.i.i.i.i, align 2
  %cmp2.i.120.i.i.i.i = icmp ult i16 %254, %255
  br i1 %cmp2.i.120.i.i.i.i, label %if.then.i.123.i.i.i.i, label %if.else.i.124.i.i.i.i

if.then.i.123.i.i.i.i:                            ; preds = %for.body.i.121.i.i.i.i
  %256 = load i16, i16* %m.i.107.i.i.i.i, align 2
  %add3.i.122.i.i.i.i = add i16 %256, 256
  store i16 %add3.i.122.i.i.i.i, i16* %m.i.107.i.i.i.i, align 2
  store i16 1, i16* %borrow.i.111.i.i.i.i, align 2
  br label %if.end.i.126.i.i.i.i

if.else.i.124.i.i.i.i:                            ; preds = %for.body.i.121.i.i.i.i
  store i16 0, i16* %borrow.i.111.i.i.i.i, align 2
  br label %if.end.i.126.i.i.i.i

if.end.i.126.i.i.i.i:                             ; preds = %if.else.i.124.i.i.i.i, %if.then.i.123.i.i.i.i
  %257 = load i16, i16* %m.i.107.i.i.i.i, align 2
  %258 = load i16, i16* %s.i.108.i.i.i.i, align 2
  %sub4.i.i.i.i.i = sub i16 %257, %258
  store i16 %sub4.i.i.i.i.i, i16* %r.i.109.i.i.i.i, align 2
  %259 = load i16, i16* %r.i.109.i.i.i.i, align 2
  %260 = load i16, i16* %i.i.106.i.i.i.i, align 2
  %261 = load i16*, i16** %a.addr.i.103.i.i.i.i, align 2
  %arrayidx5.i.125.i.i.i.i = getelementptr inbounds i16, i16* %261, i16 %260
  store i16 %259, i16* %arrayidx5.i.125.i.i.i.i, align 2
  %262 = load i16, i16* %i.i.106.i.i.i.i, align 2
  %inc.i.127.i.i.i.i = add nsw i16 %262, 1
  store i16 %inc.i.127.i.i.i.i, i16* %i.i.106.i.i.i.i, align 2
  br label %for.cond.i.116.i.i.i.i

reduce_subtract.exit.i.i.i.i:                     ; preds = %for.cond.i.116.i.i.i.i
  store i16 35, i16* @curtask, align 2
  %263 = load i16, i16* %d.i.i.i.i, align 2
  %dec13.i.i.i.i = add i16 %263, -1
  store i16 %dec13.i.i.i.i, i16* %d.i.i.i.i, align 2
  br label %while.cond.i.i.i.i

while.end.i.i.i.i:                                ; preds = %while.cond.i.i.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit.i.i

mod_mult.exit.i.i:                                ; preds = %while.end.i.i.i.i, %if.then.5.i.i.i.i
  br label %if.end.i.i

if.end.i.i:                                       ; preds = %mod_mult.exit.i.i, %while.body.i.i
  %264 = load i16*, i16** %base.addr.i.i, align 2
  %265 = load i16*, i16** %base.addr.i.i, align 2
  %266 = load i16*, i16** %n.addr.i.i, align 2
  store i16* %264, i16** %a.addr.i.78.i.i, align 2
  store i16* %265, i16** %b.addr.i.79.i.i, align 2
  store i16* %266, i16** %n.addr.i.80.i.i, align 2
  %267 = load i16*, i16** %a.addr.i.78.i.i, align 2
  %268 = load i16*, i16** %b.addr.i.79.i.i, align 2
  store i16* %267, i16** %a.addr.i.i.70.i.i, align 2
  store i16* %268, i16** %b.addr.i.i.71.i.i, align 2
  store i16 0, i16* %carry.i.i.77.i.i, align 2
  store i16 3, i16* @curtask, align 2
  store i16 0, i16* %digit.i.i.73.i.i, align 2
  br label %for.cond.i.i.82.i.i

for.cond.i.i.82.i.i:                              ; preds = %for.end.i.i.107.i.i, %if.end.i.i
  %269 = load i16, i16* %digit.i.i.73.i.i, align 2
  %cmp.i.i.81.i.i = icmp ult i16 %269, 16
  br i1 %cmp.i.i.81.i.i, label %for.body.i.i.83.i.i, label %for.end.15.i.i.108.i.i

for.body.i.i.83.i.i:                              ; preds = %for.cond.i.i.82.i.i
  store i16 14, i16* @curtask, align 2
  %270 = load i16, i16* %carry.i.i.77.i.i, align 2
  store i16 %270, i16* %p.i.i.74.i.i, align 2
  store i16 0, i16* %c.i.i.75.i.i, align 2
  store i16 0, i16* %i.i.i.72.i.i, align 2
  br label %for.cond.1.i.i.85.i.i

for.cond.1.i.i.85.i.i:                            ; preds = %if.end.i.i.101.i.i, %for.body.i.i.83.i.i
  %271 = load i16, i16* %i.i.i.72.i.i, align 2
  %cmp2.i.i.84.i.i = icmp slt i16 %271, 8
  br i1 %cmp2.i.i.84.i.i, label %for.body.3.i.i.87.i.i, label %for.end.i.i.107.i.i

for.body.3.i.i.87.i.i:                            ; preds = %for.cond.1.i.i.85.i.i
  %272 = load i16, i16* %i.i.i.72.i.i, align 2
  %273 = load i16, i16* %digit.i.i.73.i.i, align 2
  %cmp4.i.i.86.i.i = icmp ule i16 %272, %273
  br i1 %cmp4.i.i.86.i.i, label %land.lhs.true.i.i.90.i.i, label %if.end.i.i.101.i.i

land.lhs.true.i.i.90.i.i:                         ; preds = %for.body.3.i.i.87.i.i
  %274 = load i16, i16* %digit.i.i.73.i.i, align 2
  %275 = load i16, i16* %i.i.i.72.i.i, align 2
  %sub.i.i.88.i.i = sub i16 %274, %275
  %cmp5.i.i.89.i.i = icmp ult i16 %sub.i.i.88.i.i, 8
  br i1 %cmp5.i.i.89.i.i, label %if.then.i.i.99.i.i, label %if.end.i.i.101.i.i

if.then.i.i.99.i.i:                               ; preds = %land.lhs.true.i.i.90.i.i
  %276 = load i16, i16* %digit.i.i.73.i.i, align 2
  %277 = load i16, i16* %i.i.i.72.i.i, align 2
  %sub6.i.i.91.i.i = sub i16 %276, %277
  %278 = load i16*, i16** %a.addr.i.i.70.i.i, align 2
  %arrayidx.i.i.92.i.i = getelementptr inbounds i16, i16* %278, i16 %sub6.i.i.91.i.i
  %279 = load i16, i16* %arrayidx.i.i.92.i.i, align 2
  %280 = load i16, i16* %i.i.i.72.i.i, align 2
  %281 = load i16*, i16** %b.addr.i.i.71.i.i, align 2
  %arrayidx7.i.i.93.i.i = getelementptr inbounds i16, i16* %281, i16 %280
  %282 = load i16, i16* %arrayidx7.i.i.93.i.i, align 2
  %mul.i.i.94.i.i = mul i16 %279, %282
  store i16 %mul.i.i.94.i.i, i16* %dp.i.i.76.i.i, align 2
  %283 = load i16, i16* %dp.i.i.76.i.i, align 2
  %shr.i.i.95.i.i = lshr i16 %283, 8
  %284 = load i16, i16* %c.i.i.75.i.i, align 2
  %add.i.i.96.i.i = add i16 %284, %shr.i.i.95.i.i
  store i16 %add.i.i.96.i.i, i16* %c.i.i.75.i.i, align 2
  %285 = load i16, i16* %dp.i.i.76.i.i, align 2
  %and.i.i.97.i.i = and i16 %285, 255
  %286 = load i16, i16* %p.i.i.74.i.i, align 2
  %add8.i.i.98.i.i = add i16 %286, %and.i.i.97.i.i
  store i16 %add8.i.i.98.i.i, i16* %p.i.i.74.i.i, align 2
  br label %if.end.i.i.101.i.i

if.end.i.i.101.i.i:                               ; preds = %if.then.i.i.99.i.i, %land.lhs.true.i.i.90.i.i, %for.body.3.i.i.87.i.i
  %287 = load i16, i16* %i.i.i.72.i.i, align 2
  %inc.i.i.100.i.i = add nsw i16 %287, 1
  store i16 %inc.i.i.100.i.i, i16* %i.i.i.72.i.i, align 2
  br label %for.cond.1.i.i.85.i.i

for.end.i.i.107.i.i:                              ; preds = %for.cond.1.i.i.85.i.i
  %288 = load i16, i16* %p.i.i.74.i.i, align 2
  %shr9.i.i.102.i.i = lshr i16 %288, 8
  %289 = load i16, i16* %c.i.i.75.i.i, align 2
  %add10.i.i.103.i.i = add i16 %289, %shr9.i.i.102.i.i
  store i16 %add10.i.i.103.i.i, i16* %c.i.i.75.i.i, align 2
  %290 = load i16, i16* %p.i.i.74.i.i, align 2
  %and11.i.i.104.i.i = and i16 %290, 255
  store i16 %and11.i.i.104.i.i, i16* %p.i.i.74.i.i, align 2
  %291 = load i16, i16* %p.i.i.74.i.i, align 2
  %292 = load i16, i16* %digit.i.i.73.i.i, align 2
  %arrayidx12.i.i.105.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %292
  store i16 %291, i16* %arrayidx12.i.i.105.i.i, align 2
  %293 = load i16, i16* %c.i.i.75.i.i, align 2
  store i16 %293, i16* %carry.i.i.77.i.i, align 2
  %294 = load i16, i16* %digit.i.i.73.i.i, align 2
  %inc14.i.i.106.i.i = add i16 %294, 1
  store i16 %inc14.i.i.106.i.i, i16* %digit.i.i.73.i.i, align 2
  br label %for.cond.i.i.82.i.i

for.end.15.i.i.108.i.i:                           ; preds = %for.cond.i.i.82.i.i
  store i16 20, i16* @curtask, align 2
  store i16 0, i16* %i.i.i.72.i.i, align 2
  br label %for.cond.16.i.i.110.i.i

for.cond.16.i.i.110.i.i:                          ; preds = %for.body.18.i.i.114.i.i, %for.end.15.i.i.108.i.i
  %295 = load i16, i16* %i.i.i.72.i.i, align 2
  %cmp17.i.i.109.i.i = icmp slt i16 %295, 16
  br i1 %cmp17.i.i.109.i.i, label %for.body.18.i.i.114.i.i, label %mult.exit.i.115.i.i

for.body.18.i.i.114.i.i:                          ; preds = %for.cond.16.i.i.110.i.i
  %296 = load i16, i16* %i.i.i.72.i.i, align 2
  %arrayidx19.i.i.111.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %296
  %297 = load i16, i16* %arrayidx19.i.i.111.i.i, align 2
  %298 = load i16, i16* %i.i.i.72.i.i, align 2
  %299 = load i16*, i16** %a.addr.i.i.70.i.i, align 2
  %arrayidx20.i.i.112.i.i = getelementptr inbounds i16, i16* %299, i16 %298
  store i16 %297, i16* %arrayidx20.i.i.112.i.i, align 2
  %300 = load i16, i16* %i.i.i.72.i.i, align 2
  %inc22.i.i.113.i.i = add nsw i16 %300, 1
  store i16 %inc22.i.i.113.i.i, i16* %i.i.i.72.i.i, align 2
  br label %for.cond.16.i.i.110.i.i

mult.exit.i.115.i.i:                              ; preds = %for.cond.16.i.i.110.i.i
  store i16 27, i16* @curtask, align 2
  %301 = load i16*, i16** %a.addr.i.78.i.i, align 2
  %302 = load i16*, i16** %n.addr.i.80.i.i, align 2
  store i16* %301, i16** %m.addr.i.i.65.i.i, align 2
  store i16* %302, i16** %n.addr.i.i.66.i.i, align 2
  store i16 4, i16* @curtask, align 2
  store i16 16, i16* %d.i.i.69.i.i, align 2
  br label %do.body.i.i.120.i.i

do.body.i.i.120.i.i:                              ; preds = %land.end.i.i.123.i.i, %mult.exit.i.115.i.i
  %303 = load i16, i16* %d.i.i.69.i.i, align 2
  %dec.i.i.116.i.i = add i16 %303, -1
  store i16 %dec.i.i.116.i.i, i16* %d.i.i.69.i.i, align 2
  %304 = load i16, i16* %d.i.i.69.i.i, align 2
  %305 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %arrayidx.i.1.i.117.i.i = getelementptr inbounds i16, i16* %305, i16 %304
  %306 = load i16, i16* %arrayidx.i.1.i.117.i.i, align 2
  store i16 %306, i16* %m_d.i.i.68.i.i, align 2
  %307 = load i16, i16* %d.i.i.69.i.i, align 2
  %308 = load i16, i16* %m_d.i.i.68.i.i, align 2
  %call.i.i.118.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %307, i16 %308) #4
  %309 = load i16, i16* %m_d.i.i.68.i.i, align 2
  %cmp.i.2.i.119.i.i = icmp eq i16 %309, 0
  br i1 %cmp.i.2.i.119.i.i, label %land.rhs.i.i.122.i.i, label %land.end.i.i.123.i.i

land.rhs.i.i.122.i.i:                             ; preds = %do.body.i.i.120.i.i
  %310 = load i16, i16* %d.i.i.69.i.i, align 2
  %cmp1.i.i.121.i.i = icmp ugt i16 %310, 0
  br label %land.end.i.i.123.i.i

land.end.i.i.123.i.i:                             ; preds = %land.rhs.i.i.122.i.i, %do.body.i.i.120.i.i
  %311 = phi i1 [ false, %do.body.i.i.120.i.i ], [ %cmp1.i.i.121.i.i, %land.rhs.i.i.122.i.i ]
  br i1 %311, label %do.body.i.i.120.i.i, label %do.end.i.i.128.i.i

do.end.i.i.128.i.i:                               ; preds = %land.end.i.i.123.i.i
  %312 = load i16, i16* %d.i.i.69.i.i, align 2
  %call2.i.i.124.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %312) #4
  %313 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %314 = load i16*, i16** %n.addr.i.i.66.i.i, align 2
  %315 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* %313, i16** %m.addr.i.i.i.57.i.i, align 2
  store i16* %314, i16** %n.addr.i.i.i.58.i.i, align 2
  store i16 %315, i16* %d.addr.i.i.i.59.i.i, align 2
  store i8 1, i8* %normalizable.i.i.i.64.i.i, align 1
  store i16 6, i16* @curtask, align 2
  %316 = load i16, i16* %d.addr.i.i.i.59.i.i, align 2
  %add.i.i.i.125.i.i = add i16 %316, 1
  %sub.i.i.i.126.i.i = sub i16 %add.i.i.i.125.i.i, 8
  store i16 %sub.i.i.i.126.i.i, i16* %offset.i.i.i.61.i.i, align 2
  %317 = load i16, i16* %d.addr.i.i.i.59.i.i, align 2
  %318 = load i16, i16* %offset.i.i.i.61.i.i, align 2
  %call.i.i.i.127.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %317, i16 %318) #4
  %319 = load i16, i16* %d.addr.i.i.i.59.i.i, align 2
  store i16 %319, i16* %i.i.i.i.60.i.i, align 2
  br label %for.cond.i.i.i.130.i.i

for.cond.i.i.i.130.i.i:                           ; preds = %if.end.i.i.i.141.i.i, %do.end.i.i.128.i.i
  %320 = load i16, i16* %i.i.i.i.60.i.i, align 2
  %cmp.i.i.i.129.i.i = icmp sge i16 %320, 0
  br i1 %cmp.i.i.i.129.i.i, label %for.body.i.i.i.135.i.i, label %reduce_normalizable.exit.i.i.146.i.i

for.body.i.i.i.135.i.i:                           ; preds = %for.cond.i.i.i.130.i.i
  %321 = load i16, i16* %i.i.i.i.60.i.i, align 2
  %322 = load i16*, i16** %m.addr.i.i.i.57.i.i, align 2
  %arrayidx.i.i.i.131.i.i = getelementptr inbounds i16, i16* %322, i16 %321
  %323 = load i16, i16* %arrayidx.i.i.i.131.i.i, align 2
  store i16 %323, i16* %m_d.i.i.i.63.i.i, align 2
  %324 = load i16, i16* %i.i.i.i.60.i.i, align 2
  %325 = load i16, i16* %offset.i.i.i.61.i.i, align 2
  %sub1.i.i.i.132.i.i = sub i16 %324, %325
  %326 = load i16*, i16** %n.addr.i.i.i.58.i.i, align 2
  %arrayidx2.i.i.i.133.i.i = getelementptr inbounds i16, i16* %326, i16 %sub1.i.i.i.132.i.i
  %327 = load i16, i16* %arrayidx2.i.i.i.133.i.i, align 2
  store i16 %327, i16* %n_d.i.i.i.62.i.i, align 2
  %328 = load i16, i16* %m_d.i.i.i.63.i.i, align 2
  %329 = load i16, i16* %n_d.i.i.i.62.i.i, align 2
  %cmp3.i.i.i.134.i.i = icmp ugt i16 %328, %329
  br i1 %cmp3.i.i.i.134.i.i, label %if.then.i.i.i.136.i.i, label %if.else.i.i.i.138.i.i

if.then.i.i.i.136.i.i:                            ; preds = %for.body.i.i.i.135.i.i
  br label %reduce_normalizable.exit.i.i.146.i.i

if.else.i.i.i.138.i.i:                            ; preds = %for.body.i.i.i.135.i.i
  %330 = load i16, i16* %m_d.i.i.i.63.i.i, align 2
  %331 = load i16, i16* %n_d.i.i.i.62.i.i, align 2
  %cmp4.i.i.i.137.i.i = icmp ult i16 %330, %331
  br i1 %cmp4.i.i.i.137.i.i, label %if.then.5.i.i.i.139.i.i, label %if.end.i.i.i.141.i.i

if.then.5.i.i.i.139.i.i:                          ; preds = %if.else.i.i.i.138.i.i
  store i8 0, i8* %normalizable.i.i.i.64.i.i, align 1
  br label %reduce_normalizable.exit.i.i.146.i.i

if.end.i.i.i.141.i.i:                             ; preds = %if.else.i.i.i.138.i.i
  %332 = load i16, i16* %i.i.i.i.60.i.i, align 2
  %dec.i.i.i.140.i.i = add nsw i16 %332, -1
  store i16 %dec.i.i.i.140.i.i, i16* %i.i.i.i.60.i.i, align 2
  br label %for.cond.i.i.i.130.i.i

reduce_normalizable.exit.i.i.146.i.i:             ; preds = %if.then.5.i.i.i.139.i.i, %if.then.i.i.i.136.i.i, %for.cond.i.i.i.130.i.i
  %333 = load i8, i8* %normalizable.i.i.i.64.i.i, align 1
  %tobool.i.i.i.142.i.i = trunc i8 %333 to i1
  %conv.i.i.i.143.i.i = zext i1 %tobool.i.i.i.142.i.i to i16
  %call7.i.i.i.144.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143.i.i) #4
  store i16 30, i16* @curtask, align 2
  %334 = load i8, i8* %normalizable.i.i.i.64.i.i, align 1
  %tobool8.i.i.i.145.i.i = trunc i8 %334 to i1
  br i1 %tobool8.i.i.i.145.i.i, label %if.then.i.3.i.149.i.i, label %if.else.i.i.168.i.i

if.then.i.3.i.149.i.i:                            ; preds = %reduce_normalizable.exit.i.i.146.i.i
  %335 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %336 = load i16*, i16** %n.addr.i.i.66.i.i, align 2
  %337 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* %335, i16** %m.addr.i.14.i.i.47.i.i, align 2
  store i16* %336, i16** %n.addr.i.15.i.i.48.i.i, align 2
  store i16 %337, i16* %digit.addr.i.i.i.49.i.i, align 2
  store i16 5, i16* @curtask, align 2
  %338 = load i16, i16* %digit.addr.i.i.i.49.i.i, align 2
  %add.i.20.i.i.147.i.i = add i16 %338, 1
  %sub.i.21.i.i.148.i.i = sub i16 %add.i.20.i.i.147.i.i, 8
  store i16 %sub.i.21.i.i.148.i.i, i16* %offset.i.19.i.i.56.i.i, align 2
  store i16 0, i16* %borrow.i.i.i.55.i.i, align 2
  store i16 0, i16* %i.i.16.i.i.50.i.i, align 2
  br label %for.cond.i.23.i.i.151.i.i

for.cond.i.23.i.i.151.i.i:                        ; preds = %if.end.i.30.i.i.165.i.i, %if.then.i.3.i.149.i.i
  %339 = load i16, i16* %i.i.16.i.i.50.i.i, align 2
  %cmp.i.22.i.i.150.i.i = icmp slt i16 %339, 8
  br i1 %cmp.i.22.i.i.150.i.i, label %for.body.i.27.i.i.157.i.i, label %reduce_normalize.exit.i.i.166.i.i

for.body.i.27.i.i.157.i.i:                        ; preds = %for.cond.i.23.i.i.151.i.i
  store i16 21, i16* @curtask, align 2
  %340 = load i16, i16* %i.i.16.i.i.50.i.i, align 2
  %341 = load i16, i16* %offset.i.19.i.i.56.i.i, align 2
  %add1.i.i.i.152.i.i = add i16 %340, %341
  %342 = load i16*, i16** %m.addr.i.14.i.i.47.i.i, align 2
  %arrayidx.i.24.i.i.153.i.i = getelementptr inbounds i16, i16* %342, i16 %add1.i.i.i.152.i.i
  %343 = load i16, i16* %arrayidx.i.24.i.i.153.i.i, align 2
  store i16 %343, i16* %m_d.i.17.i.i.53.i.i, align 2
  %344 = load i16, i16* %i.i.16.i.i.50.i.i, align 2
  %345 = load i16*, i16** %n.addr.i.15.i.i.48.i.i, align 2
  %arrayidx2.i.25.i.i.154.i.i = getelementptr inbounds i16, i16* %345, i16 %344
  %346 = load i16, i16* %arrayidx2.i.25.i.i.154.i.i, align 2
  store i16 %346, i16* %n_d.i.18.i.i.54.i.i, align 2
  %347 = load i16, i16* %n_d.i.18.i.i.54.i.i, align 2
  %348 = load i16, i16* %borrow.i.i.i.55.i.i, align 2
  %add3.i.i.i.155.i.i = add i16 %347, %348
  store i16 %add3.i.i.i.155.i.i, i16* %s.i.i.i.52.i.i, align 2
  %349 = load i16, i16* %m_d.i.17.i.i.53.i.i, align 2
  %350 = load i16, i16* %s.i.i.i.52.i.i, align 2
  %cmp4.i.26.i.i.156.i.i = icmp ult i16 %349, %350
  br i1 %cmp4.i.26.i.i.156.i.i, label %if.then.i.28.i.i.159.i.i, label %if.else.i.29.i.i.160.i.i

if.then.i.28.i.i.159.i.i:                         ; preds = %for.body.i.27.i.i.157.i.i
  %351 = load i16, i16* %m_d.i.17.i.i.53.i.i, align 2
  %add5.i.i.i.158.i.i = add i16 %351, 256
  store i16 %add5.i.i.i.158.i.i, i16* %m_d.i.17.i.i.53.i.i, align 2
  store i16 1, i16* %borrow.i.i.i.55.i.i, align 2
  br label %if.end.i.30.i.i.165.i.i

if.else.i.29.i.i.160.i.i:                         ; preds = %for.body.i.27.i.i.157.i.i
  store i16 0, i16* %borrow.i.i.i.55.i.i, align 2
  br label %if.end.i.30.i.i.165.i.i

if.end.i.30.i.i.165.i.i:                          ; preds = %if.else.i.29.i.i.160.i.i, %if.then.i.28.i.i.159.i.i
  %352 = load i16, i16* %m_d.i.17.i.i.53.i.i, align 2
  %353 = load i16, i16* %s.i.i.i.52.i.i, align 2
  %sub6.i.i.i.161.i.i = sub i16 %352, %353
  store i16 %sub6.i.i.i.161.i.i, i16* %d.i.i.i.51.i.i, align 2
  %354 = load i16, i16* %d.i.i.i.51.i.i, align 2
  %355 = load i16, i16* %i.i.16.i.i.50.i.i, align 2
  %356 = load i16, i16* %offset.i.19.i.i.56.i.i, align 2
  %add7.i.i.i.162.i.i = add i16 %355, %356
  %357 = load i16*, i16** %m.addr.i.14.i.i.47.i.i, align 2
  %arrayidx8.i.i.i.163.i.i = getelementptr inbounds i16, i16* %357, i16 %add7.i.i.i.162.i.i
  store i16 %354, i16* %arrayidx8.i.i.i.163.i.i, align 2
  %358 = load i16, i16* %i.i.16.i.i.50.i.i, align 2
  %inc.i.i.i.164.i.i = add nsw i16 %358, 1
  store i16 %inc.i.i.i.164.i.i, i16* %i.i.16.i.i.50.i.i, align 2
  br label %for.cond.i.23.i.i.151.i.i

reduce_normalize.exit.i.i.166.i.i:                ; preds = %for.cond.i.23.i.i.151.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172.i.i

if.else.i.i.168.i.i:                              ; preds = %reduce_normalizable.exit.i.i.146.i.i
  %359 = load i16, i16* %d.i.i.69.i.i, align 2
  %cmp4.i.4.i.167.i.i = icmp eq i16 %359, 7
  br i1 %cmp4.i.4.i.167.i.i, label %if.then.5.i.i.170.i.i, label %if.end.i.5.i.171.i.i

if.then.5.i.i.170.i.i:                            ; preds = %if.else.i.i.168.i.i
  %call6.i.i.169.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312.i.i

if.end.i.5.i.171.i.i:                             ; preds = %if.else.i.i.168.i.i
  br label %if.end.7.i.i.172.i.i

if.end.7.i.i.172.i.i:                             ; preds = %if.end.i.5.i.171.i.i, %reduce_normalize.exit.i.i.166.i.i
  br label %while.cond.i.i.174.i.i

while.cond.i.i.174.i.i:                           ; preds = %reduce_subtract.exit.i.i.310.i.i, %if.end.7.i.i.172.i.i
  %360 = load i16, i16* %d.i.i.69.i.i, align 2
  %cmp8.i.i.173.i.i = icmp uge i16 %360, 8
  br i1 %cmp8.i.i.173.i.i, label %while.body.i.i.192.i.i, label %while.end.i.i.311.i.i

while.body.i.i.192.i.i:                           ; preds = %while.cond.i.i.174.i.i
  %361 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %362 = load i16*, i16** %n.addr.i.i.66.i.i, align 2
  %363 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* %q.i.i.67.i.i, i16** %quotient.addr.i.i.i.36.i.i, align 2
  store i16* %361, i16** %m.addr.i.31.i.i.37.i.i, align 2
  store i16* %362, i16** %n.addr.i.32.i.i.38.i.i, align 2
  store i16 %363, i16* %d.addr.i.33.i.i.39.i.i, align 2
  store i16 16, i16* @curtask, align 2
  %364 = load i16*, i16** %n.addr.i.32.i.i.38.i.i, align 2
  %arrayidx.i.35.i.i.175.i.i = getelementptr inbounds i16, i16* %364, i16 7
  %365 = load i16, i16* %arrayidx.i.35.i.i.175.i.i, align 2
  %shl.i.i.i.176.i.i = shl i16 %365, 8
  %366 = load i16*, i16** %n.addr.i.32.i.i.38.i.i, align 2
  %arrayidx1.i.i.i.177.i.i = getelementptr inbounds i16, i16* %366, i16 6
  %367 = load i16, i16* %arrayidx1.i.i.i.177.i.i, align 2
  %add.i.36.i.i.178.i.i = add i16 %shl.i.i.i.176.i.i, %367
  store i16 %add.i.36.i.i.178.i.i, i16* %n_div.i.i.i.42.i.i, align 2
  %368 = load i16*, i16** %n.addr.i.32.i.i.38.i.i, align 2
  %arrayidx2.i.37.i.i.179.i.i = getelementptr inbounds i16, i16* %368, i16 7
  %369 = load i16, i16* %arrayidx2.i.37.i.i.179.i.i, align 2
  store i16 %369, i16* %n_n.i.i.i.43.i.i, align 2
  %370 = load i16, i16* %d.addr.i.33.i.i.39.i.i, align 2
  %371 = load i16*, i16** %m.addr.i.31.i.i.37.i.i, align 2
  %arrayidx3.i.i.i.180.i.i = getelementptr inbounds i16, i16* %371, i16 %370
  %372 = load i16, i16* %arrayidx3.i.i.i.180.i.i, align 2
  %arrayidx4.i.i.i.181.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  store i16 %372, i16* %arrayidx4.i.i.i.181.i.i, align 2
  %373 = load i16, i16* %d.addr.i.33.i.i.39.i.i, align 2
  %sub.i.38.i.i.182.i.i = sub i16 %373, 1
  %374 = load i16*, i16** %m.addr.i.31.i.i.37.i.i, align 2
  %arrayidx5.i.i.i.183.i.i = getelementptr inbounds i16, i16* %374, i16 %sub.i.38.i.i.182.i.i
  %375 = load i16, i16* %arrayidx5.i.i.i.183.i.i, align 2
  %arrayidx6.i.i.i.184.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  store i16 %375, i16* %arrayidx6.i.i.i.184.i.i, align 2
  %376 = load i16, i16* %d.addr.i.33.i.i.39.i.i, align 2
  %sub7.i.i.i.185.i.i = sub i16 %376, 2
  %377 = load i16*, i16** %m.addr.i.31.i.i.37.i.i, align 2
  %arrayidx8.i.39.i.i.186.i.i = getelementptr inbounds i16, i16* %377, i16 %sub7.i.i.i.185.i.i
  %378 = load i16, i16* %arrayidx8.i.39.i.i.186.i.i, align 2
  %arrayidx9.i.i.i.187.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  store i16 %378, i16* %arrayidx9.i.i.i.187.i.i, align 2
  %379 = load i16, i16* %n_n.i.i.i.43.i.i, align 2
  %380 = load i16*, i16** %m.addr.i.31.i.i.37.i.i, align 2
  %arrayidx10.i.i.i.188.i.i = getelementptr inbounds i16, i16* %380, i16 2
  %381 = load i16, i16* %arrayidx10.i.i.i.188.i.i, align 2
  %call.i.40.i.i.189.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %379, i16 %381) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %382 = load i16, i16* %arrayidx11.i.i.i.190.i.i, align 2
  %383 = load i16, i16* %n_n.i.i.i.43.i.i, align 2
  %cmp.i.41.i.i.191.i.i = icmp eq i16 %382, %383
  br i1 %cmp.i.41.i.i.191.i.i, label %if.then.i.42.i.i.193.i.i, label %if.else.i.43.i.i.200.i.i

if.then.i.42.i.i.193.i.i:                         ; preds = %while.body.i.i.192.i.i
  store i16 255, i16* %q.i.i.i.41.i.i, align 2
  br label %if.end.i.46.i.i.222.i.i

if.else.i.43.i.i.200.i.i:                         ; preds = %while.body.i.i.192.i.i
  %arrayidx12.i.i.i.194.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %384 = load i16, i16* %arrayidx12.i.i.i.194.i.i, align 2
  %shl13.i.i.i.195.i.i = shl i16 %384, 8
  %arrayidx14.i.i.i.196.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %385 = load i16, i16* %arrayidx14.i.i.i.196.i.i, align 2
  %add15.i.i.i.197.i.i = add i16 %shl13.i.i.i.195.i.i, %385
  store i16 %add15.i.i.i.197.i.i, i16* %m_dividend.i.i.i.46.i.i, align 2
  %386 = load i16, i16* %m_dividend.i.i.i.46.i.i, align 2
  %387 = load i16, i16* %n_n.i.i.i.43.i.i, align 2
  %div.i.i.i.198.i.i = udiv i16 %386, %387
  store i16 %div.i.i.i.198.i.i, i16* %q.i.i.i.41.i.i, align 2
  %388 = load i16, i16* %m_dividend.i.i.i.46.i.i, align 2
  %389 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %call16.i.i.i.199.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %388, i16 %389) #4
  br label %if.end.i.46.i.i.222.i.i

if.end.i.46.i.i.222.i.i:                          ; preds = %if.else.i.43.i.i.200.i.i, %if.then.i.42.i.i.193.i.i
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %390 = load i16, i16* %arrayidx17.i.i.i.201.i.i, align 2
  %conv.i.44.i.i.202.i.i = zext i16 %390 to i32
  %shl18.i.i.i.203.i.i = shl i32 %conv.i.44.i.i.202.i.i, 16
  %arrayidx19.i.i.i.204.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %391 = load i16, i16* %arrayidx19.i.i.i.204.i.i, align 2
  %shl20.i.i.i.205.i.i = shl i16 %391, 8
  %conv21.i.i.i.206.i.i = zext i16 %shl20.i.i.i.205.i.i to i32
  %add22.i.i.i.207.i.i = add i32 %shl18.i.i.i.203.i.i, %conv21.i.i.i.206.i.i
  %arrayidx23.i.i.i.208.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %392 = load i16, i16* %arrayidx23.i.i.i.208.i.i, align 2
  %conv24.i.i.i.209.i.i = zext i16 %392 to i32
  %add25.i.i.i.210.i.i = add i32 %add22.i.i.i.207.i.i, %conv24.i.i.i.209.i.i
  store i32 %add25.i.i.i.210.i.i, i32* %n_q.i.i.i.44.i.i, align 2
  %arrayidx26.i.i.i.211.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %393 = load i16, i16* %arrayidx26.i.i.i.211.i.i, align 2
  %arrayidx27.i.i.i.212.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %394 = load i16, i16* %arrayidx27.i.i.i.212.i.i, align 2
  %arrayidx28.i.i.i.213.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %395 = load i16, i16* %arrayidx28.i.i.i.213.i.i, align 2
  %396 = load i32, i32* %n_q.i.i.i.44.i.i, align 2
  %shr.i.i.i.214.i.i = lshr i32 %396, 16
  %and.i.i.i.215.i.i = and i32 %shr.i.i.i.214.i.i, 65535
  %conv29.i.i.i.216.i.i = trunc i32 %and.i.i.i.215.i.i to i16
  %397 = load i32, i32* %n_q.i.i.i.44.i.i, align 2
  %and30.i.i.i.217.i.i = and i32 %397, 65535
  %conv31.i.i.i.218.i.i = trunc i32 %and30.i.i.i.217.i.i to i16
  %call32.i.i.i.219.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %393, i16 %394, i16 %395, i16 %conv29.i.i.i.216.i.i, i16 %conv31.i.i.i.218.i.i) #4
  %398 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %call33.i.i.i.220.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %398) #4
  %399 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %inc.i.45.i.i.221.i.i = add i16 %399, 1
  store i16 %inc.i.45.i.i.221.i.i, i16* %q.i.i.i.41.i.i, align 2
  br label %do.body.i.i.i.232.i.i

do.body.i.i.i.232.i.i:                            ; preds = %do.body.i.i.i.232.i.i, %if.end.i.46.i.i.222.i.i
  store i16 19, i16* @curtask, align 2
  %400 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %dec.i.47.i.i.223.i.i = add i16 %400, -1
  store i16 %dec.i.47.i.i.223.i.i, i16* %q.i.i.i.41.i.i, align 2
  %401 = load i16, i16* %n_div.i.i.i.42.i.i, align 2
  %402 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %call34.i.i.i.224.i.i = call i32 @mult16(i16 zeroext %401, i16 zeroext %402) #4
  store i32 %call34.i.i.i.224.i.i, i32* %qn.i.i.i.45.i.i, align 2
  %403 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %404 = load i16, i16* %n_div.i.i.i.42.i.i, align 2
  %405 = load i32, i32* %qn.i.i.i.45.i.i, align 2
  %shr35.i.i.i.225.i.i = lshr i32 %405, 16
  %and36.i.i.i.226.i.i = and i32 %shr35.i.i.i.225.i.i, 65535
  %conv37.i.i.i.227.i.i = trunc i32 %and36.i.i.i.226.i.i to i16
  %406 = load i32, i32* %qn.i.i.i.45.i.i, align 2
  %and38.i.i.i.228.i.i = and i32 %406, 65535
  %conv39.i.i.i.229.i.i = trunc i32 %and38.i.i.i.228.i.i to i16
  %call40.i.i.i.230.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %403, i16 %404, i16 %conv37.i.i.i.227.i.i, i16 %conv39.i.i.i.229.i.i) #4
  %407 = load i32, i32* %qn.i.i.i.45.i.i, align 2
  %408 = load i32, i32* %n_q.i.i.i.44.i.i, align 2
  %cmp41.i.i.i.231.i.i = icmp ugt i32 %407, %408
  br i1 %cmp41.i.i.i.231.i.i, label %do.body.i.i.i.232.i.i, label %reduce_quotient.exit.i.i.236.i.i

reduce_quotient.exit.i.i.236.i.i:                 ; preds = %do.body.i.i.i.232.i.i
  %409 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %call43.i.i.i.233.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %409) #4
  %410 = load i16, i16* %q.i.i.i.41.i.i, align 2
  %411 = load i16*, i16** %quotient.addr.i.i.i.36.i.i, align 2
  store i16 %410, i16* %411, align 2
  store i16 32, i16* @curtask, align 2
  %412 = load i16, i16* %q.i.i.67.i.i, align 2
  %413 = load i16*, i16** %n.addr.i.i.66.i.i, align 2
  %414 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %product.addr.i.i.i.27.i.i, align 2
  store i16 %412, i16* %q.addr.i.i.i.28.i.i, align 2
  store i16* %413, i16** %n.addr.i.48.i.i.29.i.i, align 2
  store i16 %414, i16* %d.addr.i.49.i.i.30.i.i, align 2
  store i16 9, i16* @curtask, align 2
  %415 = load i16, i16* %d.addr.i.49.i.i.30.i.i, align 2
  %sub.i.52.i.i.234.i.i = sub i16 %415, 8
  store i16 %sub.i.52.i.i.234.i.i, i16* %offset.i.51.i.i.32.i.i, align 2
  %416 = load i16, i16* %offset.i.51.i.i.32.i.i, align 2
  %call.i.53.i.i.235.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %416) #4
  store i16 0, i16* %i.i.50.i.i.31.i.i, align 2
  br label %for.cond.i.55.i.i.238.i.i

for.cond.i.55.i.i.238.i.i:                        ; preds = %for.body.i.57.i.i.241.i.i, %reduce_quotient.exit.i.i.236.i.i
  %417 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %418 = load i16, i16* %offset.i.51.i.i.32.i.i, align 2
  %cmp.i.54.i.i.237.i.i = icmp ult i16 %417, %418
  br i1 %cmp.i.54.i.i.237.i.i, label %for.body.i.57.i.i.241.i.i, label %for.end.i.i.i.242.i.i

for.body.i.57.i.i.241.i.i:                        ; preds = %for.cond.i.55.i.i.238.i.i
  %419 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %420 = load i16*, i16** %product.addr.i.i.i.27.i.i, align 2
  %arrayidx.i.56.i.i.239.i.i = getelementptr inbounds i16, i16* %420, i16 %419
  store i16 0, i16* %arrayidx.i.56.i.i.239.i.i, align 2
  %421 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %inc.i.58.i.i.240.i.i = add nsw i16 %421, 1
  store i16 %inc.i.58.i.i.240.i.i, i16* %i.i.50.i.i.31.i.i, align 2
  br label %for.cond.i.55.i.i.238.i.i

for.end.i.i.i.242.i.i:                            ; preds = %for.cond.i.55.i.i.238.i.i
  store i16 0, i16* %c.i.i.i.33.i.i, align 2
  %422 = load i16, i16* %offset.i.51.i.i.32.i.i, align 2
  store i16 %422, i16* %i.i.50.i.i.31.i.i, align 2
  br label %for.cond.1.i.i.i.244.i.i

for.cond.1.i.i.i.244.i.i:                         ; preds = %if.end.i.68.i.i.258.i.i, %for.end.i.i.i.242.i.i
  %423 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %cmp2.i.i.i.243.i.i = icmp slt i16 %423, 16
  br i1 %cmp2.i.i.i.243.i.i, label %for.body.3.i.i.i.247.i.i, label %reduce_multiply.exit.i.i.259.i.i

for.body.3.i.i.i.247.i.i:                         ; preds = %for.cond.1.i.i.i.244.i.i
  store i16 24, i16* @curtask, align 2
  %424 = load i16, i16* %c.i.i.i.33.i.i, align 2
  store i16 %424, i16* %p.i.i.i.34.i.i, align 2
  %425 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %426 = load i16, i16* %offset.i.51.i.i.32.i.i, align 2
  %add.i.59.i.i.245.i.i = add i16 %426, 8
  %cmp4.i.60.i.i.246.i.i = icmp ult i16 %425, %add.i.59.i.i.245.i.i
  br i1 %cmp4.i.60.i.i.246.i.i, label %if.then.i.63.i.i.252.i.i, label %if.else.i.64.i.i.253.i.i

if.then.i.63.i.i.252.i.i:                         ; preds = %for.body.3.i.i.i.247.i.i
  %427 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %428 = load i16, i16* %offset.i.51.i.i.32.i.i, align 2
  %sub5.i.i.i.248.i.i = sub i16 %427, %428
  %429 = load i16*, i16** %n.addr.i.48.i.i.29.i.i, align 2
  %arrayidx6.i.61.i.i.249.i.i = getelementptr inbounds i16, i16* %429, i16 %sub5.i.i.i.248.i.i
  %430 = load i16, i16* %arrayidx6.i.61.i.i.249.i.i, align 2
  store i16 %430, i16* %nd.i.i.i.35.i.i, align 2
  %431 = load i16, i16* %q.addr.i.i.i.28.i.i, align 2
  %432 = load i16, i16* %nd.i.i.i.35.i.i, align 2
  %mul.i.i.i.250.i.i = mul i16 %431, %432
  %433 = load i16, i16* %p.i.i.i.34.i.i, align 2
  %add7.i.62.i.i.251.i.i = add i16 %433, %mul.i.i.i.250.i.i
  store i16 %add7.i.62.i.i.251.i.i, i16* %p.i.i.i.34.i.i, align 2
  br label %if.end.i.68.i.i.258.i.i

if.else.i.64.i.i.253.i.i:                         ; preds = %for.body.3.i.i.i.247.i.i
  store i16 0, i16* %nd.i.i.i.35.i.i, align 2
  br label %if.end.i.68.i.i.258.i.i

if.end.i.68.i.i.258.i.i:                          ; preds = %if.else.i.64.i.i.253.i.i, %if.then.i.63.i.i.252.i.i
  %434 = load i16, i16* %p.i.i.i.34.i.i, align 2
  %shr.i.65.i.i.254.i.i = lshr i16 %434, 8
  store i16 %shr.i.65.i.i.254.i.i, i16* %c.i.i.i.33.i.i, align 2
  %435 = load i16, i16* %p.i.i.i.34.i.i, align 2
  %and.i.66.i.i.255.i.i = and i16 %435, 255
  store i16 %and.i.66.i.i.255.i.i, i16* %p.i.i.i.34.i.i, align 2
  %436 = load i16, i16* %p.i.i.i.34.i.i, align 2
  %437 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %438 = load i16*, i16** %product.addr.i.i.i.27.i.i, align 2
  %arrayidx8.i.67.i.i.256.i.i = getelementptr inbounds i16, i16* %438, i16 %437
  store i16 %436, i16* %arrayidx8.i.67.i.i.256.i.i, align 2
  %439 = load i16, i16* %i.i.50.i.i.31.i.i, align 2
  %inc10.i.i.i.257.i.i = add nsw i16 %439, 1
  store i16 %inc10.i.i.i.257.i.i, i16* %i.i.50.i.i.31.i.i, align 2
  br label %for.cond.1.i.i.i.244.i.i

reduce_multiply.exit.i.i.259.i.i:                 ; preds = %for.cond.1.i.i.i.244.i.i
  store i16 33, i16* @curtask, align 2
  %440 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  store i16* %440, i16** %a.addr.i.i.i.23.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.i.i.24.i.i, align 2
  store i16 0, i16* %relation.i.i.i.26.i.i, align 2
  store i16 7, i16* @curtask, align 2
  store i16 15, i16* %i.i.69.i.i.25.i.i, align 2
  br label %for.cond.i.71.i.i.261.i.i

for.cond.i.71.i.i.261.i.i:                        ; preds = %if.end.i.76.i.i.269.i.i, %reduce_multiply.exit.i.i.259.i.i
  %441 = load i16, i16* %i.i.69.i.i.25.i.i, align 2
  %cmp.i.70.i.i.260.i.i = icmp sge i16 %441, 0
  br i1 %cmp.i.70.i.i.260.i.i, label %for.body.i.72.i.i.263.i.i, label %reduce_compare.exit.i.i.271.i.i

for.body.i.72.i.i.263.i.i:                        ; preds = %for.cond.i.71.i.i.261.i.i
  %442 = load i16*, i16** %a.addr.i.i.i.23.i.i, align 2
  %443 = load i16*, i16** %b.addr.i.i.i.24.i.i, align 2
  %cmp1.i.i.i.262.i.i = icmp ugt i16* %442, %443
  br i1 %cmp1.i.i.i.262.i.i, label %if.then.i.73.i.i.264.i.i, label %if.else.i.75.i.i.266.i.i

if.then.i.73.i.i.264.i.i:                         ; preds = %for.body.i.72.i.i.263.i.i
  store i16 1, i16* %relation.i.i.i.26.i.i, align 2
  br label %reduce_compare.exit.i.i.271.i.i

if.else.i.75.i.i.266.i.i:                         ; preds = %for.body.i.72.i.i.263.i.i
  %444 = load i16*, i16** %a.addr.i.i.i.23.i.i, align 2
  %445 = load i16*, i16** %b.addr.i.i.i.24.i.i, align 2
  %cmp2.i.74.i.i.265.i.i = icmp ult i16* %444, %445
  br i1 %cmp2.i.74.i.i.265.i.i, label %if.then.3.i.i.i.267.i.i, label %if.end.i.76.i.i.269.i.i

if.then.3.i.i.i.267.i.i:                          ; preds = %if.else.i.75.i.i.266.i.i
  store i16 -1, i16* %relation.i.i.i.26.i.i, align 2
  br label %reduce_compare.exit.i.i.271.i.i

if.end.i.76.i.i.269.i.i:                          ; preds = %if.else.i.75.i.i.266.i.i
  %446 = load i16, i16* %i.i.69.i.i.25.i.i, align 2
  %dec.i.77.i.i.268.i.i = add nsw i16 %446, -1
  store i16 %dec.i.77.i.i.268.i.i, i16* %i.i.69.i.i.25.i.i, align 2
  br label %for.cond.i.71.i.i.261.i.i

reduce_compare.exit.i.i.271.i.i:                  ; preds = %if.then.3.i.i.i.267.i.i, %if.then.i.73.i.i.264.i.i, %for.cond.i.71.i.i.261.i.i
  store i16 31, i16* @curtask, align 2
  %447 = load i16, i16* %relation.i.i.i.26.i.i, align 2
  %cmp10.i.i.270.i.i = icmp slt i16 %447, 0
  br i1 %cmp10.i.i.270.i.i, label %if.then.11.i.i.273.i.i, label %if.end.12.i.i.294.i.i

if.then.11.i.i.273.i.i:                           ; preds = %reduce_compare.exit.i.i.271.i.i
  %448 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %449 = load i16*, i16** %n.addr.i.i.66.i.i, align 2
  %450 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* %448, i16** %a.addr.i.79.i.i.13.i.i, align 2
  store i16* %449, i16** %b.addr.i.80.i.i.14.i.i, align 2
  store i16 %450, i16* %d.addr.i.81.i.i.15.i.i, align 2
  store i16 10, i16* @curtask, align 2
  %451 = load i16, i16* %d.addr.i.81.i.i.15.i.i, align 2
  %sub.i.85.i.i.272.i.i = sub i16 %451, 8
  store i16 %sub.i.85.i.i.272.i.i, i16* %offset.i.83.i.i.18.i.i, align 2
  store i16 0, i16* %c.i.84.i.i.19.i.i, align 2
  %452 = load i16, i16* %offset.i.83.i.i.18.i.i, align 2
  store i16 %452, i16* %i.i.82.i.i.16.i.i, align 2
  br label %for.cond.i.87.i.i.275.i.i

for.cond.i.87.i.i.275.i.i:                        ; preds = %if.end.i.100.i.i.290.i.i, %if.then.11.i.i.273.i.i
  %453 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %cmp.i.86.i.i.274.i.i = icmp slt i16 %453, 16
  br i1 %cmp.i.86.i.i.274.i.i, label %for.body.i.92.i.i.280.i.i, label %reduce_add.exit.i.i.291.i.i

for.body.i.92.i.i.280.i.i:                        ; preds = %for.cond.i.87.i.i.275.i.i
  store i16 22, i16* @curtask, align 2
  %454 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %455 = load i16*, i16** %a.addr.i.79.i.i.13.i.i, align 2
  %arrayidx.i.88.i.i.276.i.i = getelementptr inbounds i16, i16* %455, i16 %454
  %456 = load i16, i16* %arrayidx.i.88.i.i.276.i.i, align 2
  store i16 %456, i16* %m.i.i.i.21.i.i, align 2
  %457 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %458 = load i16, i16* %offset.i.83.i.i.18.i.i, align 2
  %sub1.i.89.i.i.277.i.i = sub i16 %457, %458
  store i16 %sub1.i.89.i.i.277.i.i, i16* %j.i.i.i.17.i.i, align 2
  %459 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %460 = load i16, i16* %offset.i.83.i.i.18.i.i, align 2
  %add.i.90.i.i.278.i.i = add i16 %460, 8
  %cmp2.i.91.i.i.279.i.i = icmp ult i16 %459, %add.i.90.i.i.278.i.i
  br i1 %cmp2.i.91.i.i.279.i.i, label %if.then.i.94.i.i.282.i.i, label %if.else.i.95.i.i.283.i.i

if.then.i.94.i.i.282.i.i:                         ; preds = %for.body.i.92.i.i.280.i.i
  %461 = load i16, i16* %j.i.i.i.17.i.i, align 2
  %462 = load i16*, i16** %b.addr.i.80.i.i.14.i.i, align 2
  %arrayidx3.i.93.i.i.281.i.i = getelementptr inbounds i16, i16* %462, i16 %461
  %463 = load i16, i16* %arrayidx3.i.93.i.i.281.i.i, align 2
  store i16 %463, i16* %n.i.i.i.22.i.i, align 2
  br label %if.end.i.100.i.i.290.i.i

if.else.i.95.i.i.283.i.i:                         ; preds = %for.body.i.92.i.i.280.i.i
  store i16 0, i16* %n.i.i.i.22.i.i, align 2
  store i16 0, i16* %j.i.i.i.17.i.i, align 2
  br label %if.end.i.100.i.i.290.i.i

if.end.i.100.i.i.290.i.i:                         ; preds = %if.else.i.95.i.i.283.i.i, %if.then.i.94.i.i.282.i.i
  %464 = load i16, i16* %c.i.84.i.i.19.i.i, align 2
  %465 = load i16, i16* %m.i.i.i.21.i.i, align 2
  %add4.i.i.i.284.i.i = add i16 %464, %465
  %466 = load i16, i16* %n.i.i.i.22.i.i, align 2
  %add5.i.96.i.i.285.i.i = add i16 %add4.i.i.i.284.i.i, %466
  store i16 %add5.i.96.i.i.285.i.i, i16* %r.i.i.i.20.i.i, align 2
  %467 = load i16, i16* %r.i.i.i.20.i.i, align 2
  %shr.i.97.i.i.286.i.i = lshr i16 %467, 8
  store i16 %shr.i.97.i.i.286.i.i, i16* %c.i.84.i.i.19.i.i, align 2
  %468 = load i16, i16* %r.i.i.i.20.i.i, align 2
  %and.i.98.i.i.287.i.i = and i16 %468, 255
  store i16 %and.i.98.i.i.287.i.i, i16* %r.i.i.i.20.i.i, align 2
  %469 = load i16, i16* %r.i.i.i.20.i.i, align 2
  %470 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %471 = load i16*, i16** %a.addr.i.79.i.i.13.i.i, align 2
  %arrayidx6.i.99.i.i.288.i.i = getelementptr inbounds i16, i16* %471, i16 %470
  store i16 %469, i16* %arrayidx6.i.99.i.i.288.i.i, align 2
  %472 = load i16, i16* %i.i.82.i.i.16.i.i, align 2
  %inc.i.101.i.i.289.i.i = add nsw i16 %472, 1
  store i16 %inc.i.101.i.i.289.i.i, i16* %i.i.82.i.i.16.i.i, align 2
  br label %for.cond.i.87.i.i.275.i.i

reduce_add.exit.i.i.291.i.i:                      ; preds = %for.cond.i.87.i.i.275.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294.i.i

if.end.12.i.i.294.i.i:                            ; preds = %reduce_add.exit.i.i.291.i.i, %reduce_compare.exit.i.i.271.i.i
  %473 = load i16*, i16** %m.addr.i.i.65.i.i, align 2
  %474 = load i16, i16* %d.i.i.69.i.i, align 2
  store i16* %473, i16** %a.addr.i.103.i.i.3.i.i, align 2
  store i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16** %b.addr.i.104.i.i.4.i.i, align 2
  store i16 %474, i16* %d.addr.i.105.i.i.5.i.i, align 2
  store i16 11, i16* @curtask, align 2
  %475 = load i16, i16* %d.addr.i.105.i.i.5.i.i, align 2
  %sub.i.113.i.i.292.i.i = sub i16 %475, 8
  store i16 %sub.i.113.i.i.292.i.i, i16* %offset.i.112.i.i.12.i.i, align 2
  %476 = load i16, i16* %d.addr.i.105.i.i.5.i.i, align 2
  %477 = load i16, i16* %offset.i.112.i.i.12.i.i, align 2
  %call.i.114.i.i.293.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %476, i16 %477) #4
  store i16 0, i16* %borrow.i.111.i.i.11.i.i, align 2
  %478 = load i16, i16* %offset.i.112.i.i.12.i.i, align 2
  store i16 %478, i16* %i.i.106.i.i.6.i.i, align 2
  br label %for.cond.i.116.i.i.296.i.i

for.cond.i.116.i.i.296.i.i:                       ; preds = %if.end.i.126.i.i.308.i.i, %if.end.12.i.i.294.i.i
  %479 = load i16, i16* %i.i.106.i.i.6.i.i, align 2
  %cmp.i.115.i.i.295.i.i = icmp slt i16 %479, 16
  br i1 %cmp.i.115.i.i.295.i.i, label %for.body.i.121.i.i.301.i.i, label %reduce_subtract.exit.i.i.310.i.i

for.body.i.121.i.i.301.i.i:                       ; preds = %for.cond.i.116.i.i.296.i.i
  store i16 23, i16* @curtask, align 2
  %480 = load i16, i16* %i.i.106.i.i.6.i.i, align 2
  %481 = load i16*, i16** %a.addr.i.103.i.i.3.i.i, align 2
  %arrayidx.i.117.i.i.297.i.i = getelementptr inbounds i16, i16* %481, i16 %480
  %482 = load i16, i16* %arrayidx.i.117.i.i.297.i.i, align 2
  store i16 %482, i16* %m.i.107.i.i.7.i.i, align 2
  %483 = load i16, i16* %i.i.106.i.i.6.i.i, align 2
  %484 = load i16*, i16** %b.addr.i.104.i.i.4.i.i, align 2
  %arrayidx1.i.118.i.i.298.i.i = getelementptr inbounds i16, i16* %484, i16 %483
  %485 = load i16, i16* %arrayidx1.i.118.i.i.298.i.i, align 2
  store i16 %485, i16* %qn.i.110.i.i.10.i.i, align 2
  %486 = load i16, i16* %qn.i.110.i.i.10.i.i, align 2
  %487 = load i16, i16* %borrow.i.111.i.i.11.i.i, align 2
  %add.i.119.i.i.299.i.i = add i16 %486, %487
  store i16 %add.i.119.i.i.299.i.i, i16* %s.i.108.i.i.8.i.i, align 2
  %488 = load i16, i16* %m.i.107.i.i.7.i.i, align 2
  %489 = load i16, i16* %s.i.108.i.i.8.i.i, align 2
  %cmp2.i.120.i.i.300.i.i = icmp ult i16 %488, %489
  br i1 %cmp2.i.120.i.i.300.i.i, label %if.then.i.123.i.i.303.i.i, label %if.else.i.124.i.i.304.i.i

if.then.i.123.i.i.303.i.i:                        ; preds = %for.body.i.121.i.i.301.i.i
  %490 = load i16, i16* %m.i.107.i.i.7.i.i, align 2
  %add3.i.122.i.i.302.i.i = add i16 %490, 256
  store i16 %add3.i.122.i.i.302.i.i, i16* %m.i.107.i.i.7.i.i, align 2
  store i16 1, i16* %borrow.i.111.i.i.11.i.i, align 2
  br label %if.end.i.126.i.i.308.i.i

if.else.i.124.i.i.304.i.i:                        ; preds = %for.body.i.121.i.i.301.i.i
  store i16 0, i16* %borrow.i.111.i.i.11.i.i, align 2
  br label %if.end.i.126.i.i.308.i.i

if.end.i.126.i.i.308.i.i:                         ; preds = %if.else.i.124.i.i.304.i.i, %if.then.i.123.i.i.303.i.i
  %491 = load i16, i16* %m.i.107.i.i.7.i.i, align 2
  %492 = load i16, i16* %s.i.108.i.i.8.i.i, align 2
  %sub4.i.i.i.305.i.i = sub i16 %491, %492
  store i16 %sub4.i.i.i.305.i.i, i16* %r.i.109.i.i.9.i.i, align 2
  %493 = load i16, i16* %r.i.109.i.i.9.i.i, align 2
  %494 = load i16, i16* %i.i.106.i.i.6.i.i, align 2
  %495 = load i16*, i16** %a.addr.i.103.i.i.3.i.i, align 2
  %arrayidx5.i.125.i.i.306.i.i = getelementptr inbounds i16, i16* %495, i16 %494
  store i16 %493, i16* %arrayidx5.i.125.i.i.306.i.i, align 2
  %496 = load i16, i16* %i.i.106.i.i.6.i.i, align 2
  %inc.i.127.i.i.307.i.i = add nsw i16 %496, 1
  store i16 %inc.i.127.i.i.307.i.i, i16* %i.i.106.i.i.6.i.i, align 2
  br label %for.cond.i.116.i.i.296.i.i

reduce_subtract.exit.i.i.310.i.i:                 ; preds = %for.cond.i.116.i.i.296.i.i
  store i16 35, i16* @curtask, align 2
  %497 = load i16, i16* %d.i.i.69.i.i, align 2
  %dec13.i.i.309.i.i = add i16 %497, -1
  store i16 %dec13.i.i.309.i.i, i16* %d.i.i.69.i.i, align 2
  br label %while.cond.i.i.174.i.i

while.end.i.i.311.i.i:                            ; preds = %while.cond.i.i.174.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312.i.i

mod_mult.exit312.i.i:                             ; preds = %while.end.i.i.311.i.i, %if.then.5.i.i.170.i.i
  %498 = load i16, i16* %e.addr.i.i, align 2
  %shr.i.i = lshr i16 %498, 1
  store i16 %shr.i.i, i16* %e.addr.i.i, align 2
  br label %while.cond.i.i

mod_exp.exit.i:                                   ; preds = %while.cond.i.i
  store i16 26, i16* @curtask, align 2
  store i16 0, i16* %i.i, align 2
  br label %for.cond.16.i

for.cond.16.i:                                    ; preds = %for.body.19.i, %mod_exp.exit.i
  %499 = load i16, i16* %i.i, align 2
  %cmp17.i = icmp slt i16 %499, 8
  br i1 %cmp17.i, label %for.body.19.i, label %for.end.26.i

for.body.19.i:                                    ; preds = %for.cond.16.i
  %500 = load i16, i16* %i.i, align 2
  %arrayidx20.i = getelementptr inbounds [16 x i16], [16 x i16]* @out_block, i16 0, i16 %500
  %501 = load i16, i16* %arrayidx20.i, align 2
  %conv21.i = trunc i16 %501 to i8
  %502 = load i16, i16* %out_block_offset.i, align 2
  %503 = load i16, i16* %i.i, align 2
  %add22.i = add i16 %502, %503
  %504 = load i8*, i8** %cyphertext.addr.i, align 2
  %arrayidx23.i = getelementptr inbounds i8, i8* %504, i16 %add22.i
  store i8 %conv21.i, i8* %arrayidx23.i, align 1
  %505 = load i16, i16* %i.i, align 2
  %inc25.i = add nsw i16 %505, 1
  store i16 %inc25.i, i16* %i.i, align 2
  br label %for.cond.16.i

for.end.26.i:                                     ; preds = %for.cond.16.i
  %506 = load i16, i16* %in_block_offset.i, align 2
  %add27.i = add i16 %506, 7
  store i16 %add27.i, i16* %in_block_offset.i, align 2
  %507 = load i16, i16* %out_block_offset.i, align 2
  %add28.i = add i16 %507, 8
  store i16 %add28.i, i16* %out_block_offset.i, align 2
  br label %while.cond.i

encrypt.exit:                                     ; preds = %while.cond.i
  %508 = load i16, i16* %out_block_offset.i, align 2
  %509 = load i16*, i16** %cyphertext_len.addr.i, align 2
  store i16 %508, i16* %509, align 2
  store i16 25, i16* @curtask, align 2
  store i16 12, i16* @curtask, align 2
  %510 = load i16, i16* @overflow, align 2
  %511 = load volatile i16, i16* @"\010x03D0", align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.21, i32 0, i32 0), i16 %510, i16 %511)
  %call1 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.22, i32 0, i32 0))
  %512 = load i16, i16* @CYPHERTEXT_LEN, align 2
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @CYPHERTEXT, i32 0, i32 0), i8** %m.addr.i, align 2
  store i16 %512, i16* %len.addr.i, align 2
  store i16 0, i16* %i.i.3, align 2
  br label %for.cond.i.5

for.cond.i.5:                                     ; preds = %for.end.36.i, %encrypt.exit
  %513 = load i16, i16* %i.i.3, align 2
  %514 = load i16, i16* %len.addr.i, align 2
  %cmp.i.4 = icmp ult i16 %513, %514
  br i1 %cmp.i.4, label %for.body.i.6, label %print_hex_ascii.exit

for.body.i.6:                                     ; preds = %for.cond.i.5
  store i16 0, i16* %j.i, align 2
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %for.body.4.i, %for.body.i.6
  %515 = load i16, i16* %j.i, align 2
  %cmp2.i.7 = icmp slt i16 %515, 8
  br i1 %cmp2.i.7, label %land.rhs.i, label %land.end.i

land.rhs.i:                                       ; preds = %for.cond.1.i
  %516 = load i16, i16* %i.i.3, align 2
  %517 = load i16, i16* %j.i, align 2
  %add.i.8 = add nsw i16 %516, %517
  %518 = load i16, i16* %len.addr.i, align 2
  %cmp3.i = icmp ult i16 %add.i.8, %518
  br label %land.end.i

land.end.i:                                       ; preds = %land.rhs.i, %for.cond.1.i
  %519 = phi i1 [ false, %for.cond.1.i ], [ %cmp3.i, %land.rhs.i ]
  br i1 %519, label %for.body.4.i, label %for.end.i.13

for.body.4.i:                                     ; preds = %land.end.i
  %520 = load i16, i16* %i.i.3, align 2
  %521 = load i16, i16* %j.i, align 2
  %add5.i = add nsw i16 %520, %521
  %522 = load i8*, i8** %m.addr.i, align 2
  %arrayidx.i.9 = getelementptr inbounds i8, i8* %522, i16 %add5.i
  %523 = load i8, i8* %arrayidx.i.9, align 1
  %conv.i.10 = zext i8 %523 to i16
  %call.i.11 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %conv.i.10) #4
  %524 = load i16, i16* %j.i, align 2
  %inc.i.12 = add nsw i16 %524, 1
  store i16 %inc.i.12, i16* %j.i, align 2
  br label %for.cond.1.i

for.end.i.13:                                     ; preds = %land.end.i
  br label %for.cond.6.i

for.cond.6.i:                                     ; preds = %for.body.9.i, %for.end.i.13
  %525 = load i16, i16* %j.i, align 2
  %cmp7.i = icmp slt i16 %525, 8
  br i1 %cmp7.i, label %for.body.9.i, label %for.end.13.i

for.body.9.i:                                     ; preds = %for.cond.6.i
  %call10.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0)) #4
  %526 = load i16, i16* %j.i, align 2
  %inc12.i = add nsw i16 %526, 1
  store i16 %inc12.i, i16* %j.i, align 2
  br label %for.cond.6.i

for.end.13.i:                                     ; preds = %for.cond.6.i
  %call14.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0)) #4
  store i16 0, i16* %j.i, align 2
  br label %for.cond.15.i

for.cond.15.i:                                    ; preds = %if.end.i, %for.end.13.i
  %527 = load i16, i16* %j.i, align 2
  %cmp16.i = icmp slt i16 %527, 8
  br i1 %cmp16.i, label %land.rhs.18.i, label %land.end.22.i

land.rhs.18.i:                                    ; preds = %for.cond.15.i
  %528 = load i16, i16* %i.i.3, align 2
  %529 = load i16, i16* %j.i, align 2
  %add19.i = add nsw i16 %528, %529
  %530 = load i16, i16* %len.addr.i, align 2
  %cmp20.i = icmp ult i16 %add19.i, %530
  br label %land.end.22.i

land.end.22.i:                                    ; preds = %land.rhs.18.i, %for.cond.15.i
  %531 = phi i1 [ false, %for.cond.15.i ], [ %cmp20.i, %land.rhs.18.i ]
  br i1 %531, label %for.body.23.i, label %for.end.36.i

for.body.23.i:                                    ; preds = %land.end.22.i
  %532 = load i16, i16* %i.i.3, align 2
  %533 = load i16, i16* %j.i, align 2
  %add24.i = add nsw i16 %532, %533
  %534 = load i8*, i8** %m.addr.i, align 2
  %arrayidx25.i = getelementptr inbounds i8, i8* %534, i16 %add24.i
  %535 = load i8, i8* %arrayidx25.i, align 1
  store i8 %535, i8* %c.i, align 1
  %536 = load i8, i8* %c.i, align 1
  %conv26.i = sext i8 %536 to i16
  %cmp27.i = icmp sle i16 32, %conv26.i
  br i1 %cmp27.i, label %land.lhs.true.i, label %if.then.i

land.lhs.true.i:                                  ; preds = %for.body.23.i
  %537 = load i8, i8* %c.i, align 1
  %conv29.i = sext i8 %537 to i16
  br label %if.end.i

if.then.i:                                        ; preds = %for.body.23.i
  store i8 46, i8* %c.i, align 1
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %land.lhs.true.i
  %538 = load i8, i8* %c.i, align 1
  %conv32.i = sext i8 %538 to i16
  %call33.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i16 %conv32.i) #4
  %539 = load i16, i16* %j.i, align 2
  %inc35.i = add nsw i16 %539, 1
  store i16 %inc35.i, i16* %j.i, align 2
  br label %for.cond.15.i

for.end.36.i:                                     ; preds = %land.end.22.i
  %call37.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)) #4
  %540 = load i16, i16* %i.i.3, align 2
  %add39.i = add nsw i16 %540, 8
  store i16 %add39.i, i16* %i.i.3, align 2
  br label %for.cond.i.5

print_hex_ascii.exit:                             ; preds = %for.cond.i.5
  br label %while.body

while.body:                                       ; preds = %print_hex_ascii.exit, %while.body
  br label %while.body

do.cond:                                          ; No predecessors!
  br i1 true, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  store i16 99, i16* @curtask, align 2
  br label %while.body.2

while.body.2:                                     ; preds = %do.end, %while.body.2
  br label %while.body.2

return:                                           ; No predecessors!
  %541 = load i16, i16* %retval, align 2
  ret i16 %541
}

; Function Attrs: nounwind
define internal void @init_hw() #3 {
entry:
  call void bitcast (void (...)* @msp_watchdog_disable to void ()*)()
  %0 = load volatile i16, i16* @"\010x0130", align 2
  %and = and i16 %0, -2
  store volatile i16 %and, i16* @"\010x0130", align 2
  call void bitcast (void (...)* @msp_clock_setup to void ()*)()
  ret void
}

declare void @msp_watchdog_disable(...) #2

declare void @msp_clock_setup(...) #2

attributes #0 = { noinline nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { alwaysinline nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (http://llvm.org/git/clang.git 5d5e0a9c209901f8d08ce6f71fcf11258e1ea946) (http://llvm.org/git/llvm.git 81386d4b4fdd80f038fd4ebddc59613770ea236c)"}
!1 = !{i32 -2146774693}
