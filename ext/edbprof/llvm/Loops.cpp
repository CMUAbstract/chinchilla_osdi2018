#include <fstream>

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

#include "FatalOptimizationFailure.h"

#include "Loops.h"

#define DEBUG_TYPE "Loops"

using namespace llvm;

namespace {

unsigned getNumericLoopAttr(Loop *loop, const StringRef &attr) {
  MDNode *LoopID = loop->getLoopID();
  if (!LoopID)
    return 0;

  for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
    const MDString *S = nullptr;
    SmallVector<Metadata *, 4> Args;

    // The expected hint is either a MDString or a MDNode with the first
    // operand a MDString.
    if (const MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i))) {
      if (!MD || MD->getNumOperands() == 0)
        continue;
      S = dyn_cast<MDString>(MD->getOperand(0));
      for (unsigned i = 1, ie = MD->getNumOperands(); i < ie; ++i)
        Args.push_back(MD->getOperand(i));
    } else {
      S = dyn_cast<MDString>(LoopID->getOperand(i));
      assert(Args.size() == 0 && "too many arguments for MDString");
    }

    if (!S)
      continue;

    // Check if the hint starts with the loop metadata prefix.
    StringRef Name = S->getString();
    if (Name == attr && Args.size() == 1) {
      const ConstantInt *C = mdconst::dyn_extract<ConstantInt>(Args[0]);
      if (!C)
        continue;
      return C->getZExtValue();
    }
  }
  return 0;
}

} // anon namespace

namespace edbprof {

unsigned getLoopIterCount(Loop *loop) {
  return getNumericLoopAttr(loop, "llvm.loop.iter.count");
}

unsigned getLoopId(Loop *loop) {
  return getNumericLoopAttr(loop, "llvm.loop.id");
}

unsigned getLoopIterCount(BasicBlock *head, LoopInfo *loopInfo, Function &F)
{
  assert(loopInfo->isLoopHeader(head) && "Asked a non-loop head for loop iter attr");

  Loop* loop = loopInfo->getLoopFor(head);
  if (!loop) {
    F.getContext().diagnose(
        DiagnosticInfoFatalOptimizationFailure(
          F, loop->getStartLoc(), "no loop object for loop header"));
  }

  return getLoopIterCount(loop);
}

Loop *getLoop(llvm::Pass *pass, llvm::BasicBlock *block)
{
  Function &F = *block->getParent();
  LoopInfoWrapperPass &LI = pass->getAnalysis<LoopInfoWrapperPass>(F);
  LoopInfo *loopInfo = &LI.getLoopInfo();

  assert(loopInfo->isLoopHeader(block) && "Asked a non-loop head for loop iter attr");

  Loop* loop = loopInfo->getLoopFor(block);
  if (!loop) {
    F.getContext().diagnose(
        DiagnosticInfoFatalOptimizationFailure(
          F, loop->getStartLoc(), "no loop object for loop header"));
  }

  return loop;
}

unsigned lookupLoopIterCount(llvm::Pass *pass, llvm::BasicBlock *block)
{
  Loop *loop = getLoop(pass, block);
  unsigned loopIterCount = getLoopIterCount(loop);
  return loopIterCount;
}

unsigned lookupLoopId(llvm::Pass *pass, llvm::BasicBlock *block)
{
  Loop *loop = getLoop(pass, block);
  unsigned loopId = getLoopId(loop);
  return loopId;
}



} // namespace edbprof
