#include "GreedyBoundaryPlacer.h"

#include "BallLarusGraph.h"
#include "EnergyDist.h"
#include "CLI.h"
#include "Tasks.h"
#include "CommaSeparatedValues.h"
#include "CpuTimeStopWatch.h"
#include "WallTimeStopWatch.h"
#include "Path.h"

#include "llvm/IR/Module.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <vector>
#include <queue>
#include <algorithm>
#include <fstream>

#define DEBUG_TYPE "GreedyBoundaryPlacer"

using namespace llvm;

namespace edbprof {

GreedyBoundaryPlacer::GreedyBoundaryPlacer()
  : ModulePass(ID),
    pathEnergyEstimator(LoadBlockHashMap(BlockHashMapFilename)),
    distExprEvaluator()
{
  assert(!EnergyCapacityFilename.empty() &&
         "energy capacity dataset file not specified");
  std::ifstream energyCapacityFile(EnergyCapacityFilename);
  std::string line;
  energyCapacityFile >> line; // skip CSV header

  energyCapacityFile >> line;
  const auto &tokens = tokenize(line);

  energyCapacity = std::stof(tokens[0]);
  DEBUG(dbgs() << "read energy capacity: " << energyCapacity << "\n");
}

bool GreedyBoundaryPlacer::runOnModule(llvm::Module &M)
{
  float elapsedSec = 0.0;
  {
    WallTimeStopWatch stopWatch(&elapsedSec);
    placeBoundaries(M);
  }
  DEBUG(dbgs() << "placing boundaries took: " << elapsedSec << " sec\n");

  if (!GreedyRunningTimeFilename.empty()) {
    std::ofstream runningTimeFile(GreedyRunningTimeFilename.c_str());
    runningTimeFile << "time_sec\n"; // CSV header
    runningTimeFile << elapsedSec << "\n";
  }

  return false;
}

void GreedyBoundaryPlacer::placeBoundaries(llvm::Module &M)
{
  std::ofstream specFile(SpecOutputFilename.c_str());
  specFile << "func,block\n"; // CSV header

  DEBUG(dbgs() << "estimating path energies for module " << M.getName() << "\n");

  // Start evaluation in fast mode, where distributions are collapsed to expected values
  distExprEvaluator.setCollapse(true);

  Function *entryFunc = getEntryFunction(M);
  FuncBallLarusDag dag(&entryFunc->getEntryBlock(), this, stripExtension(M.getName()));

  DEBUG(dbgs() << "computing path energies for module " << M.getName() << "\n");

  while (true) { // while most costly path exceeds energy capacity

    std::vector<PathPtr> programPaths; // this is a heap, accessed only via {push,pop}_heap

    {
      DEBUG(dbgs() << "remarking loops\n");

      std::set<BallLarusNode *> visitedNodes;
      dag.unmarkLoops(dag.getEntry(), visitedNodes); // a marking is only valid for a given placement

      std::vector<BallLarusNode *> funcPath; // passed by ref
      std::vector<BallLarusNode *> taskPath; // passed by value
      dag.markLoops(dag.getEntry(), funcPath, taskPath);
    }

    DEBUG(dbgs() << "extracting paths\n");

    std::set<BallLarusNode *> processedTasks;

    std::queue<BallLarusNode *> tasks;
    tasks.push(dag.getEntry());

    while (tasks.size()) {

      BallLarusNode *task = tasks.front();
      tasks.pop();
      processedTasks.insert(task);

      DEBUG(dbgs() << "traversing task " << task->getName() << "\n");

      std::vector<DistExprPtr> pathEnergies;
      std::vector<PathPtr> paths;
      std::vector<BallLarusNode *> successors;
      std::map< BallLarusNode *, std::vector<DistExprPtr> > memoizedPathEnergies;
      std::map< BallLarusNode *, std::vector<PathPtr> > memoizedPaths;
      pathEnergyEstimator.estimatePathEnergies(pathEnergies, paths, successors, task, task,
                                               /* isPathHead */ true, /* isLoop */ false,
                                               memoizedPathEnergies, memoizedPaths);

      for (auto &successor : successors) {
        if (processedTasks.find(successor) == processedTasks.end()) {
          tasks.push(successor);
        }
      }

      // Transfer dist objects into path objects and eval the expression to get max energy
      DEBUG(dbgs() << "estimated path energies for task: " << task << "\n");
      unsigned pathIdx = 0;
      std::vector<DistExprPtr>::iterator pathEnergy;
      std::vector<PathPtr>::iterator path;
      for (pathEnergy = pathEnergies.begin(),
           path = paths.begin();
           pathEnergy != pathEnergies.end() && path != paths.end();
           ++pathEnergy, ++path) {
        DEBUG(dbgs() << "  path " << pathIdx
#ifdef LOG_PATH_ENERGY
              << " energy " << *pathEnergy
#endif // LOG_PATH_ENERGY
              << "\n");
        (*path)->Energy = *pathEnergy;
        (*path)->Energy->MaxValue = distExprEvaluator.evalMax(**pathEnergy);
        ++pathIdx;
      }
      DEBUG(dbgs() << "\n");

#ifdef LOG_PATH_ENERGY
      Path::printPaths(paths);
#endif // LOG_PATH_ENERGY

      for (auto &path : paths) {
        programPaths.push_back(path);
        std::push_heap(programPaths.begin(), programPaths.end(), Path::compareByMaxEnergy);
        assert(path->Energy);
        assert(programPaths.front()->Energy);
        DEBUG(dbgs() << "pushed path with energy " << path->Energy->MaxValue << ": max "
                     << programPaths.front()->Energy->MaxValue << "\n");
      }


      DEBUG(dbgs() << "left over tasks: " << tasks.size() << "\n");
    }

    DEBUG(dbgs() << "program paths total: " << programPaths.size() << "\n");

    assert(programPaths.size() && "no paths found");

    auto maxEnergyPath = programPaths.front(); // copy
    std::pop_heap(programPaths.begin(), programPaths.end(), Path::compareByMaxEnergy);
    programPaths.pop_back();

    DEBUG(dbgs() << "popped path with max energy " << maxEnergyPath->Energy->MaxValue << " path:\n");
    for (auto pathElem = maxEnergyPath->Elems.rbegin();
         pathElem != maxEnergyPath->Elems.rend(); ++pathElem) {
      (*pathElem)->debugPrint(/* level */ 0);
    }
    DEBUG(dbgs() << "\n");

    if (maxEnergyPath->Energy->MaxValue < energyCapacity) {
      DEBUG(dbgs() << "done: path with max energy is less than energy capacity: "
                   << maxEnergyPath->Energy->MaxValue << "\n");

      // Switch to precise path energy estimation (using full PDF data)
      if (distExprEvaluator.getCollapse()) {
        DEBUG(dbgs() << "switching to precise mode\n");
        distExprEvaluator.setCollapse(false);
        continue;
      } else { // last estimate was precise
        DEBUG(dbgs() << "boundary placement passes in precise mode\n");
        break; // done
      }
    }

    BallLarusNode *boundaryNode = splitPath(dag, maxEnergyPath);

    // midpointPathElem could be BlockPathElem or LoopPathElem
    std::set<BallLarusNode *> visitedNodes;
    placeBoundary(dag.getEntry(), boundaryNode->getBlock(), visitedNodes);

    DEBUG(dbgs() << "placing boundary at " << boundaryNode << "\n");

    BasicBlock *boundaryBlock = boundaryNode->getBlock();
    assert(boundaryBlock);
    specFile << boundaryBlock->getParent()->getName().str() << ","
             << boundaryBlock->getName().str() << "\n";

    // TODO: do not recompute the entire CFG: the new boundary invalidates only part of it
  }

  dag.log("boundaries");
}

BallLarusNode *GreedyBoundaryPlacer::splitPath(BallLarusDag &dag, PathPtr path)
{
  DEBUG(dbgs() << "splitting path with energy: " << *path->Energy << ":\n");
  path->debugPrint(/* level */ 0);
  DEBUG(dbgs() << "\n");

  float halfEnergy = path->Energy->MaxValue / 2;
  DEBUG(dbgs() << "half path energy = " << halfEnergy << "\n");

  float segmentEnergy = 0.0;
  unsigned segmentLength = 0;
  std::vector<PathElemPtr>::reverse_iterator prevPathElem = path->Elems.rend();
  std::vector<PathElemPtr>::reverse_iterator prevPrevPathElem = path->Elems.rend();
  for (auto pathElem = path->Elems.rbegin();
            pathElem != path->Elems.rend(); ++pathElem) {

    DEBUG(dbgs() << "split path: traversing path elem "
                 << (*pathElem)->node() << " type " << (*pathElem)->Type
#ifdef LOG_PATH_ENERGY
                 << " energy " << *((*pathElem)->Energy)
#endif
                 << "\n");

    (*pathElem)->Energy->MaxValue = distExprEvaluator.evalMax(*((*pathElem)->Energy));

    if ((*pathElem)->Type == PATH_ELEM_LOOP) {
      LoopPathElem *loopPathElem = static_cast<LoopPathElem*>(pathElem->get());
      if ((*pathElem)->Energy->MaxValue > energyCapacity) {
        PathPtr maxEnergyLoopPath;
        for (auto &loopPath : loopPathElem->LoopPaths) {
          loopPath->Energy->MaxValue = distExprEvaluator.evalMax(*loopPath->Energy);
          if (!maxEnergyLoopPath.get() || loopPath->Energy->MaxValue > maxEnergyLoopPath->Energy->MaxValue) {
            maxEnergyLoopPath = loopPath;
          }
        }
        assert(maxEnergyLoopPath.get());
        DEBUG(dbgs() << "about to split (recurring): max path energy "
                     << maxEnergyLoopPath->Energy->MaxValue << "\n");
        return splitPath(dag, maxEnergyLoopPath);
      } else {
        DEBUG(dbgs() << "split path: not entering loop: energy (" << *((*pathElem)->Energy)
                     << " less than capacity "
                     << "(" << energyCapacity << ")\n");
      }
    }

    float pathElemEnergy = (*pathElem)->Energy->MaxValue;

    DEBUG(dbgs() << "split path: "
                 << " segment length " << segmentLength
                 << " segment energy " << segmentEnergy
                 << " path elem " << pathElemEnergy
                 << " half energy " << halfEnergy << "\n");
    if (halfEnergy < segmentEnergy + pathElemEnergy
        && segmentLength > 1 ) { // HACK: don't allow split of a segment of length 1

      DEBUG(dbgs() << "split path: path len " << path->Elems.size()
                   << " reached 'midpoint': " << (*pathElem)->node() << "\n");

      // Choose the best path element among the options, according to a metric
      //
      // NOTE: the other set of options for the split point are the path elems
      // starting from the end of the path: we can either chop of the start
      // of a path or the end of a path. For now, we only consider the former.

      // TODO: minor hack (but needs a revisit): exclude if we place the boundary in
      // the loop head block, we are effectively placing it on every iteration
      // of the loop, but that is not what we want. This hack places the
      // boundary on the block that precedes the loop head block. Note that the
      // loop head block appears once before the loop path element (and also
      // appears within the loop path element, as a body block, but that's not
      // relevant to the next point). So, to skip the loop head block, we need
      // to move *two* steps back from the current path elem (the loop path elem).
      assert(prevPathElem != path->Elems.rend() && "loop head is first in a path");
      assert(prevPrevPathElem != path->Elems.rend() && "loop head block does not appear before loop");
      auto lastPathElem = ((*pathElem)->Type == PATH_ELEM_LOOP) ?
                                prevPrevPathElem : pathElem;
      lastPathElem++; // we want the range in the loop to be inclusive

      // We need to pre-calculate the checkpoint scores because we need to
      // normalize them for the total score computation

      std::vector<PathElemPtr>::reverse_iterator candidatePathElem = path->Elems.rbegin();
      ++candidatePathElem; // NOTE: the first node in the path is not a split candidate
      std::vector<float> checkpointScores; // match to nodes is by order
      float checkpointScoreMax = 0.0;
      DEBUG(dbgs() << "split path: candidate path elem is not last: "
                   << (candidatePathElem != lastPathElem) << "\n");
      //assert(candidatePathElem != lastPathElem && "midpoint is second element in path");
      if (candidatePathElem == lastPathElem) {
        DEBUG(dbgs() << "midpoint is second element in path, no other cadidates, "
                     << " splitting at midpoint node: "
                     << "midpoint " << (*candidatePathElem)->node()
                     << "split at node: " << (*pathElem)->node() << "\n");
        return (*pathElem)->node();
      }


      for (; candidatePathElem != lastPathElem; ++candidatePathElem) {
        float checkpointScore = splitScore(dag, (*candidatePathElem)->node());
        checkpointScores.push_back(checkpointScore);
        if (checkpointScore > checkpointScoreMax)
            checkpointScoreMax = checkpointScore;
      }

      float maxScore = 0.0;
      bool maxScoreSet = false;
      BallLarusNode *splitNode = nullptr;

      std::vector<PathElemPtr>::reverse_iterator splitPathElem = path->Elems.rbegin();
      ++splitPathElem; // NOTE: the first node in the path is not a split candidate
      (*splitPathElem)->Energy->MaxValue = distExprEvaluator.evalMax(*(*splitPathElem)->Energy);
      float candidateSegmentEnergy = (*splitPathElem)->Energy->MaxValue;
      // Iterate over the path segment again, concurrently iterating over
      // checkpointScore array precomputed above
      DEBUG(dbgs() << "split path: num checkpoint scores: " << checkpointScores.size()
                   << " split path elem is not last " << (splitPathElem != lastPathElem) << "\n");
      std::vector<float>::iterator checkpointScoreIter;
      for (checkpointScoreIter = checkpointScores.begin();
            splitPathElem != lastPathElem &&
                checkpointScoreIter != checkpointScores.end();
            ++splitPathElem, ++checkpointScoreIter) {

        (*splitPathElem)->Energy->MaxValue = distExprEvaluator.evalMax(*(*splitPathElem)->Energy);
        candidateSegmentEnergy += (*splitPathElem)->Energy->MaxValue;

        // The score has two components: length of path and number of checkpoints.
        // To combine the two components, normalize each of them to [0,1] range.
        float lengthScore = candidateSegmentEnergy / segmentEnergy;
        float checkpointScore = *checkpointScoreIter / checkpointScoreMax;
        // Weight each score component
        lengthScore *= GreedyScoreWeightLength;
        checkpointScore *= GreedyScoreWeightCheckpoint;
        float score = lengthScore + -checkpointScore;
        assert(*splitPathElem);
        assert((*splitPathElem)->node());
        DEBUG(dbgs() << "path split: elem " << (*splitPathElem)->node()
                     << " score " << score << " length " << lengthScore
                     << " checkpointScore " << checkpointScore << "\n");
        if (!maxScoreSet || score > maxScore) {
          maxScore = score;
          maxScoreSet = true;
          splitNode = (*splitPathElem)->node();
        }
        assert(*splitPathElem);
        assert((*splitPathElem)->node());
        DEBUG(dbgs() << "split paths: path elem " << (*splitPathElem)->node()
                     << " score " << score << " max " << maxScore << "\n");
      }

      assert(splitNode != NULL);
      DEBUG(dbgs() << "split at node " << splitNode << "\n");
      return splitNode;
    }

    ++segmentLength;
    segmentEnergy += pathElemEnergy;
    prevPrevPathElem = prevPathElem;
    prevPathElem = pathElem;
  }

  assert(false && "failed to split path");
  return nullptr; // should never get here
}

float GreedyBoundaryPlacer::splitScore(BallLarusDag &dag, BallLarusNode *node)
{
  return dag.getBlockInstanceCount(node->getBlock());
}

// Place a boundary marker in all BL nodes that wrap the block (multiple
// nodes can wrap the same block as a result of function calls).
void GreedyBoundaryPlacer::placeBoundary(BallLarusNode *node, BasicBlock *block,
                                         std::set<BallLarusNode *> &visitedNodes)
{
  visitedNodes.insert(node);

  if (node->getBlock() == block)
    node->IsTaskEntry = true;

  for (auto child = node->succBegin(); child != node->succEnd(); ++child) {
    if (visitedNodes.find((*child)->getDst()) == visitedNodes.end())
      placeBoundary((*child)->getDst(), block, visitedNodes);
  }
}

void GreedyBoundaryPlacer::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}

char GreedyBoundaryPlacer::ID = 0;
static RegisterPass<GreedyBoundaryPlacer> X("edbprof--greedy--place-boundaries",
    "Find a boundary placement using a greedy algorithm "
    "that bisects paths by energy cost");

} // namespace edbprof
