#ifndef EDBPROF_FATALOPTIMIZATIONFAILURE_H
#define EDBPROF_FATALOPTIMIZATIONFAILURE_H

#include "llvm/IR/DiagnosticInfo.h"

namespace edbprof {

  class DiagnosticInfoFatalOptimizationFailure :
            public llvm::DiagnosticInfoOptimizationBase {
   public:
    DiagnosticInfoFatalOptimizationFailure(const llvm::Function &Fn,
      const llvm::DebugLoc &DLoc, const llvm::Twine &Msg)
      : DiagnosticInfoOptimizationBase(llvm::DK_OptimizationFailure, llvm::DS_Error,
                                       nullptr, Fn, DLoc, Msg) {}

    bool isEnabled() const override { return true; };
  };

} // namespace edgprof

#endif // EDBPROF_FATALOPTIMIZATIONFAILURE_H
