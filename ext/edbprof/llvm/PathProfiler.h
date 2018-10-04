#ifndef EDBPROF_PATHPROFILER_H
#define EDBPROF_PATHPROFILER_H

#include <vector>
#include <set>
#include <fstream>
#include <string>

#include "llvm/Pass.h"

#include "BallLarusGraph.h"

namespace edbprof {

  class PathProfiler : public llvm::FunctionPass {
   public:
    static char ID;

    PathProfiler();
    ~PathProfiler();

    bool runOnFunction(llvm::Function &F) override;

   private:

    // Declaring symbol names here for visibility
    static const char *PathRegSymName;
    static const char *PathCountsPtrsSymName;
    static const char *PathCountsSymName;
    static const char *IncIndirSymName;
    static const char *TaskSymName;
    static const char *TaskBoundaryFuncName;

    static const char *InstrumentationPrefix;
    static const char *ReturnPrefix;

    llvm::BasicBlock *spliceEdge(BallLarusEdge *edge);
    void instrumentEdges(llvm::Function &F, FuncBallLarusDag &dag);
    void findTaskExits(TaskBallLarusDag *dag, BallLarusNode *node,
                       std::vector<BallLarusNode *>& exits);
    void instrumentFunctionExits(llvm::BasicBlock *node,
                                 std::vector<llvm::BasicBlock *> &path,
                                 std::set<llvm::BasicBlock *> &returnBlocks,
                                 llvm::Module *mod, llvm::GlobalVariable *pathCounts,
                                 llvm::Value *taskReg, llvm::Value *pathReg);
    void saveTaskIds(llvm::Function &F, FuncBallLarusDag *dag, const std::string &filename);

    std::ofstream taskIdsFile;
  };

} // namespace edbprof

#endif // EDBPROF_PATHPROFILER_H
