#include "PathEnergyPass.h"

#include "BallLarusGraph.h"
#include "EnergyDist.h"
#include "CLI.h"
#include "Tasks.h"
#include "CpuTimeStopWatch.h"
#include "Path.h"
#include "BlockHashMap.h"

#include "llvm/IR/Module.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <vector>
#include <queue>
#include <fstream>

#define DEBUG_TYPE "PathEnergyPass"

using namespace llvm;

namespace {

    edbprof::BallLarusNode *findPathTail(edbprof::PathPtr path) {
      edbprof::BallLarusNode *tail;
      auto lastPathElem = path->Elems.front();
      switch (path->Elems.front()->Type) { // last block in path
          case edbprof::PATH_ELEM_BLOCK: {
              auto blockElem = static_cast<edbprof::BlockPathElem *>(lastPathElem.get());
              assert(blockElem && "null block path element");
              assert(blockElem->node() && "null node in path element");
              tail = blockElem->node();
              break;
          }
          case edbprof::PATH_ELEM_LOOP:
              auto loopElem = static_cast<edbprof::LoopPathElem *>(lastPathElem.get());
              assert(loopElem && "null loop path element");
              assert(loopElem->LoopPaths.size() > 0 && "loop elem without any paths");
              loopElem->LoopPaths.front();
              tail = NULL;
              for (auto loopPath : loopElem->LoopPaths) {
                  edbprof::BallLarusNode *loopTail = findPathTail(loopPath);
                if (!tail)
                    tail = loopTail;
                assert(loopTail == tail && "loop with multiple exits"); // not supported
              }
              assert(tail && "loop without any paths");
              break;
      }
      return tail;
    }
}

namespace edbprof {

PathEnergyPass::PathEnergyPass()
  : ModulePass(ID),
    pathEnergyEstimator(LoadBlockHashMap(BlockHashMapFilename))
{
}

bool PathEnergyPass::runOnModule(llvm::Module &M)
{
  assert(!PathEnergyFilename.empty() && "No path energy output filename specified");
  std::ofstream pathEnergyFile(PathEnergyFilename.c_str());
  pathEnergyFile << "path,task,tail,elapsed_sec,energy_expr,path_elems\n";

  DEBUG(dbgs() << "estimating path energies for module " << M.getName() << "\n");

  Function *entryFunc = getEntryFunction(M);
  FuncBallLarusDag dag(&entryFunc->getEntryBlock(), this, stripExtension(M.getName()));

  DEBUG(dbgs() << "computing path energies for module " << M.getName() << "\n");

  // Keep track of the tasks by BasicBlock, not by BallLarusNode, because
  // the latter get duplicated as a result of following and expanding calls.
  std::set<BasicBlock *> processedTasks;

  std::queue<BallLarusNode *> tasks;
  tasks.push(dag.getEntry());

  while (tasks.size()) {

    BallLarusNode *task = tasks.front();
    tasks.pop();

    // NOTE: we don't filter by BasicBlock inside estimatePathEnergies, because
    // that function is re-used for loops, and when it comes to loop successors,
    // we want to traverse all successors, even if they are nodes that wrap
    // the same basic blocks. TODO: should we filter out *node* duplicates?
    if (processedTasks.find(task->getBlock()) != processedTasks.end()) {
        DEBUG(dbgs() << "task " << task->getName() << " processed: skipping\n");
        continue;
    }

    processedTasks.insert(task->getBlock());

    DEBUG(dbgs() << "traversing task " << task->getName() << " block " << task->getBlock() << "\n");

    std::vector<DistExprPtr> pathEnergies;
    std::vector<PathPtr> paths; // for diag only
    std::vector<BallLarusNode *> successors;
    std::map< BallLarusNode *, std::vector<DistExprPtr> > memoizedPathEnergies;
    std::map< BallLarusNode *, std::vector<PathPtr> > memoizedPaths; // for diag only

    float elapsedSec = 0.0;
    {
      CpuTimeStopWatch stopWatch(&elapsedSec);

      pathEnergyEstimator.estimatePathEnergies(pathEnergies, paths, successors, task, task,
                                               /* isPathHead */ true, /* isLoop */ false,
                                               memoizedPathEnergies, memoizedPaths);

      for (auto &successor : successors) {
        DEBUG(dbgs() << "queueing successor task " << successor << " block " << successor->getBlock() << "\n");
        tasks.push(successor);
      }
    }

    DEBUG(dbgs() << "estimated path energies for task: " << task << "\n");
    unsigned pathIdx = 0;
    for (auto pathEnergy : pathEnergies) {
      auto path = paths[pathIdx];
      assert(path->Elems.size() > 0 && "empty path");
      BallLarusNode *tailBlock = findPathTail(path);
      std::string tailBlockName = tailBlock->getName();
      DEBUG(dbgs() << "path " << pathIdx << ": " << task->getName() << " - " << tailBlockName << "\n"
#ifdef LOG_PATH_ENERGY
                   << *pathEnergy
#endif // LOG_PATH_ENERGY
                   << "\n");
      pathEnergyFile << pathIdx << "," << task->getName() << "," << tailBlockName
                     << "," << elapsedSec << ","
                     << "\"" << *pathEnergy << "\",\"" << *path << "\"\n";
      ++pathIdx;
    }
    DEBUG(dbgs() << "\n");

#ifdef LOG_PATH_ENERGY
    Path::printPaths(paths);
#endif // LOG_PATH_ENERGY

    DEBUG(dbgs() << "left over tasks: " << tasks.size() << "\n");
  }

  return false;
}

void PathEnergyPass::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}

char PathEnergyPass::ID = 0;
static RegisterPass<PathEnergyPass> X("estimate-path-energy",
    "Estimate path energy based on measured path frequency profile "
    "and energy of each basic block");

} // namespace edbprof
