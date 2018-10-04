#include "TaskEnergyEstimator.h"

#include "FatalOptimizationFailure.h"
#include "Loops.h"
#include "Tasks.h"
#include "CommaSeparatedValues.h"
#include "CLI.h"

#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <iomanip>
#include <fstream>
#include <sstream>
#include <map>
#include <cstdlib>

#define DEBUG_TYPE "TaskEnergyEstimator"

// Enable calculating the probability of a path through a task Without this,
// this pass only calculates energy for each path.  The case when we need to
// disable this is when validating the checker: each time a boundary placement
// changes, the path profile changes (because tasks change), but we don't want
// to re-measure the path freq profile for every placement.
//
// Note that the only reason we need the path freq profile at all in the
// checker validation use case is to compute energy cost of loops (we abstract
// the loop cost, for which we need frequencies of paths through the loop). 
// So, we need the path freq profile for *a* boundary placement -- it doesn't
// matter which one, since any one will have the fake boundaries around loops.
// #define CALCULATE_TASK_PATH_PROB

using namespace llvm;

namespace {

#if 0
void die(Function &F, const Twine& msg) {
    F.getContext().diagnose(edbprof::DiagnosticInfoFatalOptimizationFailure(
          F, F.getEntryBlock().getFirstNonPHI()->getDebugLoc(), msg));
}
#endif

} // anon namespace

namespace edbprof {

TaskEnergyEstimator::TaskEnergyEstimator() : ModulePass(ID)
{
  DEBUG(dbgs() << "Loading block energy dataset...\n");
  blockEnergyProfile.load(BlockEnergyFilename, OpaqueFunctionsFilename);
  blockEnergyProfile.print();

  if (OpaqueFunctionsFilename.size()) {
    DEBUG(dbgs() << "Loading opaque function energy dataset...\n");
    loadOpaqueFunctionEnergyDataset(OpaqueFunctionsFilename);
  }

  DEBUG(dbgs() << "Loading path counts dataset...\n");
  loadPathCountsDataset(PathCountsFilename);
  printPerPathValues(pathCounts);

  DEBUG(dbgs() << "Calculating path frequencies...\n");
  calcPathFreqs();
  printPerPathValues(pathFreqs);

  assert(!FuncEnergyFilename.empty() && "No output filename specified");
  funcEnergyFile.open(FuncEnergyFilename.c_str());
  funcEnergyFile << "task,path,energy_mean,energy_var"
#ifdef CALCULATE_TASK_PATH_PROB
                 ",prob"
#endif
                 ;

  DEBUG(dbgs() << "path recording: " << RecordPaths << "\n");

  if (RecordPaths)
    funcEnergyFile << ",path_blocks";

  funcEnergyFile << "\n";
}

TaskEnergyEstimator::~TaskEnergyEstimator()
{
  funcEnergyFile.close();
}

void TaskEnergyEstimator::loadPathCountsDataset(const std::string& file)
{
  assert(!file.empty() && "No path counts dataset filename specified");

  std::ifstream fin(file.c_str());
  assert(fin.good() && "Failed to open path counts dataset");

  std::string line;
  std::getline(fin, line);
  const auto& columns = tokenize(line);

  int funcColIdx = findColumn(columns, "func");
  int taskIdColIdx = findColumn(columns, "task_id");
  int pathIdColIdx = findColumn(columns, "path_id");
  int pathCountColIdx = findColumn(columns, "count");

  while (std::getline(fin, line)) {
    const auto& fields = tokenize(line);

    unsigned pathId = std::strtoul(fields[pathIdColIdx].c_str(), nullptr, 10);
    unsigned count = std::strtoul(fields[pathCountColIdx].c_str(), nullptr, 10);

    pathCounts[fields[funcColIdx]][fields[taskIdColIdx]][pathId] = count;
  }

  fin.close();
}

void TaskEnergyEstimator::calcPathFreqs()
{
  for (auto pathCountsEntry = pathCounts.begin();
       pathCountsEntry != pathCounts.end(); pathCountsEntry++) {
    const auto& taskPathCounts = pathCountsEntry->second;
    for (auto taskEntry = taskPathCounts.begin();
              taskEntry != taskPathCounts.end(); ++taskEntry) {
        const auto &pathEntries = taskEntry->second;
        unsigned totalCount = 0;
        for (auto pathEntry = pathEntries.begin();
                  pathEntry != pathEntries.end(); ++pathEntry) {
          totalCount += pathEntry->second;
        }
        for (auto pathEntry = pathEntries.begin();
                  pathEntry != pathEntries.end(); ++pathEntry) {
            pathFreqs[pathCountsEntry->first][taskEntry->first][pathEntry->first] =
              static_cast<float>(pathEntry->second) / totalCount;
        }
    }
  }
}

template<typename TValue>
void TaskEnergyEstimator::printPerPathValues(
    const std::map<std::string, std::map<std::string, std::map<PathId, TValue> > > &m)
{
  // Print the dataset for diagnostic purposes
  for (auto pathCountsEntry = m.begin();
       pathCountsEntry != m.end(); pathCountsEntry++) {
    DEBUG(dbgs() << "func " << pathCountsEntry->first << ":\n");
    const auto& taskPathCounts = pathCountsEntry->second;
    for (auto taskEntry = taskPathCounts.begin();
              taskEntry != taskPathCounts.end(); ++taskEntry) {
        DEBUG(dbgs() << "  task " << taskEntry->first << ":\n");
        const auto &pathEntries = taskEntry->second;
        for (auto pathEntry = pathEntries.begin();
                  pathEntry != pathEntries.end(); ++pathEntry) {
          DEBUG(dbgs() << "    path " << pathEntry->first << ": "
                       << pathEntry->second << "\n");
        }
    }
  }
}

std::string TaskEnergyEstimator::formatFuncPath(const std::vector<FuncPathElem> &funcPath)
{
  std::ostringstream str;
  for (auto funcPathElem = funcPath.begin(); funcPathElem != funcPath.end();
      ++funcPathElem) {

    switch (funcPathElem->Type) {
      case FuncPathElem::FUNC_PATH_ELEM_TYPE_TASK:
        for (auto taskPathElem = funcPathElem->TaskPath.begin();
            taskPathElem != funcPathElem->TaskPath.end();
            ++taskPathElem) {
          str << taskPathElem->Node->getName()
            << "(" << taskPathElem->Energy.Mean
            << " " << taskPathElem->Energy.Var
            << ")+";
        }
        break;
      case FuncPathElem::FUNC_PATH_ELEM_TYPE_LOOP:
        for (auto loopPathsElem = funcPathElem->LoopPaths.begin();
            loopPathsElem != funcPathElem->LoopPaths.end();
            ++loopPathsElem) {
          for (auto loopPathElem = loopPathsElem->LoopPath.begin();
              loopPathElem != loopPathsElem->LoopPath.end(); ++loopPathElem) {
            str << loopPathElem->Node->getName()
              << "(" << loopPathElem->Energy.Mean
              << " " << loopPathElem->Energy.Var
              << ")+";
          }
          str << "{" << loopPathsElem->Energy.Mean
              << " " << loopPathsElem->Energy.Var
              << " " << loopPathsElem->PathFreq
              << " " << loopPathsElem->IterCount
              << " " << loopPathsElem->NumExecutions
              << "}|";
        }
        break;
    }
    str << " [" << funcPathElem->Energy.Mean
        << " " << funcPathElem->Energy.Var << "];";
  }

  return str.str();
}



#ifdef CALCULATE_TASK_PATH_PROB
float TaskEnergyEstimator::lookupTaskPathFreq(Function &F, Task *task, unsigned pathId,
    PathFreqMap pathFreqs)
{

  DEBUG(dbgs() << "looking up freq for func " << F.getName()
               << " task " << task->getName() << " pathId " << pathId << "\n");

  const auto &funcPathFreqsIter = pathFreqs.find(F.getName());
  assert(funcPathFreqsIter != pathFreqs.end() &&
      "Function not found in path freq dataset.");
  const auto &funcPathFreqs = funcPathFreqsIter->second;
  const auto &taskPathFreqs = funcPathFreqs.find(task);
  assert(taskPathFreqs != funcPathFreqs.end() &&
      "Task not found in path freq dataset.");
  const auto taskPathFreq = taskPathFreqs->second.find(pathId);
  assert(taskPathFreq != taskPathFreqs->second.end() &&
      "Path not found in path freq dataset.");

  return taskPathFreq->second;
}
#endif // CALCULATE_TASK_PATH_PROB

void TaskEnergyEstimator::estimateLoopEnergy(
    EnergyDist &taskEnergy,
    Task *task,
    BallLarusNode *node,
    unsigned pathId, /* by value! copies must be stacked*/
    EnergyDist pathEnergy, /* by value! copies must be stacked */
    unsigned loopIterCount,
    std::vector<TaskPathElem> loopPath,
    std::vector<LoopPathElem> &loopPaths,
    const TaskPathFreqMap &taskPathFreqs)
{

  const auto &thisBlockEnergy = blockEnergyProfile.lookup(node);

  pathEnergy.Mean += thisBlockEnergy.Mean;
  pathEnergy.Var += thisBlockEnergy.Var;

  if (RecordPaths)
    loopPath.push_back(TaskPathElem(node, thisBlockEnergy));

  DEBUG(dbgs() << "estimate task energy: "
               << " block " << node->getBlock()->getName() << ": energy: "
               << " mean " << thisBlockEnergy.Mean
               << " var " << thisBlockEnergy.Var << "; "
               << " path energy " << pathEnergy.Mean << "\n");

  bool leafNode = true;
  for (auto childEdge = node->succBegin(); childEdge != node->succEnd();
       ++childEdge) {

    if (!(*childEdge)->getDst()->IsTaskEntry) {
      leafNode = false; 
      estimateLoopEnergy(taskEnergy, task, (*childEdge)->getDst(),
                         pathId + (*childEdge)->Weight, pathEnergy,
                         loopIterCount, loopPath, loopPaths, taskPathFreqs);
    }
  }

  if (leafNode) {  // end of path => pathId is valid
      //assert(pathId < pathEnergies.size() && "Path energy array has wrong size");
      //pathEnergies[pathId].Mean = pathEnergy.Mean;
      //pathEnergies[pathId].Var = pathEnergy.Var;
      // TODO: should this use lookupTaskPathFreq ?
      DEBUG(dbgs() << "looking up freq for path: "
                   << "(task " << task->getName() << ") pathId " << pathId << "\n");
      const auto pathFreq = taskPathFreqs.find(pathId);
      assert(pathFreq != taskPathFreqs.end() &&
             "Path not found in path freq dataset.");


      // We effectively "unroll" the loop iterations
      //
      // TODO: To get the numer of times a loop path executed, we can either
      // use the declared loop iteration count scaled by the path frequency, or
      // use the measured counts directly.
      unsigned numPathExecutions = pathFreq->second * loopIterCount;
      taskEnergy.Mean += numPathExecutions * pathEnergy.Mean;
      taskEnergy.Var += numPathExecutions * pathEnergy.Var;

      if (RecordPaths)
        loopPaths.push_back(LoopPathElem(loopPath, pathEnergy,
                                         pathFreq->second, loopIterCount,
                                         numPathExecutions));

      DEBUG(dbgs() << "Task " << task->getName() << ":"
                   << " path freq " << pathFreq->second
                   << " num execs " << numPathExecutions
                   << " path e (" << pathEnergy.Mean << ", " << pathEnergy.Var << ")"
                   << " => e += (" << taskEnergy.Mean << ", " << taskEnergy.Var << ")\n");
  }
}

void TaskEnergyEstimator::estimateTaskEnergies(
    Task * task, /* task whose energy we are estimating (real task, not pseudo) */
    unsigned &funcPathId, /* just a counter */
    EnergyDist funcPathEnergy, float funcPathProb, /* by value! each level has its own */
    std::vector<FuncPathElem> funcPath,
    BallLarusNode *node,
    Task* subTask, /* task that owns the path section being traversed, could be a pseudo-task */
    unsigned taskPathId, /* by value! copies must be stacked*/
    EnergyDist taskPathEnergy, /* by value! copies must be stacked */
    unsigned taskPathDepth, std::vector<TaskPathElem> taskPath,
    const PathFreqMap &pathFreqs)
{
  assert(task && "No task for which energy is estimated");
  assert(node && "Attempted to estimate energy on a NULL node");

  DEBUG(dbgs() << "estimate energy: traversing block "
               << "'" << node->getBlock()->getName() << "': "
               << "task entry " << node->IsTaskEntry << "\n"
               << " func path e (" << funcPathEnergy.Mean << ", "<< funcPathEnergy.Mean << ")"
               << " func path prob " << funcPathProb <<  "\n"
               << "  sub task " << subTask->getName()
               << " task path id " << taskPathId
               << " task path e " << taskPathEnergy.Mean
               << " task path depth " << taskPathDepth << "\n");

  // Did we cross a task boundary when we reached this node?
  // (Not all of thes are base cases -- we recur if this node is a loop entry.)
  // TODO: handle real task boundaries that correspond to fake ones
  if (node->IsTaskEntry && taskPathDepth > 0 /* first boundary is not path end */) {

    assert(node->TaskObj != NULL && "Task entry node without a task object");

#ifdef CALCULATE_TASK_PATH_PROB
    const auto taskPathFreq = lookupTaskPathFreq(subTask, taskPathId, funcPathFreqs);
#endif

    DEBUG(dbgs() << "reached end of path section at block "
        << node->getBlock()->getName() << ":\n"
        << "  task: " << subTask->getName() << " path id " << taskPathId
#ifdef CALCULATE_TASK_PATH_PROB
        << " freq " << taskPathFreq
#endif
        << " e " << taskPathEnergy.Mean << "\n"
        << " func: path e (" << funcPathEnergy.Mean << ", "<< funcPathEnergy.Mean << ") "
#ifdef CALCULATE_TASK_PATH_PROB
        << " path prob " << funcPathProb
#endif
        << " task path prob sum " << task->PathProbSum << "\n");

    // Assumption: branches are independent at (pseudo) task boundaries
    // I.e. when we cross a pseudo boundary, we lose correlation information.
#ifdef CALCULATE_TASK_PATH_PROB
    funcPathProb *= taskPathFreq;
#endif

    funcPathEnergy.Mean += taskPathEnergy.Mean;
    funcPathEnergy.Var += taskPathEnergy.Var;

    if (RecordPaths)
        funcPath.push_back(FuncPathElem(taskPath, taskPathEnergy));

    DEBUG(dbgs() << " updating func path: "
        << " e (" << funcPathEnergy.Mean << ", " << funcPathEnergy.Var << ")"
#ifdef CALCULATE_TASK_PATH_PROB
        << " prob " << funcPathProb
#endif
        << "\n");

    // Reset task path because we just crossed a task boundary
    subTask = node->TaskObj;
    taskPathId = 0;
    taskPathEnergy.Mean = 0;
    taskPathEnergy.Var = 0;
    taskPathDepth = 0;
    if (RecordPaths)
      taskPath.clear();

    // function leaf node or true task boundary? i.e. end of path through func
    if (!node->IsLoopEntry) {
      DEBUG(dbgs() << "reached end of path through function\n");

      DEBUG(dbgs() << "task " << task->Dag->getEntry()->getBlock()->getName() << ": "
          << " func e prob sum " << task->PathProbSum << "\n");

#ifdef CALCULATE_TASK_PATH_PROB
      task->PathProbSum += funcPathProb;
#endif

      DEBUG(dbgs() << "   updated " << " func prob sum " << task->PathProbSum << "\n");

      funcEnergyFile << task->Id << "," << funcPathId << ","
          << std::scientific
          << std::setprecision(std::numeric_limits<double>::digits10)
          << funcPathEnergy.Mean << "," << funcPathEnergy.Var
#ifdef CALCULATE_TASK_PATH_PROB
          << "," << funcPathProb
#endif
          ;

       if (RecordPaths)
          funcEnergyFile << ",\"" << formatFuncPath(funcPath) << "\"";

       funcEnergyFile << "\n";

      funcPathId++;

      // We have crossed a real task boundary: reset accumulator and its owning task
      task = node->TaskObj;
      funcPathEnergy.Mean = 0;
      funcPathEnergy.Var = 0;
      funcPathProb = 1;
      if (RecordPaths)
        funcPath.clear();

      // Keep going, process other real tasks (children of this node)

    } else { // loop entry

      assert(node->IsLoopEntry);

      EnergyDist loopEnergy;
      PathId loopTaskPathId = 0;
      EnergyDist loopTaskPathEnergy;

      // The loop corresponds to a pseudo-task and its energy cost is
      // abstracted into one expected value. The following call
      // calculates the expected energy cost of the loop.

      // NOTE: We assume loops have a unique successor (i.e. no exits from the loop)

      assert(node->TaskObj->Dag != NULL && "A task object without a DAG");
      assert(node->LoopExitNode && "Loop without a loop exit node");

      DEBUG(dbgs() << "computing energy of loop task: "
          << node->getBlock()->getName() << " -> "
          << node->LoopExitNode->getBlock()->getName() << "\n");

      // NOTE: When cross checking the loop iter count with the path counts from
      // the path frequency profile, the loop iterations will be off by one: the
      // loop entry boundary is crossed once when exiting from the loop, so
      // there will be an extra count per iteration. That count does not
      // consume the energy of the whole loop, but only of the loop header
      // (the condition evaluation).
      //
      // TODO: To be more precise, we should add the loop header cost to the
      // total.
      //
      unsigned loopIterCount = lookupLoopIterCount(this, node->getBlock());

      const auto &funcPathFreqsIter = pathFreqs.find(node->getFunc()->getName());
      assert(funcPathFreqsIter != pathFreqs.end() &&
          "Function not found in path freqs dataset.");
      const auto &funcPathFreqs = funcPathFreqsIter->second;
      const auto taskPathFreqs = funcPathFreqs.find(node->TaskObj->getName());
      assert(taskPathFreqs != funcPathFreqs.end() &&
          "Task not found in path freqs dataset.");

      std::vector<TaskPathElem> loopPath;
      std::vector<LoopPathElem> loopPaths;

      estimateLoopEnergy(loopEnergy, node->TaskObj,
          node->TaskObj->Dag->getEntry(),
          loopTaskPathId, loopTaskPathEnergy, loopIterCount,
          loopPath, loopPaths,
          taskPathFreqs->second);

      // Add the cost of the loop to the cost of the path through the
      // *real* task. Th loop cost is summarized by a normal distribution.
      // Even if the loop consists of multiple paths with different cost each
      // (a modal distribution), the average is normally distributed (by CLT).
      // The caveat is that the average is not really desirable, because
      // none of the instances of the (whole) loop consume an amount of energy
      // equal to the average. But, we have no better solution at this point.
      funcPathEnergy.Mean += loopEnergy.Mean;
      funcPathEnergy.Var += loopEnergy.Var;

      if (RecordPaths)
        funcPath.push_back(FuncPathElem(loopPaths, loopEnergy));

      DEBUG(dbgs() << "loop task: "
          << node->getBlock()->getName() << " -> "
          << node->LoopExitNode->getBlock()->getName() << ": "
          << "energy (" << loopEnergy.Mean << ", " << loopEnergy.Var << ") "
          << " iters " << loopIterCount
          << "; func e (" << funcPathEnergy.Mean << ", " << funcPathEnergy.Var << ")\n");

      // NOTE: funcPathProb does not change because the loop has a unique entry
      // and a unique exit node (i.e. by going into the loop, we're not
      // taking a branch; and we don't take branches *at the function level
      // of abstraction* as we branch inside the loop body.).

      assert(node->LoopExitNode && "A loop entry node without a loop exit node.");

      DEBUG(dbgs() << "traversing path segment at "
          << node->LoopExitNode->getBlock()->getName() << "\n");

      // Add the cost of the remainder of the path through the function
      // that follows the loop (until function return -- TODO: until task boundary)

      Task *succTask = node->LoopExitNode->TaskObj;

      assert(succTask != NULL &&
          "Loop successor task node without a task object.");

      // NOTE: we assume that there is always a block that follows a loop

      estimateTaskEnergies(task,
          funcPathId, funcPathEnergy, funcPathProb, funcPath,
          node->LoopExitNode, succTask, taskPathId, taskPathEnergy,
          /* task path length */ 0, taskPath, pathFreqs);

      // The two recursive cases are either call on the loop successor (above)
      // or the call to on a child (below, inside the for loop)
      return;
    }
  }

  const auto &thisBlockEnergy = blockEnergyProfile.lookup(node);

  taskPathEnergy.Mean += thisBlockEnergy.Mean;
  taskPathEnergy.Var += thisBlockEnergy.Var;

  if (RecordPaths)
    taskPath.push_back(TaskPathElem(node, thisBlockEnergy));

  DEBUG(dbgs() << "continuing traversal through task: "
               << "adding block '" << node->getBlock()->getName() << "'"
              << " mean energy " << thisBlockEnergy.Mean << "\n");

  for (auto childEdge = node->succBegin(); childEdge != node->succEnd();
      ++childEdge) {

    FuncBallLarusEdge *childFuncEdge = static_cast<FuncBallLarusEdge *>(*childEdge);

    DEBUG(dbgs() << "looking up increment for task " << subTask->getName()
                 << " for edge: "
                 << childFuncEdge->getSource()->getBlock()->getName() << "->"
                 << childFuncEdge->getDst()->getBlock()->getName() << "\n");

    assert(childFuncEdge->MultiWeight.find(subTask) !=
        childFuncEdge->MultiWeight.end() &&
        "Edge has no increment for parent task.");

    unsigned edgeIncrement = childFuncEdge->MultiWeight[subTask];

    DEBUG(dbgs() << "continuing traversal through task " << subTask->getName() << " onto block: "
        << (*childEdge)->getDst()->getBlock()->getName() << "\n"
        << "  edge weight " << edgeIncrement << "\n");

    DEBUG(dbgs() << "recursive call on block "
        << (*childEdge)->getDst()->getBlock()->getName()
        << ": continue through task\n");

    // Add the cost of the remainter of the path through the current
    // pseudo-task and then add the cost of the remainter of the path
    // through the function (until a task boundary).
    estimateTaskEnergies(task,
        funcPathId, funcPathEnergy, funcPathProb, funcPath,
        (*childEdge)->getDst(),
        subTask, taskPathId + edgeIncrement, taskPathEnergy,
        taskPathDepth + 1, taskPath, pathFreqs);
  }

  if (node->succBegin() == node->succEnd()) { // no children

#ifdef CALCULATE_TASK_PATH_PROB
    const auto taskPathFreq = lookupTaskPathFreq(subTask, taskPathId, funcPathFreqs);
#endif

    DEBUG(dbgs() << "reached end of path (leaf node):\n"
        << "  task: " << subTask << " path id " << taskPathId
#ifdef CALCULATE_TASK_PATH_PROB
        << " freq " << taskPathFreq
#endif
        << " e " << taskPathEnergy.Mean << "\n"
        << "  func: path e (" << funcPathEnergy.Mean << ", " << funcPathEnergy.Var << ")"
        << " path prob " << funcPathProb
        << " task path prob sum " << task->PathProbSum << "\n");

#ifdef CALCULATE_TASK_PATH_PROB
    funcPathProb *= taskPathFreq;
#endif

    funcPathEnergy.Mean += taskPathEnergy.Mean;
    funcPathEnergy.Var += taskPathEnergy.Var;

    if (RecordPaths)
      funcPath.push_back(FuncPathElem(taskPath, taskPathEnergy));

    funcEnergyFile << task->Id << "," << funcPathId << ","
         << std::scientific
         << std::setprecision(std::numeric_limits<double>::digits10)
         << funcPathEnergy.Mean << "," << funcPathEnergy.Var
#ifdef CALCULATE_TASK_PATH_PROB
         << "," << funcPathProb
#endif
         ;

    if (RecordPaths)
      funcEnergyFile << ",\"" << formatFuncPath(funcPath) << "\"";

    funcEnergyFile << "\n";

    funcPathId++;

#ifdef CALCULATE_TASK_PATH_PROB
    task->PathProbSum += funcPathProb;
#endif

    DEBUG(dbgs() << " updated task e: "
        << " path e (" << funcPathEnergy.Mean << ", " << funcPathEnergy.Var << ")"
#ifdef CALCULATE_TASK_PATH_PROB
        << " path prob " << funcPathProb
        << " path prob sum: " << task->PathProbSum
#endif
        << "\n");
  }
}

// Find first task boundary: skip any nodes before a boundary, since they
// don't belong to any task. Such nodes might exist even if we place a task
// boundary as the first line in the function.
void TaskEnergyEstimator::callEstimateTaskEnergies(BallLarusNode *node,
        std::set<BallLarusNode *> &nodes, const PathFreqMap &pathFreqs)
{
  DEBUG(dbgs() << "callEstimateTaskEnergies: node "
               << node->getBlock()->getName()
               << "is task " << node->IsTaskEntry << "\n");

  nodes.insert(node);

  if (node->IsTaskEntry) { // found a task
      unsigned funcPathId;
      Task *task = node->TaskObj;
      assert(task != NULL && "Task node without a task object.");

      // State needed by the recursive call
      EnergyDist funcPathEnergy;
      float funcPathProb = 1;
      PathId taskPathId = 0;
      EnergyDist taskPathEnergy;
      std::vector<FuncPathElem> funcPath;
      std::vector<TaskPathElem> taskPath;

      // Launch the estimator starting at this task (it will continue to other tasks)
      estimateTaskEnergies(task, funcPathId, funcPathEnergy, funcPathProb, funcPath,
                         node, node->TaskObj, taskPathId, taskPathEnergy,
                         /* taskPathDepth */ 0, taskPath, pathFreqs);
  } else { // skip this block, it's not part of any task
      for (auto child = node->childBegin(); child != node->childEnd(); ++child) {
        // don't follow backedges and don't retrace steps 
        if (nodes.find(*child) == nodes.end()) {
            DEBUG(dbgs() << "callEstimateTaskEnergies: recurring to node "
                         << (*child)->getBlock()->getName() << "\n");
            callEstimateTaskEnergies(*child, nodes, pathFreqs);
        }
      }
  }
}

bool TaskEnergyEstimator::runOnModule(llvm::Module &M) {

  Function *entryFunc = getEntryFunction(M);

  DEBUG(dbgs() << "Constructing CFG for module " << M.getName()
               << " entry func " << entryFunc->getName() << "\n");

  FuncBallLarusDag dag(&entryFunc->getEntryBlock(), this, stripExtension(M.getName()));

  DEBUG(dbgs() << "Calculating program energy...\n");

  std::set<BallLarusNode *> nodes;
  callEstimateTaskEnergies(dag.getEntry(), nodes, pathFreqs);

  return false;
}

void TaskEnergyEstimator::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}

char TaskEnergyEstimator::ID = 0;
static RegisterPass<TaskEnergyEstimator> X("estimate-task-energy",
    "Estimate task energy based on measured path frequency profile "
    "and energy of each basic block");

} // namespace edbprof
