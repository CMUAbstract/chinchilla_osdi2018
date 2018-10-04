#ifndef EDBPROF_TASKSPLITTER_H
#define EDBPROF_TASKSPLITTER_H

#include "BallLarusGraph.h"

#include "llvm/Pass.h"

#include <set>

namespace edbprof {

  class TaskSplitter : public llvm::FunctionPass {
   public:
    static char ID;

    TaskSplitter();
    ~TaskSplitter();

    bool runOnFunction(llvm::Function &F) override;

   private:
    void splitTasks(llvm::BasicBlock *block, std::set<llvm::BasicBlock *> &path);
  };

} // namespace edbprof

#endif // EDBPROF_TASKSPLITTER
