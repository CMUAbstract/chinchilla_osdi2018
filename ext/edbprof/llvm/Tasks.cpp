#include "llvm/IR/Instruction.h"

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
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DIBuilder.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/MC/MCSymbol.h"

#include "Tasks.h"

#define DEBUG_TYPE "Tasks"

using namespace llvm;

namespace edbprof {

// TODO: link against DINO somehow?
const char *TaskBoundaryFunctionName = "edbprof__task_boundary";
const char *EntryTaskFunctionName = "main_task";
const char *DINOTaskBoundaryFunctionName = "__dino_task_boundary";

bool isCall(llvm::Instruction &I) {
  CallInst *call = llvm::dyn_cast<CallInst>(&I);
  if (!call){
    return false;
  }
  return true;
}

bool isCallTo(llvm::Instruction &I, llvm::StringRef fname) {
  CallInst *call = llvm::dyn_cast<CallInst>(&I);
  if (!call){
    return false;
  }

  Value *func = call->getCalledValue()->stripPointerCasts();
  if (!func){
    DEBUG(dbgs() << "instruction '" << I.getOpcodeName() << "': call without a function\n");
    return false;
  }

  return !func->getName().compare(fname);
}

llvm::Function *getCallee(llvm::Instruction &I)
{
  CallInst *call = llvm::dyn_cast<CallInst>(&I);
  assert(call && "asked for callee of an instruction that's not a call");

  Value *callee = call->getCalledValue()->stripPointerCasts();
  assert(callee && "call without a callee value");

  return llvm::dyn_cast<Function>(callee); // might be NULL (e.g. for asm() blocks
}

bool isTaskBoundaryInstr(Instruction *instr)
{
   return isCallTo(*instr, TaskBoundaryFunctionName);
}

bool isTaskBoundary(BasicBlock *block)
{
  // TODO: For now, we skip phi nodes when determining whether there is a task
  // boundary at the top of this block. A better way would be to strictly
  // confine boundaries to dedicated blocks (so, a boundary would only be
  // placed on an edge in the CFG).
  auto instr = block->begin();
  DEBUG(dbgs() << "isTaskBoundary: block "
               << block->getParent()->getName() << "-" << block->getName()
               << ": instr " << instr->getOpcodeName() << "\n");
  while (isa<PHINode>(*instr)) {
    DEBUG(dbgs() << "isTaskBoundary: skipping phi node in block "
                 << block->getParent()->getName() << "-" << block->getName() << "\n");
    instr++;
  }
  return isCallTo(*instr, TaskBoundaryFunctionName);
}

Function *getEntryFunction(Module &M)
{
  Function *entryFunc = M.getFunction(EntryTaskFunctionName);
  assert(entryFunc && "no entry function found (by naming convention)");
  return entryFunc;
}

bool isFunctionSpecial(Function &F)
{
    // Skip compiler-generated functions (like llvm.dbg.*)
    return F.getName().size() == 0 ||
           F.getName().find("llvm.") == 0 ||
           F.getName().find("__edbprof_") == 0 ||
           F.getName().find("edbprof_") == 0 || // TODO: follow convention
           F.getName().find(TaskBoundaryFunctionName) == 0 ||
           F.getName().find(DINOTaskBoundaryFunctionName) == 0;
}

std::string stripExtension(const std::string &name)
{
  return name.substr(0, name.rfind('.'));
}

} // namespace edbprof

