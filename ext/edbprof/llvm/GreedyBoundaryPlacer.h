#ifndef EDBPROF_GREEDY_BOUNDARY_PLACER_H
#define EDBPROF_GREEDY_BOUNDARY_PLACER_H

#include "BallLarusGraph.h"
#include "EnergyDist.h"
#include "BlockEnergyProfile.h"
#include "Path.h"
#include "PathEnergyEstimator.h"
#include "DistExprEvaluator.h"

#include "llvm/Pass.h"

#include <utility>
#include <vector>
#include <map>

namespace edbprof {

class GreedyBoundaryPlacer : public llvm::ModulePass {
   public:
    static char ID;

    GreedyBoundaryPlacer();

    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

   private:

    void placeBoundaries(llvm::Module &M);

    void estimatePathEnergies(std::vector<DistExprPtr> &pathEnergies,
                              std::vector<PathPtr> &paths, // for diag only
                              std::vector<BallLarusNode *> &tasks,
                              BallLarusNode *entry, BallLarusNode *node,
                              bool isPathHead, bool isLoop,
                              std::map< BallLarusNode *, std::vector<DistExprPtr> >
                                &memoizedPathEnergies,
                              std::map< BallLarusNode *, std::vector<PathPtr> >
                                &memoizedPaths); // for diag only

    DistExprPtr calculateLoopEnergy(std::vector<DistExprPtr> &pathEnergies,
                              unsigned repetitions = 1);

    BallLarusNode *splitPath(BallLarusDag &dag, PathPtr path);
    float splitScore(BallLarusDag &dag, BallLarusNode *node);
    void placeBoundary(BallLarusNode *node, llvm::BasicBlock *block,
                       std::set<BallLarusNode *> &visitedNodes);

    float energyCapacity; // for now, a scalar, not a distribution

    PathEnergyEstimator pathEnergyEstimator;
    DistExprEvaluator distExprEvaluator;
};

} // namespace edbprof

#endif // EDBPROF_GREEDY_BOUNDARY_PLACER_H

