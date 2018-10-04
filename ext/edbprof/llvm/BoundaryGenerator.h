#ifndef EDBPROF_BOUNDARYGENERATOR_H
#define EDBPROF_BOUNDARYGENERATOR_H

#include "llvm/Pass.h"

#include <set>
#include <fstream>

namespace edbprof {

  // Generate multiple potential boundary placements, without actually applying
  // any of them. This pass leaves the binary unmodified, but produces a set
  // of files in a designated folder, each of which specifies a boundary placement.
  // A boundary placement specification file can be used by a separate pass
  // (BoundaryPlacer) to actually generate a binary with that placement.
  class BoundaryGenerator : public llvm::ModulePass {
   public:
    static char ID;

    BoundaryGenerator();

    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

   private:
    void buildBlockList(llvm::BasicBlock *block, std::set<llvm::BasicBlock *> &blocks);
    void loadFuncBlacklist(const std::string &filename);
    bool isFunctionBlacklisted(llvm::Function &F);

    std::ofstream specListFile;
    std::set<std::string> funcBlacklist;
  };

} // namespace edbprof

#endif // EDBPROF_BOUNDARYGENERATOR
