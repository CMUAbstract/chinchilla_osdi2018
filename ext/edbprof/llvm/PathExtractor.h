#ifndef EDBPROF_PATH_EXTRACTOR_H
#define EDBPROF_PATH_EXTRACTOR_H

#include "llvm/Pass.h"

namespace edbprof {

  /// Traverse program tree and write out each path into a file
  class PathExtractor : public llvm::FunctionPass {
    public:
      static char ID; // Pass identification, replacement for typeid

      PathExtractor() : FunctionPass(ID) {};

      void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

      /// runOnFunction: Walks through each path in the function
      /// 
      /// Returns all possibe paths in the function where paths
      /// are identified by basic block names.
      bool runOnFunction(llvm::Function &F) override;

    private:

      struct LoopState {
        unsigned IterCount;
        llvm::Loop *LoopHandle;

        LoopState() : IterCount(0), LoopHandle(nullptr) {}
      };

      struct PathElement {
        llvm::BasicBlock *Block;
        unsigned Repetitions;

        PathElement(llvm::BasicBlock *block, unsigned repetitions)
          : Block(block), Repetitions(repetitions) {}
      };

      typedef std::vector<PathElement> Path;

      void walkCFG(llvm::Function &F, llvm::BasicBlock &root, Path path,
                   LoopState &loopState, std::ofstream &out);
  };

} // namespace edbprof

#endif // EDBPROF_PATH_EXTRACTOR_H
