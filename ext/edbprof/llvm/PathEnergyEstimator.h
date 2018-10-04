#ifndef EDBPROF_PATH_ENERGY_ESTIMATOR_H
#define EDBPROF_PATH_ENERGY_ESTIMATOR_H

#include "BallLarusGraph.h"
#include "EnergyDist.h"
#include "Path.h"
#include "BlockHashMap.h"

#include "llvm/Pass.h"

#include <utility>
#include <vector>
#include <map>

namespace edbprof {

class PathEnergyEstimator {
   public:

    PathEnergyEstimator(BlockHashMapPtr blockHashMap);

    void estimatePathEnergies(std::vector<DistExprPtr> &pathEnergies,
                              std::vector<PathPtr> &paths, // for diag only
                              std::vector<BallLarusNode *> &tasks,
                              BallLarusNode *entry, BallLarusNode *node,
                              bool isPathHead, bool isLoop,
                              std::map< BallLarusNode *, std::vector<DistExprPtr> >
                                &memoizedPathEnergies,
                              std::map< BallLarusNode *, std::vector<PathPtr> >
                                &memoizedPaths); // for diag only

   private:

    DistExprPtr calculateLoopEnergy(std::vector<DistExprPtr> &pathEnergies,
                              unsigned repetitions = 1);

    void printPaths(std::vector<Path> &paths);

    BlockHashMapPtr blockHashMap;
};

} // namespace edbprof

#endif // EDBPROF_PATH_ENERGY_ESTIMATOR_H

