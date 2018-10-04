#include "TaskSplitter.h"

#include "FatalOptimizationFailure.h"
#include "Tasks.h"

#include "llvm/Pass.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <sstream>

#define DEBUG_TYPE "TaskSplitter"

using namespace llvm;

namespace {

  std::string SplitBlockNameSuffix(".SPLIT.");

} //anon namespace

namespace edbprof {

TaskSplitter::TaskSplitter()
  : FunctionPass(ID)
{
}

TaskSplitter::~TaskSplitter()
{
}

bool TaskSplitter::runOnFunction(llvm::Function &F)
{
  if (isFunctionSpecial(F)) {
    DEBUG(dbgs() << "task splitter: skipping blacklisted func: " << F.getName() << "\n");
    return false;
  }

  DEBUG(dbgs() << "Splitting blocks in function " << F.getName() << "\n");

  std::set<BasicBlock *> path;
  splitTasks(&F.getEntryBlock(), path);

  return false;
}

void TaskSplitter::splitTasks(BasicBlock *block, std::set<BasicBlock *> &path)
{

  // Do not follow backedges
  if (path.find(block) != path.end())
    return;

  path.insert(block);

  // Traverse instructions in the block
  bool wasSplit = false;
  for (auto instr = block->begin(); instr != block->end(); ++instr) {
    Instruction *splitInstruction = nullptr;

    // split at task boundary: don't split if boundary instr is already at top of block
    if (isTaskBoundaryInstr(instr) && instr != block->begin()) {
      DEBUG(dbgs() << "  task boundary instruction '" << instr->getOpcodeName() << ": "
                   << "splitting block " << block->getName() << "\n");
      splitInstruction = instr;
    } else if (isCall(*instr)) {
       Function *callee = getCallee(*instr);
       if (callee && !isFunctionSpecial(*callee)) {
          DEBUG(dbgs() << "  call instruction: " << callee->getName() << ": "
                       << "splitting block " << block->getName() << "\n");
          splitInstruction = instr->getNextNode(); // split after the call
       }
    }

    if (splitInstruction) {

      // Name the block with a suffix and an index (distinguishes multiple splits)
      std::string name(block->getName());
      size_t suffixPos = name.find(SplitBlockNameSuffix);
      size_t splitIdxPos = std::string::npos;
      unsigned splitIdx = 0;
      if (suffixPos != std::string::npos) {
        splitIdxPos = suffixPos + SplitBlockNameSuffix.size();
        assert(splitIdxPos < name.size());
        std::stringstream splitIdxStr(name.substr(splitIdxPos, name.size() - splitIdxPos));
        splitIdxStr >> splitIdx;
        ++splitIdx;
      }
      std::stringstream splitBlockName;
      splitBlockName << name.substr(0, suffixPos) << SplitBlockNameSuffix << splitIdx;

      auto tailBlock = block->splitBasicBlock(splitInstruction, splitBlockName.str());
      splitTasks(tailBlock, path);
      wasSplit = true;
      break; // the remaining instructions are in the tail block
    }
  }

  // As a result of splitting, the successors of the original block become the
  // successors of the new block. And, we already made a recursive call on the
  // new block. We want these calls on successor to execute only for a block
  // that contains no boundaries.
  if (!wasSplit) {
    DEBUG(dbgs() << "  block " << block->getName() << " was not split; "
                 << "splitting its successors\n");
    for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
      splitTasks(*succ, path);
    }
  } 
}

char TaskSplitter::ID = 0;
static RegisterPass<TaskSplitter> X("split-tasks",
    "Split basic blocks at task boundaries");

} // namespace edbprof
