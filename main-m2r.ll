; ModuleID = 'main-m2r.bc'
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
  %sub = sub i16 %digits, 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ %sub, %entry ], [ %dec, %for.inc ]
  %cmp = icmp sge i16 %i.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds i16, i16* %n, i16 %i.0
  %0 = load i16, i16* %arrayidx, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %0)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %dec = add nsw i16 %i.0, -1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare i16 @printf(i8*, ...) #2

; Function Attrs: alwaysinline nounwind
define void @log_bigint(i16* %n, i16 %digits) #1 {
entry:
  %sub = sub i16 %digits, 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ %sub, %entry ], [ %dec, %for.inc ]
  %cmp = icmp sge i16 %i.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds i16, i16* %n, i16 %i.0
  %0 = load i16, i16* %arrayidx, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %0)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %dec = add nsw i16 %i.0, -1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @print_hex_ascii(i8* %m, i16 %len) #1 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc.38, %entry
  %i.0 = phi i16 [ 0, %entry ], [ %add39, %for.inc.38 ]
  %cmp = icmp ult i16 %i.0, %len
  br i1 %cmp, label %for.body, label %for.end.40

for.body:                                         ; preds = %for.cond
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc, %for.body
  %j.0 = phi i16 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp slt i16 %j.0, 8
  br i1 %cmp2, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond.1
  %add = add nsw i16 %i.0, %j.0
  %cmp3 = icmp ult i16 %add, %len
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond.1
  %0 = phi i1 [ false, %for.cond.1 ], [ %cmp3, %land.rhs ]
  br i1 %0, label %for.body.4, label %for.end

for.body.4:                                       ; preds = %land.end
  %add5 = add nsw i16 %i.0, %j.0
  %arrayidx = getelementptr inbounds i8, i8* %m, i16 %add5
  %1 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %1 to i16
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %conv)
  br label %for.inc

for.inc:                                          ; preds = %for.body.4
  %inc = add nsw i16 %j.0, 1
  br label %for.cond.1

for.end:                                          ; preds = %land.end
  br label %for.cond.6

for.cond.6:                                       ; preds = %for.inc.11, %for.end
  %j.1 = phi i16 [ %j.0, %for.end ], [ %inc12, %for.inc.11 ]
  %cmp7 = icmp slt i16 %j.1, 8
  br i1 %cmp7, label %for.body.9, label %for.end.13

for.body.9:                                       ; preds = %for.cond.6
  %call10 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0))
  br label %for.inc.11

for.inc.11:                                       ; preds = %for.body.9
  %inc12 = add nsw i16 %j.1, 1
  br label %for.cond.6

for.end.13:                                       ; preds = %for.cond.6
  %call14 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  br label %for.cond.15

for.cond.15:                                      ; preds = %for.inc.34, %for.end.13
  %j.2 = phi i16 [ 0, %for.end.13 ], [ %inc35, %for.inc.34 ]
  %cmp16 = icmp slt i16 %j.2, 8
  br i1 %cmp16, label %land.rhs.18, label %land.end.22

land.rhs.18:                                      ; preds = %for.cond.15
  %add19 = add nsw i16 %i.0, %j.2
  %cmp20 = icmp ult i16 %add19, %len
  br label %land.end.22

land.end.22:                                      ; preds = %land.rhs.18, %for.cond.15
  %2 = phi i1 [ false, %for.cond.15 ], [ %cmp20, %land.rhs.18 ]
  br i1 %2, label %for.body.23, label %for.end.36

for.body.23:                                      ; preds = %land.end.22
  %add24 = add nsw i16 %i.0, %j.2
  %arrayidx25 = getelementptr inbounds i8, i8* %m, i16 %add24
  %3 = load i8, i8* %arrayidx25, align 1
  %conv26 = sext i8 %3 to i16
  %cmp27 = icmp sle i16 32, %conv26
  br i1 %cmp27, label %land.lhs.true, label %if.then

land.lhs.true:                                    ; preds = %for.body.23
  %conv29 = sext i8 %3 to i16
  %cmp30 = icmp sle i16 %conv29, 127
  br i1 %cmp30, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %for.body.23
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true
  %c.0 = phi i8 [ %3, %land.lhs.true ], [ 46, %if.then ]
  %conv32 = sext i8 %c.0 to i16
  %call33 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i16 %conv32)
  br label %for.inc.34

for.inc.34:                                       ; preds = %if.end
  %inc35 = add nsw i16 %j.2, 1
  br label %for.cond.15

for.end.36:                                       ; preds = %land.end.22
  %call37 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
  br label %for.inc.38

for.inc.38:                                       ; preds = %for.end.36
  %add39 = add nsw i16 %i.0, 8
  br label %for.cond

for.end.40:                                       ; preds = %for.cond
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @mult(i16* %a, i16* %b) #1 {
entry:
  store i16 3, i16* @curtask, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc.13, %entry
  %digit.0 = phi i16 [ 0, %entry ], [ %inc14, %for.inc.13 ]
  %carry.0 = phi i16 [ 0, %entry ], [ %add10, %for.inc.13 ]
  %cmp = icmp ult i16 %digit.0, 16
  br i1 %cmp, label %for.body, label %for.end.15

for.body:                                         ; preds = %for.cond
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc, %for.body
  %p.0 = phi i16 [ %carry.0, %for.body ], [ %p.1, %for.inc ]
  %i.0 = phi i16 [ 0, %for.body ], [ %inc, %for.inc ]
  %c.0 = phi i16 [ 0, %for.body ], [ %c.1, %for.inc ]
  %cmp2 = icmp slt i16 %i.0, 8
  br i1 %cmp2, label %for.body.3, label %for.end

for.body.3:                                       ; preds = %for.cond.1
  %cmp4 = icmp ule i16 %i.0, %digit.0
  br i1 %cmp4, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body.3
  %sub = sub i16 %digit.0, %i.0
  %cmp5 = icmp ult i16 %sub, 8
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %sub6 = sub i16 %digit.0, %i.0
  %arrayidx = getelementptr inbounds i16, i16* %a, i16 %sub6
  %0 = load i16, i16* %arrayidx, align 2
  %arrayidx7 = getelementptr inbounds i16, i16* %b, i16 %i.0
  %1 = load i16, i16* %arrayidx7, align 2
  %mul = mul i16 %0, %1
  %shr = lshr i16 %mul, 8
  %add = add i16 %c.0, %shr
  %and = and i16 %mul, 255
  %add8 = add i16 %p.0, %and
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body.3
  %p.1 = phi i16 [ %add8, %if.then ], [ %p.0, %land.lhs.true ], [ %p.0, %for.body.3 ]
  %c.1 = phi i16 [ %add, %if.then ], [ %c.0, %land.lhs.true ], [ %c.0, %for.body.3 ]
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i16 %i.0, 1
  br label %for.cond.1

for.end:                                          ; preds = %for.cond.1
  %shr9 = lshr i16 %p.0, 8
  %add10 = add i16 %c.0, %shr9
  %and11 = and i16 %p.0, 255
  %arrayidx12 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.0
  store i16 %and11, i16* %arrayidx12, align 2
  br label %for.inc.13

for.inc.13:                                       ; preds = %for.end
  %inc14 = add i16 %digit.0, 1
  br label %for.cond

for.end.15:                                       ; preds = %for.cond
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16

for.cond.16:                                      ; preds = %for.inc.21, %for.end.15
  %i.1 = phi i16 [ 0, %for.end.15 ], [ %inc22, %for.inc.21 ]
  %cmp17 = icmp slt i16 %i.1, 16
  br i1 %cmp17, label %for.body.18, label %for.end.23

for.body.18:                                      ; preds = %for.cond.16
  %arrayidx19 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.1
  %2 = load i16, i16* %arrayidx19, align 2
  %arrayidx20 = getelementptr inbounds i16, i16* %a, i16 %i.1
  store i16 %2, i16* %arrayidx20, align 2
  br label %for.inc.21

for.inc.21:                                       ; preds = %for.body.18
  %inc22 = add nsw i16 %i.1, 1
  br label %for.cond.16

for.end.23:                                       ; preds = %for.cond.16
  store i16 27, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define zeroext i1 @reduce_normalizable(i16* %m, i16* %n, i16 %d) #1 {
entry:
  store i16 6, i16* @curtask, align 2
  %add = add i16 %d, 1
  %sub = sub i16 %add, 8
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %d, i16 %sub)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ %d, %entry ], [ %dec, %for.inc ]
  %cmp = icmp sge i16 %i.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds i16, i16* %m, i16 %i.0
  %0 = load i16, i16* %arrayidx, align 2
  %sub1 = sub i16 %i.0, %sub
  %arrayidx2 = getelementptr inbounds i16, i16* %n, i16 %sub1
  %1 = load i16, i16* %arrayidx2, align 2
  %cmp3 = icmp ugt i16 %0, %1
  br i1 %cmp3, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  br label %for.end

if.else:                                          ; preds = %for.body
  %cmp4 = icmp ult i16 %0, %1
  br i1 %cmp4, label %if.then.5, label %if.end

if.then.5:                                        ; preds = %if.else
  br label %for.end

if.end:                                           ; preds = %if.else
  br label %if.end.6

if.end.6:                                         ; preds = %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end.6
  %dec = add nsw i16 %i.0, -1
  br label %for.cond

for.end:                                          ; preds = %if.then.5, %if.then, %for.cond
  %normalizable.0 = phi i8 [ 1, %if.then ], [ 0, %if.then.5 ], [ 1, %for.cond ]
  %tobool = trunc i8 %normalizable.0 to i1
  %conv = zext i1 %tobool to i16
  %call7 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv)
  store i16 30, i16* @curtask, align 2
  %tobool8 = trunc i8 %normalizable.0 to i1
  ret i1 %tobool8
}

; Function Attrs: alwaysinline nounwind
define void @reduce_normalize(i16* %m, i16* %n, i16 %digit) #1 {
entry:
  store i16 5, i16* @curtask, align 2
  %add = add i16 %digit, 1
  %sub = sub i16 %add, 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %for.inc ]
  %borrow.0 = phi i16 [ 0, %entry ], [ %borrow.1, %for.inc ]
  %cmp = icmp slt i16 %i.0, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 21, i16* @curtask, align 2
  %add1 = add i16 %i.0, %sub
  %arrayidx = getelementptr inbounds i16, i16* %m, i16 %add1
  %0 = load i16, i16* %arrayidx, align 2
  %arrayidx2 = getelementptr inbounds i16, i16* %n, i16 %i.0
  %1 = load i16, i16* %arrayidx2, align 2
  %add3 = add i16 %1, %borrow.0
  %cmp4 = icmp ult i16 %0, %add3
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %add5 = add i16 %0, 256
  br label %if.end

if.else:                                          ; preds = %for.body
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %m_d.0 = phi i16 [ %add5, %if.then ], [ %0, %if.else ]
  %borrow.1 = phi i16 [ 1, %if.then ], [ 0, %if.else ]
  %sub6 = sub i16 %m_d.0, %add3
  %add7 = add i16 %i.0, %sub
  %arrayidx8 = getelementptr inbounds i16, i16* %m, i16 %add7
  store i16 %sub6, i16* %arrayidx8, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 29, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce_quotient(i16* %quotient, i16* %m, i16* %n, i16 %d) #1 {
entry:
  %m_d = alloca [3 x i16], align 2
  store i16 16, i16* @curtask, align 2
  %arrayidx = getelementptr inbounds i16, i16* %n, i16 7
  %0 = load i16, i16* %arrayidx, align 2
  %shl = shl i16 %0, 8
  %arrayidx1 = getelementptr inbounds i16, i16* %n, i16 6
  %1 = load i16, i16* %arrayidx1, align 2
  %add = add i16 %shl, %1
  %arrayidx2 = getelementptr inbounds i16, i16* %n, i16 7
  %2 = load i16, i16* %arrayidx2, align 2
  %arrayidx3 = getelementptr inbounds i16, i16* %m, i16 %d
  %3 = load i16, i16* %arrayidx3, align 2
  %arrayidx4 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  store i16 %3, i16* %arrayidx4, align 2
  %sub = sub i16 %d, 1
  %arrayidx5 = getelementptr inbounds i16, i16* %m, i16 %sub
  %4 = load i16, i16* %arrayidx5, align 2
  %arrayidx6 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  store i16 %4, i16* %arrayidx6, align 2
  %sub7 = sub i16 %d, 2
  %arrayidx8 = getelementptr inbounds i16, i16* %m, i16 %sub7
  %5 = load i16, i16* %arrayidx8, align 2
  %arrayidx9 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  store i16 %5, i16* %arrayidx9, align 2
  %arrayidx10 = getelementptr inbounds i16, i16* %m, i16 2
  %6 = load i16, i16* %arrayidx10, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %2, i16 %6)
  store i16 17, i16* @curtask, align 2
  %arrayidx11 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %7 = load i16, i16* %arrayidx11, align 2
  %cmp = icmp eq i16 %7, %2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  br label %if.end

if.else:                                          ; preds = %entry
  %arrayidx12 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %8 = load i16, i16* %arrayidx12, align 2
  %shl13 = shl i16 %8, 8
  %arrayidx14 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %9 = load i16, i16* %arrayidx14, align 2
  %add15 = add i16 %shl13, %9
  %div = udiv i16 %add15, %2
  %call16 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15, i16 %div)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %q.0 = phi i16 [ 255, %if.then ], [ %div, %if.else ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %10 = load i16, i16* %arrayidx17, align 2
  %conv = zext i16 %10 to i32
  %shl18 = shl i32 %conv, 16
  %arrayidx19 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %11 = load i16, i16* %arrayidx19, align 2
  %shl20 = shl i16 %11, 8
  %conv21 = zext i16 %shl20 to i32
  %add22 = add i32 %shl18, %conv21
  %arrayidx23 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  %12 = load i16, i16* %arrayidx23, align 2
  %conv24 = zext i16 %12 to i32
  %add25 = add i32 %add22, %conv24
  %arrayidx26 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 2
  %13 = load i16, i16* %arrayidx26, align 2
  %arrayidx27 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 1
  %14 = load i16, i16* %arrayidx27, align 2
  %arrayidx28 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d, i16 0, i16 0
  %15 = load i16, i16* %arrayidx28, align 2
  %shr = lshr i32 %add25, 16
  %and = and i32 %shr, 65535
  %conv29 = trunc i32 %and to i16
  %and30 = and i32 %add25, 65535
  %conv31 = trunc i32 %and30 to i16
  %call32 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %13, i16 %14, i16 %15, i16 %conv29, i16 %conv31)
  %call33 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.0)
  %inc = add i16 %q.0, 1
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end
  %q.1 = phi i16 [ %inc, %if.end ], [ %dec, %do.cond ]
  store i16 19, i16* @curtask, align 2
  %dec = add i16 %q.1, -1
  %call34 = call i32 @mult16(i16 zeroext %add, i16 zeroext %dec)
  %shr35 = lshr i32 %call34, 16
  %and36 = and i32 %shr35, 65535
  %conv37 = trunc i32 %and36 to i16
  %and38 = and i32 %call34, 65535
  %conv39 = trunc i32 %and38 to i16
  %call40 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec, i16 %add, i16 %conv37, i16 %conv39)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %cmp41 = icmp ugt i32 %call34, %add25
  br i1 %cmp41, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %call43 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec)
  store i16 %dec, i16* %quotient, align 2
  store i16 32, i16* @curtask, align 2
  ret void
}

declare i32 @mult16(i16 zeroext, i16 zeroext) #2

; Function Attrs: alwaysinline nounwind
define void @reduce_multiply(i16* %product, i16 zeroext %q, i16* %n, i16 %d) #1 {
entry:
  store i16 9, i16* @curtask, align 2
  %sub = sub i16 %d, 8
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i16 %i.0, %sub
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds i16, i16* %product, i16 %i.0
  store i16 0, i16* %arrayidx, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %for.cond.1

for.cond.1:                                       ; preds = %for.inc.9, %for.end
  %i.1 = phi i16 [ %sub, %for.end ], [ %inc10, %for.inc.9 ]
  %c.0 = phi i16 [ 0, %for.end ], [ %shr, %for.inc.9 ]
  %cmp2 = icmp slt i16 %i.1, 16
  br i1 %cmp2, label %for.body.3, label %for.end.11

for.body.3:                                       ; preds = %for.cond.1
  store i16 24, i16* @curtask, align 2
  %add = add i16 %sub, 8
  %cmp4 = icmp ult i16 %i.1, %add
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body.3
  %sub5 = sub i16 %i.1, %sub
  %arrayidx6 = getelementptr inbounds i16, i16* %n, i16 %sub5
  %0 = load i16, i16* %arrayidx6, align 2
  %mul = mul i16 %q, %0
  %add7 = add i16 %c.0, %mul
  br label %if.end

if.else:                                          ; preds = %for.body.3
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p.0 = phi i16 [ %add7, %if.then ], [ %c.0, %if.else ]
  %shr = lshr i16 %p.0, 8
  %and = and i16 %p.0, 255
  %arrayidx8 = getelementptr inbounds i16, i16* %product, i16 %i.1
  store i16 %and, i16* %arrayidx8, align 2
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.end
  %inc10 = add nsw i16 %i.1, 1
  br label %for.cond.1

for.end.11:                                       ; preds = %for.cond.1
  store i16 33, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define i16 @reduce_compare(i16* %a, i16* %b) #1 {
entry:
  store i16 7, i16* @curtask, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ 15, %entry ], [ %dec, %for.inc ]
  %cmp = icmp sge i16 %i.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp1 = icmp ugt i16* %a, %b
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  br label %for.end

if.else:                                          ; preds = %for.body
  %cmp2 = icmp ult i16* %a, %b
  br i1 %cmp2, label %if.then.3, label %if.end

if.then.3:                                        ; preds = %if.else
  br label %for.end

if.end:                                           ; preds = %if.else
  br label %if.end.4

if.end.4:                                         ; preds = %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end.4
  %dec = add nsw i16 %i.0, -1
  br label %for.cond

for.end:                                          ; preds = %if.then.3, %if.then, %for.cond
  %relation.0 = phi i16 [ 1, %if.then ], [ -1, %if.then.3 ], [ 0, %for.cond ]
  store i16 31, i16* @curtask, align 2
  ret i16 %relation.0
}

; Function Attrs: alwaysinline nounwind
define void @reduce_add(i16* %a, i16* %b, i16 %d) #1 {
entry:
  store i16 10, i16* @curtask, align 2
  %sub = sub i16 %d, 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ %sub, %entry ], [ %inc, %for.inc ]
  %c.0 = phi i16 [ 0, %entry ], [ %shr, %for.inc ]
  %cmp = icmp slt i16 %i.0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 22, i16* @curtask, align 2
  %arrayidx = getelementptr inbounds i16, i16* %a, i16 %i.0
  %0 = load i16, i16* %arrayidx, align 2
  %sub1 = sub i16 %i.0, %sub
  %add = add i16 %sub, 8
  %cmp2 = icmp ult i16 %i.0, %add
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %arrayidx3 = getelementptr inbounds i16, i16* %b, i16 %sub1
  %1 = load i16, i16* %arrayidx3, align 2
  br label %if.end

if.else:                                          ; preds = %for.body
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %n.0 = phi i16 [ %1, %if.then ], [ 0, %if.else ]
  %add4 = add i16 %c.0, %0
  %add5 = add i16 %add4, %n.0
  %shr = lshr i16 %add5, 8
  %and = and i16 %add5, 255
  %arrayidx6 = getelementptr inbounds i16, i16* %a, i16 %i.0
  store i16 %and, i16* %arrayidx6, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 34, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce_subtract(i16* %a, i16* %b, i16 %d) #1 {
entry:
  store i16 11, i16* @curtask, align 2
  %sub = sub i16 %d, 8
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d, i16 %sub)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ %sub, %entry ], [ %inc, %for.inc ]
  %borrow.0 = phi i16 [ 0, %entry ], [ %borrow.1, %for.inc ]
  %cmp = icmp slt i16 %i.0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i16 23, i16* @curtask, align 2
  %arrayidx = getelementptr inbounds i16, i16* %a, i16 %i.0
  %0 = load i16, i16* %arrayidx, align 2
  %arrayidx1 = getelementptr inbounds i16, i16* %b, i16 %i.0
  %1 = load i16, i16* %arrayidx1, align 2
  %add = add i16 %1, %borrow.0
  %cmp2 = icmp ult i16 %0, %add
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %add3 = add i16 %0, 256
  br label %if.end

if.else:                                          ; preds = %for.body
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %m.0 = phi i16 [ %add3, %if.then ], [ %0, %if.else ]
  %borrow.1 = phi i16 [ 1, %if.then ], [ 0, %if.else ]
  %sub4 = sub i16 %m.0, %add
  %arrayidx5 = getelementptr inbounds i16, i16* %a, i16 %i.0
  store i16 %sub4, i16* %arrayidx5, align 2
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i16 35, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @reduce(i16* %m, i16* %n) #1 {
entry:
  %m_d.i.34 = alloca [3 x i16], align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body

do.body:                                          ; preds = %land.end, %entry
  %d.0 = phi i16 [ 16, %entry ], [ %dec, %land.end ]
  %dec = add i16 %d.0, -1
  %arrayidx = getelementptr inbounds i16, i16* %m, i16 %dec
  %0 = load i16, i16* %arrayidx, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec, i16 %0)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %cmp = icmp eq i16 %0, 0
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %do.cond
  %cmp1 = icmp ugt i16 %dec, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %do.cond
  %1 = phi i1 [ false, %do.cond ], [ %cmp1, %land.rhs ]
  br i1 %1, label %do.body, label %do.end

do.end:                                           ; preds = %land.end
  %call2 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec)
  store i16 6, i16* @curtask, align 2
  %add.i = add i16 %dec, 1
  %sub.i = sub i16 %add.i, 8
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec, i16 %sub.i) #4
  br label %for.cond.i

for.cond.i:                                       ; preds = %if.end.i, %do.end
  %i.i.0 = phi i16 [ %dec, %do.end ], [ %dec.i, %if.end.i ]
  %cmp.i = icmp sge i16 %i.i.0, 0
  br i1 %cmp.i, label %for.body.i, label %reduce_normalizable.exit

for.body.i:                                       ; preds = %for.cond.i
  %arrayidx.i = getelementptr inbounds i16, i16* %m, i16 %i.i.0
  %2 = load i16, i16* %arrayidx.i, align 2
  %sub1.i = sub i16 %i.i.0, %sub.i
  %arrayidx2.i = getelementptr inbounds i16, i16* %n, i16 %sub1.i
  %3 = load i16, i16* %arrayidx2.i, align 2
  %cmp3.i = icmp ugt i16 %2, %3
  br i1 %cmp3.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %for.body.i
  br label %reduce_normalizable.exit

if.else.i:                                        ; preds = %for.body.i
  %cmp4.i = icmp ult i16 %2, %3
  br i1 %cmp4.i, label %if.then.5.i, label %if.end.i

if.then.5.i:                                      ; preds = %if.else.i
  br label %reduce_normalizable.exit

if.end.i:                                         ; preds = %if.else.i
  %dec.i = add nsw i16 %i.i.0, -1
  br label %for.cond.i

reduce_normalizable.exit:                         ; preds = %for.cond.i, %if.then.i, %if.then.5.i
  %normalizable.i.0 = phi i8 [ 1, %if.then.i ], [ 0, %if.then.5.i ], [ 1, %for.cond.i ]
  %tobool.i = trunc i8 %normalizable.i.0 to i1
  %conv.i = zext i1 %tobool.i to i16
  %call7.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i = trunc i8 %normalizable.i.0 to i1
  br i1 %tobool8.i, label %if.then, label %if.else

if.then:                                          ; preds = %reduce_normalizable.exit
  store i16 5, i16* @curtask, align 2
  %add.i.20 = add i16 %dec, 1
  %sub.i.21 = sub i16 %add.i.20, 8
  br label %for.cond.i.23

for.cond.i.23:                                    ; preds = %if.end.i.30, %if.then
  %i.i.16.0 = phi i16 [ 0, %if.then ], [ %inc.i, %if.end.i.30 ]
  %borrow.i.0 = phi i16 [ 0, %if.then ], [ %borrow.i.1, %if.end.i.30 ]
  %cmp.i.22 = icmp slt i16 %i.i.16.0, 8
  br i1 %cmp.i.22, label %for.body.i.27, label %reduce_normalize.exit

for.body.i.27:                                    ; preds = %for.cond.i.23
  store i16 21, i16* @curtask, align 2
  %add1.i = add i16 %i.i.16.0, %sub.i.21
  %arrayidx.i.24 = getelementptr inbounds i16, i16* %m, i16 %add1.i
  %4 = load i16, i16* %arrayidx.i.24, align 2
  %arrayidx2.i.25 = getelementptr inbounds i16, i16* %n, i16 %i.i.16.0
  %5 = load i16, i16* %arrayidx2.i.25, align 2
  %add3.i = add i16 %5, %borrow.i.0
  %cmp4.i.26 = icmp ult i16 %4, %add3.i
  br i1 %cmp4.i.26, label %if.then.i.28, label %if.else.i.29

if.then.i.28:                                     ; preds = %for.body.i.27
  %add5.i = add i16 %4, 256
  br label %if.end.i.30

if.else.i.29:                                     ; preds = %for.body.i.27
  br label %if.end.i.30

if.end.i.30:                                      ; preds = %if.else.i.29, %if.then.i.28
  %m_d.i.17.0 = phi i16 [ %add5.i, %if.then.i.28 ], [ %4, %if.else.i.29 ]
  %borrow.i.1 = phi i16 [ 1, %if.then.i.28 ], [ 0, %if.else.i.29 ]
  %sub6.i = sub i16 %m_d.i.17.0, %add3.i
  %add7.i = add i16 %i.i.16.0, %sub.i.21
  %arrayidx8.i = getelementptr inbounds i16, i16* %m, i16 %add7.i
  store i16 %sub6.i, i16* %arrayidx8.i, align 2
  %inc.i = add nsw i16 %i.i.16.0, 1
  br label %for.cond.i.23

reduce_normalize.exit:                            ; preds = %for.cond.i.23
  store i16 29, i16* @curtask, align 2
  br label %if.end.7

if.else:                                          ; preds = %reduce_normalizable.exit
  %cmp4 = icmp eq i16 %dec, 7
  br i1 %cmp4, label %if.then.5, label %if.end

if.then.5:                                        ; preds = %if.else
  %call6 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0))
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end.7

if.end.7:                                         ; preds = %if.end, %reduce_normalize.exit
  br label %while.cond

while.cond:                                       ; preds = %reduce_subtract.exit, %if.end.7
  %d.1 = phi i16 [ %dec, %if.end.7 ], [ %dec13, %reduce_subtract.exit ]
  %cmp8 = icmp uge i16 %d.1, 8
  br i1 %cmp8, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35 = getelementptr inbounds i16, i16* %n, i16 7
  %6 = load i16, i16* %arrayidx.i.35, align 2
  %shl.i = shl i16 %6, 8
  %arrayidx1.i = getelementptr inbounds i16, i16* %n, i16 6
  %7 = load i16, i16* %arrayidx1.i, align 2
  %add.i.36 = add i16 %shl.i, %7
  %arrayidx2.i.37 = getelementptr inbounds i16, i16* %n, i16 7
  %8 = load i16, i16* %arrayidx2.i.37, align 2
  %arrayidx3.i = getelementptr inbounds i16, i16* %m, i16 %d.1
  %9 = load i16, i16* %arrayidx3.i, align 2
  %arrayidx4.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  store i16 %9, i16* %arrayidx4.i, align 2
  %sub.i.38 = sub i16 %d.1, 1
  %arrayidx5.i = getelementptr inbounds i16, i16* %m, i16 %sub.i.38
  %10 = load i16, i16* %arrayidx5.i, align 2
  %arrayidx6.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  store i16 %10, i16* %arrayidx6.i, align 2
  %sub7.i = sub i16 %d.1, 2
  %arrayidx8.i.39 = getelementptr inbounds i16, i16* %m, i16 %sub7.i
  %11 = load i16, i16* %arrayidx8.i.39, align 2
  %arrayidx9.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  store i16 %11, i16* %arrayidx9.i, align 2
  %arrayidx10.i = getelementptr inbounds i16, i16* %m, i16 2
  %12 = load i16, i16* %arrayidx10.i, align 2
  %call.i.40 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %8, i16 %12) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %13 = load i16, i16* %arrayidx11.i, align 2
  %cmp.i.41 = icmp eq i16 %13, %8
  br i1 %cmp.i.41, label %if.then.i.42, label %if.else.i.43

if.then.i.42:                                     ; preds = %while.body
  br label %if.end.i.46

if.else.i.43:                                     ; preds = %while.body
  %arrayidx12.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %14 = load i16, i16* %arrayidx12.i, align 2
  %shl13.i = shl i16 %14, 8
  %arrayidx14.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %15 = load i16, i16* %arrayidx14.i, align 2
  %add15.i = add i16 %shl13.i, %15
  %div.i = udiv i16 %add15.i, %8
  %call16.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i, i16 %div.i) #4
  br label %if.end.i.46

if.end.i.46:                                      ; preds = %if.else.i.43, %if.then.i.42
  %q.i.0 = phi i16 [ 255, %if.then.i.42 ], [ %div.i, %if.else.i.43 ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %16 = load i16, i16* %arrayidx17.i, align 2
  %conv.i.44 = zext i16 %16 to i32
  %shl18.i = shl i32 %conv.i.44, 16
  %arrayidx19.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %17 = load i16, i16* %arrayidx19.i, align 2
  %shl20.i = shl i16 %17, 8
  %conv21.i = zext i16 %shl20.i to i32
  %add22.i = add i32 %shl18.i, %conv21.i
  %arrayidx23.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  %18 = load i16, i16* %arrayidx23.i, align 2
  %conv24.i = zext i16 %18 to i32
  %add25.i = add i32 %add22.i, %conv24.i
  %arrayidx26.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 2
  %19 = load i16, i16* %arrayidx26.i, align 2
  %arrayidx27.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 1
  %20 = load i16, i16* %arrayidx27.i, align 2
  %arrayidx28.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34, i16 0, i16 0
  %21 = load i16, i16* %arrayidx28.i, align 2
  %shr.i = lshr i32 %add25.i, 16
  %and.i = and i32 %shr.i, 65535
  %conv29.i = trunc i32 %and.i to i16
  %and30.i = and i32 %add25.i, 65535
  %conv31.i = trunc i32 %and30.i to i16
  %call32.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %19, i16 %20, i16 %21, i16 %conv29.i, i16 %conv31.i) #4
  %call33.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.0) #4
  %inc.i.45 = add i16 %q.i.0, 1
  br label %do.body.i

do.body.i:                                        ; preds = %do.body.i, %if.end.i.46
  %q.i.1 = phi i16 [ %inc.i.45, %if.end.i.46 ], [ %dec.i.47, %do.body.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47 = add i16 %q.i.1, -1
  %call34.i = call i32 @mult16(i16 zeroext %add.i.36, i16 zeroext %dec.i.47) #4
  %shr35.i = lshr i32 %call34.i, 16
  %and36.i = and i32 %shr35.i, 65535
  %conv37.i = trunc i32 %and36.i to i16
  %and38.i = and i32 %call34.i, 65535
  %conv39.i = trunc i32 %and38.i to i16
  %call40.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47, i16 %add.i.36, i16 %conv37.i, i16 %conv39.i) #4
  %cmp41.i = icmp ugt i32 %call34.i, %add25.i
  br i1 %cmp41.i, label %do.body.i, label %reduce_quotient.exit

reduce_quotient.exit:                             ; preds = %do.body.i
  %call43.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52 = sub i16 %d.1, 8
  %call.i.53 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52) #4
  br label %for.cond.i.55

for.cond.i.55:                                    ; preds = %for.body.i.57, %reduce_quotient.exit
  %i.i.50.0 = phi i16 [ 0, %reduce_quotient.exit ], [ %inc.i.58, %for.body.i.57 ]
  %cmp.i.54 = icmp ult i16 %i.i.50.0, %sub.i.52
  br i1 %cmp.i.54, label %for.body.i.57, label %for.end.i

for.body.i.57:                                    ; preds = %for.cond.i.55
  %arrayidx.i.56 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.0
  store i16 0, i16* %arrayidx.i.56, align 2
  %inc.i.58 = add nsw i16 %i.i.50.0, 1
  br label %for.cond.i.55

for.end.i:                                        ; preds = %for.cond.i.55
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %if.end.i.68, %for.end.i
  %i.i.50.1 = phi i16 [ %sub.i.52, %for.end.i ], [ %inc10.i, %if.end.i.68 ]
  %c.i.0 = phi i16 [ 0, %for.end.i ], [ %shr.i.65, %if.end.i.68 ]
  %cmp2.i = icmp slt i16 %i.i.50.1, 16
  br i1 %cmp2.i, label %for.body.3.i, label %reduce_multiply.exit

for.body.3.i:                                     ; preds = %for.cond.1.i
  store i16 24, i16* @curtask, align 2
  %add.i.59 = add i16 %sub.i.52, 8
  %cmp4.i.60 = icmp ult i16 %i.i.50.1, %add.i.59
  br i1 %cmp4.i.60, label %if.then.i.63, label %if.else.i.64

if.then.i.63:                                     ; preds = %for.body.3.i
  %sub5.i = sub i16 %i.i.50.1, %sub.i.52
  %arrayidx6.i.61 = getelementptr inbounds i16, i16* %n, i16 %sub5.i
  %22 = load i16, i16* %arrayidx6.i.61, align 2
  %mul.i = mul i16 %dec.i.47, %22
  %add7.i.62 = add i16 %c.i.0, %mul.i
  br label %if.end.i.68

if.else.i.64:                                     ; preds = %for.body.3.i
  br label %if.end.i.68

if.end.i.68:                                      ; preds = %if.else.i.64, %if.then.i.63
  %p.i.0 = phi i16 [ %add7.i.62, %if.then.i.63 ], [ %c.i.0, %if.else.i.64 ]
  %shr.i.65 = lshr i16 %p.i.0, 8
  %and.i.66 = and i16 %p.i.0, 255
  %arrayidx8.i.67 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.1
  store i16 %and.i.66, i16* %arrayidx8.i.67, align 2
  %inc10.i = add nsw i16 %i.i.50.1, 1
  br label %for.cond.1.i

reduce_multiply.exit:                             ; preds = %for.cond.1.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71

for.cond.i.71:                                    ; preds = %if.end.i.76, %reduce_multiply.exit
  %i.i.69.0 = phi i16 [ 15, %reduce_multiply.exit ], [ %dec.i.77, %if.end.i.76 ]
  %cmp.i.70 = icmp sge i16 %i.i.69.0, 0
  br i1 %cmp.i.70, label %for.body.i.72, label %reduce_compare.exit

for.body.i.72:                                    ; preds = %for.cond.i.71
  %cmp1.i = icmp ugt i16* %m, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i, label %if.then.i.73, label %if.else.i.75

if.then.i.73:                                     ; preds = %for.body.i.72
  br label %reduce_compare.exit

if.else.i.75:                                     ; preds = %for.body.i.72
  %cmp2.i.74 = icmp ult i16* %m, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74, label %if.then.3.i, label %if.end.i.76

if.then.3.i:                                      ; preds = %if.else.i.75
  br label %reduce_compare.exit

if.end.i.76:                                      ; preds = %if.else.i.75
  %dec.i.77 = add nsw i16 %i.i.69.0, -1
  br label %for.cond.i.71

reduce_compare.exit:                              ; preds = %for.cond.i.71, %if.then.i.73, %if.then.3.i
  %relation.i.0 = phi i16 [ 1, %if.then.i.73 ], [ -1, %if.then.3.i ], [ 0, %for.cond.i.71 ]
  store i16 31, i16* @curtask, align 2
  %cmp10 = icmp slt i16 %relation.i.0, 0
  br i1 %cmp10, label %if.then.11, label %if.end.12

if.then.11:                                       ; preds = %reduce_compare.exit
  store i16 10, i16* @curtask, align 2
  %sub.i.85 = sub i16 %d.1, 8
  br label %for.cond.i.87

for.cond.i.87:                                    ; preds = %if.end.i.100, %if.then.11
  %c.i.84.0 = phi i16 [ 0, %if.then.11 ], [ %shr.i.97, %if.end.i.100 ]
  %i.i.82.0 = phi i16 [ %sub.i.85, %if.then.11 ], [ %inc.i.101, %if.end.i.100 ]
  %cmp.i.86 = icmp slt i16 %i.i.82.0, 16
  br i1 %cmp.i.86, label %for.body.i.92, label %reduce_add.exit

for.body.i.92:                                    ; preds = %for.cond.i.87
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88 = getelementptr inbounds i16, i16* %m, i16 %i.i.82.0
  %23 = load i16, i16* %arrayidx.i.88, align 2
  %sub1.i.89 = sub i16 %i.i.82.0, %sub.i.85
  %add.i.90 = add i16 %sub.i.85, 8
  %cmp2.i.91 = icmp ult i16 %i.i.82.0, %add.i.90
  br i1 %cmp2.i.91, label %if.then.i.94, label %if.else.i.95

if.then.i.94:                                     ; preds = %for.body.i.92
  %arrayidx3.i.93 = getelementptr inbounds i16, i16* %n, i16 %sub1.i.89
  %24 = load i16, i16* %arrayidx3.i.93, align 2
  br label %if.end.i.100

if.else.i.95:                                     ; preds = %for.body.i.92
  br label %if.end.i.100

if.end.i.100:                                     ; preds = %if.else.i.95, %if.then.i.94
  %n.i.0 = phi i16 [ %24, %if.then.i.94 ], [ 0, %if.else.i.95 ]
  %add4.i = add i16 %c.i.84.0, %23
  %add5.i.96 = add i16 %add4.i, %n.i.0
  %shr.i.97 = lshr i16 %add5.i.96, 8
  %and.i.98 = and i16 %add5.i.96, 255
  %arrayidx6.i.99 = getelementptr inbounds i16, i16* %m, i16 %i.i.82.0
  store i16 %and.i.98, i16* %arrayidx6.i.99, align 2
  %inc.i.101 = add nsw i16 %i.i.82.0, 1
  br label %for.cond.i.87

reduce_add.exit:                                  ; preds = %for.cond.i.87
  store i16 34, i16* @curtask, align 2
  br label %if.end.12

if.end.12:                                        ; preds = %reduce_add.exit, %reduce_compare.exit
  store i16 11, i16* @curtask, align 2
  %sub.i.113 = sub i16 %d.1, 8
  %call.i.114 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.1, i16 %sub.i.113) #4
  br label %for.cond.i.116

for.cond.i.116:                                   ; preds = %if.end.i.126, %if.end.12
  %borrow.i.111.0 = phi i16 [ 0, %if.end.12 ], [ %borrow.i.111.1, %if.end.i.126 ]
  %i.i.106.0 = phi i16 [ %sub.i.113, %if.end.12 ], [ %inc.i.127, %if.end.i.126 ]
  %cmp.i.115 = icmp slt i16 %i.i.106.0, 16
  br i1 %cmp.i.115, label %for.body.i.121, label %reduce_subtract.exit

for.body.i.121:                                   ; preds = %for.cond.i.116
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117 = getelementptr inbounds i16, i16* %m, i16 %i.i.106.0
  %25 = load i16, i16* %arrayidx.i.117, align 2
  %arrayidx1.i.118 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.0
  %26 = load i16, i16* %arrayidx1.i.118, align 2
  %add.i.119 = add i16 %26, %borrow.i.111.0
  %cmp2.i.120 = icmp ult i16 %25, %add.i.119
  br i1 %cmp2.i.120, label %if.then.i.123, label %if.else.i.124

if.then.i.123:                                    ; preds = %for.body.i.121
  %add3.i.122 = add i16 %25, 256
  br label %if.end.i.126

if.else.i.124:                                    ; preds = %for.body.i.121
  br label %if.end.i.126

if.end.i.126:                                     ; preds = %if.else.i.124, %if.then.i.123
  %borrow.i.111.1 = phi i16 [ 1, %if.then.i.123 ], [ 0, %if.else.i.124 ]
  %m.i.107.0 = phi i16 [ %add3.i.122, %if.then.i.123 ], [ %25, %if.else.i.124 ]
  %sub4.i = sub i16 %m.i.107.0, %add.i.119
  %arrayidx5.i.125 = getelementptr inbounds i16, i16* %m, i16 %i.i.106.0
  store i16 %sub4.i, i16* %arrayidx5.i.125, align 2
  %inc.i.127 = add nsw i16 %i.i.106.0, 1
  br label %for.cond.i.116

reduce_subtract.exit:                             ; preds = %for.cond.i.116
  store i16 35, i16* @curtask, align 2
  %dec13 = add i16 %d.1, -1
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
  %m_d.i.34.i = alloca [3 x i16], align 2
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.end.i, %entry
  %digit.i.0 = phi i16 [ 0, %entry ], [ %inc14.i, %for.end.i ]
  %carry.i.0 = phi i16 [ 0, %entry ], [ %add10.i, %for.end.i ]
  %cmp.i = icmp ult i16 %digit.i.0, 16
  br i1 %cmp.i, label %for.body.i, label %for.end.15.i

for.body.i:                                       ; preds = %for.cond.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %if.end.i, %for.body.i
  %i.i.0 = phi i16 [ 0, %for.body.i ], [ %inc.i, %if.end.i ]
  %p.i.0 = phi i16 [ %carry.i.0, %for.body.i ], [ %p.i.1, %if.end.i ]
  %c.i.0 = phi i16 [ 0, %for.body.i ], [ %c.i.1, %if.end.i ]
  %cmp2.i = icmp slt i16 %i.i.0, 8
  br i1 %cmp2.i, label %for.body.3.i, label %for.end.i

for.body.3.i:                                     ; preds = %for.cond.1.i
  %cmp4.i = icmp ule i16 %i.i.0, %digit.i.0
  br i1 %cmp4.i, label %land.lhs.true.i, label %if.end.i

land.lhs.true.i:                                  ; preds = %for.body.3.i
  %sub.i = sub i16 %digit.i.0, %i.i.0
  %cmp5.i = icmp ult i16 %sub.i, 8
  br i1 %cmp5.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %land.lhs.true.i
  %sub6.i = sub i16 %digit.i.0, %i.i.0
  %arrayidx.i = getelementptr inbounds i16, i16* %a, i16 %sub6.i
  %0 = load i16, i16* %arrayidx.i, align 2
  %arrayidx7.i = getelementptr inbounds i16, i16* %b, i16 %i.i.0
  %1 = load i16, i16* %arrayidx7.i, align 2
  %mul.i = mul i16 %0, %1
  %shr.i = lshr i16 %mul.i, 8
  %add.i = add i16 %c.i.0, %shr.i
  %and.i = and i16 %mul.i, 255
  %add8.i = add i16 %p.i.0, %and.i
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %land.lhs.true.i, %for.body.3.i
  %p.i.1 = phi i16 [ %add8.i, %if.then.i ], [ %p.i.0, %land.lhs.true.i ], [ %p.i.0, %for.body.3.i ]
  %c.i.1 = phi i16 [ %add.i, %if.then.i ], [ %c.i.0, %land.lhs.true.i ], [ %c.i.0, %for.body.3.i ]
  %inc.i = add nsw i16 %i.i.0, 1
  br label %for.cond.1.i

for.end.i:                                        ; preds = %for.cond.1.i
  %shr9.i = lshr i16 %p.i.0, 8
  %add10.i = add i16 %c.i.0, %shr9.i
  %and11.i = and i16 %p.i.0, 255
  %arrayidx12.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.0
  store i16 %and11.i, i16* %arrayidx12.i, align 2
  %inc14.i = add i16 %digit.i.0, 1
  br label %for.cond.i

for.end.15.i:                                     ; preds = %for.cond.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i

for.cond.16.i:                                    ; preds = %for.body.18.i, %for.end.15.i
  %i.i.1 = phi i16 [ 0, %for.end.15.i ], [ %inc22.i, %for.body.18.i ]
  %cmp17.i = icmp slt i16 %i.i.1, 16
  br i1 %cmp17.i, label %for.body.18.i, label %mult.exit

for.body.18.i:                                    ; preds = %for.cond.16.i
  %arrayidx19.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.1
  %2 = load i16, i16* %arrayidx19.i, align 2
  %arrayidx20.i = getelementptr inbounds i16, i16* %a, i16 %i.i.1
  store i16 %2, i16* %arrayidx20.i, align 2
  %inc22.i = add nsw i16 %i.i.1, 1
  br label %for.cond.16.i

mult.exit:                                        ; preds = %for.cond.16.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i

do.body.i:                                        ; preds = %land.end.i, %mult.exit
  %d.i.0 = phi i16 [ 16, %mult.exit ], [ %dec.i, %land.end.i ]
  %dec.i = add i16 %d.i.0, -1
  %arrayidx.i.1 = getelementptr inbounds i16, i16* %a, i16 %dec.i
  %3 = load i16, i16* %arrayidx.i.1, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i, i16 %3) #4
  %cmp.i.2 = icmp eq i16 %3, 0
  br i1 %cmp.i.2, label %land.rhs.i, label %land.end.i

land.rhs.i:                                       ; preds = %do.body.i
  %cmp1.i = icmp ugt i16 %dec.i, 0
  br label %land.end.i

land.end.i:                                       ; preds = %land.rhs.i, %do.body.i
  %4 = phi i1 [ false, %do.body.i ], [ %cmp1.i, %land.rhs.i ]
  br i1 %4, label %do.body.i, label %do.end.i

do.end.i:                                         ; preds = %land.end.i
  %call2.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i = add i16 %dec.i, 1
  %sub.i.i = sub i16 %add.i.i, 8
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i, i16 %sub.i.i) #4
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %if.end.i.i, %do.end.i
  %i.i.i.0 = phi i16 [ %dec.i, %do.end.i ], [ %dec.i.i, %if.end.i.i ]
  %cmp.i.i = icmp sge i16 %i.i.i.0, 0
  br i1 %cmp.i.i, label %for.body.i.i, label %reduce_normalizable.exit.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  %arrayidx.i.i = getelementptr inbounds i16, i16* %a, i16 %i.i.i.0
  %5 = load i16, i16* %arrayidx.i.i, align 2
  %sub1.i.i = sub i16 %i.i.i.0, %sub.i.i
  %arrayidx2.i.i = getelementptr inbounds i16, i16* %n, i16 %sub1.i.i
  %6 = load i16, i16* %arrayidx2.i.i, align 2
  %cmp3.i.i = icmp ugt i16 %5, %6
  br i1 %cmp3.i.i, label %if.then.i.i, label %if.else.i.i

if.then.i.i:                                      ; preds = %for.body.i.i
  br label %reduce_normalizable.exit.i

if.else.i.i:                                      ; preds = %for.body.i.i
  %cmp4.i.i = icmp ult i16 %5, %6
  br i1 %cmp4.i.i, label %if.then.5.i.i, label %if.end.i.i

if.then.5.i.i:                                    ; preds = %if.else.i.i
  br label %reduce_normalizable.exit.i

if.end.i.i:                                       ; preds = %if.else.i.i
  %dec.i.i = add nsw i16 %i.i.i.0, -1
  br label %for.cond.i.i

reduce_normalizable.exit.i:                       ; preds = %if.then.5.i.i, %if.then.i.i, %for.cond.i.i
  %normalizable.i.i.0 = phi i8 [ 1, %if.then.i.i ], [ 0, %if.then.5.i.i ], [ 1, %for.cond.i.i ]
  %tobool.i.i = trunc i8 %normalizable.i.i.0 to i1
  %conv.i.i = zext i1 %tobool.i.i to i16
  %call7.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i = trunc i8 %normalizable.i.i.0 to i1
  br i1 %tobool8.i.i, label %if.then.i.3, label %if.else.i

if.then.i.3:                                      ; preds = %reduce_normalizable.exit.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i = add i16 %dec.i, 1
  %sub.i.21.i = sub i16 %add.i.20.i, 8
  br label %for.cond.i.23.i

for.cond.i.23.i:                                  ; preds = %if.end.i.30.i, %if.then.i.3
  %i.i.16.i.0 = phi i16 [ 0, %if.then.i.3 ], [ %inc.i.i, %if.end.i.30.i ]
  %borrow.i.i.0 = phi i16 [ 0, %if.then.i.3 ], [ %borrow.i.i.1, %if.end.i.30.i ]
  %cmp.i.22.i = icmp slt i16 %i.i.16.i.0, 8
  br i1 %cmp.i.22.i, label %for.body.i.27.i, label %reduce_normalize.exit.i

for.body.i.27.i:                                  ; preds = %for.cond.i.23.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i = add i16 %i.i.16.i.0, %sub.i.21.i
  %arrayidx.i.24.i = getelementptr inbounds i16, i16* %a, i16 %add1.i.i
  %7 = load i16, i16* %arrayidx.i.24.i, align 2
  %arrayidx2.i.25.i = getelementptr inbounds i16, i16* %n, i16 %i.i.16.i.0
  %8 = load i16, i16* %arrayidx2.i.25.i, align 2
  %add3.i.i = add i16 %8, %borrow.i.i.0
  %cmp4.i.26.i = icmp ult i16 %7, %add3.i.i
  br i1 %cmp4.i.26.i, label %if.then.i.28.i, label %if.else.i.29.i

if.then.i.28.i:                                   ; preds = %for.body.i.27.i
  %add5.i.i = add i16 %7, 256
  br label %if.end.i.30.i

if.else.i.29.i:                                   ; preds = %for.body.i.27.i
  br label %if.end.i.30.i

if.end.i.30.i:                                    ; preds = %if.else.i.29.i, %if.then.i.28.i
  %m_d.i.17.i.0 = phi i16 [ %add5.i.i, %if.then.i.28.i ], [ %7, %if.else.i.29.i ]
  %borrow.i.i.1 = phi i16 [ 1, %if.then.i.28.i ], [ 0, %if.else.i.29.i ]
  %sub6.i.i = sub i16 %m_d.i.17.i.0, %add3.i.i
  %add7.i.i = add i16 %i.i.16.i.0, %sub.i.21.i
  %arrayidx8.i.i = getelementptr inbounds i16, i16* %a, i16 %add7.i.i
  store i16 %sub6.i.i, i16* %arrayidx8.i.i, align 2
  %inc.i.i = add nsw i16 %i.i.16.i.0, 1
  br label %for.cond.i.23.i

reduce_normalize.exit.i:                          ; preds = %for.cond.i.23.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i

if.else.i:                                        ; preds = %reduce_normalizable.exit.i
  %cmp4.i.4 = icmp eq i16 %dec.i, 7
  br i1 %cmp4.i.4, label %if.then.5.i, label %if.end.i.5

if.then.5.i:                                      ; preds = %if.else.i
  %call6.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %reduce.exit

if.end.i.5:                                       ; preds = %if.else.i
  br label %if.end.7.i

if.end.7.i:                                       ; preds = %if.end.i.5, %reduce_normalize.exit.i
  br label %while.cond.i

while.cond.i:                                     ; preds = %reduce_subtract.exit.i, %if.end.7.i
  %d.i.1 = phi i16 [ %dec.i, %if.end.7.i ], [ %dec13.i, %reduce_subtract.exit.i ]
  %cmp8.i = icmp uge i16 %d.i.1, 8
  br i1 %cmp8.i, label %while.body.i, label %while.end.i

while.body.i:                                     ; preds = %while.cond.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i = getelementptr inbounds i16, i16* %n, i16 7
  %9 = load i16, i16* %arrayidx.i.35.i, align 2
  %shl.i.i = shl i16 %9, 8
  %arrayidx1.i.i = getelementptr inbounds i16, i16* %n, i16 6
  %10 = load i16, i16* %arrayidx1.i.i, align 2
  %add.i.36.i = add i16 %shl.i.i, %10
  %arrayidx2.i.37.i = getelementptr inbounds i16, i16* %n, i16 7
  %11 = load i16, i16* %arrayidx2.i.37.i, align 2
  %arrayidx3.i.i = getelementptr inbounds i16, i16* %a, i16 %d.i.1
  %12 = load i16, i16* %arrayidx3.i.i, align 2
  %arrayidx4.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  store i16 %12, i16* %arrayidx4.i.i, align 2
  %sub.i.38.i = sub i16 %d.i.1, 1
  %arrayidx5.i.i = getelementptr inbounds i16, i16* %a, i16 %sub.i.38.i
  %13 = load i16, i16* %arrayidx5.i.i, align 2
  %arrayidx6.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  store i16 %13, i16* %arrayidx6.i.i, align 2
  %sub7.i.i = sub i16 %d.i.1, 2
  %arrayidx8.i.39.i = getelementptr inbounds i16, i16* %a, i16 %sub7.i.i
  %14 = load i16, i16* %arrayidx8.i.39.i, align 2
  %arrayidx9.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  store i16 %14, i16* %arrayidx9.i.i, align 2
  %arrayidx10.i.i = getelementptr inbounds i16, i16* %a, i16 2
  %15 = load i16, i16* %arrayidx10.i.i, align 2
  %call.i.40.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %11, i16 %15) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %16 = load i16, i16* %arrayidx11.i.i, align 2
  %cmp.i.41.i = icmp eq i16 %16, %11
  br i1 %cmp.i.41.i, label %if.then.i.42.i, label %if.else.i.43.i

if.then.i.42.i:                                   ; preds = %while.body.i
  br label %if.end.i.46.i

if.else.i.43.i:                                   ; preds = %while.body.i
  %arrayidx12.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %17 = load i16, i16* %arrayidx12.i.i, align 2
  %shl13.i.i = shl i16 %17, 8
  %arrayidx14.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %18 = load i16, i16* %arrayidx14.i.i, align 2
  %add15.i.i = add i16 %shl13.i.i, %18
  %div.i.i = udiv i16 %add15.i.i, %11
  %call16.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i, i16 %div.i.i) #4
  br label %if.end.i.46.i

if.end.i.46.i:                                    ; preds = %if.else.i.43.i, %if.then.i.42.i
  %q.i.i.0 = phi i16 [ 255, %if.then.i.42.i ], [ %div.i.i, %if.else.i.43.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %19 = load i16, i16* %arrayidx17.i.i, align 2
  %conv.i.44.i = zext i16 %19 to i32
  %shl18.i.i = shl i32 %conv.i.44.i, 16
  %arrayidx19.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %20 = load i16, i16* %arrayidx19.i.i, align 2
  %shl20.i.i = shl i16 %20, 8
  %conv21.i.i = zext i16 %shl20.i.i to i32
  %add22.i.i = add i32 %shl18.i.i, %conv21.i.i
  %arrayidx23.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  %21 = load i16, i16* %arrayidx23.i.i, align 2
  %conv24.i.i = zext i16 %21 to i32
  %add25.i.i = add i32 %add22.i.i, %conv24.i.i
  %arrayidx26.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 2
  %22 = load i16, i16* %arrayidx26.i.i, align 2
  %arrayidx27.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 1
  %23 = load i16, i16* %arrayidx27.i.i, align 2
  %arrayidx28.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i, i16 0, i16 0
  %24 = load i16, i16* %arrayidx28.i.i, align 2
  %shr.i.i = lshr i32 %add25.i.i, 16
  %and.i.i = and i32 %shr.i.i, 65535
  %conv29.i.i = trunc i32 %and.i.i to i16
  %and30.i.i = and i32 %add25.i.i, 65535
  %conv31.i.i = trunc i32 %and30.i.i to i16
  %call32.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %22, i16 %23, i16 %24, i16 %conv29.i.i, i16 %conv31.i.i) #4
  %call33.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.0) #4
  %inc.i.45.i = add i16 %q.i.i.0, 1
  br label %do.body.i.i

do.body.i.i:                                      ; preds = %do.body.i.i, %if.end.i.46.i
  %q.i.i.1 = phi i16 [ %inc.i.45.i, %if.end.i.46.i ], [ %dec.i.47.i, %do.body.i.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i = add i16 %q.i.i.1, -1
  %call34.i.i = call i32 @mult16(i16 zeroext %add.i.36.i, i16 zeroext %dec.i.47.i) #4
  %shr35.i.i = lshr i32 %call34.i.i, 16
  %and36.i.i = and i32 %shr35.i.i, 65535
  %conv37.i.i = trunc i32 %and36.i.i to i16
  %and38.i.i = and i32 %call34.i.i, 65535
  %conv39.i.i = trunc i32 %and38.i.i to i16
  %call40.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i, i16 %add.i.36.i, i16 %conv37.i.i, i16 %conv39.i.i) #4
  %cmp41.i.i = icmp ugt i32 %call34.i.i, %add25.i.i
  br i1 %cmp41.i.i, label %do.body.i.i, label %reduce_quotient.exit.i

reduce_quotient.exit.i:                           ; preds = %do.body.i.i
  %call43.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i = sub i16 %d.i.1, 8
  %call.i.53.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i) #4
  br label %for.cond.i.55.i

for.cond.i.55.i:                                  ; preds = %for.body.i.57.i, %reduce_quotient.exit.i
  %i.i.50.i.0 = phi i16 [ 0, %reduce_quotient.exit.i ], [ %inc.i.58.i, %for.body.i.57.i ]
  %cmp.i.54.i = icmp ult i16 %i.i.50.i.0, %sub.i.52.i
  br i1 %cmp.i.54.i, label %for.body.i.57.i, label %for.end.i.i

for.body.i.57.i:                                  ; preds = %for.cond.i.55.i
  %arrayidx.i.56.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.0
  store i16 0, i16* %arrayidx.i.56.i, align 2
  %inc.i.58.i = add nsw i16 %i.i.50.i.0, 1
  br label %for.cond.i.55.i

for.end.i.i:                                      ; preds = %for.cond.i.55.i
  br label %for.cond.1.i.i

for.cond.1.i.i:                                   ; preds = %if.end.i.68.i, %for.end.i.i
  %i.i.50.i.1 = phi i16 [ %sub.i.52.i, %for.end.i.i ], [ %inc10.i.i, %if.end.i.68.i ]
  %c.i.i.0 = phi i16 [ 0, %for.end.i.i ], [ %shr.i.65.i, %if.end.i.68.i ]
  %cmp2.i.i = icmp slt i16 %i.i.50.i.1, 16
  br i1 %cmp2.i.i, label %for.body.3.i.i, label %reduce_multiply.exit.i

for.body.3.i.i:                                   ; preds = %for.cond.1.i.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i = add i16 %sub.i.52.i, 8
  %cmp4.i.60.i = icmp ult i16 %i.i.50.i.1, %add.i.59.i
  br i1 %cmp4.i.60.i, label %if.then.i.63.i, label %if.else.i.64.i

if.then.i.63.i:                                   ; preds = %for.body.3.i.i
  %sub5.i.i = sub i16 %i.i.50.i.1, %sub.i.52.i
  %arrayidx6.i.61.i = getelementptr inbounds i16, i16* %n, i16 %sub5.i.i
  %25 = load i16, i16* %arrayidx6.i.61.i, align 2
  %mul.i.i = mul i16 %dec.i.47.i, %25
  %add7.i.62.i = add i16 %c.i.i.0, %mul.i.i
  br label %if.end.i.68.i

if.else.i.64.i:                                   ; preds = %for.body.3.i.i
  br label %if.end.i.68.i

if.end.i.68.i:                                    ; preds = %if.else.i.64.i, %if.then.i.63.i
  %p.i.i.0 = phi i16 [ %add7.i.62.i, %if.then.i.63.i ], [ %c.i.i.0, %if.else.i.64.i ]
  %shr.i.65.i = lshr i16 %p.i.i.0, 8
  %and.i.66.i = and i16 %p.i.i.0, 255
  %arrayidx8.i.67.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.1
  store i16 %and.i.66.i, i16* %arrayidx8.i.67.i, align 2
  %inc10.i.i = add nsw i16 %i.i.50.i.1, 1
  br label %for.cond.1.i.i

reduce_multiply.exit.i:                           ; preds = %for.cond.1.i.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i

for.cond.i.71.i:                                  ; preds = %if.end.i.76.i, %reduce_multiply.exit.i
  %i.i.69.i.0 = phi i16 [ 15, %reduce_multiply.exit.i ], [ %dec.i.77.i, %if.end.i.76.i ]
  %cmp.i.70.i = icmp sge i16 %i.i.69.i.0, 0
  br i1 %cmp.i.70.i, label %for.body.i.72.i, label %reduce_compare.exit.i

for.body.i.72.i:                                  ; preds = %for.cond.i.71.i
  %cmp1.i.i = icmp ugt i16* %a, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i, label %if.then.i.73.i, label %if.else.i.75.i

if.then.i.73.i:                                   ; preds = %for.body.i.72.i
  br label %reduce_compare.exit.i

if.else.i.75.i:                                   ; preds = %for.body.i.72.i
  %cmp2.i.74.i = icmp ult i16* %a, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i, label %if.then.3.i.i, label %if.end.i.76.i

if.then.3.i.i:                                    ; preds = %if.else.i.75.i
  br label %reduce_compare.exit.i

if.end.i.76.i:                                    ; preds = %if.else.i.75.i
  %dec.i.77.i = add nsw i16 %i.i.69.i.0, -1
  br label %for.cond.i.71.i

reduce_compare.exit.i:                            ; preds = %if.then.3.i.i, %if.then.i.73.i, %for.cond.i.71.i
  %relation.i.i.0 = phi i16 [ 1, %if.then.i.73.i ], [ -1, %if.then.3.i.i ], [ 0, %for.cond.i.71.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i = icmp slt i16 %relation.i.i.0, 0
  br i1 %cmp10.i, label %if.then.11.i, label %if.end.12.i

if.then.11.i:                                     ; preds = %reduce_compare.exit.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i = sub i16 %d.i.1, 8
  br label %for.cond.i.87.i

for.cond.i.87.i:                                  ; preds = %if.end.i.100.i, %if.then.11.i
  %c.i.84.i.0 = phi i16 [ 0, %if.then.11.i ], [ %shr.i.97.i, %if.end.i.100.i ]
  %i.i.82.i.0 = phi i16 [ %sub.i.85.i, %if.then.11.i ], [ %inc.i.101.i, %if.end.i.100.i ]
  %cmp.i.86.i = icmp slt i16 %i.i.82.i.0, 16
  br i1 %cmp.i.86.i, label %for.body.i.92.i, label %reduce_add.exit.i

for.body.i.92.i:                                  ; preds = %for.cond.i.87.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i = getelementptr inbounds i16, i16* %a, i16 %i.i.82.i.0
  %26 = load i16, i16* %arrayidx.i.88.i, align 2
  %sub1.i.89.i = sub i16 %i.i.82.i.0, %sub.i.85.i
  %add.i.90.i = add i16 %sub.i.85.i, 8
  %cmp2.i.91.i = icmp ult i16 %i.i.82.i.0, %add.i.90.i
  br i1 %cmp2.i.91.i, label %if.then.i.94.i, label %if.else.i.95.i

if.then.i.94.i:                                   ; preds = %for.body.i.92.i
  %arrayidx3.i.93.i = getelementptr inbounds i16, i16* %n, i16 %sub1.i.89.i
  %27 = load i16, i16* %arrayidx3.i.93.i, align 2
  br label %if.end.i.100.i

if.else.i.95.i:                                   ; preds = %for.body.i.92.i
  br label %if.end.i.100.i

if.end.i.100.i:                                   ; preds = %if.else.i.95.i, %if.then.i.94.i
  %n.i.i.0 = phi i16 [ %27, %if.then.i.94.i ], [ 0, %if.else.i.95.i ]
  %add4.i.i = add i16 %c.i.84.i.0, %26
  %add5.i.96.i = add i16 %add4.i.i, %n.i.i.0
  %shr.i.97.i = lshr i16 %add5.i.96.i, 8
  %and.i.98.i = and i16 %add5.i.96.i, 255
  %arrayidx6.i.99.i = getelementptr inbounds i16, i16* %a, i16 %i.i.82.i.0
  store i16 %and.i.98.i, i16* %arrayidx6.i.99.i, align 2
  %inc.i.101.i = add nsw i16 %i.i.82.i.0, 1
  br label %for.cond.i.87.i

reduce_add.exit.i:                                ; preds = %for.cond.i.87.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i

if.end.12.i:                                      ; preds = %reduce_add.exit.i, %reduce_compare.exit.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i = sub i16 %d.i.1, 8
  %call.i.114.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.1, i16 %sub.i.113.i) #4
  br label %for.cond.i.116.i

for.cond.i.116.i:                                 ; preds = %if.end.i.126.i, %if.end.12.i
  %borrow.i.111.i.0 = phi i16 [ 0, %if.end.12.i ], [ %borrow.i.111.i.1, %if.end.i.126.i ]
  %i.i.106.i.0 = phi i16 [ %sub.i.113.i, %if.end.12.i ], [ %inc.i.127.i, %if.end.i.126.i ]
  %cmp.i.115.i = icmp slt i16 %i.i.106.i.0, 16
  br i1 %cmp.i.115.i, label %for.body.i.121.i, label %reduce_subtract.exit.i

for.body.i.121.i:                                 ; preds = %for.cond.i.116.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i = getelementptr inbounds i16, i16* %a, i16 %i.i.106.i.0
  %28 = load i16, i16* %arrayidx.i.117.i, align 2
  %arrayidx1.i.118.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.0
  %29 = load i16, i16* %arrayidx1.i.118.i, align 2
  %add.i.119.i = add i16 %29, %borrow.i.111.i.0
  %cmp2.i.120.i = icmp ult i16 %28, %add.i.119.i
  br i1 %cmp2.i.120.i, label %if.then.i.123.i, label %if.else.i.124.i

if.then.i.123.i:                                  ; preds = %for.body.i.121.i
  %add3.i.122.i = add i16 %28, 256
  br label %if.end.i.126.i

if.else.i.124.i:                                  ; preds = %for.body.i.121.i
  br label %if.end.i.126.i

if.end.i.126.i:                                   ; preds = %if.else.i.124.i, %if.then.i.123.i
  %borrow.i.111.i.1 = phi i16 [ 1, %if.then.i.123.i ], [ 0, %if.else.i.124.i ]
  %m.i.107.i.0 = phi i16 [ %add3.i.122.i, %if.then.i.123.i ], [ %28, %if.else.i.124.i ]
  %sub4.i.i = sub i16 %m.i.107.i.0, %add.i.119.i
  %arrayidx5.i.125.i = getelementptr inbounds i16, i16* %a, i16 %i.i.106.i.0
  store i16 %sub4.i.i, i16* %arrayidx5.i.125.i, align 2
  %inc.i.127.i = add nsw i16 %i.i.106.i.0, 1
  br label %for.cond.i.116.i

reduce_subtract.exit.i:                           ; preds = %for.cond.i.116.i
  store i16 35, i16* @curtask, align 2
  %dec13.i = add i16 %d.i.1, -1
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
  %m_d.i.34.i.i = alloca [3 x i16], align 2
  store i16 2, i16* @curtask, align 2
  %arrayidx = getelementptr inbounds i16, i16* %out_block, i16 0
  store i16 1, i16* %arrayidx, align 2
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i16 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i16 %i.0, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx1 = getelementptr inbounds i16, i16* %out_block, i16 %i.0
  store i16 0, i16* %arrayidx1, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %while.cond

while.cond:                                       ; preds = %mod_mult.exit312, %for.end
  %e.addr.0 = phi i16 [ %e, %for.end ], [ %shr, %mod_mult.exit312 ]
  %cmp2 = icmp ugt i16 %e.addr.0, 0
  br i1 %cmp2, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i16 13, i16* @curtask, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %e.addr.0)
  %and = and i16 %e.addr.0, 1
  %tobool = icmp ne i16 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %for.end.i.i, %if.then
  %digit.i.i.0 = phi i16 [ 0, %if.then ], [ %inc14.i.i, %for.end.i.i ]
  %carry.i.i.0 = phi i16 [ 0, %if.then ], [ %add10.i.i, %for.end.i.i ]
  %cmp.i.i = icmp ult i16 %digit.i.i.0, 16
  br i1 %cmp.i.i, label %for.body.i.i, label %for.end.15.i.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i

for.cond.1.i.i:                                   ; preds = %if.end.i.i, %for.body.i.i
  %i.i.i.0 = phi i16 [ 0, %for.body.i.i ], [ %inc.i.i, %if.end.i.i ]
  %p.i.i.0 = phi i16 [ %carry.i.i.0, %for.body.i.i ], [ %p.i.i.1, %if.end.i.i ]
  %c.i.i.0 = phi i16 [ 0, %for.body.i.i ], [ %c.i.i.1, %if.end.i.i ]
  %cmp2.i.i = icmp slt i16 %i.i.i.0, 8
  br i1 %cmp2.i.i, label %for.body.3.i.i, label %for.end.i.i

for.body.3.i.i:                                   ; preds = %for.cond.1.i.i
  %cmp4.i.i = icmp ule i16 %i.i.i.0, %digit.i.i.0
  br i1 %cmp4.i.i, label %land.lhs.true.i.i, label %if.end.i.i

land.lhs.true.i.i:                                ; preds = %for.body.3.i.i
  %sub.i.i = sub i16 %digit.i.i.0, %i.i.i.0
  %cmp5.i.i = icmp ult i16 %sub.i.i, 8
  br i1 %cmp5.i.i, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %land.lhs.true.i.i
  %sub6.i.i = sub i16 %digit.i.i.0, %i.i.i.0
  %arrayidx.i.i = getelementptr inbounds i16, i16* %out_block, i16 %sub6.i.i
  %0 = load i16, i16* %arrayidx.i.i, align 2
  %arrayidx7.i.i = getelementptr inbounds i16, i16* %base, i16 %i.i.i.0
  %1 = load i16, i16* %arrayidx7.i.i, align 2
  %mul.i.i = mul i16 %0, %1
  %shr.i.i = lshr i16 %mul.i.i, 8
  %add.i.i = add i16 %c.i.i.0, %shr.i.i
  %and.i.i = and i16 %mul.i.i, 255
  %add8.i.i = add i16 %p.i.i.0, %and.i.i
  br label %if.end.i.i

if.end.i.i:                                       ; preds = %if.then.i.i, %land.lhs.true.i.i, %for.body.3.i.i
  %p.i.i.1 = phi i16 [ %add8.i.i, %if.then.i.i ], [ %p.i.i.0, %land.lhs.true.i.i ], [ %p.i.i.0, %for.body.3.i.i ]
  %c.i.i.1 = phi i16 [ %add.i.i, %if.then.i.i ], [ %c.i.i.0, %land.lhs.true.i.i ], [ %c.i.i.0, %for.body.3.i.i ]
  %inc.i.i = add nsw i16 %i.i.i.0, 1
  br label %for.cond.1.i.i

for.end.i.i:                                      ; preds = %for.cond.1.i.i
  %shr9.i.i = lshr i16 %p.i.i.0, 8
  %add10.i.i = add i16 %c.i.i.0, %shr9.i.i
  %and11.i.i = and i16 %p.i.i.0, 255
  %arrayidx12.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.0
  store i16 %and11.i.i, i16* %arrayidx12.i.i, align 2
  %inc14.i.i = add i16 %digit.i.i.0, 1
  br label %for.cond.i.i

for.end.15.i.i:                                   ; preds = %for.cond.i.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i

for.cond.16.i.i:                                  ; preds = %for.body.18.i.i, %for.end.15.i.i
  %i.i.i.1 = phi i16 [ 0, %for.end.15.i.i ], [ %inc22.i.i, %for.body.18.i.i ]
  %cmp17.i.i = icmp slt i16 %i.i.i.1, 16
  br i1 %cmp17.i.i, label %for.body.18.i.i, label %mult.exit.i

for.body.18.i.i:                                  ; preds = %for.cond.16.i.i
  %arrayidx19.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.1
  %2 = load i16, i16* %arrayidx19.i.i, align 2
  %arrayidx20.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.i.1
  store i16 %2, i16* %arrayidx20.i.i, align 2
  %inc22.i.i = add nsw i16 %i.i.i.1, 1
  br label %for.cond.16.i.i

mult.exit.i:                                      ; preds = %for.cond.16.i.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i

do.body.i.i:                                      ; preds = %land.end.i.i, %mult.exit.i
  %d.i.i.0 = phi i16 [ 16, %mult.exit.i ], [ %dec.i.i, %land.end.i.i ]
  %dec.i.i = add i16 %d.i.i.0, -1
  %arrayidx.i.1.i = getelementptr inbounds i16, i16* %out_block, i16 %dec.i.i
  %3 = load i16, i16* %arrayidx.i.1.i, align 2
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i, i16 %3) #4
  %cmp.i.2.i = icmp eq i16 %3, 0
  br i1 %cmp.i.2.i, label %land.rhs.i.i, label %land.end.i.i

land.rhs.i.i:                                     ; preds = %do.body.i.i
  %cmp1.i.i = icmp ugt i16 %dec.i.i, 0
  br label %land.end.i.i

land.end.i.i:                                     ; preds = %land.rhs.i.i, %do.body.i.i
  %4 = phi i1 [ false, %do.body.i.i ], [ %cmp1.i.i, %land.rhs.i.i ]
  br i1 %4, label %do.body.i.i, label %do.end.i.i

do.end.i.i:                                       ; preds = %land.end.i.i
  %call2.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i = add i16 %dec.i.i, 1
  %sub.i.i.i = sub i16 %add.i.i.i, 8
  %call.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i, i16 %sub.i.i.i) #4
  br label %for.cond.i.i.i

for.cond.i.i.i:                                   ; preds = %if.end.i.i.i, %do.end.i.i
  %i.i.i.i.0 = phi i16 [ %dec.i.i, %do.end.i.i ], [ %dec.i.i.i, %if.end.i.i.i ]
  %cmp.i.i.i = icmp sge i16 %i.i.i.i.0, 0
  br i1 %cmp.i.i.i, label %for.body.i.i.i, label %reduce_normalizable.exit.i.i

for.body.i.i.i:                                   ; preds = %for.cond.i.i.i
  %arrayidx.i.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.i.i.0
  %5 = load i16, i16* %arrayidx.i.i.i, align 2
  %sub1.i.i.i = sub i16 %i.i.i.i.0, %sub.i.i.i
  %arrayidx2.i.i.i = getelementptr inbounds i16, i16* %n, i16 %sub1.i.i.i
  %6 = load i16, i16* %arrayidx2.i.i.i, align 2
  %cmp3.i.i.i = icmp ugt i16 %5, %6
  br i1 %cmp3.i.i.i, label %if.then.i.i.i, label %if.else.i.i.i

if.then.i.i.i:                                    ; preds = %for.body.i.i.i
  br label %reduce_normalizable.exit.i.i

if.else.i.i.i:                                    ; preds = %for.body.i.i.i
  %cmp4.i.i.i = icmp ult i16 %5, %6
  br i1 %cmp4.i.i.i, label %if.then.5.i.i.i, label %if.end.i.i.i

if.then.5.i.i.i:                                  ; preds = %if.else.i.i.i
  br label %reduce_normalizable.exit.i.i

if.end.i.i.i:                                     ; preds = %if.else.i.i.i
  %dec.i.i.i = add nsw i16 %i.i.i.i.0, -1
  br label %for.cond.i.i.i

reduce_normalizable.exit.i.i:                     ; preds = %if.then.5.i.i.i, %if.then.i.i.i, %for.cond.i.i.i
  %normalizable.i.i.i.0 = phi i8 [ 1, %if.then.i.i.i ], [ 0, %if.then.5.i.i.i ], [ 1, %for.cond.i.i.i ]
  %tobool.i.i.i = trunc i8 %normalizable.i.i.i.0 to i1
  %conv.i.i.i = zext i1 %tobool.i.i.i to i16
  %call7.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i = trunc i8 %normalizable.i.i.i.0 to i1
  br i1 %tobool8.i.i.i, label %if.then.i.3.i, label %if.else.i.i

if.then.i.3.i:                                    ; preds = %reduce_normalizable.exit.i.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i = add i16 %dec.i.i, 1
  %sub.i.21.i.i = sub i16 %add.i.20.i.i, 8
  br label %for.cond.i.23.i.i

for.cond.i.23.i.i:                                ; preds = %if.end.i.30.i.i, %if.then.i.3.i
  %i.i.16.i.i.0 = phi i16 [ 0, %if.then.i.3.i ], [ %inc.i.i.i, %if.end.i.30.i.i ]
  %borrow.i.i.i.0 = phi i16 [ 0, %if.then.i.3.i ], [ %borrow.i.i.i.1, %if.end.i.30.i.i ]
  %cmp.i.22.i.i = icmp slt i16 %i.i.16.i.i.0, 8
  br i1 %cmp.i.22.i.i, label %for.body.i.27.i.i, label %reduce_normalize.exit.i.i

for.body.i.27.i.i:                                ; preds = %for.cond.i.23.i.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i = add i16 %i.i.16.i.i.0, %sub.i.21.i.i
  %arrayidx.i.24.i.i = getelementptr inbounds i16, i16* %out_block, i16 %add1.i.i.i
  %7 = load i16, i16* %arrayidx.i.24.i.i, align 2
  %arrayidx2.i.25.i.i = getelementptr inbounds i16, i16* %n, i16 %i.i.16.i.i.0
  %8 = load i16, i16* %arrayidx2.i.25.i.i, align 2
  %add3.i.i.i = add i16 %8, %borrow.i.i.i.0
  %cmp4.i.26.i.i = icmp ult i16 %7, %add3.i.i.i
  br i1 %cmp4.i.26.i.i, label %if.then.i.28.i.i, label %if.else.i.29.i.i

if.then.i.28.i.i:                                 ; preds = %for.body.i.27.i.i
  %add5.i.i.i = add i16 %7, 256
  br label %if.end.i.30.i.i

if.else.i.29.i.i:                                 ; preds = %for.body.i.27.i.i
  br label %if.end.i.30.i.i

if.end.i.30.i.i:                                  ; preds = %if.else.i.29.i.i, %if.then.i.28.i.i
  %m_d.i.17.i.i.0 = phi i16 [ %add5.i.i.i, %if.then.i.28.i.i ], [ %7, %if.else.i.29.i.i ]
  %borrow.i.i.i.1 = phi i16 [ 1, %if.then.i.28.i.i ], [ 0, %if.else.i.29.i.i ]
  %sub6.i.i.i = sub i16 %m_d.i.17.i.i.0, %add3.i.i.i
  %add7.i.i.i = add i16 %i.i.16.i.i.0, %sub.i.21.i.i
  %arrayidx8.i.i.i = getelementptr inbounds i16, i16* %out_block, i16 %add7.i.i.i
  store i16 %sub6.i.i.i, i16* %arrayidx8.i.i.i, align 2
  %inc.i.i.i = add nsw i16 %i.i.16.i.i.0, 1
  br label %for.cond.i.23.i.i

reduce_normalize.exit.i.i:                        ; preds = %for.cond.i.23.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i

if.else.i.i:                                      ; preds = %reduce_normalizable.exit.i.i
  %cmp4.i.4.i = icmp eq i16 %dec.i.i, 7
  br i1 %cmp4.i.4.i, label %if.then.5.i.i, label %if.end.i.5.i

if.then.5.i.i:                                    ; preds = %if.else.i.i
  %call6.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit

if.end.i.5.i:                                     ; preds = %if.else.i.i
  br label %if.end.7.i.i

if.end.7.i.i:                                     ; preds = %if.end.i.5.i, %reduce_normalize.exit.i.i
  br label %while.cond.i.i

while.cond.i.i:                                   ; preds = %reduce_subtract.exit.i.i, %if.end.7.i.i
  %d.i.i.1 = phi i16 [ %dec.i.i, %if.end.7.i.i ], [ %dec13.i.i, %reduce_subtract.exit.i.i ]
  %cmp8.i.i = icmp uge i16 %d.i.i.1, 8
  br i1 %cmp8.i.i, label %while.body.i.i, label %while.end.i.i

while.body.i.i:                                   ; preds = %while.cond.i.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i = getelementptr inbounds i16, i16* %n, i16 7
  %9 = load i16, i16* %arrayidx.i.35.i.i, align 2
  %shl.i.i.i = shl i16 %9, 8
  %arrayidx1.i.i.i = getelementptr inbounds i16, i16* %n, i16 6
  %10 = load i16, i16* %arrayidx1.i.i.i, align 2
  %add.i.36.i.i = add i16 %shl.i.i.i, %10
  %arrayidx2.i.37.i.i = getelementptr inbounds i16, i16* %n, i16 7
  %11 = load i16, i16* %arrayidx2.i.37.i.i, align 2
  %arrayidx3.i.i.i = getelementptr inbounds i16, i16* %out_block, i16 %d.i.i.1
  %12 = load i16, i16* %arrayidx3.i.i.i, align 2
  %arrayidx4.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  store i16 %12, i16* %arrayidx4.i.i.i, align 2
  %sub.i.38.i.i = sub i16 %d.i.i.1, 1
  %arrayidx5.i.i.i = getelementptr inbounds i16, i16* %out_block, i16 %sub.i.38.i.i
  %13 = load i16, i16* %arrayidx5.i.i.i, align 2
  %arrayidx6.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  store i16 %13, i16* %arrayidx6.i.i.i, align 2
  %sub7.i.i.i = sub i16 %d.i.i.1, 2
  %arrayidx8.i.39.i.i = getelementptr inbounds i16, i16* %out_block, i16 %sub7.i.i.i
  %14 = load i16, i16* %arrayidx8.i.39.i.i, align 2
  %arrayidx9.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  store i16 %14, i16* %arrayidx9.i.i.i, align 2
  %arrayidx10.i.i.i = getelementptr inbounds i16, i16* %out_block, i16 2
  %15 = load i16, i16* %arrayidx10.i.i.i, align 2
  %call.i.40.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %11, i16 %15) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %16 = load i16, i16* %arrayidx11.i.i.i, align 2
  %cmp.i.41.i.i = icmp eq i16 %16, %11
  br i1 %cmp.i.41.i.i, label %if.then.i.42.i.i, label %if.else.i.43.i.i

if.then.i.42.i.i:                                 ; preds = %while.body.i.i
  br label %if.end.i.46.i.i

if.else.i.43.i.i:                                 ; preds = %while.body.i.i
  %arrayidx12.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %17 = load i16, i16* %arrayidx12.i.i.i, align 2
  %shl13.i.i.i = shl i16 %17, 8
  %arrayidx14.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %18 = load i16, i16* %arrayidx14.i.i.i, align 2
  %add15.i.i.i = add i16 %shl13.i.i.i, %18
  %div.i.i.i = udiv i16 %add15.i.i.i, %11
  %call16.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i, i16 %div.i.i.i) #4
  br label %if.end.i.46.i.i

if.end.i.46.i.i:                                  ; preds = %if.else.i.43.i.i, %if.then.i.42.i.i
  %q.i.i.i.0 = phi i16 [ 255, %if.then.i.42.i.i ], [ %div.i.i.i, %if.else.i.43.i.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %19 = load i16, i16* %arrayidx17.i.i.i, align 2
  %conv.i.44.i.i = zext i16 %19 to i32
  %shl18.i.i.i = shl i32 %conv.i.44.i.i, 16
  %arrayidx19.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %20 = load i16, i16* %arrayidx19.i.i.i, align 2
  %shl20.i.i.i = shl i16 %20, 8
  %conv21.i.i.i = zext i16 %shl20.i.i.i to i32
  %add22.i.i.i = add i32 %shl18.i.i.i, %conv21.i.i.i
  %arrayidx23.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %21 = load i16, i16* %arrayidx23.i.i.i, align 2
  %conv24.i.i.i = zext i16 %21 to i32
  %add25.i.i.i = add i32 %add22.i.i.i, %conv24.i.i.i
  %arrayidx26.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %22 = load i16, i16* %arrayidx26.i.i.i, align 2
  %arrayidx27.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %23 = load i16, i16* %arrayidx27.i.i.i, align 2
  %arrayidx28.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %24 = load i16, i16* %arrayidx28.i.i.i, align 2
  %shr.i.i.i = lshr i32 %add25.i.i.i, 16
  %and.i.i.i = and i32 %shr.i.i.i, 65535
  %conv29.i.i.i = trunc i32 %and.i.i.i to i16
  %and30.i.i.i = and i32 %add25.i.i.i, 65535
  %conv31.i.i.i = trunc i32 %and30.i.i.i to i16
  %call32.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %22, i16 %23, i16 %24, i16 %conv29.i.i.i, i16 %conv31.i.i.i) #4
  %call33.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.0) #4
  %inc.i.45.i.i = add i16 %q.i.i.i.0, 1
  br label %do.body.i.i.i

do.body.i.i.i:                                    ; preds = %do.body.i.i.i, %if.end.i.46.i.i
  %q.i.i.i.1 = phi i16 [ %inc.i.45.i.i, %if.end.i.46.i.i ], [ %dec.i.47.i.i, %do.body.i.i.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i = add i16 %q.i.i.i.1, -1
  %call34.i.i.i = call i32 @mult16(i16 zeroext %add.i.36.i.i, i16 zeroext %dec.i.47.i.i) #4
  %shr35.i.i.i = lshr i32 %call34.i.i.i, 16
  %and36.i.i.i = and i32 %shr35.i.i.i, 65535
  %conv37.i.i.i = trunc i32 %and36.i.i.i to i16
  %and38.i.i.i = and i32 %call34.i.i.i, 65535
  %conv39.i.i.i = trunc i32 %and38.i.i.i to i16
  %call40.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i, i16 %add.i.36.i.i, i16 %conv37.i.i.i, i16 %conv39.i.i.i) #4
  %cmp41.i.i.i = icmp ugt i32 %call34.i.i.i, %add25.i.i.i
  br i1 %cmp41.i.i.i, label %do.body.i.i.i, label %reduce_quotient.exit.i.i

reduce_quotient.exit.i.i:                         ; preds = %do.body.i.i.i
  %call43.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i = sub i16 %d.i.i.1, 8
  %call.i.53.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i) #4
  br label %for.cond.i.55.i.i

for.cond.i.55.i.i:                                ; preds = %for.body.i.57.i.i, %reduce_quotient.exit.i.i
  %i.i.50.i.i.0 = phi i16 [ 0, %reduce_quotient.exit.i.i ], [ %inc.i.58.i.i, %for.body.i.57.i.i ]
  %cmp.i.54.i.i = icmp ult i16 %i.i.50.i.i.0, %sub.i.52.i.i
  br i1 %cmp.i.54.i.i, label %for.body.i.57.i.i, label %for.end.i.i.i

for.body.i.57.i.i:                                ; preds = %for.cond.i.55.i.i
  %arrayidx.i.56.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.0
  store i16 0, i16* %arrayidx.i.56.i.i, align 2
  %inc.i.58.i.i = add nsw i16 %i.i.50.i.i.0, 1
  br label %for.cond.i.55.i.i

for.end.i.i.i:                                    ; preds = %for.cond.i.55.i.i
  br label %for.cond.1.i.i.i

for.cond.1.i.i.i:                                 ; preds = %if.end.i.68.i.i, %for.end.i.i.i
  %i.i.50.i.i.1 = phi i16 [ %sub.i.52.i.i, %for.end.i.i.i ], [ %inc10.i.i.i, %if.end.i.68.i.i ]
  %c.i.i.i.0 = phi i16 [ 0, %for.end.i.i.i ], [ %shr.i.65.i.i, %if.end.i.68.i.i ]
  %cmp2.i.i.i = icmp slt i16 %i.i.50.i.i.1, 16
  br i1 %cmp2.i.i.i, label %for.body.3.i.i.i, label %reduce_multiply.exit.i.i

for.body.3.i.i.i:                                 ; preds = %for.cond.1.i.i.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i = add i16 %sub.i.52.i.i, 8
  %cmp4.i.60.i.i = icmp ult i16 %i.i.50.i.i.1, %add.i.59.i.i
  br i1 %cmp4.i.60.i.i, label %if.then.i.63.i.i, label %if.else.i.64.i.i

if.then.i.63.i.i:                                 ; preds = %for.body.3.i.i.i
  %sub5.i.i.i = sub i16 %i.i.50.i.i.1, %sub.i.52.i.i
  %arrayidx6.i.61.i.i = getelementptr inbounds i16, i16* %n, i16 %sub5.i.i.i
  %25 = load i16, i16* %arrayidx6.i.61.i.i, align 2
  %mul.i.i.i = mul i16 %dec.i.47.i.i, %25
  %add7.i.62.i.i = add i16 %c.i.i.i.0, %mul.i.i.i
  br label %if.end.i.68.i.i

if.else.i.64.i.i:                                 ; preds = %for.body.3.i.i.i
  br label %if.end.i.68.i.i

if.end.i.68.i.i:                                  ; preds = %if.else.i.64.i.i, %if.then.i.63.i.i
  %p.i.i.i.0 = phi i16 [ %add7.i.62.i.i, %if.then.i.63.i.i ], [ %c.i.i.i.0, %if.else.i.64.i.i ]
  %shr.i.65.i.i = lshr i16 %p.i.i.i.0, 8
  %and.i.66.i.i = and i16 %p.i.i.i.0, 255
  %arrayidx8.i.67.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.1
  store i16 %and.i.66.i.i, i16* %arrayidx8.i.67.i.i, align 2
  %inc10.i.i.i = add nsw i16 %i.i.50.i.i.1, 1
  br label %for.cond.1.i.i.i

reduce_multiply.exit.i.i:                         ; preds = %for.cond.1.i.i.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i

for.cond.i.71.i.i:                                ; preds = %if.end.i.76.i.i, %reduce_multiply.exit.i.i
  %i.i.69.i.i.0 = phi i16 [ 15, %reduce_multiply.exit.i.i ], [ %dec.i.77.i.i, %if.end.i.76.i.i ]
  %cmp.i.70.i.i = icmp sge i16 %i.i.69.i.i.0, 0
  br i1 %cmp.i.70.i.i, label %for.body.i.72.i.i, label %reduce_compare.exit.i.i

for.body.i.72.i.i:                                ; preds = %for.cond.i.71.i.i
  %cmp1.i.i.i = icmp ugt i16* %out_block, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i, label %if.then.i.73.i.i, label %if.else.i.75.i.i

if.then.i.73.i.i:                                 ; preds = %for.body.i.72.i.i
  br label %reduce_compare.exit.i.i

if.else.i.75.i.i:                                 ; preds = %for.body.i.72.i.i
  %cmp2.i.74.i.i = icmp ult i16* %out_block, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i, label %if.then.3.i.i.i, label %if.end.i.76.i.i

if.then.3.i.i.i:                                  ; preds = %if.else.i.75.i.i
  br label %reduce_compare.exit.i.i

if.end.i.76.i.i:                                  ; preds = %if.else.i.75.i.i
  %dec.i.77.i.i = add nsw i16 %i.i.69.i.i.0, -1
  br label %for.cond.i.71.i.i

reduce_compare.exit.i.i:                          ; preds = %if.then.3.i.i.i, %if.then.i.73.i.i, %for.cond.i.71.i.i
  %relation.i.i.i.0 = phi i16 [ 1, %if.then.i.73.i.i ], [ -1, %if.then.3.i.i.i ], [ 0, %for.cond.i.71.i.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i = icmp slt i16 %relation.i.i.i.0, 0
  br i1 %cmp10.i.i, label %if.then.11.i.i, label %if.end.12.i.i

if.then.11.i.i:                                   ; preds = %reduce_compare.exit.i.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i = sub i16 %d.i.i.1, 8
  br label %for.cond.i.87.i.i

for.cond.i.87.i.i:                                ; preds = %if.end.i.100.i.i, %if.then.11.i.i
  %i.i.82.i.i.0 = phi i16 [ %sub.i.85.i.i, %if.then.11.i.i ], [ %inc.i.101.i.i, %if.end.i.100.i.i ]
  %c.i.84.i.i.0 = phi i16 [ 0, %if.then.11.i.i ], [ %shr.i.97.i.i, %if.end.i.100.i.i ]
  %cmp.i.86.i.i = icmp slt i16 %i.i.82.i.i.0, 16
  br i1 %cmp.i.86.i.i, label %for.body.i.92.i.i, label %reduce_add.exit.i.i

for.body.i.92.i.i:                                ; preds = %for.cond.i.87.i.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.82.i.i.0
  %26 = load i16, i16* %arrayidx.i.88.i.i, align 2
  %sub1.i.89.i.i = sub i16 %i.i.82.i.i.0, %sub.i.85.i.i
  %add.i.90.i.i = add i16 %sub.i.85.i.i, 8
  %cmp2.i.91.i.i = icmp ult i16 %i.i.82.i.i.0, %add.i.90.i.i
  br i1 %cmp2.i.91.i.i, label %if.then.i.94.i.i, label %if.else.i.95.i.i

if.then.i.94.i.i:                                 ; preds = %for.body.i.92.i.i
  %arrayidx3.i.93.i.i = getelementptr inbounds i16, i16* %n, i16 %sub1.i.89.i.i
  %27 = load i16, i16* %arrayidx3.i.93.i.i, align 2
  br label %if.end.i.100.i.i

if.else.i.95.i.i:                                 ; preds = %for.body.i.92.i.i
  br label %if.end.i.100.i.i

if.end.i.100.i.i:                                 ; preds = %if.else.i.95.i.i, %if.then.i.94.i.i
  %n.i.i.i.0 = phi i16 [ %27, %if.then.i.94.i.i ], [ 0, %if.else.i.95.i.i ]
  %add4.i.i.i = add i16 %c.i.84.i.i.0, %26
  %add5.i.96.i.i = add i16 %add4.i.i.i, %n.i.i.i.0
  %shr.i.97.i.i = lshr i16 %add5.i.96.i.i, 8
  %and.i.98.i.i = and i16 %add5.i.96.i.i, 255
  %arrayidx6.i.99.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.82.i.i.0
  store i16 %and.i.98.i.i, i16* %arrayidx6.i.99.i.i, align 2
  %inc.i.101.i.i = add nsw i16 %i.i.82.i.i.0, 1
  br label %for.cond.i.87.i.i

reduce_add.exit.i.i:                              ; preds = %for.cond.i.87.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i

if.end.12.i.i:                                    ; preds = %reduce_add.exit.i.i, %reduce_compare.exit.i.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i = sub i16 %d.i.i.1, 8
  %call.i.114.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.1, i16 %sub.i.113.i.i) #4
  br label %for.cond.i.116.i.i

for.cond.i.116.i.i:                               ; preds = %if.end.i.126.i.i, %if.end.12.i.i
  %i.i.106.i.i.0 = phi i16 [ %sub.i.113.i.i, %if.end.12.i.i ], [ %inc.i.127.i.i, %if.end.i.126.i.i ]
  %borrow.i.111.i.i.0 = phi i16 [ 0, %if.end.12.i.i ], [ %borrow.i.111.i.i.1, %if.end.i.126.i.i ]
  %cmp.i.115.i.i = icmp slt i16 %i.i.106.i.i.0, 16
  br i1 %cmp.i.115.i.i, label %for.body.i.121.i.i, label %reduce_subtract.exit.i.i

for.body.i.121.i.i:                               ; preds = %for.cond.i.116.i.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.106.i.i.0
  %28 = load i16, i16* %arrayidx.i.117.i.i, align 2
  %arrayidx1.i.118.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.0
  %29 = load i16, i16* %arrayidx1.i.118.i.i, align 2
  %add.i.119.i.i = add i16 %29, %borrow.i.111.i.i.0
  %cmp2.i.120.i.i = icmp ult i16 %28, %add.i.119.i.i
  br i1 %cmp2.i.120.i.i, label %if.then.i.123.i.i, label %if.else.i.124.i.i

if.then.i.123.i.i:                                ; preds = %for.body.i.121.i.i
  %add3.i.122.i.i = add i16 %28, 256
  br label %if.end.i.126.i.i

if.else.i.124.i.i:                                ; preds = %for.body.i.121.i.i
  br label %if.end.i.126.i.i

if.end.i.126.i.i:                                 ; preds = %if.else.i.124.i.i, %if.then.i.123.i.i
  %m.i.107.i.i.0 = phi i16 [ %add3.i.122.i.i, %if.then.i.123.i.i ], [ %28, %if.else.i.124.i.i ]
  %borrow.i.111.i.i.1 = phi i16 [ 1, %if.then.i.123.i.i ], [ 0, %if.else.i.124.i.i ]
  %sub4.i.i.i = sub i16 %m.i.107.i.i.0, %add.i.119.i.i
  %arrayidx5.i.125.i.i = getelementptr inbounds i16, i16* %out_block, i16 %i.i.106.i.i.0
  store i16 %sub4.i.i.i, i16* %arrayidx5.i.125.i.i, align 2
  %inc.i.127.i.i = add nsw i16 %i.i.106.i.i.0, 1
  br label %for.cond.i.116.i.i

reduce_subtract.exit.i.i:                         ; preds = %for.cond.i.116.i.i
  store i16 35, i16* @curtask, align 2
  %dec13.i.i = add i16 %d.i.i.1, -1
  br label %while.cond.i.i

while.end.i.i:                                    ; preds = %while.cond.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit

mod_mult.exit:                                    ; preds = %if.then.5.i.i, %while.end.i.i
  br label %if.end

if.end:                                           ; preds = %mod_mult.exit, %while.body
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i.82

for.cond.i.i.82:                                  ; preds = %for.end.i.i.107, %if.end
  %digit.i.i.73.0 = phi i16 [ 0, %if.end ], [ %inc14.i.i.106, %for.end.i.i.107 ]
  %carry.i.i.77.0 = phi i16 [ 0, %if.end ], [ %add10.i.i.103, %for.end.i.i.107 ]
  %cmp.i.i.81 = icmp ult i16 %digit.i.i.73.0, 16
  br i1 %cmp.i.i.81, label %for.body.i.i.83, label %for.end.15.i.i.108

for.body.i.i.83:                                  ; preds = %for.cond.i.i.82
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i.85

for.cond.1.i.i.85:                                ; preds = %if.end.i.i.101, %for.body.i.i.83
  %i.i.i.72.0 = phi i16 [ 0, %for.body.i.i.83 ], [ %inc.i.i.100, %if.end.i.i.101 ]
  %p.i.i.74.0 = phi i16 [ %carry.i.i.77.0, %for.body.i.i.83 ], [ %p.i.i.74.1, %if.end.i.i.101 ]
  %c.i.i.75.0 = phi i16 [ 0, %for.body.i.i.83 ], [ %c.i.i.75.1, %if.end.i.i.101 ]
  %cmp2.i.i.84 = icmp slt i16 %i.i.i.72.0, 8
  br i1 %cmp2.i.i.84, label %for.body.3.i.i.87, label %for.end.i.i.107

for.body.3.i.i.87:                                ; preds = %for.cond.1.i.i.85
  %cmp4.i.i.86 = icmp ule i16 %i.i.i.72.0, %digit.i.i.73.0
  br i1 %cmp4.i.i.86, label %land.lhs.true.i.i.90, label %if.end.i.i.101

land.lhs.true.i.i.90:                             ; preds = %for.body.3.i.i.87
  %sub.i.i.88 = sub i16 %digit.i.i.73.0, %i.i.i.72.0
  %cmp5.i.i.89 = icmp ult i16 %sub.i.i.88, 8
  br i1 %cmp5.i.i.89, label %if.then.i.i.99, label %if.end.i.i.101

if.then.i.i.99:                                   ; preds = %land.lhs.true.i.i.90
  %sub6.i.i.91 = sub i16 %digit.i.i.73.0, %i.i.i.72.0
  %arrayidx.i.i.92 = getelementptr inbounds i16, i16* %base, i16 %sub6.i.i.91
  %30 = load i16, i16* %arrayidx.i.i.92, align 2
  %arrayidx7.i.i.93 = getelementptr inbounds i16, i16* %base, i16 %i.i.i.72.0
  %31 = load i16, i16* %arrayidx7.i.i.93, align 2
  %mul.i.i.94 = mul i16 %30, %31
  %shr.i.i.95 = lshr i16 %mul.i.i.94, 8
  %add.i.i.96 = add i16 %c.i.i.75.0, %shr.i.i.95
  %and.i.i.97 = and i16 %mul.i.i.94, 255
  %add8.i.i.98 = add i16 %p.i.i.74.0, %and.i.i.97
  br label %if.end.i.i.101

if.end.i.i.101:                                   ; preds = %if.then.i.i.99, %land.lhs.true.i.i.90, %for.body.3.i.i.87
  %p.i.i.74.1 = phi i16 [ %add8.i.i.98, %if.then.i.i.99 ], [ %p.i.i.74.0, %land.lhs.true.i.i.90 ], [ %p.i.i.74.0, %for.body.3.i.i.87 ]
  %c.i.i.75.1 = phi i16 [ %add.i.i.96, %if.then.i.i.99 ], [ %c.i.i.75.0, %land.lhs.true.i.i.90 ], [ %c.i.i.75.0, %for.body.3.i.i.87 ]
  %inc.i.i.100 = add nsw i16 %i.i.i.72.0, 1
  br label %for.cond.1.i.i.85

for.end.i.i.107:                                  ; preds = %for.cond.1.i.i.85
  %shr9.i.i.102 = lshr i16 %p.i.i.74.0, 8
  %add10.i.i.103 = add i16 %c.i.i.75.0, %shr9.i.i.102
  %and11.i.i.104 = and i16 %p.i.i.74.0, 255
  %arrayidx12.i.i.105 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.73.0
  store i16 %and11.i.i.104, i16* %arrayidx12.i.i.105, align 2
  %inc14.i.i.106 = add i16 %digit.i.i.73.0, 1
  br label %for.cond.i.i.82

for.end.15.i.i.108:                               ; preds = %for.cond.i.i.82
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i.110

for.cond.16.i.i.110:                              ; preds = %for.body.18.i.i.114, %for.end.15.i.i.108
  %i.i.i.72.1 = phi i16 [ 0, %for.end.15.i.i.108 ], [ %inc22.i.i.113, %for.body.18.i.i.114 ]
  %cmp17.i.i.109 = icmp slt i16 %i.i.i.72.1, 16
  br i1 %cmp17.i.i.109, label %for.body.18.i.i.114, label %mult.exit.i.115

for.body.18.i.i.114:                              ; preds = %for.cond.16.i.i.110
  %arrayidx19.i.i.111 = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.72.1
  %32 = load i16, i16* %arrayidx19.i.i.111, align 2
  %arrayidx20.i.i.112 = getelementptr inbounds i16, i16* %base, i16 %i.i.i.72.1
  store i16 %32, i16* %arrayidx20.i.i.112, align 2
  %inc22.i.i.113 = add nsw i16 %i.i.i.72.1, 1
  br label %for.cond.16.i.i.110

mult.exit.i.115:                                  ; preds = %for.cond.16.i.i.110
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i.120

do.body.i.i.120:                                  ; preds = %land.end.i.i.123, %mult.exit.i.115
  %d.i.i.69.0 = phi i16 [ 16, %mult.exit.i.115 ], [ %dec.i.i.116, %land.end.i.i.123 ]
  %dec.i.i.116 = add i16 %d.i.i.69.0, -1
  %arrayidx.i.1.i.117 = getelementptr inbounds i16, i16* %base, i16 %dec.i.i.116
  %33 = load i16, i16* %arrayidx.i.1.i.117, align 2
  %call.i.i.118 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i.116, i16 %33) #4
  %cmp.i.2.i.119 = icmp eq i16 %33, 0
  br i1 %cmp.i.2.i.119, label %land.rhs.i.i.122, label %land.end.i.i.123

land.rhs.i.i.122:                                 ; preds = %do.body.i.i.120
  %cmp1.i.i.121 = icmp ugt i16 %dec.i.i.116, 0
  br label %land.end.i.i.123

land.end.i.i.123:                                 ; preds = %land.rhs.i.i.122, %do.body.i.i.120
  %34 = phi i1 [ false, %do.body.i.i.120 ], [ %cmp1.i.i.121, %land.rhs.i.i.122 ]
  br i1 %34, label %do.body.i.i.120, label %do.end.i.i.128

do.end.i.i.128:                                   ; preds = %land.end.i.i.123
  %call2.i.i.124 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i.116) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i.125 = add i16 %dec.i.i.116, 1
  %sub.i.i.i.126 = sub i16 %add.i.i.i.125, 8
  %call.i.i.i.127 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i.116, i16 %sub.i.i.i.126) #4
  br label %for.cond.i.i.i.130

for.cond.i.i.i.130:                               ; preds = %if.end.i.i.i.141, %do.end.i.i.128
  %i.i.i.i.60.0 = phi i16 [ %dec.i.i.116, %do.end.i.i.128 ], [ %dec.i.i.i.140, %if.end.i.i.i.141 ]
  %cmp.i.i.i.129 = icmp sge i16 %i.i.i.i.60.0, 0
  br i1 %cmp.i.i.i.129, label %for.body.i.i.i.135, label %reduce_normalizable.exit.i.i.146

for.body.i.i.i.135:                               ; preds = %for.cond.i.i.i.130
  %arrayidx.i.i.i.131 = getelementptr inbounds i16, i16* %base, i16 %i.i.i.i.60.0
  %35 = load i16, i16* %arrayidx.i.i.i.131, align 2
  %sub1.i.i.i.132 = sub i16 %i.i.i.i.60.0, %sub.i.i.i.126
  %arrayidx2.i.i.i.133 = getelementptr inbounds i16, i16* %n, i16 %sub1.i.i.i.132
  %36 = load i16, i16* %arrayidx2.i.i.i.133, align 2
  %cmp3.i.i.i.134 = icmp ugt i16 %35, %36
  br i1 %cmp3.i.i.i.134, label %if.then.i.i.i.136, label %if.else.i.i.i.138

if.then.i.i.i.136:                                ; preds = %for.body.i.i.i.135
  br label %reduce_normalizable.exit.i.i.146

if.else.i.i.i.138:                                ; preds = %for.body.i.i.i.135
  %cmp4.i.i.i.137 = icmp ult i16 %35, %36
  br i1 %cmp4.i.i.i.137, label %if.then.5.i.i.i.139, label %if.end.i.i.i.141

if.then.5.i.i.i.139:                              ; preds = %if.else.i.i.i.138
  br label %reduce_normalizable.exit.i.i.146

if.end.i.i.i.141:                                 ; preds = %if.else.i.i.i.138
  %dec.i.i.i.140 = add nsw i16 %i.i.i.i.60.0, -1
  br label %for.cond.i.i.i.130

reduce_normalizable.exit.i.i.146:                 ; preds = %if.then.5.i.i.i.139, %if.then.i.i.i.136, %for.cond.i.i.i.130
  %normalizable.i.i.i.64.0 = phi i8 [ 1, %if.then.i.i.i.136 ], [ 0, %if.then.5.i.i.i.139 ], [ 1, %for.cond.i.i.i.130 ]
  %tobool.i.i.i.142 = trunc i8 %normalizable.i.i.i.64.0 to i1
  %conv.i.i.i.143 = zext i1 %tobool.i.i.i.142 to i16
  %call7.i.i.i.144 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i.145 = trunc i8 %normalizable.i.i.i.64.0 to i1
  br i1 %tobool8.i.i.i.145, label %if.then.i.3.i.149, label %if.else.i.i.168

if.then.i.3.i.149:                                ; preds = %reduce_normalizable.exit.i.i.146
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i.147 = add i16 %dec.i.i.116, 1
  %sub.i.21.i.i.148 = sub i16 %add.i.20.i.i.147, 8
  br label %for.cond.i.23.i.i.151

for.cond.i.23.i.i.151:                            ; preds = %if.end.i.30.i.i.165, %if.then.i.3.i.149
  %borrow.i.i.i.55.0 = phi i16 [ 0, %if.then.i.3.i.149 ], [ %borrow.i.i.i.55.1, %if.end.i.30.i.i.165 ]
  %i.i.16.i.i.50.0 = phi i16 [ 0, %if.then.i.3.i.149 ], [ %inc.i.i.i.164, %if.end.i.30.i.i.165 ]
  %cmp.i.22.i.i.150 = icmp slt i16 %i.i.16.i.i.50.0, 8
  br i1 %cmp.i.22.i.i.150, label %for.body.i.27.i.i.157, label %reduce_normalize.exit.i.i.166

for.body.i.27.i.i.157:                            ; preds = %for.cond.i.23.i.i.151
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i.152 = add i16 %i.i.16.i.i.50.0, %sub.i.21.i.i.148
  %arrayidx.i.24.i.i.153 = getelementptr inbounds i16, i16* %base, i16 %add1.i.i.i.152
  %37 = load i16, i16* %arrayidx.i.24.i.i.153, align 2
  %arrayidx2.i.25.i.i.154 = getelementptr inbounds i16, i16* %n, i16 %i.i.16.i.i.50.0
  %38 = load i16, i16* %arrayidx2.i.25.i.i.154, align 2
  %add3.i.i.i.155 = add i16 %38, %borrow.i.i.i.55.0
  %cmp4.i.26.i.i.156 = icmp ult i16 %37, %add3.i.i.i.155
  br i1 %cmp4.i.26.i.i.156, label %if.then.i.28.i.i.159, label %if.else.i.29.i.i.160

if.then.i.28.i.i.159:                             ; preds = %for.body.i.27.i.i.157
  %add5.i.i.i.158 = add i16 %37, 256
  br label %if.end.i.30.i.i.165

if.else.i.29.i.i.160:                             ; preds = %for.body.i.27.i.i.157
  br label %if.end.i.30.i.i.165

if.end.i.30.i.i.165:                              ; preds = %if.else.i.29.i.i.160, %if.then.i.28.i.i.159
  %borrow.i.i.i.55.1 = phi i16 [ 1, %if.then.i.28.i.i.159 ], [ 0, %if.else.i.29.i.i.160 ]
  %m_d.i.17.i.i.53.0 = phi i16 [ %add5.i.i.i.158, %if.then.i.28.i.i.159 ], [ %37, %if.else.i.29.i.i.160 ]
  %sub6.i.i.i.161 = sub i16 %m_d.i.17.i.i.53.0, %add3.i.i.i.155
  %add7.i.i.i.162 = add i16 %i.i.16.i.i.50.0, %sub.i.21.i.i.148
  %arrayidx8.i.i.i.163 = getelementptr inbounds i16, i16* %base, i16 %add7.i.i.i.162
  store i16 %sub6.i.i.i.161, i16* %arrayidx8.i.i.i.163, align 2
  %inc.i.i.i.164 = add nsw i16 %i.i.16.i.i.50.0, 1
  br label %for.cond.i.23.i.i.151

reduce_normalize.exit.i.i.166:                    ; preds = %for.cond.i.23.i.i.151
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172

if.else.i.i.168:                                  ; preds = %reduce_normalizable.exit.i.i.146
  %cmp4.i.4.i.167 = icmp eq i16 %dec.i.i.116, 7
  br i1 %cmp4.i.4.i.167, label %if.then.5.i.i.170, label %if.end.i.5.i.171

if.then.5.i.i.170:                                ; preds = %if.else.i.i.168
  %call6.i.i.169 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312

if.end.i.5.i.171:                                 ; preds = %if.else.i.i.168
  br label %if.end.7.i.i.172

if.end.7.i.i.172:                                 ; preds = %if.end.i.5.i.171, %reduce_normalize.exit.i.i.166
  br label %while.cond.i.i.174

while.cond.i.i.174:                               ; preds = %reduce_subtract.exit.i.i.310, %if.end.7.i.i.172
  %d.i.i.69.1 = phi i16 [ %dec.i.i.116, %if.end.7.i.i.172 ], [ %dec13.i.i.309, %reduce_subtract.exit.i.i.310 ]
  %cmp8.i.i.173 = icmp uge i16 %d.i.i.69.1, 8
  br i1 %cmp8.i.i.173, label %while.body.i.i.192, label %while.end.i.i.311

while.body.i.i.192:                               ; preds = %while.cond.i.i.174
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i.175 = getelementptr inbounds i16, i16* %n, i16 7
  %39 = load i16, i16* %arrayidx.i.35.i.i.175, align 2
  %shl.i.i.i.176 = shl i16 %39, 8
  %arrayidx1.i.i.i.177 = getelementptr inbounds i16, i16* %n, i16 6
  %40 = load i16, i16* %arrayidx1.i.i.i.177, align 2
  %add.i.36.i.i.178 = add i16 %shl.i.i.i.176, %40
  %arrayidx2.i.37.i.i.179 = getelementptr inbounds i16, i16* %n, i16 7
  %41 = load i16, i16* %arrayidx2.i.37.i.i.179, align 2
  %arrayidx3.i.i.i.180 = getelementptr inbounds i16, i16* %base, i16 %d.i.i.69.1
  %42 = load i16, i16* %arrayidx3.i.i.i.180, align 2
  %arrayidx4.i.i.i.181 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  store i16 %42, i16* %arrayidx4.i.i.i.181, align 2
  %sub.i.38.i.i.182 = sub i16 %d.i.i.69.1, 1
  %arrayidx5.i.i.i.183 = getelementptr inbounds i16, i16* %base, i16 %sub.i.38.i.i.182
  %43 = load i16, i16* %arrayidx5.i.i.i.183, align 2
  %arrayidx6.i.i.i.184 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  store i16 %43, i16* %arrayidx6.i.i.i.184, align 2
  %sub7.i.i.i.185 = sub i16 %d.i.i.69.1, 2
  %arrayidx8.i.39.i.i.186 = getelementptr inbounds i16, i16* %base, i16 %sub7.i.i.i.185
  %44 = load i16, i16* %arrayidx8.i.39.i.i.186, align 2
  %arrayidx9.i.i.i.187 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  store i16 %44, i16* %arrayidx9.i.i.i.187, align 2
  %arrayidx10.i.i.i.188 = getelementptr inbounds i16, i16* %base, i16 2
  %45 = load i16, i16* %arrayidx10.i.i.i.188, align 2
  %call.i.40.i.i.189 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %41, i16 %45) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %46 = load i16, i16* %arrayidx11.i.i.i.190, align 2
  %cmp.i.41.i.i.191 = icmp eq i16 %46, %41
  br i1 %cmp.i.41.i.i.191, label %if.then.i.42.i.i.193, label %if.else.i.43.i.i.200

if.then.i.42.i.i.193:                             ; preds = %while.body.i.i.192
  br label %if.end.i.46.i.i.222

if.else.i.43.i.i.200:                             ; preds = %while.body.i.i.192
  %arrayidx12.i.i.i.194 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %47 = load i16, i16* %arrayidx12.i.i.i.194, align 2
  %shl13.i.i.i.195 = shl i16 %47, 8
  %arrayidx14.i.i.i.196 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %48 = load i16, i16* %arrayidx14.i.i.i.196, align 2
  %add15.i.i.i.197 = add i16 %shl13.i.i.i.195, %48
  %div.i.i.i.198 = udiv i16 %add15.i.i.i.197, %41
  %call16.i.i.i.199 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i.197, i16 %div.i.i.i.198) #4
  br label %if.end.i.46.i.i.222

if.end.i.46.i.i.222:                              ; preds = %if.else.i.43.i.i.200, %if.then.i.42.i.i.193
  %q.i.i.i.41.0 = phi i16 [ 255, %if.then.i.42.i.i.193 ], [ %div.i.i.i.198, %if.else.i.43.i.i.200 ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %49 = load i16, i16* %arrayidx17.i.i.i.201, align 2
  %conv.i.44.i.i.202 = zext i16 %49 to i32
  %shl18.i.i.i.203 = shl i32 %conv.i.44.i.i.202, 16
  %arrayidx19.i.i.i.204 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %50 = load i16, i16* %arrayidx19.i.i.i.204, align 2
  %shl20.i.i.i.205 = shl i16 %50, 8
  %conv21.i.i.i.206 = zext i16 %shl20.i.i.i.205 to i32
  %add22.i.i.i.207 = add i32 %shl18.i.i.i.203, %conv21.i.i.i.206
  %arrayidx23.i.i.i.208 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %51 = load i16, i16* %arrayidx23.i.i.i.208, align 2
  %conv24.i.i.i.209 = zext i16 %51 to i32
  %add25.i.i.i.210 = add i32 %add22.i.i.i.207, %conv24.i.i.i.209
  %arrayidx26.i.i.i.211 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 2
  %52 = load i16, i16* %arrayidx26.i.i.i.211, align 2
  %arrayidx27.i.i.i.212 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 1
  %53 = load i16, i16* %arrayidx27.i.i.i.212, align 2
  %arrayidx28.i.i.i.213 = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i, i16 0, i16 0
  %54 = load i16, i16* %arrayidx28.i.i.i.213, align 2
  %shr.i.i.i.214 = lshr i32 %add25.i.i.i.210, 16
  %and.i.i.i.215 = and i32 %shr.i.i.i.214, 65535
  %conv29.i.i.i.216 = trunc i32 %and.i.i.i.215 to i16
  %and30.i.i.i.217 = and i32 %add25.i.i.i.210, 65535
  %conv31.i.i.i.218 = trunc i32 %and30.i.i.i.217 to i16
  %call32.i.i.i.219 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %52, i16 %53, i16 %54, i16 %conv29.i.i.i.216, i16 %conv31.i.i.i.218) #4
  %call33.i.i.i.220 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.41.0) #4
  %inc.i.45.i.i.221 = add i16 %q.i.i.i.41.0, 1
  br label %do.body.i.i.i.232

do.body.i.i.i.232:                                ; preds = %do.body.i.i.i.232, %if.end.i.46.i.i.222
  %q.i.i.i.41.1 = phi i16 [ %inc.i.45.i.i.221, %if.end.i.46.i.i.222 ], [ %dec.i.47.i.i.223, %do.body.i.i.i.232 ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i.223 = add i16 %q.i.i.i.41.1, -1
  %call34.i.i.i.224 = call i32 @mult16(i16 zeroext %add.i.36.i.i.178, i16 zeroext %dec.i.47.i.i.223) #4
  %shr35.i.i.i.225 = lshr i32 %call34.i.i.i.224, 16
  %and36.i.i.i.226 = and i32 %shr35.i.i.i.225, 65535
  %conv37.i.i.i.227 = trunc i32 %and36.i.i.i.226 to i16
  %and38.i.i.i.228 = and i32 %call34.i.i.i.224, 65535
  %conv39.i.i.i.229 = trunc i32 %and38.i.i.i.228 to i16
  %call40.i.i.i.230 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i.223, i16 %add.i.36.i.i.178, i16 %conv37.i.i.i.227, i16 %conv39.i.i.i.229) #4
  %cmp41.i.i.i.231 = icmp ugt i32 %call34.i.i.i.224, %add25.i.i.i.210
  br i1 %cmp41.i.i.i.231, label %do.body.i.i.i.232, label %reduce_quotient.exit.i.i.236

reduce_quotient.exit.i.i.236:                     ; preds = %do.body.i.i.i.232
  %call43.i.i.i.233 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i.223) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i.234 = sub i16 %d.i.i.69.1, 8
  %call.i.53.i.i.235 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i.234) #4
  br label %for.cond.i.55.i.i.238

for.cond.i.55.i.i.238:                            ; preds = %for.body.i.57.i.i.241, %reduce_quotient.exit.i.i.236
  %i.i.50.i.i.31.0 = phi i16 [ 0, %reduce_quotient.exit.i.i.236 ], [ %inc.i.58.i.i.240, %for.body.i.57.i.i.241 ]
  %cmp.i.54.i.i.237 = icmp ult i16 %i.i.50.i.i.31.0, %sub.i.52.i.i.234
  br i1 %cmp.i.54.i.i.237, label %for.body.i.57.i.i.241, label %for.end.i.i.i.242

for.body.i.57.i.i.241:                            ; preds = %for.cond.i.55.i.i.238
  %arrayidx.i.56.i.i.239 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.0
  store i16 0, i16* %arrayidx.i.56.i.i.239, align 2
  %inc.i.58.i.i.240 = add nsw i16 %i.i.50.i.i.31.0, 1
  br label %for.cond.i.55.i.i.238

for.end.i.i.i.242:                                ; preds = %for.cond.i.55.i.i.238
  br label %for.cond.1.i.i.i.244

for.cond.1.i.i.i.244:                             ; preds = %if.end.i.68.i.i.258, %for.end.i.i.i.242
  %c.i.i.i.33.0 = phi i16 [ 0, %for.end.i.i.i.242 ], [ %shr.i.65.i.i.254, %if.end.i.68.i.i.258 ]
  %i.i.50.i.i.31.1 = phi i16 [ %sub.i.52.i.i.234, %for.end.i.i.i.242 ], [ %inc10.i.i.i.257, %if.end.i.68.i.i.258 ]
  %cmp2.i.i.i.243 = icmp slt i16 %i.i.50.i.i.31.1, 16
  br i1 %cmp2.i.i.i.243, label %for.body.3.i.i.i.247, label %reduce_multiply.exit.i.i.259

for.body.3.i.i.i.247:                             ; preds = %for.cond.1.i.i.i.244
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i.245 = add i16 %sub.i.52.i.i.234, 8
  %cmp4.i.60.i.i.246 = icmp ult i16 %i.i.50.i.i.31.1, %add.i.59.i.i.245
  br i1 %cmp4.i.60.i.i.246, label %if.then.i.63.i.i.252, label %if.else.i.64.i.i.253

if.then.i.63.i.i.252:                             ; preds = %for.body.3.i.i.i.247
  %sub5.i.i.i.248 = sub i16 %i.i.50.i.i.31.1, %sub.i.52.i.i.234
  %arrayidx6.i.61.i.i.249 = getelementptr inbounds i16, i16* %n, i16 %sub5.i.i.i.248
  %55 = load i16, i16* %arrayidx6.i.61.i.i.249, align 2
  %mul.i.i.i.250 = mul i16 %dec.i.47.i.i.223, %55
  %add7.i.62.i.i.251 = add i16 %c.i.i.i.33.0, %mul.i.i.i.250
  br label %if.end.i.68.i.i.258

if.else.i.64.i.i.253:                             ; preds = %for.body.3.i.i.i.247
  br label %if.end.i.68.i.i.258

if.end.i.68.i.i.258:                              ; preds = %if.else.i.64.i.i.253, %if.then.i.63.i.i.252
  %p.i.i.i.34.0 = phi i16 [ %add7.i.62.i.i.251, %if.then.i.63.i.i.252 ], [ %c.i.i.i.33.0, %if.else.i.64.i.i.253 ]
  %shr.i.65.i.i.254 = lshr i16 %p.i.i.i.34.0, 8
  %and.i.66.i.i.255 = and i16 %p.i.i.i.34.0, 255
  %arrayidx8.i.67.i.i.256 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.1
  store i16 %and.i.66.i.i.255, i16* %arrayidx8.i.67.i.i.256, align 2
  %inc10.i.i.i.257 = add nsw i16 %i.i.50.i.i.31.1, 1
  br label %for.cond.1.i.i.i.244

reduce_multiply.exit.i.i.259:                     ; preds = %for.cond.1.i.i.i.244
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i.261

for.cond.i.71.i.i.261:                            ; preds = %if.end.i.76.i.i.269, %reduce_multiply.exit.i.i.259
  %i.i.69.i.i.25.0 = phi i16 [ 15, %reduce_multiply.exit.i.i.259 ], [ %dec.i.77.i.i.268, %if.end.i.76.i.i.269 ]
  %cmp.i.70.i.i.260 = icmp sge i16 %i.i.69.i.i.25.0, 0
  br i1 %cmp.i.70.i.i.260, label %for.body.i.72.i.i.263, label %reduce_compare.exit.i.i.271

for.body.i.72.i.i.263:                            ; preds = %for.cond.i.71.i.i.261
  %cmp1.i.i.i.262 = icmp ugt i16* %base, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i.262, label %if.then.i.73.i.i.264, label %if.else.i.75.i.i.266

if.then.i.73.i.i.264:                             ; preds = %for.body.i.72.i.i.263
  br label %reduce_compare.exit.i.i.271

if.else.i.75.i.i.266:                             ; preds = %for.body.i.72.i.i.263
  %cmp2.i.74.i.i.265 = icmp ult i16* %base, getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i.265, label %if.then.3.i.i.i.267, label %if.end.i.76.i.i.269

if.then.3.i.i.i.267:                              ; preds = %if.else.i.75.i.i.266
  br label %reduce_compare.exit.i.i.271

if.end.i.76.i.i.269:                              ; preds = %if.else.i.75.i.i.266
  %dec.i.77.i.i.268 = add nsw i16 %i.i.69.i.i.25.0, -1
  br label %for.cond.i.71.i.i.261

reduce_compare.exit.i.i.271:                      ; preds = %if.then.3.i.i.i.267, %if.then.i.73.i.i.264, %for.cond.i.71.i.i.261
  %relation.i.i.i.26.0 = phi i16 [ 1, %if.then.i.73.i.i.264 ], [ -1, %if.then.3.i.i.i.267 ], [ 0, %for.cond.i.71.i.i.261 ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i.270 = icmp slt i16 %relation.i.i.i.26.0, 0
  br i1 %cmp10.i.i.270, label %if.then.11.i.i.273, label %if.end.12.i.i.294

if.then.11.i.i.273:                               ; preds = %reduce_compare.exit.i.i.271
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i.272 = sub i16 %d.i.i.69.1, 8
  br label %for.cond.i.87.i.i.275

for.cond.i.87.i.i.275:                            ; preds = %if.end.i.100.i.i.290, %if.then.11.i.i.273
  %c.i.84.i.i.19.0 = phi i16 [ 0, %if.then.11.i.i.273 ], [ %shr.i.97.i.i.286, %if.end.i.100.i.i.290 ]
  %i.i.82.i.i.16.0 = phi i16 [ %sub.i.85.i.i.272, %if.then.11.i.i.273 ], [ %inc.i.101.i.i.289, %if.end.i.100.i.i.290 ]
  %cmp.i.86.i.i.274 = icmp slt i16 %i.i.82.i.i.16.0, 16
  br i1 %cmp.i.86.i.i.274, label %for.body.i.92.i.i.280, label %reduce_add.exit.i.i.291

for.body.i.92.i.i.280:                            ; preds = %for.cond.i.87.i.i.275
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i.276 = getelementptr inbounds i16, i16* %base, i16 %i.i.82.i.i.16.0
  %56 = load i16, i16* %arrayidx.i.88.i.i.276, align 2
  %sub1.i.89.i.i.277 = sub i16 %i.i.82.i.i.16.0, %sub.i.85.i.i.272
  %add.i.90.i.i.278 = add i16 %sub.i.85.i.i.272, 8
  %cmp2.i.91.i.i.279 = icmp ult i16 %i.i.82.i.i.16.0, %add.i.90.i.i.278
  br i1 %cmp2.i.91.i.i.279, label %if.then.i.94.i.i.282, label %if.else.i.95.i.i.283

if.then.i.94.i.i.282:                             ; preds = %for.body.i.92.i.i.280
  %arrayidx3.i.93.i.i.281 = getelementptr inbounds i16, i16* %n, i16 %sub1.i.89.i.i.277
  %57 = load i16, i16* %arrayidx3.i.93.i.i.281, align 2
  br label %if.end.i.100.i.i.290

if.else.i.95.i.i.283:                             ; preds = %for.body.i.92.i.i.280
  br label %if.end.i.100.i.i.290

if.end.i.100.i.i.290:                             ; preds = %if.else.i.95.i.i.283, %if.then.i.94.i.i.282
  %n.i.i.i.22.0 = phi i16 [ %57, %if.then.i.94.i.i.282 ], [ 0, %if.else.i.95.i.i.283 ]
  %add4.i.i.i.284 = add i16 %c.i.84.i.i.19.0, %56
  %add5.i.96.i.i.285 = add i16 %add4.i.i.i.284, %n.i.i.i.22.0
  %shr.i.97.i.i.286 = lshr i16 %add5.i.96.i.i.285, 8
  %and.i.98.i.i.287 = and i16 %add5.i.96.i.i.285, 255
  %arrayidx6.i.99.i.i.288 = getelementptr inbounds i16, i16* %base, i16 %i.i.82.i.i.16.0
  store i16 %and.i.98.i.i.287, i16* %arrayidx6.i.99.i.i.288, align 2
  %inc.i.101.i.i.289 = add nsw i16 %i.i.82.i.i.16.0, 1
  br label %for.cond.i.87.i.i.275

reduce_add.exit.i.i.291:                          ; preds = %for.cond.i.87.i.i.275
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294

if.end.12.i.i.294:                                ; preds = %reduce_add.exit.i.i.291, %reduce_compare.exit.i.i.271
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i.292 = sub i16 %d.i.i.69.1, 8
  %call.i.114.i.i.293 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.69.1, i16 %sub.i.113.i.i.292) #4
  br label %for.cond.i.116.i.i.296

for.cond.i.116.i.i.296:                           ; preds = %if.end.i.126.i.i.308, %if.end.12.i.i.294
  %borrow.i.111.i.i.11.0 = phi i16 [ 0, %if.end.12.i.i.294 ], [ %borrow.i.111.i.i.11.1, %if.end.i.126.i.i.308 ]
  %i.i.106.i.i.6.0 = phi i16 [ %sub.i.113.i.i.292, %if.end.12.i.i.294 ], [ %inc.i.127.i.i.307, %if.end.i.126.i.i.308 ]
  %cmp.i.115.i.i.295 = icmp slt i16 %i.i.106.i.i.6.0, 16
  br i1 %cmp.i.115.i.i.295, label %for.body.i.121.i.i.301, label %reduce_subtract.exit.i.i.310

for.body.i.121.i.i.301:                           ; preds = %for.cond.i.116.i.i.296
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i.297 = getelementptr inbounds i16, i16* %base, i16 %i.i.106.i.i.6.0
  %58 = load i16, i16* %arrayidx.i.117.i.i.297, align 2
  %arrayidx1.i.118.i.i.298 = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.6.0
  %59 = load i16, i16* %arrayidx1.i.118.i.i.298, align 2
  %add.i.119.i.i.299 = add i16 %59, %borrow.i.111.i.i.11.0
  %cmp2.i.120.i.i.300 = icmp ult i16 %58, %add.i.119.i.i.299
  br i1 %cmp2.i.120.i.i.300, label %if.then.i.123.i.i.303, label %if.else.i.124.i.i.304

if.then.i.123.i.i.303:                            ; preds = %for.body.i.121.i.i.301
  %add3.i.122.i.i.302 = add i16 %58, 256
  br label %if.end.i.126.i.i.308

if.else.i.124.i.i.304:                            ; preds = %for.body.i.121.i.i.301
  br label %if.end.i.126.i.i.308

if.end.i.126.i.i.308:                             ; preds = %if.else.i.124.i.i.304, %if.then.i.123.i.i.303
  %borrow.i.111.i.i.11.1 = phi i16 [ 1, %if.then.i.123.i.i.303 ], [ 0, %if.else.i.124.i.i.304 ]
  %m.i.107.i.i.7.0 = phi i16 [ %add3.i.122.i.i.302, %if.then.i.123.i.i.303 ], [ %58, %if.else.i.124.i.i.304 ]
  %sub4.i.i.i.305 = sub i16 %m.i.107.i.i.7.0, %add.i.119.i.i.299
  %arrayidx5.i.125.i.i.306 = getelementptr inbounds i16, i16* %base, i16 %i.i.106.i.i.6.0
  store i16 %sub4.i.i.i.305, i16* %arrayidx5.i.125.i.i.306, align 2
  %inc.i.127.i.i.307 = add nsw i16 %i.i.106.i.i.6.0, 1
  br label %for.cond.i.116.i.i.296

reduce_subtract.exit.i.i.310:                     ; preds = %for.cond.i.116.i.i.296
  store i16 35, i16* @curtask, align 2
  %dec13.i.i.309 = add i16 %d.i.i.69.1, -1
  br label %while.cond.i.i.174

while.end.i.i.311:                                ; preds = %while.cond.i.i.174
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312

mod_mult.exit312:                                 ; preds = %if.then.5.i.i.170, %while.end.i.i.311
  %shr = lshr i16 %e.addr.0, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i16 26, i16* @curtask, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @encrypt(i8* %cyphertext, i16* %cyphertext_len, i8* %message, i16 %message_length, %struct.pubkey_t* %k) #1 {
entry:
  %m_d.i.34.i.i.i = alloca [3 x i16], align 2
  br label %while.cond

while.cond:                                       ; preds = %for.end.26, %entry
  %in_block_offset.0 = phi i16 [ 0, %entry ], [ %add27, %for.end.26 ]
  %out_block_offset.0 = phi i16 [ 0, %entry ], [ %add28, %for.end.26 ]
  %cmp = icmp ult i16 %in_block_offset.0, %message_length
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i16 1, i16* @curtask, align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.19, i32 0, i32 0), i16 %in_block_offset.0)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %while.body
  %i.0 = phi i16 [ 0, %while.body ], [ %inc, %for.inc ]
  %cmp1 = icmp ult i16 %i.0, 7
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add = add i16 %in_block_offset.0, %i.0
  %cmp2 = icmp ult i16 %add, %message_length
  br i1 %cmp2, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.body
  %add3 = add i16 %in_block_offset.0, %i.0
  %arrayidx = getelementptr inbounds i8, i8* %message, i16 %add3
  %0 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %0 to i16
  br label %cond.end

cond.false:                                       ; preds = %for.body
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i16 [ %conv, %cond.true ], [ 255, %cond.false ]
  %arrayidx4 = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %i.0
  store i16 %cond, i16* %arrayidx4, align 2
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %inc = add nsw i16 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %for.cond.5

for.cond.5:                                       ; preds = %for.inc.13, %for.end
  %i.1 = phi i16 [ 0, %for.end ], [ %inc14, %for.inc.13 ]
  %cmp6 = icmp ult i16 %i.1, 1
  br i1 %cmp6, label %for.body.8, label %for.end.15

for.body.8:                                       ; preds = %for.cond.5
  %arrayidx9 = getelementptr inbounds [1 x i8], [1 x i8]* @PAD_DIGITS, i16 0, i16 %i.1
  %1 = load i8, i8* %arrayidx9, align 1
  %conv10 = zext i8 %1 to i16
  %add11 = add i16 7, %i.1
  %arrayidx12 = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %add11
  store i16 %conv10, i16* %arrayidx12, align 2
  br label %for.inc.13

for.inc.13:                                       ; preds = %for.body.8
  %inc14 = add nsw i16 %i.1, 1
  br label %for.cond.5

for.end.15:                                       ; preds = %for.cond.5
  %e = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %k, i32 0, i32 1
  %2 = load i16, i16* %e, align 2
  %n = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* %k, i32 0, i32 0
  %arraydecay = getelementptr inbounds [16 x i16], [16 x i16]* %n, i32 0, i32 0
  store i16 2, i16* @curtask, align 2
  store i16 1, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), align 2
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.body.i, %for.end.15
  %i.i.0 = phi i16 [ 1, %for.end.15 ], [ %inc.i, %for.body.i ]
  %cmp.i = icmp slt i16 %i.i.0, 8
  br i1 %cmp.i, label %for.body.i, label %for.end.i

for.body.i:                                       ; preds = %for.cond.i
  %arrayidx1.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.0
  store i16 0, i16* %arrayidx1.i, align 2
  %inc.i = add nsw i16 %i.i.0, 1
  br label %for.cond.i

for.end.i:                                        ; preds = %for.cond.i
  br label %while.cond.i

while.cond.i:                                     ; preds = %mod_mult.exit312.i, %for.end.i
  %e.addr.i.0 = phi i16 [ %2, %for.end.i ], [ %shr.i, %mod_mult.exit312.i ]
  %cmp2.i = icmp ugt i16 %e.addr.i.0, 0
  br i1 %cmp2.i, label %while.body.i, label %mod_exp.exit

while.body.i:                                     ; preds = %while.cond.i
  store i16 13, i16* @curtask, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %e.addr.i.0) #4
  %and.i = and i16 %e.addr.i.0, 1
  %tobool.i = icmp ne i16 %and.i, 0
  br i1 %tobool.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %while.body.i
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i.i

for.cond.i.i.i:                                   ; preds = %for.end.i.i.i, %if.then.i
  %digit.i.i.i.0 = phi i16 [ 0, %if.then.i ], [ %inc14.i.i.i, %for.end.i.i.i ]
  %carry.i.i.i.0 = phi i16 [ 0, %if.then.i ], [ %add10.i.i.i, %for.end.i.i.i ]
  %cmp.i.i.i = icmp ult i16 %digit.i.i.i.0, 16
  br i1 %cmp.i.i.i, label %for.body.i.i.i, label %for.end.15.i.i.i

for.body.i.i.i:                                   ; preds = %for.cond.i.i.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i.i

for.cond.1.i.i.i:                                 ; preds = %if.end.i.i.i, %for.body.i.i.i
  %i.i.i.i.0 = phi i16 [ 0, %for.body.i.i.i ], [ %inc.i.i.i, %if.end.i.i.i ]
  %p.i.i.i.0 = phi i16 [ %carry.i.i.i.0, %for.body.i.i.i ], [ %p.i.i.i.1, %if.end.i.i.i ]
  %c.i.i.i.0 = phi i16 [ 0, %for.body.i.i.i ], [ %c.i.i.i.1, %if.end.i.i.i ]
  %cmp2.i.i.i = icmp slt i16 %i.i.i.i.0, 8
  br i1 %cmp2.i.i.i, label %for.body.3.i.i.i, label %for.end.i.i.i

for.body.3.i.i.i:                                 ; preds = %for.cond.1.i.i.i
  %cmp4.i.i.i = icmp ule i16 %i.i.i.i.0, %digit.i.i.i.0
  br i1 %cmp4.i.i.i, label %land.lhs.true.i.i.i, label %if.end.i.i.i

land.lhs.true.i.i.i:                              ; preds = %for.body.3.i.i.i
  %sub.i.i.i = sub i16 %digit.i.i.i.0, %i.i.i.i.0
  %cmp5.i.i.i = icmp ult i16 %sub.i.i.i, 8
  br i1 %cmp5.i.i.i, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %land.lhs.true.i.i.i
  %sub6.i.i.i = sub i16 %digit.i.i.i.0, %i.i.i.i.0
  %arrayidx.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub6.i.i.i
  %3 = load i16, i16* %arrayidx.i.i.i, align 2
  %arrayidx7.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.i.0
  %4 = load i16, i16* %arrayidx7.i.i.i, align 2
  %mul.i.i.i = mul i16 %3, %4
  %shr.i.i.i = lshr i16 %mul.i.i.i, 8
  %add.i.i.i = add i16 %c.i.i.i.0, %shr.i.i.i
  %and.i.i.i = and i16 %mul.i.i.i, 255
  %add8.i.i.i = add i16 %p.i.i.i.0, %and.i.i.i
  br label %if.end.i.i.i

if.end.i.i.i:                                     ; preds = %if.then.i.i.i, %land.lhs.true.i.i.i, %for.body.3.i.i.i
  %p.i.i.i.1 = phi i16 [ %add8.i.i.i, %if.then.i.i.i ], [ %p.i.i.i.0, %land.lhs.true.i.i.i ], [ %p.i.i.i.0, %for.body.3.i.i.i ]
  %c.i.i.i.1 = phi i16 [ %add.i.i.i, %if.then.i.i.i ], [ %c.i.i.i.0, %land.lhs.true.i.i.i ], [ %c.i.i.i.0, %for.body.3.i.i.i ]
  %inc.i.i.i = add nsw i16 %i.i.i.i.0, 1
  br label %for.cond.1.i.i.i

for.end.i.i.i:                                    ; preds = %for.cond.1.i.i.i
  %shr9.i.i.i = lshr i16 %p.i.i.i.0, 8
  %add10.i.i.i = add i16 %c.i.i.i.0, %shr9.i.i.i
  %and11.i.i.i = and i16 %p.i.i.i.0, 255
  %arrayidx12.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.i.0
  store i16 %and11.i.i.i, i16* %arrayidx12.i.i.i, align 2
  %inc14.i.i.i = add i16 %digit.i.i.i.0, 1
  br label %for.cond.i.i.i

for.end.15.i.i.i:                                 ; preds = %for.cond.i.i.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i.i

for.cond.16.i.i.i:                                ; preds = %for.body.18.i.i.i, %for.end.15.i.i.i
  %i.i.i.i.1 = phi i16 [ 0, %for.end.15.i.i.i ], [ %inc22.i.i.i, %for.body.18.i.i.i ]
  %cmp17.i.i.i = icmp slt i16 %i.i.i.i.1, 16
  br i1 %cmp17.i.i.i, label %for.body.18.i.i.i, label %mult.exit.i.i

for.body.18.i.i.i:                                ; preds = %for.cond.16.i.i.i
  %arrayidx19.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.i.1
  %5 = load i16, i16* %arrayidx19.i.i.i, align 2
  %arrayidx20.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.i.i.1
  store i16 %5, i16* %arrayidx20.i.i.i, align 2
  %inc22.i.i.i = add nsw i16 %i.i.i.i.1, 1
  br label %for.cond.16.i.i.i

mult.exit.i.i:                                    ; preds = %for.cond.16.i.i.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i.i

do.body.i.i.i:                                    ; preds = %land.end.i.i.i, %mult.exit.i.i
  %d.i.i.i.0 = phi i16 [ 16, %mult.exit.i.i ], [ %dec.i.i.i, %land.end.i.i.i ]
  %dec.i.i.i = add i16 %d.i.i.i.0, -1
  %arrayidx.i.1.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %dec.i.i.i
  %6 = load i16, i16* %arrayidx.i.1.i.i, align 2
  %call.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i.i, i16 %6) #4
  %cmp.i.2.i.i = icmp eq i16 %6, 0
  br i1 %cmp.i.2.i.i, label %land.rhs.i.i.i, label %land.end.i.i.i

land.rhs.i.i.i:                                   ; preds = %do.body.i.i.i
  %cmp1.i.i.i = icmp ugt i16 %dec.i.i.i, 0
  br label %land.end.i.i.i

land.end.i.i.i:                                   ; preds = %land.rhs.i.i.i, %do.body.i.i.i
  %7 = phi i1 [ false, %do.body.i.i.i ], [ %cmp1.i.i.i, %land.rhs.i.i.i ]
  br i1 %7, label %do.body.i.i.i, label %do.end.i.i.i

do.end.i.i.i:                                     ; preds = %land.end.i.i.i
  %call2.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i.i = add i16 %dec.i.i.i, 1
  %sub.i.i.i.i = sub i16 %add.i.i.i.i, 8
  %call.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i.i, i16 %sub.i.i.i.i) #4
  br label %for.cond.i.i.i.i

for.cond.i.i.i.i:                                 ; preds = %if.end.i.i.i.i, %do.end.i.i.i
  %i.i.i.i.i.0 = phi i16 [ %dec.i.i.i, %do.end.i.i.i ], [ %dec.i.i.i.i, %if.end.i.i.i.i ]
  %cmp.i.i.i.i = icmp sge i16 %i.i.i.i.i.0, 0
  br i1 %cmp.i.i.i.i, label %for.body.i.i.i.i, label %reduce_normalizable.exit.i.i.i

for.body.i.i.i.i:                                 ; preds = %for.cond.i.i.i.i
  %arrayidx.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.i.i.i.0
  %8 = load i16, i16* %arrayidx.i.i.i.i, align 2
  %sub1.i.i.i.i = sub i16 %i.i.i.i.i.0, %sub.i.i.i.i
  %arrayidx2.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub1.i.i.i.i
  %9 = load i16, i16* %arrayidx2.i.i.i.i, align 2
  %cmp3.i.i.i.i = icmp ugt i16 %8, %9
  br i1 %cmp3.i.i.i.i, label %if.then.i.i.i.i, label %if.else.i.i.i.i

if.then.i.i.i.i:                                  ; preds = %for.body.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i

if.else.i.i.i.i:                                  ; preds = %for.body.i.i.i.i
  %cmp4.i.i.i.i = icmp ult i16 %8, %9
  br i1 %cmp4.i.i.i.i, label %if.then.5.i.i.i.i, label %if.end.i.i.i.i

if.then.5.i.i.i.i:                                ; preds = %if.else.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i

if.end.i.i.i.i:                                   ; preds = %if.else.i.i.i.i
  %dec.i.i.i.i = add nsw i16 %i.i.i.i.i.0, -1
  br label %for.cond.i.i.i.i

reduce_normalizable.exit.i.i.i:                   ; preds = %if.then.5.i.i.i.i, %if.then.i.i.i.i, %for.cond.i.i.i.i
  %normalizable.i.i.i.i.0 = phi i8 [ 1, %if.then.i.i.i.i ], [ 0, %if.then.5.i.i.i.i ], [ 1, %for.cond.i.i.i.i ]
  %tobool.i.i.i.i = trunc i8 %normalizable.i.i.i.i.0 to i1
  %conv.i.i.i.i = zext i1 %tobool.i.i.i.i to i16
  %call7.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i.i = trunc i8 %normalizable.i.i.i.i.0 to i1
  br i1 %tobool8.i.i.i.i, label %if.then.i.3.i.i, label %if.else.i.i.i

if.then.i.3.i.i:                                  ; preds = %reduce_normalizable.exit.i.i.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i.i = add i16 %dec.i.i.i, 1
  %sub.i.21.i.i.i = sub i16 %add.i.20.i.i.i, 8
  br label %for.cond.i.23.i.i.i

for.cond.i.23.i.i.i:                              ; preds = %if.end.i.30.i.i.i, %if.then.i.3.i.i
  %i.i.16.i.i.i.0 = phi i16 [ 0, %if.then.i.3.i.i ], [ %inc.i.i.i.i, %if.end.i.30.i.i.i ]
  %borrow.i.i.i.i.0 = phi i16 [ 0, %if.then.i.3.i.i ], [ %borrow.i.i.i.i.1, %if.end.i.30.i.i.i ]
  %cmp.i.22.i.i.i = icmp slt i16 %i.i.16.i.i.i.0, 8
  br i1 %cmp.i.22.i.i.i, label %for.body.i.27.i.i.i, label %reduce_normalize.exit.i.i.i

for.body.i.27.i.i.i:                              ; preds = %for.cond.i.23.i.i.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i.i = add i16 %i.i.16.i.i.i.0, %sub.i.21.i.i.i
  %arrayidx.i.24.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %add1.i.i.i.i
  %10 = load i16, i16* %arrayidx.i.24.i.i.i, align 2
  %arrayidx2.i.25.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 %i.i.16.i.i.i.0
  %11 = load i16, i16* %arrayidx2.i.25.i.i.i, align 2
  %add3.i.i.i.i = add i16 %11, %borrow.i.i.i.i.0
  %cmp4.i.26.i.i.i = icmp ult i16 %10, %add3.i.i.i.i
  br i1 %cmp4.i.26.i.i.i, label %if.then.i.28.i.i.i, label %if.else.i.29.i.i.i

if.then.i.28.i.i.i:                               ; preds = %for.body.i.27.i.i.i
  %add5.i.i.i.i = add i16 %10, 256
  br label %if.end.i.30.i.i.i

if.else.i.29.i.i.i:                               ; preds = %for.body.i.27.i.i.i
  br label %if.end.i.30.i.i.i

if.end.i.30.i.i.i:                                ; preds = %if.else.i.29.i.i.i, %if.then.i.28.i.i.i
  %m_d.i.17.i.i.i.0 = phi i16 [ %add5.i.i.i.i, %if.then.i.28.i.i.i ], [ %10, %if.else.i.29.i.i.i ]
  %borrow.i.i.i.i.1 = phi i16 [ 1, %if.then.i.28.i.i.i ], [ 0, %if.else.i.29.i.i.i ]
  %sub6.i.i.i.i = sub i16 %m_d.i.17.i.i.i.0, %add3.i.i.i.i
  %add7.i.i.i.i = add i16 %i.i.16.i.i.i.0, %sub.i.21.i.i.i
  %arrayidx8.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %add7.i.i.i.i
  store i16 %sub6.i.i.i.i, i16* %arrayidx8.i.i.i.i, align 2
  %inc.i.i.i.i = add nsw i16 %i.i.16.i.i.i.0, 1
  br label %for.cond.i.23.i.i.i

reduce_normalize.exit.i.i.i:                      ; preds = %for.cond.i.23.i.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.i

if.else.i.i.i:                                    ; preds = %reduce_normalizable.exit.i.i.i
  %cmp4.i.4.i.i = icmp eq i16 %dec.i.i.i, 7
  br i1 %cmp4.i.4.i.i, label %if.then.5.i.i.i, label %if.end.i.5.i.i

if.then.5.i.i.i:                                  ; preds = %if.else.i.i.i
  %call6.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit.i

if.end.i.5.i.i:                                   ; preds = %if.else.i.i.i
  br label %if.end.7.i.i.i

if.end.7.i.i.i:                                   ; preds = %if.end.i.5.i.i, %reduce_normalize.exit.i.i.i
  br label %while.cond.i.i.i

while.cond.i.i.i:                                 ; preds = %reduce_subtract.exit.i.i.i, %if.end.7.i.i.i
  %d.i.i.i.1 = phi i16 [ %dec.i.i.i, %if.end.7.i.i.i ], [ %dec13.i.i.i, %reduce_subtract.exit.i.i.i ]
  %cmp8.i.i.i = icmp uge i16 %d.i.i.i.1, 8
  br i1 %cmp8.i.i.i, label %while.body.i.i.i, label %while.end.i.i.i

while.body.i.i.i:                                 ; preds = %while.cond.i.i.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 7
  %12 = load i16, i16* %arrayidx.i.35.i.i.i, align 2
  %shl.i.i.i.i = shl i16 %12, 8
  %arrayidx1.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 6
  %13 = load i16, i16* %arrayidx1.i.i.i.i, align 2
  %add.i.36.i.i.i = add i16 %shl.i.i.i.i, %13
  %arrayidx2.i.37.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 7
  %14 = load i16, i16* %arrayidx2.i.37.i.i.i, align 2
  %arrayidx3.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %d.i.i.i.1
  %15 = load i16, i16* %arrayidx3.i.i.i.i, align 2
  %arrayidx4.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  store i16 %15, i16* %arrayidx4.i.i.i.i, align 2
  %sub.i.38.i.i.i = sub i16 %d.i.i.i.1, 1
  %arrayidx5.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub.i.38.i.i.i
  %16 = load i16, i16* %arrayidx5.i.i.i.i, align 2
  %arrayidx6.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  store i16 %16, i16* %arrayidx6.i.i.i.i, align 2
  %sub7.i.i.i.i = sub i16 %d.i.i.i.1, 2
  %arrayidx8.i.39.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub7.i.i.i.i
  %17 = load i16, i16* %arrayidx8.i.39.i.i.i, align 2
  %arrayidx9.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  store i16 %17, i16* %arrayidx9.i.i.i.i, align 2
  %arrayidx10.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 2
  %18 = load i16, i16* %arrayidx10.i.i.i.i, align 2
  %call.i.40.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %14, i16 %18) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %19 = load i16, i16* %arrayidx11.i.i.i.i, align 2
  %cmp.i.41.i.i.i = icmp eq i16 %19, %14
  br i1 %cmp.i.41.i.i.i, label %if.then.i.42.i.i.i, label %if.else.i.43.i.i.i

if.then.i.42.i.i.i:                               ; preds = %while.body.i.i.i
  br label %if.end.i.46.i.i.i

if.else.i.43.i.i.i:                               ; preds = %while.body.i.i.i
  %arrayidx12.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %20 = load i16, i16* %arrayidx12.i.i.i.i, align 2
  %shl13.i.i.i.i = shl i16 %20, 8
  %arrayidx14.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %21 = load i16, i16* %arrayidx14.i.i.i.i, align 2
  %add15.i.i.i.i = add i16 %shl13.i.i.i.i, %21
  %div.i.i.i.i = udiv i16 %add15.i.i.i.i, %14
  %call16.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i.i, i16 %div.i.i.i.i) #4
  br label %if.end.i.46.i.i.i

if.end.i.46.i.i.i:                                ; preds = %if.else.i.43.i.i.i, %if.then.i.42.i.i.i
  %q.i.i.i.i.0 = phi i16 [ 255, %if.then.i.42.i.i.i ], [ %div.i.i.i.i, %if.else.i.43.i.i.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %22 = load i16, i16* %arrayidx17.i.i.i.i, align 2
  %conv.i.44.i.i.i = zext i16 %22 to i32
  %shl18.i.i.i.i = shl i32 %conv.i.44.i.i.i, 16
  %arrayidx19.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %23 = load i16, i16* %arrayidx19.i.i.i.i, align 2
  %shl20.i.i.i.i = shl i16 %23, 8
  %conv21.i.i.i.i = zext i16 %shl20.i.i.i.i to i32
  %add22.i.i.i.i = add i32 %shl18.i.i.i.i, %conv21.i.i.i.i
  %arrayidx23.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %24 = load i16, i16* %arrayidx23.i.i.i.i, align 2
  %conv24.i.i.i.i = zext i16 %24 to i32
  %add25.i.i.i.i = add i32 %add22.i.i.i.i, %conv24.i.i.i.i
  %arrayidx26.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %25 = load i16, i16* %arrayidx26.i.i.i.i, align 2
  %arrayidx27.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %26 = load i16, i16* %arrayidx27.i.i.i.i, align 2
  %arrayidx28.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %27 = load i16, i16* %arrayidx28.i.i.i.i, align 2
  %shr.i.i.i.i = lshr i32 %add25.i.i.i.i, 16
  %and.i.i.i.i = and i32 %shr.i.i.i.i, 65535
  %conv29.i.i.i.i = trunc i32 %and.i.i.i.i to i16
  %and30.i.i.i.i = and i32 %add25.i.i.i.i, 65535
  %conv31.i.i.i.i = trunc i32 %and30.i.i.i.i to i16
  %call32.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %25, i16 %26, i16 %27, i16 %conv29.i.i.i.i, i16 %conv31.i.i.i.i) #4
  %call33.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.i.0) #4
  %inc.i.45.i.i.i = add i16 %q.i.i.i.i.0, 1
  br label %do.body.i.i.i.i

do.body.i.i.i.i:                                  ; preds = %do.body.i.i.i.i, %if.end.i.46.i.i.i
  %q.i.i.i.i.1 = phi i16 [ %inc.i.45.i.i.i, %if.end.i.46.i.i.i ], [ %dec.i.47.i.i.i, %do.body.i.i.i.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i.i = add i16 %q.i.i.i.i.1, -1
  %call34.i.i.i.i = call i32 @mult16(i16 zeroext %add.i.36.i.i.i, i16 zeroext %dec.i.47.i.i.i) #4
  %shr35.i.i.i.i = lshr i32 %call34.i.i.i.i, 16
  %and36.i.i.i.i = and i32 %shr35.i.i.i.i, 65535
  %conv37.i.i.i.i = trunc i32 %and36.i.i.i.i to i16
  %and38.i.i.i.i = and i32 %call34.i.i.i.i, 65535
  %conv39.i.i.i.i = trunc i32 %and38.i.i.i.i to i16
  %call40.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i.i, i16 %add.i.36.i.i.i, i16 %conv37.i.i.i.i, i16 %conv39.i.i.i.i) #4
  %cmp41.i.i.i.i = icmp ugt i32 %call34.i.i.i.i, %add25.i.i.i.i
  br i1 %cmp41.i.i.i.i, label %do.body.i.i.i.i, label %reduce_quotient.exit.i.i.i

reduce_quotient.exit.i.i.i:                       ; preds = %do.body.i.i.i.i
  %call43.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i.i = sub i16 %d.i.i.i.1, 8
  %call.i.53.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i.i) #4
  br label %for.cond.i.55.i.i.i

for.cond.i.55.i.i.i:                              ; preds = %for.body.i.57.i.i.i, %reduce_quotient.exit.i.i.i
  %i.i.50.i.i.i.0 = phi i16 [ 0, %reduce_quotient.exit.i.i.i ], [ %inc.i.58.i.i.i, %for.body.i.57.i.i.i ]
  %cmp.i.54.i.i.i = icmp ult i16 %i.i.50.i.i.i.0, %sub.i.52.i.i.i
  br i1 %cmp.i.54.i.i.i, label %for.body.i.57.i.i.i, label %for.end.i.i.i.i

for.body.i.57.i.i.i:                              ; preds = %for.cond.i.55.i.i.i
  %arrayidx.i.56.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.i.0
  store i16 0, i16* %arrayidx.i.56.i.i.i, align 2
  %inc.i.58.i.i.i = add nsw i16 %i.i.50.i.i.i.0, 1
  br label %for.cond.i.55.i.i.i

for.end.i.i.i.i:                                  ; preds = %for.cond.i.55.i.i.i
  br label %for.cond.1.i.i.i.i

for.cond.1.i.i.i.i:                               ; preds = %if.end.i.68.i.i.i, %for.end.i.i.i.i
  %i.i.50.i.i.i.1 = phi i16 [ %sub.i.52.i.i.i, %for.end.i.i.i.i ], [ %inc10.i.i.i.i, %if.end.i.68.i.i.i ]
  %c.i.i.i.i.0 = phi i16 [ 0, %for.end.i.i.i.i ], [ %shr.i.65.i.i.i, %if.end.i.68.i.i.i ]
  %cmp2.i.i.i.i = icmp slt i16 %i.i.50.i.i.i.1, 16
  br i1 %cmp2.i.i.i.i, label %for.body.3.i.i.i.i, label %reduce_multiply.exit.i.i.i

for.body.3.i.i.i.i:                               ; preds = %for.cond.1.i.i.i.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i.i = add i16 %sub.i.52.i.i.i, 8
  %cmp4.i.60.i.i.i = icmp ult i16 %i.i.50.i.i.i.1, %add.i.59.i.i.i
  br i1 %cmp4.i.60.i.i.i, label %if.then.i.63.i.i.i, label %if.else.i.64.i.i.i

if.then.i.63.i.i.i:                               ; preds = %for.body.3.i.i.i.i
  %sub5.i.i.i.i = sub i16 %i.i.50.i.i.i.1, %sub.i.52.i.i.i
  %arrayidx6.i.61.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub5.i.i.i.i
  %28 = load i16, i16* %arrayidx6.i.61.i.i.i, align 2
  %mul.i.i.i.i = mul i16 %dec.i.47.i.i.i, %28
  %add7.i.62.i.i.i = add i16 %c.i.i.i.i.0, %mul.i.i.i.i
  br label %if.end.i.68.i.i.i

if.else.i.64.i.i.i:                               ; preds = %for.body.3.i.i.i.i
  br label %if.end.i.68.i.i.i

if.end.i.68.i.i.i:                                ; preds = %if.else.i.64.i.i.i, %if.then.i.63.i.i.i
  %p.i.i.i.i.0 = phi i16 [ %add7.i.62.i.i.i, %if.then.i.63.i.i.i ], [ %c.i.i.i.i.0, %if.else.i.64.i.i.i ]
  %shr.i.65.i.i.i = lshr i16 %p.i.i.i.i.0, 8
  %and.i.66.i.i.i = and i16 %p.i.i.i.i.0, 255
  %arrayidx8.i.67.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.i.1
  store i16 %and.i.66.i.i.i, i16* %arrayidx8.i.67.i.i.i, align 2
  %inc10.i.i.i.i = add nsw i16 %i.i.50.i.i.i.1, 1
  br label %for.cond.1.i.i.i.i

reduce_multiply.exit.i.i.i:                       ; preds = %for.cond.1.i.i.i.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i.i

for.cond.i.71.i.i.i:                              ; preds = %if.end.i.76.i.i.i, %reduce_multiply.exit.i.i.i
  %i.i.69.i.i.i.0 = phi i16 [ 15, %reduce_multiply.exit.i.i.i ], [ %dec.i.77.i.i.i, %if.end.i.76.i.i.i ]
  %cmp.i.70.i.i.i = icmp sge i16 %i.i.69.i.i.i.0, 0
  br i1 %cmp.i.70.i.i.i, label %for.body.i.72.i.i.i, label %reduce_compare.exit.i.i.i

for.body.i.72.i.i.i:                              ; preds = %for.cond.i.71.i.i.i
  %cmp1.i.i.i.i = icmp ugt i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i.i, label %if.then.i.73.i.i.i, label %if.else.i.75.i.i.i

if.then.i.73.i.i.i:                               ; preds = %for.body.i.72.i.i.i
  br label %reduce_compare.exit.i.i.i

if.else.i.75.i.i.i:                               ; preds = %for.body.i.72.i.i.i
  %cmp2.i.74.i.i.i = icmp ult i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i.i, label %if.then.3.i.i.i.i, label %if.end.i.76.i.i.i

if.then.3.i.i.i.i:                                ; preds = %if.else.i.75.i.i.i
  br label %reduce_compare.exit.i.i.i

if.end.i.76.i.i.i:                                ; preds = %if.else.i.75.i.i.i
  %dec.i.77.i.i.i = add nsw i16 %i.i.69.i.i.i.0, -1
  br label %for.cond.i.71.i.i.i

reduce_compare.exit.i.i.i:                        ; preds = %if.then.3.i.i.i.i, %if.then.i.73.i.i.i, %for.cond.i.71.i.i.i
  %relation.i.i.i.i.0 = phi i16 [ 1, %if.then.i.73.i.i.i ], [ -1, %if.then.3.i.i.i.i ], [ 0, %for.cond.i.71.i.i.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i.i = icmp slt i16 %relation.i.i.i.i.0, 0
  br i1 %cmp10.i.i.i, label %if.then.11.i.i.i, label %if.end.12.i.i.i

if.then.11.i.i.i:                                 ; preds = %reduce_compare.exit.i.i.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i.i = sub i16 %d.i.i.i.1, 8
  br label %for.cond.i.87.i.i.i

for.cond.i.87.i.i.i:                              ; preds = %if.end.i.100.i.i.i, %if.then.11.i.i.i
  %i.i.82.i.i.i.0 = phi i16 [ %sub.i.85.i.i.i, %if.then.11.i.i.i ], [ %inc.i.101.i.i.i, %if.end.i.100.i.i.i ]
  %c.i.84.i.i.i.0 = phi i16 [ 0, %if.then.11.i.i.i ], [ %shr.i.97.i.i.i, %if.end.i.100.i.i.i ]
  %cmp.i.86.i.i.i = icmp slt i16 %i.i.82.i.i.i.0, 16
  br i1 %cmp.i.86.i.i.i, label %for.body.i.92.i.i.i, label %reduce_add.exit.i.i.i

for.body.i.92.i.i.i:                              ; preds = %for.cond.i.87.i.i.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.82.i.i.i.0
  %29 = load i16, i16* %arrayidx.i.88.i.i.i, align 2
  %sub1.i.89.i.i.i = sub i16 %i.i.82.i.i.i.0, %sub.i.85.i.i.i
  %add.i.90.i.i.i = add i16 %sub.i.85.i.i.i, 8
  %cmp2.i.91.i.i.i = icmp ult i16 %i.i.82.i.i.i.0, %add.i.90.i.i.i
  br i1 %cmp2.i.91.i.i.i, label %if.then.i.94.i.i.i, label %if.else.i.95.i.i.i

if.then.i.94.i.i.i:                               ; preds = %for.body.i.92.i.i.i
  %arrayidx3.i.93.i.i.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub1.i.89.i.i.i
  %30 = load i16, i16* %arrayidx3.i.93.i.i.i, align 2
  br label %if.end.i.100.i.i.i

if.else.i.95.i.i.i:                               ; preds = %for.body.i.92.i.i.i
  br label %if.end.i.100.i.i.i

if.end.i.100.i.i.i:                               ; preds = %if.else.i.95.i.i.i, %if.then.i.94.i.i.i
  %n.i.i.i.i.0 = phi i16 [ %30, %if.then.i.94.i.i.i ], [ 0, %if.else.i.95.i.i.i ]
  %add4.i.i.i.i = add i16 %c.i.84.i.i.i.0, %29
  %add5.i.96.i.i.i = add i16 %add4.i.i.i.i, %n.i.i.i.i.0
  %shr.i.97.i.i.i = lshr i16 %add5.i.96.i.i.i, 8
  %and.i.98.i.i.i = and i16 %add5.i.96.i.i.i, 255
  %arrayidx6.i.99.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.82.i.i.i.0
  store i16 %and.i.98.i.i.i, i16* %arrayidx6.i.99.i.i.i, align 2
  %inc.i.101.i.i.i = add nsw i16 %i.i.82.i.i.i.0, 1
  br label %for.cond.i.87.i.i.i

reduce_add.exit.i.i.i:                            ; preds = %for.cond.i.87.i.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.i

if.end.12.i.i.i:                                  ; preds = %reduce_add.exit.i.i.i, %reduce_compare.exit.i.i.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i.i = sub i16 %d.i.i.i.1, 8
  %call.i.114.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.i.1, i16 %sub.i.113.i.i.i) #4
  br label %for.cond.i.116.i.i.i

for.cond.i.116.i.i.i:                             ; preds = %if.end.i.126.i.i.i, %if.end.12.i.i.i
  %i.i.106.i.i.i.0 = phi i16 [ %sub.i.113.i.i.i, %if.end.12.i.i.i ], [ %inc.i.127.i.i.i, %if.end.i.126.i.i.i ]
  %borrow.i.111.i.i.i.0 = phi i16 [ 0, %if.end.12.i.i.i ], [ %borrow.i.111.i.i.i.1, %if.end.i.126.i.i.i ]
  %cmp.i.115.i.i.i = icmp slt i16 %i.i.106.i.i.i.0, 16
  br i1 %cmp.i.115.i.i.i, label %for.body.i.121.i.i.i, label %reduce_subtract.exit.i.i.i

for.body.i.121.i.i.i:                             ; preds = %for.cond.i.116.i.i.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.106.i.i.i.0
  %31 = load i16, i16* %arrayidx.i.117.i.i.i, align 2
  %arrayidx1.i.118.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.i.0
  %32 = load i16, i16* %arrayidx1.i.118.i.i.i, align 2
  %add.i.119.i.i.i = add i16 %32, %borrow.i.111.i.i.i.0
  %cmp2.i.120.i.i.i = icmp ult i16 %31, %add.i.119.i.i.i
  br i1 %cmp2.i.120.i.i.i, label %if.then.i.123.i.i.i, label %if.else.i.124.i.i.i

if.then.i.123.i.i.i:                              ; preds = %for.body.i.121.i.i.i
  %add3.i.122.i.i.i = add i16 %31, 256
  br label %if.end.i.126.i.i.i

if.else.i.124.i.i.i:                              ; preds = %for.body.i.121.i.i.i
  br label %if.end.i.126.i.i.i

if.end.i.126.i.i.i:                               ; preds = %if.else.i.124.i.i.i, %if.then.i.123.i.i.i
  %m.i.107.i.i.i.0 = phi i16 [ %add3.i.122.i.i.i, %if.then.i.123.i.i.i ], [ %31, %if.else.i.124.i.i.i ]
  %borrow.i.111.i.i.i.1 = phi i16 [ 1, %if.then.i.123.i.i.i ], [ 0, %if.else.i.124.i.i.i ]
  %sub4.i.i.i.i = sub i16 %m.i.107.i.i.i.0, %add.i.119.i.i.i
  %arrayidx5.i.125.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.106.i.i.i.0
  store i16 %sub4.i.i.i.i, i16* %arrayidx5.i.125.i.i.i, align 2
  %inc.i.127.i.i.i = add nsw i16 %i.i.106.i.i.i.0, 1
  br label %for.cond.i.116.i.i.i

reduce_subtract.exit.i.i.i:                       ; preds = %for.cond.i.116.i.i.i
  store i16 35, i16* @curtask, align 2
  %dec13.i.i.i = add i16 %d.i.i.i.1, -1
  br label %while.cond.i.i.i

while.end.i.i.i:                                  ; preds = %while.cond.i.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit.i

mod_mult.exit.i:                                  ; preds = %while.end.i.i.i, %if.then.5.i.i.i
  br label %if.end.i

if.end.i:                                         ; preds = %mod_mult.exit.i, %while.body.i
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i.82.i

for.cond.i.i.82.i:                                ; preds = %for.end.i.i.107.i, %if.end.i
  %digit.i.i.73.i.0 = phi i16 [ 0, %if.end.i ], [ %inc14.i.i.106.i, %for.end.i.i.107.i ]
  %carry.i.i.77.i.0 = phi i16 [ 0, %if.end.i ], [ %add10.i.i.103.i, %for.end.i.i.107.i ]
  %cmp.i.i.81.i = icmp ult i16 %digit.i.i.73.i.0, 16
  br i1 %cmp.i.i.81.i, label %for.body.i.i.83.i, label %for.end.15.i.i.108.i

for.body.i.i.83.i:                                ; preds = %for.cond.i.i.82.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i.85.i

for.cond.1.i.i.85.i:                              ; preds = %if.end.i.i.101.i, %for.body.i.i.83.i
  %i.i.i.72.i.0 = phi i16 [ 0, %for.body.i.i.83.i ], [ %inc.i.i.100.i, %if.end.i.i.101.i ]
  %p.i.i.74.i.0 = phi i16 [ %carry.i.i.77.i.0, %for.body.i.i.83.i ], [ %p.i.i.74.i.1, %if.end.i.i.101.i ]
  %c.i.i.75.i.0 = phi i16 [ 0, %for.body.i.i.83.i ], [ %c.i.i.75.i.1, %if.end.i.i.101.i ]
  %cmp2.i.i.84.i = icmp slt i16 %i.i.i.72.i.0, 8
  br i1 %cmp2.i.i.84.i, label %for.body.3.i.i.87.i, label %for.end.i.i.107.i

for.body.3.i.i.87.i:                              ; preds = %for.cond.1.i.i.85.i
  %cmp4.i.i.86.i = icmp ule i16 %i.i.i.72.i.0, %digit.i.i.73.i.0
  br i1 %cmp4.i.i.86.i, label %land.lhs.true.i.i.90.i, label %if.end.i.i.101.i

land.lhs.true.i.i.90.i:                           ; preds = %for.body.3.i.i.87.i
  %sub.i.i.88.i = sub i16 %digit.i.i.73.i.0, %i.i.i.72.i.0
  %cmp5.i.i.89.i = icmp ult i16 %sub.i.i.88.i, 8
  br i1 %cmp5.i.i.89.i, label %if.then.i.i.99.i, label %if.end.i.i.101.i

if.then.i.i.99.i:                                 ; preds = %land.lhs.true.i.i.90.i
  %sub6.i.i.91.i = sub i16 %digit.i.i.73.i.0, %i.i.i.72.i.0
  %arrayidx.i.i.92.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub6.i.i.91.i
  %33 = load i16, i16* %arrayidx.i.i.92.i, align 2
  %arrayidx7.i.i.93.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.72.i.0
  %34 = load i16, i16* %arrayidx7.i.i.93.i, align 2
  %mul.i.i.94.i = mul i16 %33, %34
  %shr.i.i.95.i = lshr i16 %mul.i.i.94.i, 8
  %add.i.i.96.i = add i16 %c.i.i.75.i.0, %shr.i.i.95.i
  %and.i.i.97.i = and i16 %mul.i.i.94.i, 255
  %add8.i.i.98.i = add i16 %p.i.i.74.i.0, %and.i.i.97.i
  br label %if.end.i.i.101.i

if.end.i.i.101.i:                                 ; preds = %if.then.i.i.99.i, %land.lhs.true.i.i.90.i, %for.body.3.i.i.87.i
  %p.i.i.74.i.1 = phi i16 [ %add8.i.i.98.i, %if.then.i.i.99.i ], [ %p.i.i.74.i.0, %land.lhs.true.i.i.90.i ], [ %p.i.i.74.i.0, %for.body.3.i.i.87.i ]
  %c.i.i.75.i.1 = phi i16 [ %add.i.i.96.i, %if.then.i.i.99.i ], [ %c.i.i.75.i.0, %land.lhs.true.i.i.90.i ], [ %c.i.i.75.i.0, %for.body.3.i.i.87.i ]
  %inc.i.i.100.i = add nsw i16 %i.i.i.72.i.0, 1
  br label %for.cond.1.i.i.85.i

for.end.i.i.107.i:                                ; preds = %for.cond.1.i.i.85.i
  %shr9.i.i.102.i = lshr i16 %p.i.i.74.i.0, 8
  %add10.i.i.103.i = add i16 %c.i.i.75.i.0, %shr9.i.i.102.i
  %and11.i.i.104.i = and i16 %p.i.i.74.i.0, 255
  %arrayidx12.i.i.105.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.73.i.0
  store i16 %and11.i.i.104.i, i16* %arrayidx12.i.i.105.i, align 2
  %inc14.i.i.106.i = add i16 %digit.i.i.73.i.0, 1
  br label %for.cond.i.i.82.i

for.end.15.i.i.108.i:                             ; preds = %for.cond.i.i.82.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i.110.i

for.cond.16.i.i.110.i:                            ; preds = %for.body.18.i.i.114.i, %for.end.15.i.i.108.i
  %i.i.i.72.i.1 = phi i16 [ 0, %for.end.15.i.i.108.i ], [ %inc22.i.i.113.i, %for.body.18.i.i.114.i ]
  %cmp17.i.i.109.i = icmp slt i16 %i.i.i.72.i.1, 16
  br i1 %cmp17.i.i.109.i, label %for.body.18.i.i.114.i, label %mult.exit.i.115.i

for.body.18.i.i.114.i:                            ; preds = %for.cond.16.i.i.110.i
  %arrayidx19.i.i.111.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.72.i.1
  %35 = load i16, i16* %arrayidx19.i.i.111.i, align 2
  %arrayidx20.i.i.112.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.72.i.1
  store i16 %35, i16* %arrayidx20.i.i.112.i, align 2
  %inc22.i.i.113.i = add nsw i16 %i.i.i.72.i.1, 1
  br label %for.cond.16.i.i.110.i

mult.exit.i.115.i:                                ; preds = %for.cond.16.i.i.110.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i.120.i

do.body.i.i.120.i:                                ; preds = %land.end.i.i.123.i, %mult.exit.i.115.i
  %d.i.i.69.i.0 = phi i16 [ 16, %mult.exit.i.115.i ], [ %dec.i.i.116.i, %land.end.i.i.123.i ]
  %dec.i.i.116.i = add i16 %d.i.i.69.i.0, -1
  %arrayidx.i.1.i.117.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %dec.i.i.116.i
  %36 = load i16, i16* %arrayidx.i.1.i.117.i, align 2
  %call.i.i.118.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i.116.i, i16 %36) #4
  %cmp.i.2.i.119.i = icmp eq i16 %36, 0
  br i1 %cmp.i.2.i.119.i, label %land.rhs.i.i.122.i, label %land.end.i.i.123.i

land.rhs.i.i.122.i:                               ; preds = %do.body.i.i.120.i
  %cmp1.i.i.121.i = icmp ugt i16 %dec.i.i.116.i, 0
  br label %land.end.i.i.123.i

land.end.i.i.123.i:                               ; preds = %land.rhs.i.i.122.i, %do.body.i.i.120.i
  %37 = phi i1 [ false, %do.body.i.i.120.i ], [ %cmp1.i.i.121.i, %land.rhs.i.i.122.i ]
  br i1 %37, label %do.body.i.i.120.i, label %do.end.i.i.128.i

do.end.i.i.128.i:                                 ; preds = %land.end.i.i.123.i
  %call2.i.i.124.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i.116.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i.125.i = add i16 %dec.i.i.116.i, 1
  %sub.i.i.i.126.i = sub i16 %add.i.i.i.125.i, 8
  %call.i.i.i.127.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i.116.i, i16 %sub.i.i.i.126.i) #4
  br label %for.cond.i.i.i.130.i

for.cond.i.i.i.130.i:                             ; preds = %if.end.i.i.i.141.i, %do.end.i.i.128.i
  %i.i.i.i.60.i.0 = phi i16 [ %dec.i.i.116.i, %do.end.i.i.128.i ], [ %dec.i.i.i.140.i, %if.end.i.i.i.141.i ]
  %cmp.i.i.i.129.i = icmp sge i16 %i.i.i.i.60.i.0, 0
  br i1 %cmp.i.i.i.129.i, label %for.body.i.i.i.135.i, label %reduce_normalizable.exit.i.i.146.i

for.body.i.i.i.135.i:                             ; preds = %for.cond.i.i.i.130.i
  %arrayidx.i.i.i.131.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.i.60.i.0
  %38 = load i16, i16* %arrayidx.i.i.i.131.i, align 2
  %sub1.i.i.i.132.i = sub i16 %i.i.i.i.60.i.0, %sub.i.i.i.126.i
  %arrayidx2.i.i.i.133.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub1.i.i.i.132.i
  %39 = load i16, i16* %arrayidx2.i.i.i.133.i, align 2
  %cmp3.i.i.i.134.i = icmp ugt i16 %38, %39
  br i1 %cmp3.i.i.i.134.i, label %if.then.i.i.i.136.i, label %if.else.i.i.i.138.i

if.then.i.i.i.136.i:                              ; preds = %for.body.i.i.i.135.i
  br label %reduce_normalizable.exit.i.i.146.i

if.else.i.i.i.138.i:                              ; preds = %for.body.i.i.i.135.i
  %cmp4.i.i.i.137.i = icmp ult i16 %38, %39
  br i1 %cmp4.i.i.i.137.i, label %if.then.5.i.i.i.139.i, label %if.end.i.i.i.141.i

if.then.5.i.i.i.139.i:                            ; preds = %if.else.i.i.i.138.i
  br label %reduce_normalizable.exit.i.i.146.i

if.end.i.i.i.141.i:                               ; preds = %if.else.i.i.i.138.i
  %dec.i.i.i.140.i = add nsw i16 %i.i.i.i.60.i.0, -1
  br label %for.cond.i.i.i.130.i

reduce_normalizable.exit.i.i.146.i:               ; preds = %if.then.5.i.i.i.139.i, %if.then.i.i.i.136.i, %for.cond.i.i.i.130.i
  %normalizable.i.i.i.64.i.0 = phi i8 [ 1, %if.then.i.i.i.136.i ], [ 0, %if.then.5.i.i.i.139.i ], [ 1, %for.cond.i.i.i.130.i ]
  %tobool.i.i.i.142.i = trunc i8 %normalizable.i.i.i.64.i.0 to i1
  %conv.i.i.i.143.i = zext i1 %tobool.i.i.i.142.i to i16
  %call7.i.i.i.144.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i.145.i = trunc i8 %normalizable.i.i.i.64.i.0 to i1
  br i1 %tobool8.i.i.i.145.i, label %if.then.i.3.i.149.i, label %if.else.i.i.168.i

if.then.i.3.i.149.i:                              ; preds = %reduce_normalizable.exit.i.i.146.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i.147.i = add i16 %dec.i.i.116.i, 1
  %sub.i.21.i.i.148.i = sub i16 %add.i.20.i.i.147.i, 8
  br label %for.cond.i.23.i.i.151.i

for.cond.i.23.i.i.151.i:                          ; preds = %if.end.i.30.i.i.165.i, %if.then.i.3.i.149.i
  %borrow.i.i.i.55.i.0 = phi i16 [ 0, %if.then.i.3.i.149.i ], [ %borrow.i.i.i.55.i.1, %if.end.i.30.i.i.165.i ]
  %i.i.16.i.i.50.i.0 = phi i16 [ 0, %if.then.i.3.i.149.i ], [ %inc.i.i.i.164.i, %if.end.i.30.i.i.165.i ]
  %cmp.i.22.i.i.150.i = icmp slt i16 %i.i.16.i.i.50.i.0, 8
  br i1 %cmp.i.22.i.i.150.i, label %for.body.i.27.i.i.157.i, label %reduce_normalize.exit.i.i.166.i

for.body.i.27.i.i.157.i:                          ; preds = %for.cond.i.23.i.i.151.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i.152.i = add i16 %i.i.16.i.i.50.i.0, %sub.i.21.i.i.148.i
  %arrayidx.i.24.i.i.153.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %add1.i.i.i.152.i
  %40 = load i16, i16* %arrayidx.i.24.i.i.153.i, align 2
  %arrayidx2.i.25.i.i.154.i = getelementptr inbounds i16, i16* %arraydecay, i16 %i.i.16.i.i.50.i.0
  %41 = load i16, i16* %arrayidx2.i.25.i.i.154.i, align 2
  %add3.i.i.i.155.i = add i16 %41, %borrow.i.i.i.55.i.0
  %cmp4.i.26.i.i.156.i = icmp ult i16 %40, %add3.i.i.i.155.i
  br i1 %cmp4.i.26.i.i.156.i, label %if.then.i.28.i.i.159.i, label %if.else.i.29.i.i.160.i

if.then.i.28.i.i.159.i:                           ; preds = %for.body.i.27.i.i.157.i
  %add5.i.i.i.158.i = add i16 %40, 256
  br label %if.end.i.30.i.i.165.i

if.else.i.29.i.i.160.i:                           ; preds = %for.body.i.27.i.i.157.i
  br label %if.end.i.30.i.i.165.i

if.end.i.30.i.i.165.i:                            ; preds = %if.else.i.29.i.i.160.i, %if.then.i.28.i.i.159.i
  %borrow.i.i.i.55.i.1 = phi i16 [ 1, %if.then.i.28.i.i.159.i ], [ 0, %if.else.i.29.i.i.160.i ]
  %m_d.i.17.i.i.53.i.0 = phi i16 [ %add5.i.i.i.158.i, %if.then.i.28.i.i.159.i ], [ %40, %if.else.i.29.i.i.160.i ]
  %sub6.i.i.i.161.i = sub i16 %m_d.i.17.i.i.53.i.0, %add3.i.i.i.155.i
  %add7.i.i.i.162.i = add i16 %i.i.16.i.i.50.i.0, %sub.i.21.i.i.148.i
  %arrayidx8.i.i.i.163.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %add7.i.i.i.162.i
  store i16 %sub6.i.i.i.161.i, i16* %arrayidx8.i.i.i.163.i, align 2
  %inc.i.i.i.164.i = add nsw i16 %i.i.16.i.i.50.i.0, 1
  br label %for.cond.i.23.i.i.151.i

reduce_normalize.exit.i.i.166.i:                  ; preds = %for.cond.i.23.i.i.151.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172.i

if.else.i.i.168.i:                                ; preds = %reduce_normalizable.exit.i.i.146.i
  %cmp4.i.4.i.167.i = icmp eq i16 %dec.i.i.116.i, 7
  br i1 %cmp4.i.4.i.167.i, label %if.then.5.i.i.170.i, label %if.end.i.5.i.171.i

if.then.5.i.i.170.i:                              ; preds = %if.else.i.i.168.i
  %call6.i.i.169.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312.i

if.end.i.5.i.171.i:                               ; preds = %if.else.i.i.168.i
  br label %if.end.7.i.i.172.i

if.end.7.i.i.172.i:                               ; preds = %if.end.i.5.i.171.i, %reduce_normalize.exit.i.i.166.i
  br label %while.cond.i.i.174.i

while.cond.i.i.174.i:                             ; preds = %reduce_subtract.exit.i.i.310.i, %if.end.7.i.i.172.i
  %d.i.i.69.i.1 = phi i16 [ %dec.i.i.116.i, %if.end.7.i.i.172.i ], [ %dec13.i.i.309.i, %reduce_subtract.exit.i.i.310.i ]
  %cmp8.i.i.173.i = icmp uge i16 %d.i.i.69.i.1, 8
  br i1 %cmp8.i.i.173.i, label %while.body.i.i.192.i, label %while.end.i.i.311.i

while.body.i.i.192.i:                             ; preds = %while.cond.i.i.174.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i.175.i = getelementptr inbounds i16, i16* %arraydecay, i16 7
  %42 = load i16, i16* %arrayidx.i.35.i.i.175.i, align 2
  %shl.i.i.i.176.i = shl i16 %42, 8
  %arrayidx1.i.i.i.177.i = getelementptr inbounds i16, i16* %arraydecay, i16 6
  %43 = load i16, i16* %arrayidx1.i.i.i.177.i, align 2
  %add.i.36.i.i.178.i = add i16 %shl.i.i.i.176.i, %43
  %arrayidx2.i.37.i.i.179.i = getelementptr inbounds i16, i16* %arraydecay, i16 7
  %44 = load i16, i16* %arrayidx2.i.37.i.i.179.i, align 2
  %arrayidx3.i.i.i.180.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %d.i.i.69.i.1
  %45 = load i16, i16* %arrayidx3.i.i.i.180.i, align 2
  %arrayidx4.i.i.i.181.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  store i16 %45, i16* %arrayidx4.i.i.i.181.i, align 2
  %sub.i.38.i.i.182.i = sub i16 %d.i.i.69.i.1, 1
  %arrayidx5.i.i.i.183.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub.i.38.i.i.182.i
  %46 = load i16, i16* %arrayidx5.i.i.i.183.i, align 2
  %arrayidx6.i.i.i.184.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  store i16 %46, i16* %arrayidx6.i.i.i.184.i, align 2
  %sub7.i.i.i.185.i = sub i16 %d.i.i.69.i.1, 2
  %arrayidx8.i.39.i.i.186.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub7.i.i.i.185.i
  %47 = load i16, i16* %arrayidx8.i.39.i.i.186.i, align 2
  %arrayidx9.i.i.i.187.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  store i16 %47, i16* %arrayidx9.i.i.i.187.i, align 2
  %arrayidx10.i.i.i.188.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 2
  %48 = load i16, i16* %arrayidx10.i.i.i.188.i, align 2
  %call.i.40.i.i.189.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %44, i16 %48) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %49 = load i16, i16* %arrayidx11.i.i.i.190.i, align 2
  %cmp.i.41.i.i.191.i = icmp eq i16 %49, %44
  br i1 %cmp.i.41.i.i.191.i, label %if.then.i.42.i.i.193.i, label %if.else.i.43.i.i.200.i

if.then.i.42.i.i.193.i:                           ; preds = %while.body.i.i.192.i
  br label %if.end.i.46.i.i.222.i

if.else.i.43.i.i.200.i:                           ; preds = %while.body.i.i.192.i
  %arrayidx12.i.i.i.194.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %50 = load i16, i16* %arrayidx12.i.i.i.194.i, align 2
  %shl13.i.i.i.195.i = shl i16 %50, 8
  %arrayidx14.i.i.i.196.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %51 = load i16, i16* %arrayidx14.i.i.i.196.i, align 2
  %add15.i.i.i.197.i = add i16 %shl13.i.i.i.195.i, %51
  %div.i.i.i.198.i = udiv i16 %add15.i.i.i.197.i, %44
  %call16.i.i.i.199.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i.197.i, i16 %div.i.i.i.198.i) #4
  br label %if.end.i.46.i.i.222.i

if.end.i.46.i.i.222.i:                            ; preds = %if.else.i.43.i.i.200.i, %if.then.i.42.i.i.193.i
  %q.i.i.i.41.i.0 = phi i16 [ 255, %if.then.i.42.i.i.193.i ], [ %div.i.i.i.198.i, %if.else.i.43.i.i.200.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %52 = load i16, i16* %arrayidx17.i.i.i.201.i, align 2
  %conv.i.44.i.i.202.i = zext i16 %52 to i32
  %shl18.i.i.i.203.i = shl i32 %conv.i.44.i.i.202.i, 16
  %arrayidx19.i.i.i.204.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %53 = load i16, i16* %arrayidx19.i.i.i.204.i, align 2
  %shl20.i.i.i.205.i = shl i16 %53, 8
  %conv21.i.i.i.206.i = zext i16 %shl20.i.i.i.205.i to i32
  %add22.i.i.i.207.i = add i32 %shl18.i.i.i.203.i, %conv21.i.i.i.206.i
  %arrayidx23.i.i.i.208.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %54 = load i16, i16* %arrayidx23.i.i.i.208.i, align 2
  %conv24.i.i.i.209.i = zext i16 %54 to i32
  %add25.i.i.i.210.i = add i32 %add22.i.i.i.207.i, %conv24.i.i.i.209.i
  %arrayidx26.i.i.i.211.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 2
  %55 = load i16, i16* %arrayidx26.i.i.i.211.i, align 2
  %arrayidx27.i.i.i.212.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 1
  %56 = load i16, i16* %arrayidx27.i.i.i.212.i, align 2
  %arrayidx28.i.i.i.213.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i, i16 0, i16 0
  %57 = load i16, i16* %arrayidx28.i.i.i.213.i, align 2
  %shr.i.i.i.214.i = lshr i32 %add25.i.i.i.210.i, 16
  %and.i.i.i.215.i = and i32 %shr.i.i.i.214.i, 65535
  %conv29.i.i.i.216.i = trunc i32 %and.i.i.i.215.i to i16
  %and30.i.i.i.217.i = and i32 %add25.i.i.i.210.i, 65535
  %conv31.i.i.i.218.i = trunc i32 %and30.i.i.i.217.i to i16
  %call32.i.i.i.219.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %55, i16 %56, i16 %57, i16 %conv29.i.i.i.216.i, i16 %conv31.i.i.i.218.i) #4
  %call33.i.i.i.220.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.41.i.0) #4
  %inc.i.45.i.i.221.i = add i16 %q.i.i.i.41.i.0, 1
  br label %do.body.i.i.i.232.i

do.body.i.i.i.232.i:                              ; preds = %do.body.i.i.i.232.i, %if.end.i.46.i.i.222.i
  %q.i.i.i.41.i.1 = phi i16 [ %inc.i.45.i.i.221.i, %if.end.i.46.i.i.222.i ], [ %dec.i.47.i.i.223.i, %do.body.i.i.i.232.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i.223.i = add i16 %q.i.i.i.41.i.1, -1
  %call34.i.i.i.224.i = call i32 @mult16(i16 zeroext %add.i.36.i.i.178.i, i16 zeroext %dec.i.47.i.i.223.i) #4
  %shr35.i.i.i.225.i = lshr i32 %call34.i.i.i.224.i, 16
  %and36.i.i.i.226.i = and i32 %shr35.i.i.i.225.i, 65535
  %conv37.i.i.i.227.i = trunc i32 %and36.i.i.i.226.i to i16
  %and38.i.i.i.228.i = and i32 %call34.i.i.i.224.i, 65535
  %conv39.i.i.i.229.i = trunc i32 %and38.i.i.i.228.i to i16
  %call40.i.i.i.230.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i.223.i, i16 %add.i.36.i.i.178.i, i16 %conv37.i.i.i.227.i, i16 %conv39.i.i.i.229.i) #4
  %cmp41.i.i.i.231.i = icmp ugt i32 %call34.i.i.i.224.i, %add25.i.i.i.210.i
  br i1 %cmp41.i.i.i.231.i, label %do.body.i.i.i.232.i, label %reduce_quotient.exit.i.i.236.i

reduce_quotient.exit.i.i.236.i:                   ; preds = %do.body.i.i.i.232.i
  %call43.i.i.i.233.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i.223.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i.234.i = sub i16 %d.i.i.69.i.1, 8
  %call.i.53.i.i.235.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i.234.i) #4
  br label %for.cond.i.55.i.i.238.i

for.cond.i.55.i.i.238.i:                          ; preds = %for.body.i.57.i.i.241.i, %reduce_quotient.exit.i.i.236.i
  %i.i.50.i.i.31.i.0 = phi i16 [ 0, %reduce_quotient.exit.i.i.236.i ], [ %inc.i.58.i.i.240.i, %for.body.i.57.i.i.241.i ]
  %cmp.i.54.i.i.237.i = icmp ult i16 %i.i.50.i.i.31.i.0, %sub.i.52.i.i.234.i
  br i1 %cmp.i.54.i.i.237.i, label %for.body.i.57.i.i.241.i, label %for.end.i.i.i.242.i

for.body.i.57.i.i.241.i:                          ; preds = %for.cond.i.55.i.i.238.i
  %arrayidx.i.56.i.i.239.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.i.0
  store i16 0, i16* %arrayidx.i.56.i.i.239.i, align 2
  %inc.i.58.i.i.240.i = add nsw i16 %i.i.50.i.i.31.i.0, 1
  br label %for.cond.i.55.i.i.238.i

for.end.i.i.i.242.i:                              ; preds = %for.cond.i.55.i.i.238.i
  br label %for.cond.1.i.i.i.244.i

for.cond.1.i.i.i.244.i:                           ; preds = %if.end.i.68.i.i.258.i, %for.end.i.i.i.242.i
  %c.i.i.i.33.i.0 = phi i16 [ 0, %for.end.i.i.i.242.i ], [ %shr.i.65.i.i.254.i, %if.end.i.68.i.i.258.i ]
  %i.i.50.i.i.31.i.1 = phi i16 [ %sub.i.52.i.i.234.i, %for.end.i.i.i.242.i ], [ %inc10.i.i.i.257.i, %if.end.i.68.i.i.258.i ]
  %cmp2.i.i.i.243.i = icmp slt i16 %i.i.50.i.i.31.i.1, 16
  br i1 %cmp2.i.i.i.243.i, label %for.body.3.i.i.i.247.i, label %reduce_multiply.exit.i.i.259.i

for.body.3.i.i.i.247.i:                           ; preds = %for.cond.1.i.i.i.244.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i.245.i = add i16 %sub.i.52.i.i.234.i, 8
  %cmp4.i.60.i.i.246.i = icmp ult i16 %i.i.50.i.i.31.i.1, %add.i.59.i.i.245.i
  br i1 %cmp4.i.60.i.i.246.i, label %if.then.i.63.i.i.252.i, label %if.else.i.64.i.i.253.i

if.then.i.63.i.i.252.i:                           ; preds = %for.body.3.i.i.i.247.i
  %sub5.i.i.i.248.i = sub i16 %i.i.50.i.i.31.i.1, %sub.i.52.i.i.234.i
  %arrayidx6.i.61.i.i.249.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub5.i.i.i.248.i
  %58 = load i16, i16* %arrayidx6.i.61.i.i.249.i, align 2
  %mul.i.i.i.250.i = mul i16 %dec.i.47.i.i.223.i, %58
  %add7.i.62.i.i.251.i = add i16 %c.i.i.i.33.i.0, %mul.i.i.i.250.i
  br label %if.end.i.68.i.i.258.i

if.else.i.64.i.i.253.i:                           ; preds = %for.body.3.i.i.i.247.i
  br label %if.end.i.68.i.i.258.i

if.end.i.68.i.i.258.i:                            ; preds = %if.else.i.64.i.i.253.i, %if.then.i.63.i.i.252.i
  %p.i.i.i.34.i.0 = phi i16 [ %add7.i.62.i.i.251.i, %if.then.i.63.i.i.252.i ], [ %c.i.i.i.33.i.0, %if.else.i.64.i.i.253.i ]
  %shr.i.65.i.i.254.i = lshr i16 %p.i.i.i.34.i.0, 8
  %and.i.66.i.i.255.i = and i16 %p.i.i.i.34.i.0, 255
  %arrayidx8.i.67.i.i.256.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.i.1
  store i16 %and.i.66.i.i.255.i, i16* %arrayidx8.i.67.i.i.256.i, align 2
  %inc10.i.i.i.257.i = add nsw i16 %i.i.50.i.i.31.i.1, 1
  br label %for.cond.1.i.i.i.244.i

reduce_multiply.exit.i.i.259.i:                   ; preds = %for.cond.1.i.i.i.244.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i.261.i

for.cond.i.71.i.i.261.i:                          ; preds = %if.end.i.76.i.i.269.i, %reduce_multiply.exit.i.i.259.i
  %i.i.69.i.i.25.i.0 = phi i16 [ 15, %reduce_multiply.exit.i.i.259.i ], [ %dec.i.77.i.i.268.i, %if.end.i.76.i.i.269.i ]
  %cmp.i.70.i.i.260.i = icmp sge i16 %i.i.69.i.i.25.i.0, 0
  br i1 %cmp.i.70.i.i.260.i, label %for.body.i.72.i.i.263.i, label %reduce_compare.exit.i.i.271.i

for.body.i.72.i.i.263.i:                          ; preds = %for.cond.i.71.i.i.261.i
  %cmp1.i.i.i.262.i = icmp ugt i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i.262.i, label %if.then.i.73.i.i.264.i, label %if.else.i.75.i.i.266.i

if.then.i.73.i.i.264.i:                           ; preds = %for.body.i.72.i.i.263.i
  br label %reduce_compare.exit.i.i.271.i

if.else.i.75.i.i.266.i:                           ; preds = %for.body.i.72.i.i.263.i
  %cmp2.i.74.i.i.265.i = icmp ult i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i.265.i, label %if.then.3.i.i.i.267.i, label %if.end.i.76.i.i.269.i

if.then.3.i.i.i.267.i:                            ; preds = %if.else.i.75.i.i.266.i
  br label %reduce_compare.exit.i.i.271.i

if.end.i.76.i.i.269.i:                            ; preds = %if.else.i.75.i.i.266.i
  %dec.i.77.i.i.268.i = add nsw i16 %i.i.69.i.i.25.i.0, -1
  br label %for.cond.i.71.i.i.261.i

reduce_compare.exit.i.i.271.i:                    ; preds = %if.then.3.i.i.i.267.i, %if.then.i.73.i.i.264.i, %for.cond.i.71.i.i.261.i
  %relation.i.i.i.26.i.0 = phi i16 [ 1, %if.then.i.73.i.i.264.i ], [ -1, %if.then.3.i.i.i.267.i ], [ 0, %for.cond.i.71.i.i.261.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i.270.i = icmp slt i16 %relation.i.i.i.26.i.0, 0
  br i1 %cmp10.i.i.270.i, label %if.then.11.i.i.273.i, label %if.end.12.i.i.294.i

if.then.11.i.i.273.i:                             ; preds = %reduce_compare.exit.i.i.271.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i.272.i = sub i16 %d.i.i.69.i.1, 8
  br label %for.cond.i.87.i.i.275.i

for.cond.i.87.i.i.275.i:                          ; preds = %if.end.i.100.i.i.290.i, %if.then.11.i.i.273.i
  %c.i.84.i.i.19.i.0 = phi i16 [ 0, %if.then.11.i.i.273.i ], [ %shr.i.97.i.i.286.i, %if.end.i.100.i.i.290.i ]
  %i.i.82.i.i.16.i.0 = phi i16 [ %sub.i.85.i.i.272.i, %if.then.11.i.i.273.i ], [ %inc.i.101.i.i.289.i, %if.end.i.100.i.i.290.i ]
  %cmp.i.86.i.i.274.i = icmp slt i16 %i.i.82.i.i.16.i.0, 16
  br i1 %cmp.i.86.i.i.274.i, label %for.body.i.92.i.i.280.i, label %reduce_add.exit.i.i.291.i

for.body.i.92.i.i.280.i:                          ; preds = %for.cond.i.87.i.i.275.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i.276.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.82.i.i.16.i.0
  %59 = load i16, i16* %arrayidx.i.88.i.i.276.i, align 2
  %sub1.i.89.i.i.277.i = sub i16 %i.i.82.i.i.16.i.0, %sub.i.85.i.i.272.i
  %add.i.90.i.i.278.i = add i16 %sub.i.85.i.i.272.i, 8
  %cmp2.i.91.i.i.279.i = icmp ult i16 %i.i.82.i.i.16.i.0, %add.i.90.i.i.278.i
  br i1 %cmp2.i.91.i.i.279.i, label %if.then.i.94.i.i.282.i, label %if.else.i.95.i.i.283.i

if.then.i.94.i.i.282.i:                           ; preds = %for.body.i.92.i.i.280.i
  %arrayidx3.i.93.i.i.281.i = getelementptr inbounds i16, i16* %arraydecay, i16 %sub1.i.89.i.i.277.i
  %60 = load i16, i16* %arrayidx3.i.93.i.i.281.i, align 2
  br label %if.end.i.100.i.i.290.i

if.else.i.95.i.i.283.i:                           ; preds = %for.body.i.92.i.i.280.i
  br label %if.end.i.100.i.i.290.i

if.end.i.100.i.i.290.i:                           ; preds = %if.else.i.95.i.i.283.i, %if.then.i.94.i.i.282.i
  %n.i.i.i.22.i.0 = phi i16 [ %60, %if.then.i.94.i.i.282.i ], [ 0, %if.else.i.95.i.i.283.i ]
  %add4.i.i.i.284.i = add i16 %c.i.84.i.i.19.i.0, %59
  %add5.i.96.i.i.285.i = add i16 %add4.i.i.i.284.i, %n.i.i.i.22.i.0
  %shr.i.97.i.i.286.i = lshr i16 %add5.i.96.i.i.285.i, 8
  %and.i.98.i.i.287.i = and i16 %add5.i.96.i.i.285.i, 255
  %arrayidx6.i.99.i.i.288.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.82.i.i.16.i.0
  store i16 %and.i.98.i.i.287.i, i16* %arrayidx6.i.99.i.i.288.i, align 2
  %inc.i.101.i.i.289.i = add nsw i16 %i.i.82.i.i.16.i.0, 1
  br label %for.cond.i.87.i.i.275.i

reduce_add.exit.i.i.291.i:                        ; preds = %for.cond.i.87.i.i.275.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294.i

if.end.12.i.i.294.i:                              ; preds = %reduce_add.exit.i.i.291.i, %reduce_compare.exit.i.i.271.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i.292.i = sub i16 %d.i.i.69.i.1, 8
  %call.i.114.i.i.293.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.69.i.1, i16 %sub.i.113.i.i.292.i) #4
  br label %for.cond.i.116.i.i.296.i

for.cond.i.116.i.i.296.i:                         ; preds = %if.end.i.126.i.i.308.i, %if.end.12.i.i.294.i
  %borrow.i.111.i.i.11.i.0 = phi i16 [ 0, %if.end.12.i.i.294.i ], [ %borrow.i.111.i.i.11.i.1, %if.end.i.126.i.i.308.i ]
  %i.i.106.i.i.6.i.0 = phi i16 [ %sub.i.113.i.i.292.i, %if.end.12.i.i.294.i ], [ %inc.i.127.i.i.307.i, %if.end.i.126.i.i.308.i ]
  %cmp.i.115.i.i.295.i = icmp slt i16 %i.i.106.i.i.6.i.0, 16
  br i1 %cmp.i.115.i.i.295.i, label %for.body.i.121.i.i.301.i, label %reduce_subtract.exit.i.i.310.i

for.body.i.121.i.i.301.i:                         ; preds = %for.cond.i.116.i.i.296.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i.297.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.106.i.i.6.i.0
  %61 = load i16, i16* %arrayidx.i.117.i.i.297.i, align 2
  %arrayidx1.i.118.i.i.298.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.6.i.0
  %62 = load i16, i16* %arrayidx1.i.118.i.i.298.i, align 2
  %add.i.119.i.i.299.i = add i16 %62, %borrow.i.111.i.i.11.i.0
  %cmp2.i.120.i.i.300.i = icmp ult i16 %61, %add.i.119.i.i.299.i
  br i1 %cmp2.i.120.i.i.300.i, label %if.then.i.123.i.i.303.i, label %if.else.i.124.i.i.304.i

if.then.i.123.i.i.303.i:                          ; preds = %for.body.i.121.i.i.301.i
  %add3.i.122.i.i.302.i = add i16 %61, 256
  br label %if.end.i.126.i.i.308.i

if.else.i.124.i.i.304.i:                          ; preds = %for.body.i.121.i.i.301.i
  br label %if.end.i.126.i.i.308.i

if.end.i.126.i.i.308.i:                           ; preds = %if.else.i.124.i.i.304.i, %if.then.i.123.i.i.303.i
  %borrow.i.111.i.i.11.i.1 = phi i16 [ 1, %if.then.i.123.i.i.303.i ], [ 0, %if.else.i.124.i.i.304.i ]
  %m.i.107.i.i.7.i.0 = phi i16 [ %add3.i.122.i.i.302.i, %if.then.i.123.i.i.303.i ], [ %61, %if.else.i.124.i.i.304.i ]
  %sub4.i.i.i.305.i = sub i16 %m.i.107.i.i.7.i.0, %add.i.119.i.i.299.i
  %arrayidx5.i.125.i.i.306.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.106.i.i.6.i.0
  store i16 %sub4.i.i.i.305.i, i16* %arrayidx5.i.125.i.i.306.i, align 2
  %inc.i.127.i.i.307.i = add nsw i16 %i.i.106.i.i.6.i.0, 1
  br label %for.cond.i.116.i.i.296.i

reduce_subtract.exit.i.i.310.i:                   ; preds = %for.cond.i.116.i.i.296.i
  store i16 35, i16* @curtask, align 2
  %dec13.i.i.309.i = add i16 %d.i.i.69.i.1, -1
  br label %while.cond.i.i.174.i

while.end.i.i.311.i:                              ; preds = %while.cond.i.i.174.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312.i

mod_mult.exit312.i:                               ; preds = %while.end.i.i.311.i, %if.then.5.i.i.170.i
  %shr.i = lshr i16 %e.addr.i.0, 1
  br label %while.cond.i

mod_exp.exit:                                     ; preds = %while.cond.i
  store i16 26, i16* @curtask, align 2
  br label %for.cond.16

for.cond.16:                                      ; preds = %for.inc.24, %mod_exp.exit
  %i.2 = phi i16 [ 0, %mod_exp.exit ], [ %inc25, %for.inc.24 ]
  %cmp17 = icmp slt i16 %i.2, 8
  br i1 %cmp17, label %for.body.19, label %for.end.26

for.body.19:                                      ; preds = %for.cond.16
  %arrayidx20 = getelementptr inbounds [16 x i16], [16 x i16]* @out_block, i16 0, i16 %i.2
  %63 = load i16, i16* %arrayidx20, align 2
  %conv21 = trunc i16 %63 to i8
  %add22 = add i16 %out_block_offset.0, %i.2
  %arrayidx23 = getelementptr inbounds i8, i8* %cyphertext, i16 %add22
  store i8 %conv21, i8* %arrayidx23, align 1
  br label %for.inc.24

for.inc.24:                                       ; preds = %for.body.19
  %inc25 = add nsw i16 %i.2, 1
  br label %for.cond.16

for.end.26:                                       ; preds = %for.cond.16
  %add27 = add i16 %in_block_offset.0, 7
  %add28 = add i16 %out_block_offset.0, 8
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i16 %out_block_offset.0, i16* %cyphertext_len, align 2
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
  %m_d.i.34.i.i.i.i = alloca [3 x i16], align 2
  call void @init()
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  store i16 0, i16* @curtask, align 2
  br label %while.cond.i

while.cond.i:                                     ; preds = %for.end.26.i, %do.body
  %in_block_offset.i.0 = phi i16 [ 0, %do.body ], [ %add27.i, %for.end.26.i ]
  %out_block_offset.i.0 = phi i16 [ 0, %do.body ], [ %add28.i, %for.end.26.i ]
  %cmp.i = icmp ult i16 %in_block_offset.i.0, 11
  br i1 %cmp.i, label %while.body.i, label %encrypt.exit

while.body.i:                                     ; preds = %while.cond.i
  store i16 1, i16* @curtask, align 2
  %call.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.19, i32 0, i32 0), i16 %in_block_offset.i.0) #4
  br label %for.cond.i

for.cond.i:                                       ; preds = %cond.end.i, %while.body.i
  %i.i.0 = phi i16 [ 0, %while.body.i ], [ %inc.i, %cond.end.i ]
  %cmp1.i = icmp ult i16 %i.i.0, 7
  br i1 %cmp1.i, label %for.body.i, label %for.end.i

for.body.i:                                       ; preds = %for.cond.i
  %add.i = add i16 %in_block_offset.i.0, %i.i.0
  %cmp2.i = icmp ult i16 %add.i, 11
  br i1 %cmp2.i, label %cond.true.i, label %cond.false.i

cond.true.i:                                      ; preds = %for.body.i
  %add3.i = add i16 %in_block_offset.i.0, %i.i.0
  %arrayidx.i = getelementptr inbounds i8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @PLAINTEXT, i32 0, i32 0), i16 %add3.i
  %0 = load i8, i8* %arrayidx.i, align 1
  %conv.i = zext i8 %0 to i16
  br label %cond.end.i

cond.false.i:                                     ; preds = %for.body.i
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %cond.true.i
  %cond.i = phi i16 [ %conv.i, %cond.true.i ], [ 255, %cond.false.i ]
  %arrayidx4.i = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %i.i.0
  store i16 %cond.i, i16* %arrayidx4.i, align 2
  %inc.i = add nsw i16 %i.i.0, 1
  br label %for.cond.i

for.end.i:                                        ; preds = %for.cond.i
  br label %for.cond.5.i

for.cond.5.i:                                     ; preds = %for.body.8.i, %for.end.i
  %i.i.1 = phi i16 [ 0, %for.end.i ], [ %inc14.i, %for.body.8.i ]
  %cmp6.i = icmp ult i16 %i.i.1, 1
  br i1 %cmp6.i, label %for.body.8.i, label %for.end.15.i

for.body.8.i:                                     ; preds = %for.cond.5.i
  %arrayidx9.i = getelementptr inbounds [1 x i8], [1 x i8]* @PAD_DIGITS, i16 0, i16 %i.i.1
  %1 = load i8, i8* %arrayidx9.i, align 1
  %conv10.i = zext i8 %1 to i16
  %add11.i = add i16 7, %i.i.1
  %arrayidx12.i = getelementptr inbounds [16 x i16], [16 x i16]* @in_block, i16 0, i16 %add11.i
  store i16 %conv10.i, i16* %arrayidx12.i, align 2
  %inc14.i = add nsw i16 %i.i.1, 1
  br label %for.cond.5.i

for.end.15.i:                                     ; preds = %for.cond.5.i
  %e.i = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* @pubkey, i32 0, i32 1
  %2 = load i16, i16* %e.i, align 2
  %n.i = getelementptr inbounds %struct.pubkey_t, %struct.pubkey_t* @pubkey, i32 0, i32 0
  %arraydecay.i = getelementptr inbounds [16 x i16], [16 x i16]* %n.i, i32 0, i32 0
  store i16 2, i16* @curtask, align 2
  store i16 1, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), align 2
  br label %for.cond.i.i

for.cond.i.i:                                     ; preds = %for.body.i.i, %for.end.15.i
  %i.i.i.0 = phi i16 [ 1, %for.end.15.i ], [ %inc.i.i, %for.body.i.i ]
  %cmp.i.i = icmp slt i16 %i.i.i.0, 8
  br i1 %cmp.i.i, label %for.body.i.i, label %for.end.i.i

for.body.i.i:                                     ; preds = %for.cond.i.i
  %arrayidx1.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.i.0
  store i16 0, i16* %arrayidx1.i.i, align 2
  %inc.i.i = add nsw i16 %i.i.i.0, 1
  br label %for.cond.i.i

for.end.i.i:                                      ; preds = %for.cond.i.i
  br label %while.cond.i.i

while.cond.i.i:                                   ; preds = %mod_mult.exit312.i.i, %for.end.i.i
  %e.addr.i.i.0 = phi i16 [ %2, %for.end.i.i ], [ %shr.i.i, %mod_mult.exit312.i.i ]
  %cmp2.i.i = icmp ugt i16 %e.addr.i.i.0, 0
  br i1 %cmp2.i.i, label %while.body.i.i, label %mod_exp.exit.i

while.body.i.i:                                   ; preds = %while.cond.i.i
  store i16 13, i16* @curtask, align 2
  %call.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.18, i32 0, i32 0), i16 %e.addr.i.i.0) #4
  %and.i.i = and i16 %e.addr.i.i.0, 1
  %tobool.i.i = icmp ne i16 %and.i.i, 0
  br i1 %tobool.i.i, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.body.i.i
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i.i.i

for.cond.i.i.i.i:                                 ; preds = %for.end.i.i.i.i, %if.then.i.i
  %digit.i.i.i.i.0 = phi i16 [ 0, %if.then.i.i ], [ %inc14.i.i.i.i, %for.end.i.i.i.i ]
  %carry.i.i.i.i.0 = phi i16 [ 0, %if.then.i.i ], [ %add10.i.i.i.i, %for.end.i.i.i.i ]
  %cmp.i.i.i.i = icmp ult i16 %digit.i.i.i.i.0, 16
  br i1 %cmp.i.i.i.i, label %for.body.i.i.i.i, label %for.end.15.i.i.i.i

for.body.i.i.i.i:                                 ; preds = %for.cond.i.i.i.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i.i.i

for.cond.1.i.i.i.i:                               ; preds = %if.end.i.i.i.i, %for.body.i.i.i.i
  %i.i.i.i.i.0 = phi i16 [ 0, %for.body.i.i.i.i ], [ %inc.i.i.i.i, %if.end.i.i.i.i ]
  %p.i.i.i.i.0 = phi i16 [ %carry.i.i.i.i.0, %for.body.i.i.i.i ], [ %p.i.i.i.i.1, %if.end.i.i.i.i ]
  %c.i.i.i.i.0 = phi i16 [ 0, %for.body.i.i.i.i ], [ %c.i.i.i.i.1, %if.end.i.i.i.i ]
  %cmp2.i.i.i.i = icmp slt i16 %i.i.i.i.i.0, 8
  br i1 %cmp2.i.i.i.i, label %for.body.3.i.i.i.i, label %for.end.i.i.i.i

for.body.3.i.i.i.i:                               ; preds = %for.cond.1.i.i.i.i
  %cmp4.i.i.i.i = icmp ule i16 %i.i.i.i.i.0, %digit.i.i.i.i.0
  br i1 %cmp4.i.i.i.i, label %land.lhs.true.i.i.i.i, label %if.end.i.i.i.i

land.lhs.true.i.i.i.i:                            ; preds = %for.body.3.i.i.i.i
  %sub.i.i.i.i = sub i16 %digit.i.i.i.i.0, %i.i.i.i.i.0
  %cmp5.i.i.i.i = icmp ult i16 %sub.i.i.i.i, 8
  br i1 %cmp5.i.i.i.i, label %if.then.i.i.i.i, label %if.end.i.i.i.i

if.then.i.i.i.i:                                  ; preds = %land.lhs.true.i.i.i.i
  %sub6.i.i.i.i = sub i16 %digit.i.i.i.i.0, %i.i.i.i.i.0
  %arrayidx.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub6.i.i.i.i
  %3 = load i16, i16* %arrayidx.i.i.i.i, align 2
  %arrayidx7.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.i.i.0
  %4 = load i16, i16* %arrayidx7.i.i.i.i, align 2
  %mul.i.i.i.i = mul i16 %3, %4
  %shr.i.i.i.i = lshr i16 %mul.i.i.i.i, 8
  %add.i.i.i.i = add i16 %c.i.i.i.i.0, %shr.i.i.i.i
  %and.i.i.i.i = and i16 %mul.i.i.i.i, 255
  %add8.i.i.i.i = add i16 %p.i.i.i.i.0, %and.i.i.i.i
  br label %if.end.i.i.i.i

if.end.i.i.i.i:                                   ; preds = %if.then.i.i.i.i, %land.lhs.true.i.i.i.i, %for.body.3.i.i.i.i
  %p.i.i.i.i.1 = phi i16 [ %add8.i.i.i.i, %if.then.i.i.i.i ], [ %p.i.i.i.i.0, %land.lhs.true.i.i.i.i ], [ %p.i.i.i.i.0, %for.body.3.i.i.i.i ]
  %c.i.i.i.i.1 = phi i16 [ %add.i.i.i.i, %if.then.i.i.i.i ], [ %c.i.i.i.i.0, %land.lhs.true.i.i.i.i ], [ %c.i.i.i.i.0, %for.body.3.i.i.i.i ]
  %inc.i.i.i.i = add nsw i16 %i.i.i.i.i.0, 1
  br label %for.cond.1.i.i.i.i

for.end.i.i.i.i:                                  ; preds = %for.cond.1.i.i.i.i
  %shr9.i.i.i.i = lshr i16 %p.i.i.i.i.0, 8
  %add10.i.i.i.i = add i16 %c.i.i.i.i.0, %shr9.i.i.i.i
  %and11.i.i.i.i = and i16 %p.i.i.i.i.0, 255
  %arrayidx12.i.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.i.i.0
  store i16 %and11.i.i.i.i, i16* %arrayidx12.i.i.i.i, align 2
  %inc14.i.i.i.i = add i16 %digit.i.i.i.i.0, 1
  br label %for.cond.i.i.i.i

for.end.15.i.i.i.i:                               ; preds = %for.cond.i.i.i.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i.i.i

for.cond.16.i.i.i.i:                              ; preds = %for.body.18.i.i.i.i, %for.end.15.i.i.i.i
  %i.i.i.i.i.1 = phi i16 [ 0, %for.end.15.i.i.i.i ], [ %inc22.i.i.i.i, %for.body.18.i.i.i.i ]
  %cmp17.i.i.i.i = icmp slt i16 %i.i.i.i.i.1, 16
  br i1 %cmp17.i.i.i.i, label %for.body.18.i.i.i.i, label %mult.exit.i.i.i

for.body.18.i.i.i.i:                              ; preds = %for.cond.16.i.i.i.i
  %arrayidx19.i.i.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.i.i.1
  %5 = load i16, i16* %arrayidx19.i.i.i.i, align 2
  %arrayidx20.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.i.i.i.1
  store i16 %5, i16* %arrayidx20.i.i.i.i, align 2
  %inc22.i.i.i.i = add nsw i16 %i.i.i.i.i.1, 1
  br label %for.cond.16.i.i.i.i

mult.exit.i.i.i:                                  ; preds = %for.cond.16.i.i.i.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i.i.i

do.body.i.i.i.i:                                  ; preds = %land.end.i.i.i.i, %mult.exit.i.i.i
  %d.i.i.i.i.0 = phi i16 [ 16, %mult.exit.i.i.i ], [ %dec.i.i.i.i, %land.end.i.i.i.i ]
  %dec.i.i.i.i = add i16 %d.i.i.i.i.0, -1
  %arrayidx.i.1.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %dec.i.i.i.i
  %6 = load i16, i16* %arrayidx.i.1.i.i.i, align 2
  %call.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i.i.i, i16 %6) #4
  %cmp.i.2.i.i.i = icmp eq i16 %6, 0
  br i1 %cmp.i.2.i.i.i, label %land.rhs.i.i.i.i, label %land.end.i.i.i.i

land.rhs.i.i.i.i:                                 ; preds = %do.body.i.i.i.i
  %cmp1.i.i.i.i = icmp ugt i16 %dec.i.i.i.i, 0
  br label %land.end.i.i.i.i

land.end.i.i.i.i:                                 ; preds = %land.rhs.i.i.i.i, %do.body.i.i.i.i
  %7 = phi i1 [ false, %do.body.i.i.i.i ], [ %cmp1.i.i.i.i, %land.rhs.i.i.i.i ]
  br i1 %7, label %do.body.i.i.i.i, label %do.end.i.i.i.i

do.end.i.i.i.i:                                   ; preds = %land.end.i.i.i.i
  %call2.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i.i.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i.i.i = add i16 %dec.i.i.i.i, 1
  %sub.i.i.i.i.i = sub i16 %add.i.i.i.i.i, 8
  %call.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i.i.i, i16 %sub.i.i.i.i.i) #4
  br label %for.cond.i.i.i.i.i

for.cond.i.i.i.i.i:                               ; preds = %if.end.i.i.i.i.i, %do.end.i.i.i.i
  %i.i.i.i.i.i.0 = phi i16 [ %dec.i.i.i.i, %do.end.i.i.i.i ], [ %dec.i.i.i.i.i, %if.end.i.i.i.i.i ]
  %cmp.i.i.i.i.i = icmp sge i16 %i.i.i.i.i.i.0, 0
  br i1 %cmp.i.i.i.i.i, label %for.body.i.i.i.i.i, label %reduce_normalizable.exit.i.i.i.i

for.body.i.i.i.i.i:                               ; preds = %for.cond.i.i.i.i.i
  %arrayidx.i.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.i.i.i.i.0
  %8 = load i16, i16* %arrayidx.i.i.i.i.i, align 2
  %sub1.i.i.i.i.i = sub i16 %i.i.i.i.i.i.0, %sub.i.i.i.i.i
  %arrayidx2.i.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub1.i.i.i.i.i
  %9 = load i16, i16* %arrayidx2.i.i.i.i.i, align 2
  %cmp3.i.i.i.i.i = icmp ugt i16 %8, %9
  br i1 %cmp3.i.i.i.i.i, label %if.then.i.i.i.i.i, label %if.else.i.i.i.i.i

if.then.i.i.i.i.i:                                ; preds = %for.body.i.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i.i

if.else.i.i.i.i.i:                                ; preds = %for.body.i.i.i.i.i
  %cmp4.i.i.i.i.i = icmp ult i16 %8, %9
  br i1 %cmp4.i.i.i.i.i, label %if.then.5.i.i.i.i.i, label %if.end.i.i.i.i.i

if.then.5.i.i.i.i.i:                              ; preds = %if.else.i.i.i.i.i
  br label %reduce_normalizable.exit.i.i.i.i

if.end.i.i.i.i.i:                                 ; preds = %if.else.i.i.i.i.i
  %dec.i.i.i.i.i = add nsw i16 %i.i.i.i.i.i.0, -1
  br label %for.cond.i.i.i.i.i

reduce_normalizable.exit.i.i.i.i:                 ; preds = %if.then.5.i.i.i.i.i, %if.then.i.i.i.i.i, %for.cond.i.i.i.i.i
  %normalizable.i.i.i.i.i.0 = phi i8 [ 1, %if.then.i.i.i.i.i ], [ 0, %if.then.5.i.i.i.i.i ], [ 1, %for.cond.i.i.i.i.i ]
  %tobool.i.i.i.i.i = trunc i8 %normalizable.i.i.i.i.i.0 to i1
  %conv.i.i.i.i.i = zext i1 %tobool.i.i.i.i.i to i16
  %call7.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.i.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i.i.i = trunc i8 %normalizable.i.i.i.i.i.0 to i1
  br i1 %tobool8.i.i.i.i.i, label %if.then.i.3.i.i.i, label %if.else.i.i.i.i

if.then.i.3.i.i.i:                                ; preds = %reduce_normalizable.exit.i.i.i.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i.i.i = add i16 %dec.i.i.i.i, 1
  %sub.i.21.i.i.i.i = sub i16 %add.i.20.i.i.i.i, 8
  br label %for.cond.i.23.i.i.i.i

for.cond.i.23.i.i.i.i:                            ; preds = %if.end.i.30.i.i.i.i, %if.then.i.3.i.i.i
  %i.i.16.i.i.i.i.0 = phi i16 [ 0, %if.then.i.3.i.i.i ], [ %inc.i.i.i.i.i, %if.end.i.30.i.i.i.i ]
  %borrow.i.i.i.i.i.0 = phi i16 [ 0, %if.then.i.3.i.i.i ], [ %borrow.i.i.i.i.i.1, %if.end.i.30.i.i.i.i ]
  %cmp.i.22.i.i.i.i = icmp slt i16 %i.i.16.i.i.i.i.0, 8
  br i1 %cmp.i.22.i.i.i.i, label %for.body.i.27.i.i.i.i, label %reduce_normalize.exit.i.i.i.i

for.body.i.27.i.i.i.i:                            ; preds = %for.cond.i.23.i.i.i.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i.i.i = add i16 %i.i.16.i.i.i.i.0, %sub.i.21.i.i.i.i
  %arrayidx.i.24.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %add1.i.i.i.i.i
  %10 = load i16, i16* %arrayidx.i.24.i.i.i.i, align 2
  %arrayidx2.i.25.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %i.i.16.i.i.i.i.0
  %11 = load i16, i16* %arrayidx2.i.25.i.i.i.i, align 2
  %add3.i.i.i.i.i = add i16 %11, %borrow.i.i.i.i.i.0
  %cmp4.i.26.i.i.i.i = icmp ult i16 %10, %add3.i.i.i.i.i
  br i1 %cmp4.i.26.i.i.i.i, label %if.then.i.28.i.i.i.i, label %if.else.i.29.i.i.i.i

if.then.i.28.i.i.i.i:                             ; preds = %for.body.i.27.i.i.i.i
  %add5.i.i.i.i.i = add i16 %10, 256
  br label %if.end.i.30.i.i.i.i

if.else.i.29.i.i.i.i:                             ; preds = %for.body.i.27.i.i.i.i
  br label %if.end.i.30.i.i.i.i

if.end.i.30.i.i.i.i:                              ; preds = %if.else.i.29.i.i.i.i, %if.then.i.28.i.i.i.i
  %m_d.i.17.i.i.i.i.0 = phi i16 [ %add5.i.i.i.i.i, %if.then.i.28.i.i.i.i ], [ %10, %if.else.i.29.i.i.i.i ]
  %borrow.i.i.i.i.i.1 = phi i16 [ 1, %if.then.i.28.i.i.i.i ], [ 0, %if.else.i.29.i.i.i.i ]
  %sub6.i.i.i.i.i = sub i16 %m_d.i.17.i.i.i.i.0, %add3.i.i.i.i.i
  %add7.i.i.i.i.i = add i16 %i.i.16.i.i.i.i.0, %sub.i.21.i.i.i.i
  %arrayidx8.i.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %add7.i.i.i.i.i
  store i16 %sub6.i.i.i.i.i, i16* %arrayidx8.i.i.i.i.i, align 2
  %inc.i.i.i.i.i = add nsw i16 %i.i.16.i.i.i.i.0, 1
  br label %for.cond.i.23.i.i.i.i

reduce_normalize.exit.i.i.i.i:                    ; preds = %for.cond.i.23.i.i.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.i.i

if.else.i.i.i.i:                                  ; preds = %reduce_normalizable.exit.i.i.i.i
  %cmp4.i.4.i.i.i = icmp eq i16 %dec.i.i.i.i, 7
  br i1 %cmp4.i.4.i.i.i, label %if.then.5.i.i.i.i, label %if.end.i.5.i.i.i

if.then.5.i.i.i.i:                                ; preds = %if.else.i.i.i.i
  %call6.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit.i.i

if.end.i.5.i.i.i:                                 ; preds = %if.else.i.i.i.i
  br label %if.end.7.i.i.i.i

if.end.7.i.i.i.i:                                 ; preds = %if.end.i.5.i.i.i, %reduce_normalize.exit.i.i.i.i
  br label %while.cond.i.i.i.i

while.cond.i.i.i.i:                               ; preds = %reduce_subtract.exit.i.i.i.i, %if.end.7.i.i.i.i
  %d.i.i.i.i.1 = phi i16 [ %dec.i.i.i.i, %if.end.7.i.i.i.i ], [ %dec13.i.i.i.i, %reduce_subtract.exit.i.i.i.i ]
  %cmp8.i.i.i.i = icmp uge i16 %d.i.i.i.i.1, 8
  br i1 %cmp8.i.i.i.i, label %while.body.i.i.i.i, label %while.end.i.i.i.i

while.body.i.i.i.i:                               ; preds = %while.cond.i.i.i.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 7
  %12 = load i16, i16* %arrayidx.i.35.i.i.i.i, align 2
  %shl.i.i.i.i.i = shl i16 %12, 8
  %arrayidx1.i.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 6
  %13 = load i16, i16* %arrayidx1.i.i.i.i.i, align 2
  %add.i.36.i.i.i.i = add i16 %shl.i.i.i.i.i, %13
  %arrayidx2.i.37.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 7
  %14 = load i16, i16* %arrayidx2.i.37.i.i.i.i, align 2
  %arrayidx3.i.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %d.i.i.i.i.1
  %15 = load i16, i16* %arrayidx3.i.i.i.i.i, align 2
  %arrayidx4.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  store i16 %15, i16* %arrayidx4.i.i.i.i.i, align 2
  %sub.i.38.i.i.i.i = sub i16 %d.i.i.i.i.1, 1
  %arrayidx5.i.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub.i.38.i.i.i.i
  %16 = load i16, i16* %arrayidx5.i.i.i.i.i, align 2
  %arrayidx6.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  store i16 %16, i16* %arrayidx6.i.i.i.i.i, align 2
  %sub7.i.i.i.i.i = sub i16 %d.i.i.i.i.1, 2
  %arrayidx8.i.39.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %sub7.i.i.i.i.i
  %17 = load i16, i16* %arrayidx8.i.39.i.i.i.i, align 2
  %arrayidx9.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  store i16 %17, i16* %arrayidx9.i.i.i.i.i, align 2
  %arrayidx10.i.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 2
  %18 = load i16, i16* %arrayidx10.i.i.i.i.i, align 2
  %call.i.40.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %14, i16 %18) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %19 = load i16, i16* %arrayidx11.i.i.i.i.i, align 2
  %cmp.i.41.i.i.i.i = icmp eq i16 %19, %14
  br i1 %cmp.i.41.i.i.i.i, label %if.then.i.42.i.i.i.i, label %if.else.i.43.i.i.i.i

if.then.i.42.i.i.i.i:                             ; preds = %while.body.i.i.i.i
  br label %if.end.i.46.i.i.i.i

if.else.i.43.i.i.i.i:                             ; preds = %while.body.i.i.i.i
  %arrayidx12.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %20 = load i16, i16* %arrayidx12.i.i.i.i.i, align 2
  %shl13.i.i.i.i.i = shl i16 %20, 8
  %arrayidx14.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %21 = load i16, i16* %arrayidx14.i.i.i.i.i, align 2
  %add15.i.i.i.i.i = add i16 %shl13.i.i.i.i.i, %21
  %div.i.i.i.i.i = udiv i16 %add15.i.i.i.i.i, %14
  %call16.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i.i.i, i16 %div.i.i.i.i.i) #4
  br label %if.end.i.46.i.i.i.i

if.end.i.46.i.i.i.i:                              ; preds = %if.else.i.43.i.i.i.i, %if.then.i.42.i.i.i.i
  %q.i.i.i.i.i.0 = phi i16 [ 255, %if.then.i.42.i.i.i.i ], [ %div.i.i.i.i.i, %if.else.i.43.i.i.i.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %22 = load i16, i16* %arrayidx17.i.i.i.i.i, align 2
  %conv.i.44.i.i.i.i = zext i16 %22 to i32
  %shl18.i.i.i.i.i = shl i32 %conv.i.44.i.i.i.i, 16
  %arrayidx19.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %23 = load i16, i16* %arrayidx19.i.i.i.i.i, align 2
  %shl20.i.i.i.i.i = shl i16 %23, 8
  %conv21.i.i.i.i.i = zext i16 %shl20.i.i.i.i.i to i32
  %add22.i.i.i.i.i = add i32 %shl18.i.i.i.i.i, %conv21.i.i.i.i.i
  %arrayidx23.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %24 = load i16, i16* %arrayidx23.i.i.i.i.i, align 2
  %conv24.i.i.i.i.i = zext i16 %24 to i32
  %add25.i.i.i.i.i = add i32 %add22.i.i.i.i.i, %conv24.i.i.i.i.i
  %arrayidx26.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %25 = load i16, i16* %arrayidx26.i.i.i.i.i, align 2
  %arrayidx27.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %26 = load i16, i16* %arrayidx27.i.i.i.i.i, align 2
  %arrayidx28.i.i.i.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %27 = load i16, i16* %arrayidx28.i.i.i.i.i, align 2
  %shr.i.i.i.i.i = lshr i32 %add25.i.i.i.i.i, 16
  %and.i.i.i.i.i = and i32 %shr.i.i.i.i.i, 65535
  %conv29.i.i.i.i.i = trunc i32 %and.i.i.i.i.i to i16
  %and30.i.i.i.i.i = and i32 %add25.i.i.i.i.i, 65535
  %conv31.i.i.i.i.i = trunc i32 %and30.i.i.i.i.i to i16
  %call32.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %25, i16 %26, i16 %27, i16 %conv29.i.i.i.i.i, i16 %conv31.i.i.i.i.i) #4
  %call33.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.i.i.0) #4
  %inc.i.45.i.i.i.i = add i16 %q.i.i.i.i.i.0, 1
  br label %do.body.i.i.i.i.i

do.body.i.i.i.i.i:                                ; preds = %do.body.i.i.i.i.i, %if.end.i.46.i.i.i.i
  %q.i.i.i.i.i.1 = phi i16 [ %inc.i.45.i.i.i.i, %if.end.i.46.i.i.i.i ], [ %dec.i.47.i.i.i.i, %do.body.i.i.i.i.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i.i.i = add i16 %q.i.i.i.i.i.1, -1
  %call34.i.i.i.i.i = call i32 @mult16(i16 zeroext %add.i.36.i.i.i.i, i16 zeroext %dec.i.47.i.i.i.i) #4
  %shr35.i.i.i.i.i = lshr i32 %call34.i.i.i.i.i, 16
  %and36.i.i.i.i.i = and i32 %shr35.i.i.i.i.i, 65535
  %conv37.i.i.i.i.i = trunc i32 %and36.i.i.i.i.i to i16
  %and38.i.i.i.i.i = and i32 %call34.i.i.i.i.i, 65535
  %conv39.i.i.i.i.i = trunc i32 %and38.i.i.i.i.i to i16
  %call40.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i.i.i, i16 %add.i.36.i.i.i.i, i16 %conv37.i.i.i.i.i, i16 %conv39.i.i.i.i.i) #4
  %cmp41.i.i.i.i.i = icmp ugt i32 %call34.i.i.i.i.i, %add25.i.i.i.i.i
  br i1 %cmp41.i.i.i.i.i, label %do.body.i.i.i.i.i, label %reduce_quotient.exit.i.i.i.i

reduce_quotient.exit.i.i.i.i:                     ; preds = %do.body.i.i.i.i.i
  %call43.i.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i.i.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i.i.i = sub i16 %d.i.i.i.i.1, 8
  %call.i.53.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i.i.i) #4
  br label %for.cond.i.55.i.i.i.i

for.cond.i.55.i.i.i.i:                            ; preds = %for.body.i.57.i.i.i.i, %reduce_quotient.exit.i.i.i.i
  %i.i.50.i.i.i.i.0 = phi i16 [ 0, %reduce_quotient.exit.i.i.i.i ], [ %inc.i.58.i.i.i.i, %for.body.i.57.i.i.i.i ]
  %cmp.i.54.i.i.i.i = icmp ult i16 %i.i.50.i.i.i.i.0, %sub.i.52.i.i.i.i
  br i1 %cmp.i.54.i.i.i.i, label %for.body.i.57.i.i.i.i, label %for.end.i.i.i.i.i

for.body.i.57.i.i.i.i:                            ; preds = %for.cond.i.55.i.i.i.i
  %arrayidx.i.56.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.i.i.0
  store i16 0, i16* %arrayidx.i.56.i.i.i.i, align 2
  %inc.i.58.i.i.i.i = add nsw i16 %i.i.50.i.i.i.i.0, 1
  br label %for.cond.i.55.i.i.i.i

for.end.i.i.i.i.i:                                ; preds = %for.cond.i.55.i.i.i.i
  br label %for.cond.1.i.i.i.i.i

for.cond.1.i.i.i.i.i:                             ; preds = %if.end.i.68.i.i.i.i, %for.end.i.i.i.i.i
  %i.i.50.i.i.i.i.1 = phi i16 [ %sub.i.52.i.i.i.i, %for.end.i.i.i.i.i ], [ %inc10.i.i.i.i.i, %if.end.i.68.i.i.i.i ]
  %c.i.i.i.i.i.0 = phi i16 [ 0, %for.end.i.i.i.i.i ], [ %shr.i.65.i.i.i.i, %if.end.i.68.i.i.i.i ]
  %cmp2.i.i.i.i.i = icmp slt i16 %i.i.50.i.i.i.i.1, 16
  br i1 %cmp2.i.i.i.i.i, label %for.body.3.i.i.i.i.i, label %reduce_multiply.exit.i.i.i.i

for.body.3.i.i.i.i.i:                             ; preds = %for.cond.1.i.i.i.i.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i.i.i = add i16 %sub.i.52.i.i.i.i, 8
  %cmp4.i.60.i.i.i.i = icmp ult i16 %i.i.50.i.i.i.i.1, %add.i.59.i.i.i.i
  br i1 %cmp4.i.60.i.i.i.i, label %if.then.i.63.i.i.i.i, label %if.else.i.64.i.i.i.i

if.then.i.63.i.i.i.i:                             ; preds = %for.body.3.i.i.i.i.i
  %sub5.i.i.i.i.i = sub i16 %i.i.50.i.i.i.i.1, %sub.i.52.i.i.i.i
  %arrayidx6.i.61.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub5.i.i.i.i.i
  %28 = load i16, i16* %arrayidx6.i.61.i.i.i.i, align 2
  %mul.i.i.i.i.i = mul i16 %dec.i.47.i.i.i.i, %28
  %add7.i.62.i.i.i.i = add i16 %c.i.i.i.i.i.0, %mul.i.i.i.i.i
  br label %if.end.i.68.i.i.i.i

if.else.i.64.i.i.i.i:                             ; preds = %for.body.3.i.i.i.i.i
  br label %if.end.i.68.i.i.i.i

if.end.i.68.i.i.i.i:                              ; preds = %if.else.i.64.i.i.i.i, %if.then.i.63.i.i.i.i
  %p.i.i.i.i.i.0 = phi i16 [ %add7.i.62.i.i.i.i, %if.then.i.63.i.i.i.i ], [ %c.i.i.i.i.i.0, %if.else.i.64.i.i.i.i ]
  %shr.i.65.i.i.i.i = lshr i16 %p.i.i.i.i.i.0, 8
  %and.i.66.i.i.i.i = and i16 %p.i.i.i.i.i.0, 255
  %arrayidx8.i.67.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.i.i.1
  store i16 %and.i.66.i.i.i.i, i16* %arrayidx8.i.67.i.i.i.i, align 2
  %inc10.i.i.i.i.i = add nsw i16 %i.i.50.i.i.i.i.1, 1
  br label %for.cond.1.i.i.i.i.i

reduce_multiply.exit.i.i.i.i:                     ; preds = %for.cond.1.i.i.i.i.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i.i.i

for.cond.i.71.i.i.i.i:                            ; preds = %if.end.i.76.i.i.i.i, %reduce_multiply.exit.i.i.i.i
  %i.i.69.i.i.i.i.0 = phi i16 [ 15, %reduce_multiply.exit.i.i.i.i ], [ %dec.i.77.i.i.i.i, %if.end.i.76.i.i.i.i ]
  %cmp.i.70.i.i.i.i = icmp sge i16 %i.i.69.i.i.i.i.0, 0
  br i1 %cmp.i.70.i.i.i.i, label %for.body.i.72.i.i.i.i, label %reduce_compare.exit.i.i.i.i

for.body.i.72.i.i.i.i:                            ; preds = %for.cond.i.71.i.i.i.i
  %cmp1.i.i.i.i.i = icmp ugt i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i.i.i, label %if.then.i.73.i.i.i.i, label %if.else.i.75.i.i.i.i

if.then.i.73.i.i.i.i:                             ; preds = %for.body.i.72.i.i.i.i
  br label %reduce_compare.exit.i.i.i.i

if.else.i.75.i.i.i.i:                             ; preds = %for.body.i.72.i.i.i.i
  %cmp2.i.74.i.i.i.i = icmp ult i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i.i.i, label %if.then.3.i.i.i.i.i, label %if.end.i.76.i.i.i.i

if.then.3.i.i.i.i.i:                              ; preds = %if.else.i.75.i.i.i.i
  br label %reduce_compare.exit.i.i.i.i

if.end.i.76.i.i.i.i:                              ; preds = %if.else.i.75.i.i.i.i
  %dec.i.77.i.i.i.i = add nsw i16 %i.i.69.i.i.i.i.0, -1
  br label %for.cond.i.71.i.i.i.i

reduce_compare.exit.i.i.i.i:                      ; preds = %if.then.3.i.i.i.i.i, %if.then.i.73.i.i.i.i, %for.cond.i.71.i.i.i.i
  %relation.i.i.i.i.i.0 = phi i16 [ 1, %if.then.i.73.i.i.i.i ], [ -1, %if.then.3.i.i.i.i.i ], [ 0, %for.cond.i.71.i.i.i.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i.i.i = icmp slt i16 %relation.i.i.i.i.i.0, 0
  br i1 %cmp10.i.i.i.i, label %if.then.11.i.i.i.i, label %if.end.12.i.i.i.i

if.then.11.i.i.i.i:                               ; preds = %reduce_compare.exit.i.i.i.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i.i.i = sub i16 %d.i.i.i.i.1, 8
  br label %for.cond.i.87.i.i.i.i

for.cond.i.87.i.i.i.i:                            ; preds = %if.end.i.100.i.i.i.i, %if.then.11.i.i.i.i
  %i.i.82.i.i.i.i.0 = phi i16 [ %sub.i.85.i.i.i.i, %if.then.11.i.i.i.i ], [ %inc.i.101.i.i.i.i, %if.end.i.100.i.i.i.i ]
  %c.i.84.i.i.i.i.0 = phi i16 [ 0, %if.then.11.i.i.i.i ], [ %shr.i.97.i.i.i.i, %if.end.i.100.i.i.i.i ]
  %cmp.i.86.i.i.i.i = icmp slt i16 %i.i.82.i.i.i.i.0, 16
  br i1 %cmp.i.86.i.i.i.i, label %for.body.i.92.i.i.i.i, label %reduce_add.exit.i.i.i.i

for.body.i.92.i.i.i.i:                            ; preds = %for.cond.i.87.i.i.i.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.82.i.i.i.i.0
  %29 = load i16, i16* %arrayidx.i.88.i.i.i.i, align 2
  %sub1.i.89.i.i.i.i = sub i16 %i.i.82.i.i.i.i.0, %sub.i.85.i.i.i.i
  %add.i.90.i.i.i.i = add i16 %sub.i.85.i.i.i.i, 8
  %cmp2.i.91.i.i.i.i = icmp ult i16 %i.i.82.i.i.i.i.0, %add.i.90.i.i.i.i
  br i1 %cmp2.i.91.i.i.i.i, label %if.then.i.94.i.i.i.i, label %if.else.i.95.i.i.i.i

if.then.i.94.i.i.i.i:                             ; preds = %for.body.i.92.i.i.i.i
  %arrayidx3.i.93.i.i.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub1.i.89.i.i.i.i
  %30 = load i16, i16* %arrayidx3.i.93.i.i.i.i, align 2
  br label %if.end.i.100.i.i.i.i

if.else.i.95.i.i.i.i:                             ; preds = %for.body.i.92.i.i.i.i
  br label %if.end.i.100.i.i.i.i

if.end.i.100.i.i.i.i:                             ; preds = %if.else.i.95.i.i.i.i, %if.then.i.94.i.i.i.i
  %n.i.i.i.i.i.0 = phi i16 [ %30, %if.then.i.94.i.i.i.i ], [ 0, %if.else.i.95.i.i.i.i ]
  %add4.i.i.i.i.i = add i16 %c.i.84.i.i.i.i.0, %29
  %add5.i.96.i.i.i.i = add i16 %add4.i.i.i.i.i, %n.i.i.i.i.i.0
  %shr.i.97.i.i.i.i = lshr i16 %add5.i.96.i.i.i.i, 8
  %and.i.98.i.i.i.i = and i16 %add5.i.96.i.i.i.i, 255
  %arrayidx6.i.99.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.82.i.i.i.i.0
  store i16 %and.i.98.i.i.i.i, i16* %arrayidx6.i.99.i.i.i.i, align 2
  %inc.i.101.i.i.i.i = add nsw i16 %i.i.82.i.i.i.i.0, 1
  br label %for.cond.i.87.i.i.i.i

reduce_add.exit.i.i.i.i:                          ; preds = %for.cond.i.87.i.i.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.i.i

if.end.12.i.i.i.i:                                ; preds = %reduce_add.exit.i.i.i.i, %reduce_compare.exit.i.i.i.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i.i.i = sub i16 %d.i.i.i.i.1, 8
  %call.i.114.i.i.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.i.i.1, i16 %sub.i.113.i.i.i.i) #4
  br label %for.cond.i.116.i.i.i.i

for.cond.i.116.i.i.i.i:                           ; preds = %if.end.i.126.i.i.i.i, %if.end.12.i.i.i.i
  %i.i.106.i.i.i.i.0 = phi i16 [ %sub.i.113.i.i.i.i, %if.end.12.i.i.i.i ], [ %inc.i.127.i.i.i.i, %if.end.i.126.i.i.i.i ]
  %borrow.i.111.i.i.i.i.0 = phi i16 [ 0, %if.end.12.i.i.i.i ], [ %borrow.i.111.i.i.i.i.1, %if.end.i.126.i.i.i.i ]
  %cmp.i.115.i.i.i.i = icmp slt i16 %i.i.106.i.i.i.i.0, 16
  br i1 %cmp.i.115.i.i.i.i, label %for.body.i.121.i.i.i.i, label %reduce_subtract.exit.i.i.i.i

for.body.i.121.i.i.i.i:                           ; preds = %for.cond.i.116.i.i.i.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.106.i.i.i.i.0
  %31 = load i16, i16* %arrayidx.i.117.i.i.i.i, align 2
  %arrayidx1.i.118.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.i.i.0
  %32 = load i16, i16* %arrayidx1.i.118.i.i.i.i, align 2
  %add.i.119.i.i.i.i = add i16 %32, %borrow.i.111.i.i.i.i.0
  %cmp2.i.120.i.i.i.i = icmp ult i16 %31, %add.i.119.i.i.i.i
  br i1 %cmp2.i.120.i.i.i.i, label %if.then.i.123.i.i.i.i, label %if.else.i.124.i.i.i.i

if.then.i.123.i.i.i.i:                            ; preds = %for.body.i.121.i.i.i.i
  %add3.i.122.i.i.i.i = add i16 %31, 256
  br label %if.end.i.126.i.i.i.i

if.else.i.124.i.i.i.i:                            ; preds = %for.body.i.121.i.i.i.i
  br label %if.end.i.126.i.i.i.i

if.end.i.126.i.i.i.i:                             ; preds = %if.else.i.124.i.i.i.i, %if.then.i.123.i.i.i.i
  %m.i.107.i.i.i.i.0 = phi i16 [ %add3.i.122.i.i.i.i, %if.then.i.123.i.i.i.i ], [ %31, %if.else.i.124.i.i.i.i ]
  %borrow.i.111.i.i.i.i.1 = phi i16 [ 1, %if.then.i.123.i.i.i.i ], [ 0, %if.else.i.124.i.i.i.i ]
  %sub4.i.i.i.i.i = sub i16 %m.i.107.i.i.i.i.0, %add.i.119.i.i.i.i
  %arrayidx5.i.125.i.i.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @out_block, i32 0, i32 0), i16 %i.i.106.i.i.i.i.0
  store i16 %sub4.i.i.i.i.i, i16* %arrayidx5.i.125.i.i.i.i, align 2
  %inc.i.127.i.i.i.i = add nsw i16 %i.i.106.i.i.i.i.0, 1
  br label %for.cond.i.116.i.i.i.i

reduce_subtract.exit.i.i.i.i:                     ; preds = %for.cond.i.116.i.i.i.i
  store i16 35, i16* @curtask, align 2
  %dec13.i.i.i.i = add i16 %d.i.i.i.i.1, -1
  br label %while.cond.i.i.i.i

while.end.i.i.i.i:                                ; preds = %while.cond.i.i.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit.i.i

mod_mult.exit.i.i:                                ; preds = %while.end.i.i.i.i, %if.then.5.i.i.i.i
  br label %if.end.i.i

if.end.i.i:                                       ; preds = %mod_mult.exit.i.i, %while.body.i.i
  store i16 3, i16* @curtask, align 2
  br label %for.cond.i.i.82.i.i

for.cond.i.i.82.i.i:                              ; preds = %for.end.i.i.107.i.i, %if.end.i.i
  %digit.i.i.73.i.i.0 = phi i16 [ 0, %if.end.i.i ], [ %inc14.i.i.106.i.i, %for.end.i.i.107.i.i ]
  %carry.i.i.77.i.i.0 = phi i16 [ 0, %if.end.i.i ], [ %add10.i.i.103.i.i, %for.end.i.i.107.i.i ]
  %cmp.i.i.81.i.i = icmp ult i16 %digit.i.i.73.i.i.0, 16
  br i1 %cmp.i.i.81.i.i, label %for.body.i.i.83.i.i, label %for.end.15.i.i.108.i.i

for.body.i.i.83.i.i:                              ; preds = %for.cond.i.i.82.i.i
  store i16 14, i16* @curtask, align 2
  br label %for.cond.1.i.i.85.i.i

for.cond.1.i.i.85.i.i:                            ; preds = %if.end.i.i.101.i.i, %for.body.i.i.83.i.i
  %i.i.i.72.i.i.0 = phi i16 [ 0, %for.body.i.i.83.i.i ], [ %inc.i.i.100.i.i, %if.end.i.i.101.i.i ]
  %p.i.i.74.i.i.0 = phi i16 [ %carry.i.i.77.i.i.0, %for.body.i.i.83.i.i ], [ %p.i.i.74.i.i.1, %if.end.i.i.101.i.i ]
  %c.i.i.75.i.i.0 = phi i16 [ 0, %for.body.i.i.83.i.i ], [ %c.i.i.75.i.i.1, %if.end.i.i.101.i.i ]
  %cmp2.i.i.84.i.i = icmp slt i16 %i.i.i.72.i.i.0, 8
  br i1 %cmp2.i.i.84.i.i, label %for.body.3.i.i.87.i.i, label %for.end.i.i.107.i.i

for.body.3.i.i.87.i.i:                            ; preds = %for.cond.1.i.i.85.i.i
  %cmp4.i.i.86.i.i = icmp ule i16 %i.i.i.72.i.i.0, %digit.i.i.73.i.i.0
  br i1 %cmp4.i.i.86.i.i, label %land.lhs.true.i.i.90.i.i, label %if.end.i.i.101.i.i

land.lhs.true.i.i.90.i.i:                         ; preds = %for.body.3.i.i.87.i.i
  %sub.i.i.88.i.i = sub i16 %digit.i.i.73.i.i.0, %i.i.i.72.i.i.0
  %cmp5.i.i.89.i.i = icmp ult i16 %sub.i.i.88.i.i, 8
  br i1 %cmp5.i.i.89.i.i, label %if.then.i.i.99.i.i, label %if.end.i.i.101.i.i

if.then.i.i.99.i.i:                               ; preds = %land.lhs.true.i.i.90.i.i
  %sub6.i.i.91.i.i = sub i16 %digit.i.i.73.i.i.0, %i.i.i.72.i.i.0
  %arrayidx.i.i.92.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub6.i.i.91.i.i
  %33 = load i16, i16* %arrayidx.i.i.92.i.i, align 2
  %arrayidx7.i.i.93.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.72.i.i.0
  %34 = load i16, i16* %arrayidx7.i.i.93.i.i, align 2
  %mul.i.i.94.i.i = mul i16 %33, %34
  %shr.i.i.95.i.i = lshr i16 %mul.i.i.94.i.i, 8
  %add.i.i.96.i.i = add i16 %c.i.i.75.i.i.0, %shr.i.i.95.i.i
  %and.i.i.97.i.i = and i16 %mul.i.i.94.i.i, 255
  %add8.i.i.98.i.i = add i16 %p.i.i.74.i.i.0, %and.i.i.97.i.i
  br label %if.end.i.i.101.i.i

if.end.i.i.101.i.i:                               ; preds = %if.then.i.i.99.i.i, %land.lhs.true.i.i.90.i.i, %for.body.3.i.i.87.i.i
  %p.i.i.74.i.i.1 = phi i16 [ %add8.i.i.98.i.i, %if.then.i.i.99.i.i ], [ %p.i.i.74.i.i.0, %land.lhs.true.i.i.90.i.i ], [ %p.i.i.74.i.i.0, %for.body.3.i.i.87.i.i ]
  %c.i.i.75.i.i.1 = phi i16 [ %add.i.i.96.i.i, %if.then.i.i.99.i.i ], [ %c.i.i.75.i.i.0, %land.lhs.true.i.i.90.i.i ], [ %c.i.i.75.i.i.0, %for.body.3.i.i.87.i.i ]
  %inc.i.i.100.i.i = add nsw i16 %i.i.i.72.i.i.0, 1
  br label %for.cond.1.i.i.85.i.i

for.end.i.i.107.i.i:                              ; preds = %for.cond.1.i.i.85.i.i
  %shr9.i.i.102.i.i = lshr i16 %p.i.i.74.i.i.0, 8
  %add10.i.i.103.i.i = add i16 %c.i.i.75.i.i.0, %shr9.i.i.102.i.i
  %and11.i.i.104.i.i = and i16 %p.i.i.74.i.i.0, 255
  %arrayidx12.i.i.105.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %digit.i.i.73.i.i.0
  store i16 %and11.i.i.104.i.i, i16* %arrayidx12.i.i.105.i.i, align 2
  %inc14.i.i.106.i.i = add i16 %digit.i.i.73.i.i.0, 1
  br label %for.cond.i.i.82.i.i

for.end.15.i.i.108.i.i:                           ; preds = %for.cond.i.i.82.i.i
  store i16 20, i16* @curtask, align 2
  br label %for.cond.16.i.i.110.i.i

for.cond.16.i.i.110.i.i:                          ; preds = %for.body.18.i.i.114.i.i, %for.end.15.i.i.108.i.i
  %i.i.i.72.i.i.1 = phi i16 [ 0, %for.end.15.i.i.108.i.i ], [ %inc22.i.i.113.i.i, %for.body.18.i.i.114.i.i ]
  %cmp17.i.i.109.i.i = icmp slt i16 %i.i.i.72.i.i.1, 16
  br i1 %cmp17.i.i.109.i.i, label %for.body.18.i.i.114.i.i, label %mult.exit.i.115.i.i

for.body.18.i.i.114.i.i:                          ; preds = %for.cond.16.i.i.110.i.i
  %arrayidx19.i.i.111.i.i = getelementptr inbounds [16 x i16], [16 x i16]* @product, i16 0, i16 %i.i.i.72.i.i.1
  %35 = load i16, i16* %arrayidx19.i.i.111.i.i, align 2
  %arrayidx20.i.i.112.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.72.i.i.1
  store i16 %35, i16* %arrayidx20.i.i.112.i.i, align 2
  %inc22.i.i.113.i.i = add nsw i16 %i.i.i.72.i.i.1, 1
  br label %for.cond.16.i.i.110.i.i

mult.exit.i.115.i.i:                              ; preds = %for.cond.16.i.i.110.i.i
  store i16 27, i16* @curtask, align 2
  store i16 4, i16* @curtask, align 2
  br label %do.body.i.i.120.i.i

do.body.i.i.120.i.i:                              ; preds = %land.end.i.i.123.i.i, %mult.exit.i.115.i.i
  %d.i.i.69.i.i.0 = phi i16 [ 16, %mult.exit.i.115.i.i ], [ %dec.i.i.116.i.i, %land.end.i.i.123.i.i ]
  %dec.i.i.116.i.i = add i16 %d.i.i.69.i.i.0, -1
  %arrayidx.i.1.i.117.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %dec.i.i.116.i.i
  %36 = load i16, i16* %arrayidx.i.1.i.117.i.i, align 2
  %call.i.i.118.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.15, i32 0, i32 0), i16 %dec.i.i.116.i.i, i16 %36) #4
  %cmp.i.2.i.119.i.i = icmp eq i16 %36, 0
  br i1 %cmp.i.2.i.119.i.i, label %land.rhs.i.i.122.i.i, label %land.end.i.i.123.i.i

land.rhs.i.i.122.i.i:                             ; preds = %do.body.i.i.120.i.i
  %cmp1.i.i.121.i.i = icmp ugt i16 %dec.i.i.116.i.i, 0
  br label %land.end.i.i.123.i.i

land.end.i.i.123.i.i:                             ; preds = %land.rhs.i.i.122.i.i, %do.body.i.i.120.i.i
  %37 = phi i1 [ false, %do.body.i.i.120.i.i ], [ %cmp1.i.i.121.i.i, %land.rhs.i.i.122.i.i ]
  br i1 %37, label %do.body.i.i.120.i.i, label %do.end.i.i.128.i.i

do.end.i.i.128.i.i:                               ; preds = %land.end.i.i.123.i.i
  %call2.i.i.124.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.16, i32 0, i32 0), i16 %dec.i.i.116.i.i) #4
  store i16 6, i16* @curtask, align 2
  %add.i.i.i.125.i.i = add i16 %dec.i.i.116.i.i, 1
  %sub.i.i.i.126.i.i = sub i16 %add.i.i.i.125.i.i, 8
  %call.i.i.i.127.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0), i16 %dec.i.i.116.i.i, i16 %sub.i.i.i.126.i.i) #4
  br label %for.cond.i.i.i.130.i.i

for.cond.i.i.i.130.i.i:                           ; preds = %if.end.i.i.i.141.i.i, %do.end.i.i.128.i.i
  %i.i.i.i.60.i.i.0 = phi i16 [ %dec.i.i.116.i.i, %do.end.i.i.128.i.i ], [ %dec.i.i.i.140.i.i, %if.end.i.i.i.141.i.i ]
  %cmp.i.i.i.129.i.i = icmp sge i16 %i.i.i.i.60.i.i.0, 0
  br i1 %cmp.i.i.i.129.i.i, label %for.body.i.i.i.135.i.i, label %reduce_normalizable.exit.i.i.146.i.i

for.body.i.i.i.135.i.i:                           ; preds = %for.cond.i.i.i.130.i.i
  %arrayidx.i.i.i.131.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.i.i.60.i.i.0
  %38 = load i16, i16* %arrayidx.i.i.i.131.i.i, align 2
  %sub1.i.i.i.132.i.i = sub i16 %i.i.i.i.60.i.i.0, %sub.i.i.i.126.i.i
  %arrayidx2.i.i.i.133.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub1.i.i.i.132.i.i
  %39 = load i16, i16* %arrayidx2.i.i.i.133.i.i, align 2
  %cmp3.i.i.i.134.i.i = icmp ugt i16 %38, %39
  br i1 %cmp3.i.i.i.134.i.i, label %if.then.i.i.i.136.i.i, label %if.else.i.i.i.138.i.i

if.then.i.i.i.136.i.i:                            ; preds = %for.body.i.i.i.135.i.i
  br label %reduce_normalizable.exit.i.i.146.i.i

if.else.i.i.i.138.i.i:                            ; preds = %for.body.i.i.i.135.i.i
  %cmp4.i.i.i.137.i.i = icmp ult i16 %38, %39
  br i1 %cmp4.i.i.i.137.i.i, label %if.then.5.i.i.i.139.i.i, label %if.end.i.i.i.141.i.i

if.then.5.i.i.i.139.i.i:                          ; preds = %if.else.i.i.i.138.i.i
  br label %reduce_normalizable.exit.i.i.146.i.i

if.end.i.i.i.141.i.i:                             ; preds = %if.else.i.i.i.138.i.i
  %dec.i.i.i.140.i.i = add nsw i16 %i.i.i.i.60.i.i.0, -1
  br label %for.cond.i.i.i.130.i.i

reduce_normalizable.exit.i.i.146.i.i:             ; preds = %if.then.5.i.i.i.139.i.i, %if.then.i.i.i.136.i.i, %for.cond.i.i.i.130.i.i
  %normalizable.i.i.i.64.i.i.0 = phi i8 [ 1, %if.then.i.i.i.136.i.i ], [ 0, %if.then.5.i.i.i.139.i.i ], [ 1, %for.cond.i.i.i.130.i.i ]
  %tobool.i.i.i.142.i.i = trunc i8 %normalizable.i.i.i.64.i.i.0 to i1
  %conv.i.i.i.143.i.i = zext i1 %tobool.i.i.i.142.i.i to i16
  %call7.i.i.i.144.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i32 0, i32 0), i16 %conv.i.i.i.143.i.i) #4
  store i16 30, i16* @curtask, align 2
  %tobool8.i.i.i.145.i.i = trunc i8 %normalizable.i.i.i.64.i.i.0 to i1
  br i1 %tobool8.i.i.i.145.i.i, label %if.then.i.3.i.149.i.i, label %if.else.i.i.168.i.i

if.then.i.3.i.149.i.i:                            ; preds = %reduce_normalizable.exit.i.i.146.i.i
  store i16 5, i16* @curtask, align 2
  %add.i.20.i.i.147.i.i = add i16 %dec.i.i.116.i.i, 1
  %sub.i.21.i.i.148.i.i = sub i16 %add.i.20.i.i.147.i.i, 8
  br label %for.cond.i.23.i.i.151.i.i

for.cond.i.23.i.i.151.i.i:                        ; preds = %if.end.i.30.i.i.165.i.i, %if.then.i.3.i.149.i.i
  %borrow.i.i.i.55.i.i.0 = phi i16 [ 0, %if.then.i.3.i.149.i.i ], [ %borrow.i.i.i.55.i.i.1, %if.end.i.30.i.i.165.i.i ]
  %i.i.16.i.i.50.i.i.0 = phi i16 [ 0, %if.then.i.3.i.149.i.i ], [ %inc.i.i.i.164.i.i, %if.end.i.30.i.i.165.i.i ]
  %cmp.i.22.i.i.150.i.i = icmp slt i16 %i.i.16.i.i.50.i.i.0, 8
  br i1 %cmp.i.22.i.i.150.i.i, label %for.body.i.27.i.i.157.i.i, label %reduce_normalize.exit.i.i.166.i.i

for.body.i.27.i.i.157.i.i:                        ; preds = %for.cond.i.23.i.i.151.i.i
  store i16 21, i16* @curtask, align 2
  %add1.i.i.i.152.i.i = add i16 %i.i.16.i.i.50.i.i.0, %sub.i.21.i.i.148.i.i
  %arrayidx.i.24.i.i.153.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %add1.i.i.i.152.i.i
  %40 = load i16, i16* %arrayidx.i.24.i.i.153.i.i, align 2
  %arrayidx2.i.25.i.i.154.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %i.i.16.i.i.50.i.i.0
  %41 = load i16, i16* %arrayidx2.i.25.i.i.154.i.i, align 2
  %add3.i.i.i.155.i.i = add i16 %41, %borrow.i.i.i.55.i.i.0
  %cmp4.i.26.i.i.156.i.i = icmp ult i16 %40, %add3.i.i.i.155.i.i
  br i1 %cmp4.i.26.i.i.156.i.i, label %if.then.i.28.i.i.159.i.i, label %if.else.i.29.i.i.160.i.i

if.then.i.28.i.i.159.i.i:                         ; preds = %for.body.i.27.i.i.157.i.i
  %add5.i.i.i.158.i.i = add i16 %40, 256
  br label %if.end.i.30.i.i.165.i.i

if.else.i.29.i.i.160.i.i:                         ; preds = %for.body.i.27.i.i.157.i.i
  br label %if.end.i.30.i.i.165.i.i

if.end.i.30.i.i.165.i.i:                          ; preds = %if.else.i.29.i.i.160.i.i, %if.then.i.28.i.i.159.i.i
  %borrow.i.i.i.55.i.i.1 = phi i16 [ 1, %if.then.i.28.i.i.159.i.i ], [ 0, %if.else.i.29.i.i.160.i.i ]
  %m_d.i.17.i.i.53.i.i.0 = phi i16 [ %add5.i.i.i.158.i.i, %if.then.i.28.i.i.159.i.i ], [ %40, %if.else.i.29.i.i.160.i.i ]
  %sub6.i.i.i.161.i.i = sub i16 %m_d.i.17.i.i.53.i.i.0, %add3.i.i.i.155.i.i
  %add7.i.i.i.162.i.i = add i16 %i.i.16.i.i.50.i.i.0, %sub.i.21.i.i.148.i.i
  %arrayidx8.i.i.i.163.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %add7.i.i.i.162.i.i
  store i16 %sub6.i.i.i.161.i.i, i16* %arrayidx8.i.i.i.163.i.i, align 2
  %inc.i.i.i.164.i.i = add nsw i16 %i.i.16.i.i.50.i.i.0, 1
  br label %for.cond.i.23.i.i.151.i.i

reduce_normalize.exit.i.i.166.i.i:                ; preds = %for.cond.i.23.i.i.151.i.i
  store i16 29, i16* @curtask, align 2
  br label %if.end.7.i.i.172.i.i

if.else.i.i.168.i.i:                              ; preds = %reduce_normalizable.exit.i.i.146.i.i
  %cmp4.i.4.i.167.i.i = icmp eq i16 %dec.i.i.116.i.i, 7
  br i1 %cmp4.i.4.i.167.i.i, label %if.then.5.i.i.170.i.i, label %if.end.i.5.i.171.i.i

if.then.5.i.i.170.i.i:                            ; preds = %if.else.i.i.168.i.i
  %call6.i.i.169.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.17, i32 0, i32 0)) #4
  br label %mod_mult.exit312.i.i

if.end.i.5.i.171.i.i:                             ; preds = %if.else.i.i.168.i.i
  br label %if.end.7.i.i.172.i.i

if.end.7.i.i.172.i.i:                             ; preds = %if.end.i.5.i.171.i.i, %reduce_normalize.exit.i.i.166.i.i
  br label %while.cond.i.i.174.i.i

while.cond.i.i.174.i.i:                           ; preds = %reduce_subtract.exit.i.i.310.i.i, %if.end.7.i.i.172.i.i
  %d.i.i.69.i.i.1 = phi i16 [ %dec.i.i.116.i.i, %if.end.7.i.i.172.i.i ], [ %dec13.i.i.309.i.i, %reduce_subtract.exit.i.i.310.i.i ]
  %cmp8.i.i.173.i.i = icmp uge i16 %d.i.i.69.i.i.1, 8
  br i1 %cmp8.i.i.173.i.i, label %while.body.i.i.192.i.i, label %while.end.i.i.311.i.i

while.body.i.i.192.i.i:                           ; preds = %while.cond.i.i.174.i.i
  store i16 16, i16* @curtask, align 2
  %arrayidx.i.35.i.i.175.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 7
  %42 = load i16, i16* %arrayidx.i.35.i.i.175.i.i, align 2
  %shl.i.i.i.176.i.i = shl i16 %42, 8
  %arrayidx1.i.i.i.177.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 6
  %43 = load i16, i16* %arrayidx1.i.i.i.177.i.i, align 2
  %add.i.36.i.i.178.i.i = add i16 %shl.i.i.i.176.i.i, %43
  %arrayidx2.i.37.i.i.179.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 7
  %44 = load i16, i16* %arrayidx2.i.37.i.i.179.i.i, align 2
  %arrayidx3.i.i.i.180.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %d.i.i.69.i.i.1
  %45 = load i16, i16* %arrayidx3.i.i.i.180.i.i, align 2
  %arrayidx4.i.i.i.181.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  store i16 %45, i16* %arrayidx4.i.i.i.181.i.i, align 2
  %sub.i.38.i.i.182.i.i = sub i16 %d.i.i.69.i.i.1, 1
  %arrayidx5.i.i.i.183.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub.i.38.i.i.182.i.i
  %46 = load i16, i16* %arrayidx5.i.i.i.183.i.i, align 2
  %arrayidx6.i.i.i.184.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  store i16 %46, i16* %arrayidx6.i.i.i.184.i.i, align 2
  %sub7.i.i.i.185.i.i = sub i16 %d.i.i.69.i.i.1, 2
  %arrayidx8.i.39.i.i.186.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %sub7.i.i.i.185.i.i
  %47 = load i16, i16* %arrayidx8.i.39.i.i.186.i.i, align 2
  %arrayidx9.i.i.i.187.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  store i16 %47, i16* %arrayidx9.i.i.i.187.i.i, align 2
  %arrayidx10.i.i.i.188.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 2
  %48 = load i16, i16* %arrayidx10.i.i.i.188.i.i, align 2
  %call.i.40.i.i.189.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i32 0, i32 0), i16 %44, i16 %48) #4
  store i16 17, i16* @curtask, align 2
  %arrayidx11.i.i.i.190.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %49 = load i16, i16* %arrayidx11.i.i.i.190.i.i, align 2
  %cmp.i.41.i.i.191.i.i = icmp eq i16 %49, %44
  br i1 %cmp.i.41.i.i.191.i.i, label %if.then.i.42.i.i.193.i.i, label %if.else.i.43.i.i.200.i.i

if.then.i.42.i.i.193.i.i:                         ; preds = %while.body.i.i.192.i.i
  br label %if.end.i.46.i.i.222.i.i

if.else.i.43.i.i.200.i.i:                         ; preds = %while.body.i.i.192.i.i
  %arrayidx12.i.i.i.194.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %50 = load i16, i16* %arrayidx12.i.i.i.194.i.i, align 2
  %shl13.i.i.i.195.i.i = shl i16 %50, 8
  %arrayidx14.i.i.i.196.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %51 = load i16, i16* %arrayidx14.i.i.i.196.i.i, align 2
  %add15.i.i.i.197.i.i = add i16 %shl13.i.i.i.195.i.i, %51
  %div.i.i.i.198.i.i = udiv i16 %add15.i.i.i.197.i.i, %44
  %call16.i.i.i.199.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.8, i32 0, i32 0), i16 %add15.i.i.i.197.i.i, i16 %div.i.i.i.198.i.i) #4
  br label %if.end.i.46.i.i.222.i.i

if.end.i.46.i.i.222.i.i:                          ; preds = %if.else.i.43.i.i.200.i.i, %if.then.i.42.i.i.193.i.i
  %q.i.i.i.41.i.i.0 = phi i16 [ 255, %if.then.i.42.i.i.193.i.i ], [ %div.i.i.i.198.i.i, %if.else.i.43.i.i.200.i.i ]
  store i16 18, i16* @curtask, align 2
  %arrayidx17.i.i.i.201.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %52 = load i16, i16* %arrayidx17.i.i.i.201.i.i, align 2
  %conv.i.44.i.i.202.i.i = zext i16 %52 to i32
  %shl18.i.i.i.203.i.i = shl i32 %conv.i.44.i.i.202.i.i, 16
  %arrayidx19.i.i.i.204.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %53 = load i16, i16* %arrayidx19.i.i.i.204.i.i, align 2
  %shl20.i.i.i.205.i.i = shl i16 %53, 8
  %conv21.i.i.i.206.i.i = zext i16 %shl20.i.i.i.205.i.i to i32
  %add22.i.i.i.207.i.i = add i32 %shl18.i.i.i.203.i.i, %conv21.i.i.i.206.i.i
  %arrayidx23.i.i.i.208.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %54 = load i16, i16* %arrayidx23.i.i.i.208.i.i, align 2
  %conv24.i.i.i.209.i.i = zext i16 %54 to i32
  %add25.i.i.i.210.i.i = add i32 %add22.i.i.i.207.i.i, %conv24.i.i.i.209.i.i
  %arrayidx26.i.i.i.211.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 2
  %55 = load i16, i16* %arrayidx26.i.i.i.211.i.i, align 2
  %arrayidx27.i.i.i.212.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 1
  %56 = load i16, i16* %arrayidx27.i.i.i.212.i.i, align 2
  %arrayidx28.i.i.i.213.i.i = getelementptr inbounds [3 x i16], [3 x i16]* %m_d.i.34.i.i.i.i, i16 0, i16 0
  %57 = load i16, i16* %arrayidx28.i.i.i.213.i.i, align 2
  %shr.i.i.i.214.i.i = lshr i32 %add25.i.i.i.210.i.i, 16
  %and.i.i.i.215.i.i = and i32 %shr.i.i.i.214.i.i, 65535
  %conv29.i.i.i.216.i.i = trunc i32 %and.i.i.i.215.i.i to i16
  %and30.i.i.i.217.i.i = and i32 %add25.i.i.i.210.i.i, 65535
  %conv31.i.i.i.218.i.i = trunc i32 %and30.i.i.i.217.i.i to i16
  %call32.i.i.i.219.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.9, i32 0, i32 0), i16 %55, i16 %56, i16 %57, i16 %conv29.i.i.i.216.i.i, i16 %conv31.i.i.i.218.i.i) #4
  %call33.i.i.i.220.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.10, i32 0, i32 0), i16 %q.i.i.i.41.i.i.0) #4
  %inc.i.45.i.i.221.i.i = add i16 %q.i.i.i.41.i.i.0, 1
  br label %do.body.i.i.i.232.i.i

do.body.i.i.i.232.i.i:                            ; preds = %do.body.i.i.i.232.i.i, %if.end.i.46.i.i.222.i.i
  %q.i.i.i.41.i.i.1 = phi i16 [ %inc.i.45.i.i.221.i.i, %if.end.i.46.i.i.222.i.i ], [ %dec.i.47.i.i.223.i.i, %do.body.i.i.i.232.i.i ]
  store i16 19, i16* @curtask, align 2
  %dec.i.47.i.i.223.i.i = add i16 %q.i.i.i.41.i.i.1, -1
  %call34.i.i.i.224.i.i = call i32 @mult16(i16 zeroext %add.i.36.i.i.178.i.i, i16 zeroext %dec.i.47.i.i.223.i.i) #4
  %shr35.i.i.i.225.i.i = lshr i32 %call34.i.i.i.224.i.i, 16
  %and36.i.i.i.226.i.i = and i32 %shr35.i.i.i.225.i.i, 65535
  %conv37.i.i.i.227.i.i = trunc i32 %and36.i.i.i.226.i.i to i16
  %and38.i.i.i.228.i.i = and i32 %call34.i.i.i.224.i.i, 65535
  %conv39.i.i.i.229.i.i = trunc i32 %and38.i.i.i.228.i.i to i16
  %call40.i.i.i.230.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.11, i32 0, i32 0), i16 %dec.i.47.i.i.223.i.i, i16 %add.i.36.i.i.178.i.i, i16 %conv37.i.i.i.227.i.i, i16 %conv39.i.i.i.229.i.i) #4
  %cmp41.i.i.i.231.i.i = icmp ugt i32 %call34.i.i.i.224.i.i, %add25.i.i.i.210.i.i
  br i1 %cmp41.i.i.i.231.i.i, label %do.body.i.i.i.232.i.i, label %reduce_quotient.exit.i.i.236.i.i

reduce_quotient.exit.i.i.236.i.i:                 ; preds = %do.body.i.i.i.232.i.i
  %call43.i.i.i.233.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.12, i32 0, i32 0), i16 %dec.i.47.i.i.223.i.i) #4
  store i16 32, i16* @curtask, align 2
  store i16 9, i16* @curtask, align 2
  %sub.i.52.i.i.234.i.i = sub i16 %d.i.i.69.i.i.1, 8
  %call.i.53.i.i.235.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i16 %sub.i.52.i.i.234.i.i) #4
  br label %for.cond.i.55.i.i.238.i.i

for.cond.i.55.i.i.238.i.i:                        ; preds = %for.body.i.57.i.i.241.i.i, %reduce_quotient.exit.i.i.236.i.i
  %i.i.50.i.i.31.i.i.0 = phi i16 [ 0, %reduce_quotient.exit.i.i.236.i.i ], [ %inc.i.58.i.i.240.i.i, %for.body.i.57.i.i.241.i.i ]
  %cmp.i.54.i.i.237.i.i = icmp ult i16 %i.i.50.i.i.31.i.i.0, %sub.i.52.i.i.234.i.i
  br i1 %cmp.i.54.i.i.237.i.i, label %for.body.i.57.i.i.241.i.i, label %for.end.i.i.i.242.i.i

for.body.i.57.i.i.241.i.i:                        ; preds = %for.cond.i.55.i.i.238.i.i
  %arrayidx.i.56.i.i.239.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.i.i.0
  store i16 0, i16* %arrayidx.i.56.i.i.239.i.i, align 2
  %inc.i.58.i.i.240.i.i = add nsw i16 %i.i.50.i.i.31.i.i.0, 1
  br label %for.cond.i.55.i.i.238.i.i

for.end.i.i.i.242.i.i:                            ; preds = %for.cond.i.55.i.i.238.i.i
  br label %for.cond.1.i.i.i.244.i.i

for.cond.1.i.i.i.244.i.i:                         ; preds = %if.end.i.68.i.i.258.i.i, %for.end.i.i.i.242.i.i
  %c.i.i.i.33.i.i.0 = phi i16 [ 0, %for.end.i.i.i.242.i.i ], [ %shr.i.65.i.i.254.i.i, %if.end.i.68.i.i.258.i.i ]
  %i.i.50.i.i.31.i.i.1 = phi i16 [ %sub.i.52.i.i.234.i.i, %for.end.i.i.i.242.i.i ], [ %inc10.i.i.i.257.i.i, %if.end.i.68.i.i.258.i.i ]
  %cmp2.i.i.i.243.i.i = icmp slt i16 %i.i.50.i.i.31.i.i.1, 16
  br i1 %cmp2.i.i.i.243.i.i, label %for.body.3.i.i.i.247.i.i, label %reduce_multiply.exit.i.i.259.i.i

for.body.3.i.i.i.247.i.i:                         ; preds = %for.cond.1.i.i.i.244.i.i
  store i16 24, i16* @curtask, align 2
  %add.i.59.i.i.245.i.i = add i16 %sub.i.52.i.i.234.i.i, 8
  %cmp4.i.60.i.i.246.i.i = icmp ult i16 %i.i.50.i.i.31.i.i.1, %add.i.59.i.i.245.i.i
  br i1 %cmp4.i.60.i.i.246.i.i, label %if.then.i.63.i.i.252.i.i, label %if.else.i.64.i.i.253.i.i

if.then.i.63.i.i.252.i.i:                         ; preds = %for.body.3.i.i.i.247.i.i
  %sub5.i.i.i.248.i.i = sub i16 %i.i.50.i.i.31.i.i.1, %sub.i.52.i.i.234.i.i
  %arrayidx6.i.61.i.i.249.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub5.i.i.i.248.i.i
  %58 = load i16, i16* %arrayidx6.i.61.i.i.249.i.i, align 2
  %mul.i.i.i.250.i.i = mul i16 %dec.i.47.i.i.223.i.i, %58
  %add7.i.62.i.i.251.i.i = add i16 %c.i.i.i.33.i.i.0, %mul.i.i.i.250.i.i
  br label %if.end.i.68.i.i.258.i.i

if.else.i.64.i.i.253.i.i:                         ; preds = %for.body.3.i.i.i.247.i.i
  br label %if.end.i.68.i.i.258.i.i

if.end.i.68.i.i.258.i.i:                          ; preds = %if.else.i.64.i.i.253.i.i, %if.then.i.63.i.i.252.i.i
  %p.i.i.i.34.i.i.0 = phi i16 [ %add7.i.62.i.i.251.i.i, %if.then.i.63.i.i.252.i.i ], [ %c.i.i.i.33.i.i.0, %if.else.i.64.i.i.253.i.i ]
  %shr.i.65.i.i.254.i.i = lshr i16 %p.i.i.i.34.i.i.0, 8
  %and.i.66.i.i.255.i.i = and i16 %p.i.i.i.34.i.i.0, 255
  %arrayidx8.i.67.i.i.256.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.50.i.i.31.i.i.1
  store i16 %and.i.66.i.i.255.i.i, i16* %arrayidx8.i.67.i.i.256.i.i, align 2
  %inc10.i.i.i.257.i.i = add nsw i16 %i.i.50.i.i.31.i.i.1, 1
  br label %for.cond.1.i.i.i.244.i.i

reduce_multiply.exit.i.i.259.i.i:                 ; preds = %for.cond.1.i.i.i.244.i.i
  store i16 33, i16* @curtask, align 2
  store i16 7, i16* @curtask, align 2
  br label %for.cond.i.71.i.i.261.i.i

for.cond.i.71.i.i.261.i.i:                        ; preds = %if.end.i.76.i.i.269.i.i, %reduce_multiply.exit.i.i.259.i.i
  %i.i.69.i.i.25.i.i.0 = phi i16 [ 15, %reduce_multiply.exit.i.i.259.i.i ], [ %dec.i.77.i.i.268.i.i, %if.end.i.76.i.i.269.i.i ]
  %cmp.i.70.i.i.260.i.i = icmp sge i16 %i.i.69.i.i.25.i.i.0, 0
  br i1 %cmp.i.70.i.i.260.i.i, label %for.body.i.72.i.i.263.i.i, label %reduce_compare.exit.i.i.271.i.i

for.body.i.72.i.i.263.i.i:                        ; preds = %for.cond.i.71.i.i.261.i.i
  %cmp1.i.i.i.262.i.i = icmp ugt i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp1.i.i.i.262.i.i, label %if.then.i.73.i.i.264.i.i, label %if.else.i.75.i.i.266.i.i

if.then.i.73.i.i.264.i.i:                         ; preds = %for.body.i.72.i.i.263.i.i
  br label %reduce_compare.exit.i.i.271.i.i

if.else.i.75.i.i.266.i.i:                         ; preds = %for.body.i.72.i.i.263.i.i
  %cmp2.i.74.i.i.265.i.i = icmp ult i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0)
  br i1 %cmp2.i.74.i.i.265.i.i, label %if.then.3.i.i.i.267.i.i, label %if.end.i.76.i.i.269.i.i

if.then.3.i.i.i.267.i.i:                          ; preds = %if.else.i.75.i.i.266.i.i
  br label %reduce_compare.exit.i.i.271.i.i

if.end.i.76.i.i.269.i.i:                          ; preds = %if.else.i.75.i.i.266.i.i
  %dec.i.77.i.i.268.i.i = add nsw i16 %i.i.69.i.i.25.i.i.0, -1
  br label %for.cond.i.71.i.i.261.i.i

reduce_compare.exit.i.i.271.i.i:                  ; preds = %if.then.3.i.i.i.267.i.i, %if.then.i.73.i.i.264.i.i, %for.cond.i.71.i.i.261.i.i
  %relation.i.i.i.26.i.i.0 = phi i16 [ 1, %if.then.i.73.i.i.264.i.i ], [ -1, %if.then.3.i.i.i.267.i.i ], [ 0, %for.cond.i.71.i.i.261.i.i ]
  store i16 31, i16* @curtask, align 2
  %cmp10.i.i.270.i.i = icmp slt i16 %relation.i.i.i.26.i.i.0, 0
  br i1 %cmp10.i.i.270.i.i, label %if.then.11.i.i.273.i.i, label %if.end.12.i.i.294.i.i

if.then.11.i.i.273.i.i:                           ; preds = %reduce_compare.exit.i.i.271.i.i
  store i16 10, i16* @curtask, align 2
  %sub.i.85.i.i.272.i.i = sub i16 %d.i.i.69.i.i.1, 8
  br label %for.cond.i.87.i.i.275.i.i

for.cond.i.87.i.i.275.i.i:                        ; preds = %if.end.i.100.i.i.290.i.i, %if.then.11.i.i.273.i.i
  %c.i.84.i.i.19.i.i.0 = phi i16 [ 0, %if.then.11.i.i.273.i.i ], [ %shr.i.97.i.i.286.i.i, %if.end.i.100.i.i.290.i.i ]
  %i.i.82.i.i.16.i.i.0 = phi i16 [ %sub.i.85.i.i.272.i.i, %if.then.11.i.i.273.i.i ], [ %inc.i.101.i.i.289.i.i, %if.end.i.100.i.i.290.i.i ]
  %cmp.i.86.i.i.274.i.i = icmp slt i16 %i.i.82.i.i.16.i.i.0, 16
  br i1 %cmp.i.86.i.i.274.i.i, label %for.body.i.92.i.i.280.i.i, label %reduce_add.exit.i.i.291.i.i

for.body.i.92.i.i.280.i.i:                        ; preds = %for.cond.i.87.i.i.275.i.i
  store i16 22, i16* @curtask, align 2
  %arrayidx.i.88.i.i.276.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.82.i.i.16.i.i.0
  %59 = load i16, i16* %arrayidx.i.88.i.i.276.i.i, align 2
  %sub1.i.89.i.i.277.i.i = sub i16 %i.i.82.i.i.16.i.i.0, %sub.i.85.i.i.272.i.i
  %add.i.90.i.i.278.i.i = add i16 %sub.i.85.i.i.272.i.i, 8
  %cmp2.i.91.i.i.279.i.i = icmp ult i16 %i.i.82.i.i.16.i.i.0, %add.i.90.i.i.278.i.i
  br i1 %cmp2.i.91.i.i.279.i.i, label %if.then.i.94.i.i.282.i.i, label %if.else.i.95.i.i.283.i.i

if.then.i.94.i.i.282.i.i:                         ; preds = %for.body.i.92.i.i.280.i.i
  %arrayidx3.i.93.i.i.281.i.i = getelementptr inbounds i16, i16* %arraydecay.i, i16 %sub1.i.89.i.i.277.i.i
  %60 = load i16, i16* %arrayidx3.i.93.i.i.281.i.i, align 2
  br label %if.end.i.100.i.i.290.i.i

if.else.i.95.i.i.283.i.i:                         ; preds = %for.body.i.92.i.i.280.i.i
  br label %if.end.i.100.i.i.290.i.i

if.end.i.100.i.i.290.i.i:                         ; preds = %if.else.i.95.i.i.283.i.i, %if.then.i.94.i.i.282.i.i
  %n.i.i.i.22.i.i.0 = phi i16 [ %60, %if.then.i.94.i.i.282.i.i ], [ 0, %if.else.i.95.i.i.283.i.i ]
  %add4.i.i.i.284.i.i = add i16 %c.i.84.i.i.19.i.i.0, %59
  %add5.i.96.i.i.285.i.i = add i16 %add4.i.i.i.284.i.i, %n.i.i.i.22.i.i.0
  %shr.i.97.i.i.286.i.i = lshr i16 %add5.i.96.i.i.285.i.i, 8
  %and.i.98.i.i.287.i.i = and i16 %add5.i.96.i.i.285.i.i, 255
  %arrayidx6.i.99.i.i.288.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.82.i.i.16.i.i.0
  store i16 %and.i.98.i.i.287.i.i, i16* %arrayidx6.i.99.i.i.288.i.i, align 2
  %inc.i.101.i.i.289.i.i = add nsw i16 %i.i.82.i.i.16.i.i.0, 1
  br label %for.cond.i.87.i.i.275.i.i

reduce_add.exit.i.i.291.i.i:                      ; preds = %for.cond.i.87.i.i.275.i.i
  store i16 34, i16* @curtask, align 2
  br label %if.end.12.i.i.294.i.i

if.end.12.i.i.294.i.i:                            ; preds = %reduce_add.exit.i.i.291.i.i, %reduce_compare.exit.i.i.271.i.i
  store i16 11, i16* @curtask, align 2
  %sub.i.113.i.i.292.i.i = sub i16 %d.i.i.69.i.i.1, 8
  %call.i.114.i.i.293.i.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.14, i32 0, i32 0), i16 %d.i.i.69.i.i.1, i16 %sub.i.113.i.i.292.i.i) #4
  br label %for.cond.i.116.i.i.296.i.i

for.cond.i.116.i.i.296.i.i:                       ; preds = %if.end.i.126.i.i.308.i.i, %if.end.12.i.i.294.i.i
  %borrow.i.111.i.i.11.i.i.0 = phi i16 [ 0, %if.end.12.i.i.294.i.i ], [ %borrow.i.111.i.i.11.i.i.1, %if.end.i.126.i.i.308.i.i ]
  %i.i.106.i.i.6.i.i.0 = phi i16 [ %sub.i.113.i.i.292.i.i, %if.end.12.i.i.294.i.i ], [ %inc.i.127.i.i.307.i.i, %if.end.i.126.i.i.308.i.i ]
  %cmp.i.115.i.i.295.i.i = icmp slt i16 %i.i.106.i.i.6.i.i.0, 16
  br i1 %cmp.i.115.i.i.295.i.i, label %for.body.i.121.i.i.301.i.i, label %reduce_subtract.exit.i.i.310.i.i

for.body.i.121.i.i.301.i.i:                       ; preds = %for.cond.i.116.i.i.296.i.i
  store i16 23, i16* @curtask, align 2
  %arrayidx.i.117.i.i.297.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.106.i.i.6.i.i.0
  %61 = load i16, i16* %arrayidx.i.117.i.i.297.i.i, align 2
  %arrayidx1.i.118.i.i.298.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @qxn, i32 0, i32 0), i16 %i.i.106.i.i.6.i.i.0
  %62 = load i16, i16* %arrayidx1.i.118.i.i.298.i.i, align 2
  %add.i.119.i.i.299.i.i = add i16 %62, %borrow.i.111.i.i.11.i.i.0
  %cmp2.i.120.i.i.300.i.i = icmp ult i16 %61, %add.i.119.i.i.299.i.i
  br i1 %cmp2.i.120.i.i.300.i.i, label %if.then.i.123.i.i.303.i.i, label %if.else.i.124.i.i.304.i.i

if.then.i.123.i.i.303.i.i:                        ; preds = %for.body.i.121.i.i.301.i.i
  %add3.i.122.i.i.302.i.i = add i16 %61, 256
  br label %if.end.i.126.i.i.308.i.i

if.else.i.124.i.i.304.i.i:                        ; preds = %for.body.i.121.i.i.301.i.i
  br label %if.end.i.126.i.i.308.i.i

if.end.i.126.i.i.308.i.i:                         ; preds = %if.else.i.124.i.i.304.i.i, %if.then.i.123.i.i.303.i.i
  %borrow.i.111.i.i.11.i.i.1 = phi i16 [ 1, %if.then.i.123.i.i.303.i.i ], [ 0, %if.else.i.124.i.i.304.i.i ]
  %m.i.107.i.i.7.i.i.0 = phi i16 [ %add3.i.122.i.i.302.i.i, %if.then.i.123.i.i.303.i.i ], [ %61, %if.else.i.124.i.i.304.i.i ]
  %sub4.i.i.i.305.i.i = sub i16 %m.i.107.i.i.7.i.i.0, %add.i.119.i.i.299.i.i
  %arrayidx5.i.125.i.i.306.i.i = getelementptr inbounds i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @in_block, i32 0, i32 0), i16 %i.i.106.i.i.6.i.i.0
  store i16 %sub4.i.i.i.305.i.i, i16* %arrayidx5.i.125.i.i.306.i.i, align 2
  %inc.i.127.i.i.307.i.i = add nsw i16 %i.i.106.i.i.6.i.i.0, 1
  br label %for.cond.i.116.i.i.296.i.i

reduce_subtract.exit.i.i.310.i.i:                 ; preds = %for.cond.i.116.i.i.296.i.i
  store i16 35, i16* @curtask, align 2
  %dec13.i.i.309.i.i = add i16 %d.i.i.69.i.i.1, -1
  br label %while.cond.i.i.174.i.i

while.end.i.i.311.i.i:                            ; preds = %while.cond.i.i.174.i.i
  store i16 28, i16* @curtask, align 2
  br label %mod_mult.exit312.i.i

mod_mult.exit312.i.i:                             ; preds = %while.end.i.i.311.i.i, %if.then.5.i.i.170.i.i
  %shr.i.i = lshr i16 %e.addr.i.i.0, 1
  br label %while.cond.i.i

mod_exp.exit.i:                                   ; preds = %while.cond.i.i
  store i16 26, i16* @curtask, align 2
  br label %for.cond.16.i

for.cond.16.i:                                    ; preds = %for.body.19.i, %mod_exp.exit.i
  %i.i.2 = phi i16 [ 0, %mod_exp.exit.i ], [ %inc25.i, %for.body.19.i ]
  %cmp17.i = icmp slt i16 %i.i.2, 8
  br i1 %cmp17.i, label %for.body.19.i, label %for.end.26.i

for.body.19.i:                                    ; preds = %for.cond.16.i
  %arrayidx20.i = getelementptr inbounds [16 x i16], [16 x i16]* @out_block, i16 0, i16 %i.i.2
  %63 = load i16, i16* %arrayidx20.i, align 2
  %conv21.i = trunc i16 %63 to i8
  %add22.i = add i16 %out_block_offset.i.0, %i.i.2
  %arrayidx23.i = getelementptr inbounds i8, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @CYPHERTEXT, i32 0, i32 0), i16 %add22.i
  store i8 %conv21.i, i8* %arrayidx23.i, align 1
  %inc25.i = add nsw i16 %i.i.2, 1
  br label %for.cond.16.i

for.end.26.i:                                     ; preds = %for.cond.16.i
  %add27.i = add i16 %in_block_offset.i.0, 7
  %add28.i = add i16 %out_block_offset.i.0, 8
  br label %while.cond.i

encrypt.exit:                                     ; preds = %while.cond.i
  store i16 %out_block_offset.i.0, i16* @CYPHERTEXT_LEN, align 2
  store i16 25, i16* @curtask, align 2
  store i16 12, i16* @curtask, align 2
  %64 = load i16, i16* @overflow, align 2
  %65 = load volatile i16, i16* @"\010x03D0", align 2
  %call = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.21, i32 0, i32 0), i16 %64, i16 %65)
  %call1 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.22, i32 0, i32 0))
  %66 = load i16, i16* @CYPHERTEXT_LEN, align 2
  br label %for.cond.i.5

for.cond.i.5:                                     ; preds = %for.end.36.i, %encrypt.exit
  %i.i.3.0 = phi i16 [ 0, %encrypt.exit ], [ %add39.i, %for.end.36.i ]
  %cmp.i.4 = icmp ult i16 %i.i.3.0, %66
  br i1 %cmp.i.4, label %for.body.i.6, label %print_hex_ascii.exit

for.body.i.6:                                     ; preds = %for.cond.i.5
  br label %for.cond.1.i

for.cond.1.i:                                     ; preds = %for.body.4.i, %for.body.i.6
  %j.i.0 = phi i16 [ 0, %for.body.i.6 ], [ %inc.i.12, %for.body.4.i ]
  %cmp2.i.7 = icmp slt i16 %j.i.0, 8
  br i1 %cmp2.i.7, label %land.rhs.i, label %land.end.i

land.rhs.i:                                       ; preds = %for.cond.1.i
  %add.i.8 = add nsw i16 %i.i.3.0, %j.i.0
  %cmp3.i = icmp ult i16 %add.i.8, %66
  br label %land.end.i

land.end.i:                                       ; preds = %land.rhs.i, %for.cond.1.i
  %67 = phi i1 [ false, %for.cond.1.i ], [ %cmp3.i, %land.rhs.i ]
  br i1 %67, label %for.body.4.i, label %for.end.i.13

for.body.4.i:                                     ; preds = %land.end.i
  %add5.i = add nsw i16 %i.i.3.0, %j.i.0
  %arrayidx.i.9 = getelementptr inbounds i8, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @CYPHERTEXT, i32 0, i32 0), i16 %add5.i
  %68 = load i8, i8* %arrayidx.i.9, align 1
  %conv.i.10 = zext i8 %68 to i16
  %call.i.11 = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i16 %conv.i.10) #4
  %inc.i.12 = add nsw i16 %j.i.0, 1
  br label %for.cond.1.i

for.end.i.13:                                     ; preds = %land.end.i
  br label %for.cond.6.i

for.cond.6.i:                                     ; preds = %for.body.9.i, %for.end.i.13
  %j.i.1 = phi i16 [ %j.i.0, %for.end.i.13 ], [ %inc12.i, %for.body.9.i ]
  %cmp7.i = icmp slt i16 %j.i.1, 8
  br i1 %cmp7.i, label %for.body.9.i, label %for.end.13.i

for.body.9.i:                                     ; preds = %for.cond.6.i
  %call10.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0)) #4
  %inc12.i = add nsw i16 %j.i.1, 1
  br label %for.cond.6.i

for.end.13.i:                                     ; preds = %for.cond.6.i
  %call14.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0)) #4
  br label %for.cond.15.i

for.cond.15.i:                                    ; preds = %if.end.i, %for.end.13.i
  %j.i.2 = phi i16 [ 0, %for.end.13.i ], [ %inc35.i, %if.end.i ]
  %cmp16.i = icmp slt i16 %j.i.2, 8
  br i1 %cmp16.i, label %land.rhs.18.i, label %land.end.22.i

land.rhs.18.i:                                    ; preds = %for.cond.15.i
  %add19.i = add nsw i16 %i.i.3.0, %j.i.2
  %cmp20.i = icmp ult i16 %add19.i, %66
  br label %land.end.22.i

land.end.22.i:                                    ; preds = %land.rhs.18.i, %for.cond.15.i
  %69 = phi i1 [ false, %for.cond.15.i ], [ %cmp20.i, %land.rhs.18.i ]
  br i1 %69, label %for.body.23.i, label %for.end.36.i

for.body.23.i:                                    ; preds = %land.end.22.i
  %add24.i = add nsw i16 %i.i.3.0, %j.i.2
  %arrayidx25.i = getelementptr inbounds i8, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @CYPHERTEXT, i32 0, i32 0), i16 %add24.i
  %70 = load i8, i8* %arrayidx25.i, align 1
  %conv26.i = sext i8 %70 to i16
  %cmp27.i = icmp sle i16 32, %conv26.i
  br i1 %cmp27.i, label %land.lhs.true.i, label %if.then.i

land.lhs.true.i:                                  ; preds = %for.body.23.i
  %conv29.i = sext i8 %70 to i16
  br label %if.end.i

if.then.i:                                        ; preds = %for.body.23.i
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %land.lhs.true.i
  %c.i.0 = phi i8 [ %70, %land.lhs.true.i ], [ 46, %if.then.i ]
  %conv32.i = sext i8 %c.i.0 to i16
  %call33.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i16 %conv32.i) #4
  %inc35.i = add nsw i16 %j.i.2, 1
  br label %for.cond.15.i

for.end.36.i:                                     ; preds = %land.end.22.i
  %call37.i = call i16 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)) #4
  %add39.i = add nsw i16 %i.i.3.0, 8
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
  ret i16 0
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
