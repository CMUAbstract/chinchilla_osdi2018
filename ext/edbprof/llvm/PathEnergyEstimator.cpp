#include "PathEnergyEstimator.h"

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

#define DEBUG_TYPE "PathEnergyEstimator"

using namespace llvm;

namespace edbprof {

PathEnergyEstimator::PathEnergyEstimator(BlockHashMapPtr blockHashMap)
  : blockHashMap(blockHashMap)
{
}

DistExprPtr PathEnergyEstimator::calculateLoopEnergy(std::vector<DistExprPtr> &pathEnergies,
                                                         unsigned repetitions)
{
  DEBUG(dbgs() << "calc loop energy: num paths " << pathEnergies.size()
               << " reps " << repetitions << "\n");

  // For now, we assume uniform path probabilities, with the exception of the
  // path out of the loop (which happens on exactly one iteration).  The energy
  // of the exit path is zero (the exit block is not included!), so we can
  // simply ignore it (it's not in the list in pathEnergies).
  float pathProb = 1.0 / pathEnergies.size(); // exclude the exit path

  MixDistExprPtr mixEnergy(new MixDistExpr());

  for (auto pathEnergy : pathEnergies) {
    mixEnergy->mix(WeightedDistExprPtr(new WeightedDistExpr(pathEnergy, pathProb)));
  }

#if 0
  // TODO: this is going to be deadly performance-wise
  SumDistExprPtr totalEnergy(new SumDistExpr());
  for (unsigned i = 0; i < repetitions; ++i) {
    *totalEnergy += mixEnergy;
  }
#else
  MultDistExprPtr totalEnergy(new MultDistExpr(mixEnergy, repetitions));
#endif

  return totalEnergy;
}

void PathEnergyEstimator::estimatePathEnergies(std::vector<DistExprPtr> &pathEnergies,
                                               std::vector<PathPtr> &paths, // for diag only
                                               std::vector<BallLarusNode *> &successors,
                                               BallLarusNode *entry, BallLarusNode *node,
                                               bool isPathHead, bool isLoop,
                                               std::map< BallLarusNode *, std::vector<DistExprPtr> >
                                                    &memoizedPathEnergies,
                                               std::map< BallLarusNode *, std::vector<PathPtr> >
                                                    &memoizedPaths) // for diag only
{
  assert(node);

  DEBUG(dbgs() << "path energies: entry " << entry
               << " isLoop " << isLoop << " node " << node
               << " task entry " << node->IsTaskEntry
               << " loop exit " << node->IsLoopExit
               << "\n");

  const auto &memedPathEnergies = memoizedPathEnergies.find(node);
  if (memedPathEnergies != memoizedPathEnergies.end()) {
    DEBUG(dbgs() << "path energies: entry " << entry
                 << " node " << node << ": returning memoized result\n");
    pathEnergies = memedPathEnergies->second; // copy
    // for diag only
    const auto &memedPaths = memoizedPaths.find(node);
    assert(memedPaths != memoizedPaths.end());
    paths = memedPaths->second;
    return;
  }

  // Base case: task boundary OR loop exit OR loop head (of the current loop,
  // ie. at the last nesting level), all at least one level deeper than where
  // we started.
  //
  // NOTE:
  // (1) we can't do without pre-labeling pass that sets
  // loop entry and exit, because we have no way of knowing ahead of time
  // whether a path starting a some node will eventually encounter a backedge.
  //
  // (2) we can't do without tracking entry (at least, when it is the loop head),
  // because we will follow backedges and we can't use the loop entry flag
  // to detect a backedge destination, because it doesn't distinguish between
  // loop nesting levels. In other words, we do want to continue recursion
  // at a loop entry node, if that is an entry into an inner loop.

  if ((isLoop && (node->IsLoopExit || node->IsTaskEntry || node == entry)) ||
     (!isLoop && ((!isPathHead &&    (node->IsTaskEntry || node == entry))))) {

    PathType pathType;
    if (node == entry) {
      pathType = PATH_TYPE_LOOP;
    } else {
      pathType = PATH_TYPE_PLAIN;
    }

    DEBUG(dbgs() << "path energies: " << "entry " << entry << " node " << node
                 << ": bottom of recursion: new path type " << pathType << "\n");

    // Don't create path from head *to* loop exit. We only recognize a path through
    // the loop to loop exit. We record the loop exit as a successor, so there's no
    // room for a path that is not through the loop, but is to the loop exit.
    if (!isLoop || (isLoop && !node->IsLoopExit)) {
      pathEnergies.push_back(ZeroDistExprPtr(new ZeroDistExpr())); // path energy is zero for the empty tail
      paths.push_back(PathPtr(new Path(pathType)));
    }

    // loop head is not a successor
    if ((isLoop && !node->IsLoopEntry) || (!isLoop && node->IsTaskEntry)) {
        DEBUG(dbgs() << "path energies: node " << node << " isLoop " << isLoop
                     << ": enqueueing successor " << node << "\n");
        successors.push_back(node);
    }
    return;
  }

  DEBUG(dbgs() << "Looking up block: " << node->getName() << "\n");
  assert(blockHashMap->find(node->getName()) != blockHashMap->end() && "Block not in block map");
  BlockHash &blockHash = (*blockHashMap)[node->getName()];
  DistExprPtr nodeEnergy = HistDistExprPtr(new HistDistExpr(blockHash));

  PathElemPtr pathElem = PathElemPtr(new BlockPathElem(nodeEnergy, node)); // for diag only

  DEBUG(dbgs() << "path energies: entry " << entry
               << " node " << node << " energy "
#ifdef LOG_PATH_ENERGY
               << *nodeEnergy
#endif // LOG_PATH_ENERGY
               << "\n");

  std::vector<DistExprPtr> successorPathEnergies;
  std::vector<PathPtr> successorPaths; // for diag only

  if (node->IsLoopEntry) {
    DEBUG(dbgs() << "path energies: node " << node << " is a loop head\n");

    std::vector<DistExprPtr> loopPathEnergies;
    std::vector<PathPtr> loopPaths; // for diag only
    std::vector<BallLarusNode *> loopSuccessors;

    for (auto childEdge = node->succBegin(); childEdge != node->succEnd(); ++childEdge) {
      BallLarusNode *loopPathHead = (*childEdge)->getDst();
      DEBUG(dbgs() << "path energies: recurring on loop head child: "
                   << loopPathHead << "\n");

      estimatePathEnergies(loopPathEnergies, loopPaths, loopSuccessors,
                           node, loopPathHead,
                           /* isPathHead */ false, /* isLoop */ true,
                           memoizedPathEnergies, memoizedPaths);

      DEBUG(dbgs() << "loop exits: ");
      for (auto &loopSucc : loopSuccessors)
        DEBUG(dbgs() << loopSucc << " ");
      DEBUG(dbgs() << "\n");
    }

    std::vector<DistExprPtr> loopBodyPathEnergies;
    std::vector<PathPtr> loopBodyPaths;

    // TODO: get rid of this nasty split into paths and energies
    std::vector<DistExprPtr>::iterator loopPathEnergy;
    std::vector<PathPtr>::iterator loopPath;
    for (loopPathEnergy = loopPathEnergies.begin(),
         loopPath = loopPaths.begin();
         loopPathEnergy != loopPathEnergies.end() &&
         loopPath != loopPaths.end();
         ++loopPathEnergy, ++loopPath) {
      switch ((*loopPath)->Type) {
        case PATH_TYPE_LOOP:
          (*loopPath)->Elems.push_back(pathElem); // append loop head to path
          loopBodyPathEnergies.push_back(*loopPathEnergy);
          loopBodyPaths.push_back(*loopPath);
          (*loopPath)->Energy = *loopPathEnergy;
          break;
        case PATH_TYPE_PLAIN:
          successorPathEnergies.push_back(*loopPathEnergy);
          successorPaths.push_back(*loopPath);
          break;
        default:
          assert(false && "invalid path type");
      }
    }

    DEBUG(dbgs() << "path energies: entry " << entry
                 << " node " << node << "\n");
    assert(loopBodyPathEnergies.size() > 0 && "no loop paths through loop");
    DistExprPtr loopEnergy = calculateLoopEnergy(loopBodyPathEnergies, node->LoopIterCount);
    DEBUG(dbgs() << "path energies: node " << node
                 << " loop paths " << loopBodyPaths.size()
#ifdef LOG_PATH_ENERGY
                 << " loop energy " << *loopEnergy
#endif // LOG_PATH_ENERGY
                 << "\n");

    // for diag only
    PathElemPtr loopPathElem(new LoopPathElem(loopEnergy, node, loopBodyPaths, node->LoopIterCount));

#ifdef LOG_PATH_ENERGY
    DEBUG(dbgs() << "loop successors: ");
    for (auto &loopSuccessor : loopSuccessors) {
      DEBUG(dbgs() << loopSuccessor << " ");
    }
    DEBUG(dbgs() << "\n");
#endif // LOG_PATH_ENERGY

    for (auto &loopSuccessor : loopSuccessors) {

      // A node after a task boundary is not a loop successor (the path after
      // the loop does not continue to that block). So, don't recur on it
      // here. Instead, enqueue it, and we'll get to it in a higher stack frame.
      if (!loopSuccessor->IsTaskEntry) {
        DEBUG(dbgs() << "path energies: recurring on loop successor " << loopSuccessor << "\n");
        std::vector<DistExprPtr> loopExitPathEnergies;
        std::vector<PathPtr> loopExitPaths;
        estimatePathEnergies(loopExitPathEnergies, loopExitPaths, successors,
                             entry, loopSuccessor,
                             /* isPathHead */ false, /* isLoop */ false,
                             memoizedPathEnergies, memoizedPaths);
        for (auto &loopExitPathEnergy : loopExitPathEnergies) {
          successorPathEnergies.push_back(loopExitPathEnergy + loopEnergy);
        }
        for (auto &loopExitPath : loopExitPaths) {
          PathPtr loopExitPathClone(new Path(loopExitPath->Type));
          loopExitPathClone->Elems.insert(loopExitPathClone->Elems.end(),
                                       loopExitPath->Elems.begin(), loopExitPath->Elems.end());
          loopExitPathClone->Elems.push_back(loopPathElem);
          successorPaths.push_back(loopExitPathClone);
        }
      } else {
        DEBUG(dbgs() << "path energies: skipping loop successor " << loopSuccessor
                     << ": task entry, appending to successor list\n");
        successors.push_back(loopSuccessor);
      }
    }

  } else { // not a loop entry

    DEBUG(dbgs() << "path energies: entry " << entry << " node " << node
                 << " is regular node\n");

    for (auto childEdge = node->succBegin(); childEdge != node->succEnd(); ++childEdge) {
      DEBUG(dbgs() << "path energies: entry " << entry << " node " << node
                   << " recurring on child " << (*childEdge)->getDst() << "\n");

      estimatePathEnergies(successorPathEnergies, successorPaths, successors,
                           entry, (*childEdge)->getDst(),
                           /* isPathHead */ false, isLoop,
                           memoizedPathEnergies, memoizedPaths);
    }

  }

  // At leaf nodes, we take the same action as upon crossing a task boundary
  if (!successorPathEnergies.size()) {
    DEBUG(dbgs() << "path energies: entry " << entry
                 << " node " << node << ": leaf node\n");
    successorPathEnergies.push_back(ZeroDistExprPtr(new ZeroDistExpr()));
    successorPaths.push_back(PathPtr(new Path(PATH_TYPE_PLAIN))); // for diag only
  }

  for (auto childEnergy : successorPathEnergies) {
    pathEnergies.push_back(childEnergy + nodeEnergy);
    DEBUG(dbgs() << "path energies: entry " << entry << " node " << node
                 << " added path: "
#ifdef LOG_PATH_ENERGY
                 << " node energy " << *nodeEnergy
                 << " path energy:\n" << *pathEnergies.back()
#endif // LOG_PATH_ENERGY
                 << "\n");
  }

  // for diag only
  for (auto childPath : successorPaths) {
    PathPtr childPathClone(new Path(childPath->Type));
    childPathClone->Elems.insert(childPathClone->Elems.end(),
                                 childPath->Elems.begin(), childPath->Elems.end());
    childPathClone->Elems.push_back(pathElem);
    paths.push_back(childPathClone);

    DEBUG(dbgs() << "path energies: entry " << entry << " node " << node
                 << " added path for diag: count " << paths.size()
                 << " path type " << childPath->Type << ":\n");
#ifdef LOG_PATH_ENERGY
    childPath->print(/* level */ 0);
    DEBUG(dbgs() << "node energy " << *nodeEnergy << "\n");
#endif // LOG_PATH_ENERGY
  }

  memoizedPathEnergies[node] = pathEnergies; // memoize
  memoizedPaths[node] = paths; // memoize
}

} // namespace edbprof
