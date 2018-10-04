#ifndef EDBPROF_LOOPS_H
#define EDBPROF_LOOPS_H

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DIBuilder.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/MC/MCSymbol.h"

namespace edbprof {

/// Retrieve the number of loop iterations from the metadata created / by
//  #pragma clang loop iter_count(<count>) associated with the loop.
unsigned lookupLoopIterCount(llvm::Pass *pass, llvm::BasicBlock *block);
unsigned lookupLoopId(llvm::Pass *pass, llvm::BasicBlock *block);
unsigned getLoopIterCount(llvm::Loop *loop);
unsigned getLoopId(llvm::Loop *loop);

} // namespace edbprof

#endif // EDBPROF_LOOPS_H
