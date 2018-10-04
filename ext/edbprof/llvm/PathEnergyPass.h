#ifndef EDBPROF_PATH_ENERGY_PASS_H
#define EDBPROF_PATH_ENERGY_PASS_H

#include "PathEnergyEstimator.h"

#include "llvm/Pass.h"

namespace edbprof {

class PathEnergyPass : public llvm::ModulePass {
   public:
    static char ID;

    PathEnergyPass();

    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

   private:
    PathEnergyEstimator pathEnergyEstimator;
};

} // namespace edbprof

#endif // EDBPROF_PATH_ENERGY_PASS_H

