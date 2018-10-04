#ifndef EDBPROF_TASKENERGYESTIMATOR_H
#define EDBPROF_TASKENERGYESTIMATOR_H

#include "BallLarusGraph.h"

#include "EnergyDist.h"
#include "BlockEnergyProfile.h"

#include "llvm/Pass.h"

#include <map>
#include <vector>
#include <fstream>

namespace edbprof {

  class TaskEnergyEstimator : public llvm::ModulePass {
   public:
    static char ID;

    TaskEnergyEstimator();
    ~TaskEnergyEstimator();

    bool runOnModule(llvm::Module &M) override;

    void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

   private:

    typedef unsigned PathId;

    // Store path elements for diagnostics

    // A block and its energy ('task' is legacy term for a pseudo-task)
    struct TaskPathElem {
      BallLarusNode *Node;
      EnergyDist Energy;

      TaskPathElem(BallLarusNode *node, const EnergyDist &energy) :
        Node(node), Energy(energy) { }

      TaskPathElem(BallLarusNode *node) :
        Node(node) { }
    };

    // The set of all paths through a loop body and meta info about the loop
    struct LoopPathElem {
      std::vector<TaskPathElem> LoopPath;
      EnergyDist Energy;
      float PathFreq;
      unsigned IterCount;
      unsigned NumExecutions;

      LoopPathElem(std::vector<TaskPathElem> &loopPath, const EnergyDist &energy,
                   float pathFreq, unsigned iterCount, unsigned numExecs) :
        LoopPath(loopPath), Energy(energy), PathFreq(pathFreq),
        IterCount(iterCount), NumExecutions(numExecs) { }
    };

    // A set of paths through a task ('func' is legacy term for program)
    struct FuncPathElem {
      // Either one or the other
      enum {
        FUNC_PATH_ELEM_TYPE_TASK,
        FUNC_PATH_ELEM_TYPE_LOOP,
      } Type;

      // Only one of these are set depending on value of Type field
      std::vector<TaskPathElem> TaskPath;
      std::vector<LoopPathElem> LoopPaths;

      EnergyDist Energy;
      unsigned LoopMultiplier;

      FuncPathElem(std::vector<TaskPathElem> &taskPath,
                  const EnergyDist &energy) :
        Type(FUNC_PATH_ELEM_TYPE_TASK), TaskPath(taskPath),
        Energy(energy) { }

      FuncPathElem(std::vector<LoopPathElem> &loopPaths,
                   const EnergyDist &energy) :
        Type(FUNC_PATH_ELEM_TYPE_LOOP), LoopPaths(loopPaths),
        Energy(energy) { }
    };

    // path idx -> freq
    typedef std::map<PathId, float> TaskPathFreqMap;

    // func name -> (task -> (path idx -> count))
    typedef std::map<std::string, std::map<std::string, std::map<PathId, unsigned> > > PathCountMap;

    // func name -> (task -> (path idx -> freq))
    typedef std::map<std::string, std::map<std::string, TaskPathFreqMap> > PathFreqMap;

    void loadBlockEnergyDataset(const std::string& file);
    void loadOpaqueFunctionEnergyDataset(const std::string &file);
    void loadPathCountsDataset(const std::string& file);

    void calcPathFreqs();

    float lookupTaskPathFreq(llvm::Function &F, Task *task, unsigned pathId, PathFreqMap pathFreqs);
    EnergyDist lookupBlockEnergy(BallLarusNode *node);

    void estimateLoopEnergy(
        EnergyDist &taskEnergy, /* accumulator */
        Task *task,
        BallLarusNode *node,
        unsigned pathId, /* by value! copies must be stacked*/
        EnergyDist pathEnergy, /* by value! copies must be stacked */
        unsigned loopIterCount,
        std::vector<TaskPathElem> loopPath,
        std::vector<LoopPathElem> &loopPaths,
        const TaskPathFreqMap &pathFreqs);

    void callEstimateTaskEnergies(BallLarusNode *node,
        std::set<BallLarusNode *> &nodes,
        const PathFreqMap &pathFreqs);

    void estimateTaskEnergies(
        Task *task,
        unsigned &funcPathId, EnergyDist funcPathEnergy, float funcPathProb,
        std::vector<FuncPathElem> funcPath,
        BallLarusNode *node,
        Task *subTask,
        unsigned taskPathId, /* by value! copies must be stacked*/
        EnergyDist taskPathEnergy, /* by value! copies must be stacked */
        unsigned taskPathDepth, std::vector<TaskPathElem> taskPath,
        const PathFreqMap &pathFreqs);

    void printBlockEnergies();

    template<typename TValue>
    void printPerPathValues(const std::map<std::string, std::map<std::string, std::map<PathId, TValue> > > &m);

    std::string formatFuncPath(const std::vector<FuncPathElem> &funcPath);

    std::ofstream funcEnergyFile;

    BlockEnergyProfile blockEnergyProfile;

    // NOTE: these maps cannot use object pointers as keys because we load
    // the datasets before we have a reference to Module/Function objects.

    // TODO: these should be keyed on function object address, not on func name
    //
    // TODO: instead of passing these around as maps, store the values
    // in the CFG objects once and use for calculations when needed.
    // This is easy for funcBlockEnergy, but a bit tricky for path freqs
    // because there are multiple options concerning what object to
    // associated a path with.
    
    PathCountMap pathCounts;
    PathFreqMap pathFreqs;
  };

} // namespace edbprof

#endif // EDBPROF_TASKENERGYESTIMATOR_H
