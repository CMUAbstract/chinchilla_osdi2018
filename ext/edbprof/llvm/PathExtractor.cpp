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

#include "PathExtractor.h"

#define DEBUG_TYPE "PathExtractor"

using namespace llvm;
using namespace edbprof;

namespace edbprof {

/// Walk the control flow graph starting at the 'root' basic
/// block and output each path found, along with repetition
/// count for blocks that are part of a loop.
///
/// Loops are handled by walking through each loop once.
/// LoopState keeps track of the loop we are in until we
/// follow a backedge twice.
///
/// TODO: Handle nested loops.
///
/// NOTE: We pass the path by copy because each recursive call
/// will modify the repetition counts, in case of loops. We could
/// store the counts in another datastructure and pass only that
/// one by copy and not the path, but that datastructure would
/// mirror the path datastructure, so there's little point. An
/// alternative would be to somehow undo the changes in the
/// caller's stack frame, but that seems complicated because
/// the backedge can reach back to an arbitrary block in the path,
/// not necessarily related to the caller.
void PathExtractor::walkCFG(Function &F, BasicBlock &root, Path path,
                            LoopState &loopState, std::ofstream &out) {

  LoopInfoWrapperPass &LI = getAnalysis<LoopInfoWrapperPass>();
  LoopInfo *Linfo = &LI.getLoopInfo();

  // We take record the loop and its declareed iteration count when we pass
  // its header, but we only increment the repetitions of the loop body when
  // we finish passing the last block in the body (because we don't know the
  // body at this point).
  if (Linfo->isLoopHeader(&root)) { // entered a loop

    Loop* loop = Linfo->getLoopFor(&root);
    if (!loop) {
      F.getContext().diagnose(
          DiagnosticInfoFatalOptimizationFailure(
            F, loop->getStartLoc(), "no loop object for loop header"));
    }

    loopState.LoopHandle = loop;
    loopState.IterCount = getLoopIterCount(loop);
  }

  path.push_back(PathElement(&root, 1 /* repetitions */));

  if (succ_begin(&root) == succ_end(&root)) { // last block in the path

    // Write path to the output file as one line
    out << F.getName().str() << ": ";
    for (auto iter = path.begin(); iter != path.end(); iter++) {
      out << iter->Block->getName().str() << "*" << iter->Repetitions << " ";
    }
    out << "\n"; 

    // Print the path to debug stream
    DEBUG(dbgs() << "path: " << F.getName() << ": ");
    for (auto iter = path.begin(); iter != path.end(); iter++) {
      DEBUG(dbgs() << iter->Block->getName() << "*"
                   << iter->Repetitions << " ");
    }
    DEBUG(dbgs() << "\n");

  } else { // recursive case: walk each successor

    for (auto succ = succ_begin(&root); succ != succ_end(&root); ++succ) {

      // Do not make the recursive call for a backedge that was already
      // visited.  NOTE: we may visit a node more than once but not an
      // edge.
      bool backedge_visited = false;

      for (auto ancestor = path.begin(); ancestor != path.end();
          ancestor++) {

        if (ancestor->Block == *succ) { // followed a backedge

          // Following the backage for the second time
          if (ancestor != path.begin() && (ancestor - 1)->Block == &root) {

            backedge_visited = true;

#if 0 // This actually triggers
            LoopInfoWrapperPass &LI = getAnalysis<LoopInfoWrapperPass>();
            LoopInfo *Linfo = &LI.getLoopInfo();
            if (!Linfo->isLoopHeader(ancestor->Block)) {
              BasicBlock ancestorBB = ancestor->Block;
              ancestorBB->getContext().diagnose(
                  DiagnosticInfoFatalOptimizationFailure(
                    F, ancestorBB->getFirstNonPHI()->getDebugLoc(),
                    "backedge to a block that is not a loop header"));
            }
#endif
            break;

          } else { // following the backage for the first time

            // We've identified the blocks in loop body, set rep counts
            for (auto loopBody = ancestor; loopBody != path.end(); loopBody++) {
              loopBody->Repetitions = loopState.IterCount;
            }

            // We exited the loop body, reset the loop state
            loopState.LoopHandle = nullptr;
            loopState.IterCount = 1;
          }
        }
      }

      if (!backedge_visited)
        walkCFG(F, **succ, path, loopState, out);
    }
  }

  path.pop_back();
}

void PathExtractor::getAnalysisUsage(AnalysisUsage &AU) const{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}

bool PathExtractor::runOnFunction(Function &F) {

  std::string pathfile_filename = (F.getParent()->getName() + ".path").str();
  std::ofstream pathfile(pathfile_filename, std::ofstream::app);

  Path path;
  LoopState loopState;

  walkCFG(F, F.getEntryBlock(), path, loopState, pathfile);

  pathfile.close();

  return false; // not modified
}

char PathExtractor::ID = 0;
static RegisterPass<PathExtractor> X("extract-paths", "Extract paths to a file",
    /* does not modify CFG? */ true,
    /* is analysis pass? */ false);

} // namespace edbprof
