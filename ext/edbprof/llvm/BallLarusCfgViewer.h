#ifndef EDBPROF_BALLLARUSCFGVIEWER_H
#define EDBPROF_BALLLARUSCFGVIEWER_H

#include "llvm/Pass.h"

namespace edbprof {

  class BallLarusCfgViewer: public llvm::ModulePass {
   public:
    static char ID;

    static const char *DotFileSuffix;

    BallLarusCfgViewer() : ModulePass(ID) {};

    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

  };

} // namespace edbprof

#endif // EDBPROF_BALLLARUSCFGVIEWER_H
