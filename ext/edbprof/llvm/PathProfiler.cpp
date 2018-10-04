#include <algorithm>

#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/TinyPtrVector.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DIBuilder.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include "BallLarusGraph.h"
#include "AddIncFunc.h"
#include "Tasks.h"
#include "CLI.h"

#include "PathProfiler.h"

using namespace llvm;
using namespace edbprof;

#define DEBUG_TYPE "PathProfiler"

namespace {

const char *IncPathCountFuncName = "__edbprof_pathprof__inc_pathcount";

//static Function* IncPathCountFunc = NULL;

Function *declareIncPathCountFunc(Module &M) {
  LLVMContext &ctx = M.getContext();

  // Prototype: inc(u16* memloc)
  // Increments the value at memory location and halts (inf loop) on overflow

  auto I16 = IntegerType::get(ctx, 16);
  PointerType* intPtrType = PointerType::get(I16, 0);
  PointerType* intPtrPtrType = PointerType::get(intPtrType, 0);

  TinyPtrVector<Type *> argsTy;
  argsTy.push_back(intPtrPtrType);
  argsTy.push_back(I16);
  argsTy.push_back(I16);
  auto retTy = Type::getVoidTy(ctx);
  auto funcTy = FunctionType::get(retTy, argsTy, /* isVarArg */ false);

  auto func = Function::Create(funcTy, GlobalValue::ExternalLinkage,
                               IncPathCountFuncName, &M);
  func->setCallingConv(CallingConv::C);

  return func;
}

// This one takes an global variable that is an array
Value *issueGlobalArrayVarAddr(IRBuilder<>& builder, Value *var, Value *idx) {
  DEBUG(dbgs() << "GEP addr <- " << var->getName()
               << "[" << idx->getName() << "]\n");
  Type *I16 = Type::getInt16Ty(builder.getContext());
  SmallVector<Value *, 2> indexes(2);
  indexes[0] = ConstantInt::get(I16, 0); // resolve the global "pointer"
  indexes[1] = idx;
  return builder.CreateGEP(var, indexes);
}

#if 0 // unused
// This one takes a pointer to an array
Value *issueGlobalArrayPtrAddr(IRBuilder<>& builder, Value *array, Value *idx) {
  DEBUG(dbgs() << "GEP addr <- " << array->getName()
               << "[" << idx->getName() << "]\n");
  SmallVector<Value *, 1> indexes(1);
  indexes[0] = idx;
  return builder.CreateGEP(array, indexes);
}
#endif

Value *issueIndirectGlobalArrayAddr(IRBuilder<>& builder,
                                    Value *arrayVar, Value *idxAddr) {
  DEBUG(dbgs() << "LOAD val <- *" << arrayVar->getName() << "\n");
  auto idxVal = builder.CreateLoad(idxAddr);
  return issueGlobalArrayVarAddr(builder, arrayVar, idxVal);
}

#if 0 // unused
Value *issueIndirectX2GlobalArrayAddr(IRBuilder<>& builder, Value *outerArrayVar,
                                      Value *outerIdxAddr, Value *innerIdxAddr) {

  DEBUG(dbgs() << "outerArrayVar: "); outerArrayVar->getType()->dump(); DEBUG(dbgs() << "\n");

  DEBUG(dbgs() << "LOAD outerIdxVal <- *" << outerArrayVar->getName() << "\n");
  auto outerIdxVal = builder.CreateLoad(outerIdxAddr, "outerIdxVal");

  auto outerElemAddr = issueGlobalArrayVarAddr(builder, outerArrayVar, outerIdxVal);
  DEBUG(dbgs() << "outerElemAddr: "); outerElemAddr->getType()->dump(); DEBUG(dbgs() << "\n");

  auto innerArrayAddr = builder.CreateLoad(outerElemAddr, "innerArrayAddr");
  DEBUG(dbgs() << "innerArrayAddr: "); innerArrayAddr->getType()->dump(); DEBUG(dbgs() << "\n");

  DEBUG(dbgs() << "LOAD innerIdxVal <- *innerIdxAddr\n");
  auto innerIdxVal = builder.CreateLoad(innerIdxAddr, "innerIdxVal");

  auto innerElemAddr = issueGlobalArrayPtrAddr(builder, innerArrayAddr, innerIdxVal);
  DEBUG(dbgs() << "intterelemAddr: "); innerElemAddr->getType()->dump(); DEBUG(dbgs() << "\n");

  return innerElemAddr;
}
#endif

Instruction *instrumentWithSet(IRBuilder<> &builder, Value *addr, int value) {

  DEBUG(dbgs() << "STORE " << addr->getName() << " <- " << value << "\n");
  Type *I16 = Type::getInt16Ty(builder.getContext());
  auto val = llvm::ConstantInt::get(I16, value);
  return builder.CreateStore(val, addr);
}

#if 0 // unused
Instruction *instrumentWithInc(IRBuilder<> &builder, Value *addr, int inc) {

  DEBUG(dbgs() << "LOAD val <- *" << addr->getName() << "\n");
  Value *val = builder.CreateLoad(addr);

  DEBUG(dbgs() << "ADD sum <- val + " << inc << "\n");
  Type *I16 = Type::getInt16Ty(builder.getContext());
  Value *increment = llvm::ConstantInt::get(I16, inc);
  Value *sum = builder.CreateAdd(val, increment);

  DEBUG(dbgs() << "STORE addr <- sum\n");
  return builder.CreateStore(sum, addr);
}
#endif

Instruction *instrumentWithIndirectInc(IRBuilder<> &builder, Value *addr,
                                    Value *incIndirArray, Value *incIdx) {

  Value *incAddr = issueIndirectGlobalArrayAddr(builder, incIndirArray, incIdx);

  DEBUG(dbgs() << "LOAD addrVal <- *" << addr->getName() << "\n");
  Value *addrVal = builder.CreateLoad(addr);

  DEBUG(dbgs() << "LOAD addrVal <- *" << addr->getName() << "\n");
  Value *incVal = builder.CreateLoad(incAddr);

  DEBUG(dbgs() << "ADD sum <- addrVal + incVal\n");
  DEBUG(dbgs() << "addrVal type: "); DEBUG(addrVal->getType()->dump());
  DEBUG(dbgs() << "incVal type: "); DEBUG(incVal->getType()->dump());
  DEBUG(dbgs() << "\n");
  Value *sum = builder.CreateAdd(addrVal, incVal);

  DEBUG(dbgs() << "STORE addr <- sum\n");
  return builder.CreateStore(sum, addr);
}

#if 0 // unused
Instruction *issueIncCall(IRBuilder<> &builder, Value *addr, Module *mod)
{
  DEBUG(dbgs() << "CALL " << IncPathCountFuncName << "(pathcounts[])\n");

  auto addFunc = mod->getFunction(IncPathCountFuncName);
  if (!addFunc)
    addFunc = declareIncPathCountFunc(*mod);

  TinyPtrVector<Value *> incParams;
  incParams.push_back(addr);
  return builder.CreateCall(addFunc, incParams);
}

Instruction *instrumentWithIncIndirectArrayElement(IRBuilder<> &builder, Module *mod,
                 Value *arrayVar, Value *idxAddr) {
  auto addr = issueIndirectGlobalArrayAddr(builder, arrayVar, idxAddr);
  return issueIncCall(builder, addr, mod);
}
#endif

Instruction *instrumentWithIncIndirectX2ArrayElement(IRBuilder<> &builder, Module *mod,
                 Value *pathCountsArray, Value *taskRegAddr, Value *pathRegAddr) {

  auto addFunc = mod->getFunction(IncPathCountFuncName);
  if (!addFunc)
    addFunc = declareIncPathCountFunc(*mod);

  DEBUG(dbgs() << "LOAD taskIdxVla <- *taskRegAddr\n");
  auto taskIdx = builder.CreateLoad(taskRegAddr, "taskIdx");

  DEBUG(dbgs() << "LOAD pathIdxVla <- *pathRegAddr\n");
  auto pathIdx = builder.CreateLoad(pathRegAddr, "taskId");

  DEBUG(dbgs() << "pathCountsArray: "); DEBUG(pathCountsArray->getType()->dump());

  DEBUG(dbgs() << "GEP addr <- " << pathCountsArray->getName() << "[0, 0]\n");

  Type *I16 = Type::getInt16Ty(builder.getContext());
  auto zero = ConstantInt::get(I16, 0); // resolve the global "pointer"
  SmallVector<Value *, 2> indexes(2);
  indexes[0] = zero;
  indexes[1] = zero;
  Value *pathCountsArrayAddr = builder.CreateGEP(pathCountsArray, indexes);

  DEBUG(dbgs() << "pathCountsArrayAddr: "); DEBUG(pathCountsArrayAddr->getType()->dump());
  DEBUG(dbgs() << "taskIdx: "); DEBUG(taskIdx->getType()->dump());
  DEBUG(dbgs() << "pathIdx: "); DEBUG(pathIdx->getType()->dump());

  DEBUG(dbgs() << "CALL " << IncPathCountFuncName << "(pathcounts, task reg, path reg)\n");

  TinyPtrVector<Value *> incParams;
  incParams.push_back(pathCountsArrayAddr);
  incParams.push_back(taskIdx);
  incParams.push_back(pathIdx);
  return builder.CreateCall(addFunc, incParams);
}

} // namespace

namespace edbprof {

const char *PathProfiler::PathRegSymName = "__edbprof_pathreg__";
const char *PathProfiler::PathCountsPtrsSymName = "__edbprof_pathcounts_ptrs__";
const char *PathProfiler::PathCountsSymName = "__edbprof_pathcounts__";
const char *PathProfiler::TaskSymName = "__edbprof_task__";
const char *PathProfiler::IncIndirSymName = "__edbprof_incindir__";

const char *PathProfiler::TaskBoundaryFuncName = "edbprof__task_boundary"; // TODO: add __

const char *PathProfiler::InstrumentationPrefix = "INSTRUMENT.";
const char *PathProfiler::ReturnPrefix = "RET.";

PathProfiler::PathProfiler() : FunctionPass(ID)
{
  taskIdsFile.open(TaskIdsFilename);
  taskIdsFile << "func,task_id,task_name\n"; // CSV header
}

PathProfiler::~PathProfiler()
{
  taskIdsFile.close();
}

BasicBlock *PathProfiler::spliceEdge(BallLarusEdge *edge)
{
    auto newBlock = SplitEdge(edge->getSource()->getBlock(),
                              edge->getDst()->getBlock(),
                              nullptr, nullptr);

    // If destination got split (i.e. destination's instructions got moved into
    // a new block), then we should instrument the old (now empty) destination
    // block, not the newly created block. Also, if that is the case, we need
    // to update the block pointer in the destination node. Note that when
    // source gets split, we don't need to update the source node.
    BasicBlock *instrumBlock;
    if (newBlock->getSinglePredecessor() == edge->getDst()->getBlock()) {
      instrumBlock = edge->getDst()->getBlock();
      edge->getDst()->setBlock(newBlock);
    } else {
      instrumBlock = newBlock;
    }

    instrumBlock->setName(InstrumentationPrefix + instrumBlock->getName());

    return instrumBlock;
}

// TODO: should this be done as part of constructing the task DAG?
void PathProfiler::findTaskExits(TaskBallLarusDag *dag, BallLarusNode *node,
                                 std::vector<BallLarusNode *>& exits)
{
  if (node->succBegin() == node->succEnd()) { // leaf?
    exits.push_back(node);
  } else {
    for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
      findTaskExits(dag, (*succ)->getDst(), exits);
    }
  }
}

void PathProfiler::instrumentFunctionExits(BasicBlock *block,
                                           std::vector<BasicBlock *> &path,
                                           std::set<BasicBlock *> &returnBlocks,
                                           Module *mod, GlobalVariable *pathCounts,
                                           Value *taskReg, Value *pathReg)
{
  if (ReturnInst::classof(block->getTerminator()) &&
      returnBlocks.find(block) == returnBlocks.end()) {

    DEBUG(dbgs() << "Instrumenting func return: " << block->getName() << "\n");

    // First, split the return instruction into its own block

    std::string leafBlockName = block->getName();

    TerminatorInst *termInst = block->getTerminator();
    assert(termInst && "Exit block has no terminator instruction");

    BasicBlock *retBlock = block->splitBasicBlock(termInst);

    // Then, splice the edge to the block with the return instruction,
    // creating another block that will hold the instrumentation.

    BasicBlock *instrumBlock = retBlock; // this block will become the instrumentation block
    termInst = retBlock->getTerminator();
    retBlock = retBlock->splitBasicBlock(termInst);
    retBlock->setName(ReturnPrefix + leafBlockName);
    instrumBlock->setName(InstrumentationPrefix + leafBlockName);

    // Insert instrumentation to increment the path count, like on a task boundary
    IRBuilder<> builder(instrumBlock->getFirstInsertionPt());
    instrumentWithIncIndirectX2ArrayElement(builder, mod, pathCounts, taskReg, pathReg);

    // We must keep track of the return blocks we found, to not re-instrument them,
    // since the same block may be reachable via different paths.
    returnBlocks.insert(retBlock);

  } else {

    path.push_back(block);

    for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
      if (std::find(path.rbegin(), path.rend(), *succ) == path.rend()) {
        instrumentFunctionExits(*succ, path, returnBlocks,
                                mod, pathCounts, taskReg, pathReg);
      }
    }

    path.pop_back();
  }
}

void PathProfiler::instrumentEdges(Function &F, FuncBallLarusDag &dag)
{
  auto mod = F.getParent();

  // After split, this ref will point to an empty block that will hold instrum
  auto entryInstrumBlock = dag.getEntry()->getBlock();
  const std::string entryBlockName = entryInstrumBlock->getName();
  entryInstrumBlock->setName(InstrumentationPrefix + entryBlockName);

  // split returns a ref to the block with original instructions
  auto entryBlock = entryInstrumBlock->splitBasicBlock(entryInstrumBlock->begin(), entryBlockName);
  IRBuilder<> Builder(entryInstrumBlock->getFirstInsertionPt());

  // Hacky.. we need to update the pointer in our data structure
  // TODO: perhaps one solution is to wrap the block into yet another object
  // that would be shared by the nodes in per-function and in per-task dags.
  dag.getEntry()->setBlock(entryBlock);
  if (dag.getEntry()->TaskObj != NULL) {
    DEBUG(dbgs() << "updating block reference in task dag for block: "
                 << entryBlock->getName() << "\n");
    dag.getEntry()->TaskObj->Dag->getEntry()->setBlock(entryBlock);
  }

  Type *I16 = Type::getInt16Ty(Builder.getContext());

  DEBUG(dbgs() << "Allocating increment path count arrays\n");

  // 2D array: task id -> path id -> count

  Twine pathCountsGlobalName(Twine(PathCountsPtrsSymName) + F.getName());

  PointerType* Int16PtrType = PointerType::get(IntegerType::get(mod->getContext(), 16), 0);
  ArrayType *Int16PtrArrayType = ArrayType::get(Int16PtrType, dag.getTasks().size());

  GlobalVariable *pathCounts = new GlobalVariable(
      *F.getParent(), Int16PtrArrayType, /* const */ false,
      GlobalValue::ExternalLinkage,
      /* initilizer, set in loop below */ 0,
      pathCountsGlobalName);

  // For static lookup of second level array (when we know the task id statically)
  std::map<Task *, GlobalVariable *> pathCountsArrays;

  std::vector<Constant*> pathCountsInitializerElems;

  for (auto task = dag.getTasks().begin(); task != dag.getTasks().end(); ++task) {
    // A global partly because we need to be able to retrieve it via EDB by reading mem
    Twine taskPathCountsGlobalName(
            Twine(PathCountsSymName) + F.getParent()->getName() + "__" +
            F.getName() + "__" + Twine((*task)->Id));

    Type *AI16 = ArrayType::get(Builder.getInt16Ty(),
                                (*task)->Dag->getEntry()->getNumPaths());
    GlobalVariable *taskPathCounts = new GlobalVariable(
        *F.getParent(), AI16, /* const */ false, GlobalValue::ExternalLinkage,
        ConstantAggregateZero::get(AI16), taskPathCountsGlobalName);

    // Construct initializer element (a pointer to this task's array of counts)
    ConstantInt* zeroIdx = ConstantInt::get(mod->getContext(), APInt(32, StringRef("0"), 10));
    std::vector<Constant*> taskPathCountsIdxes;
    taskPathCountsIdxes.push_back(zeroIdx);
    taskPathCountsIdxes.push_back(zeroIdx);
    Constant* taskPathCountsPtr =
      ConstantExpr::getGetElementPtr(AI16, taskPathCounts, taskPathCountsIdxes);
    pathCountsInitializerElems.push_back(taskPathCountsPtr);

    pathCountsArrays[*task] = taskPathCounts;
  }

  Constant* pathCountsInitializer =
    ConstantArray::get(Int16PtrArrayType, pathCountsInitializerElems);
  pathCounts->setInitializer(pathCountsInitializer);

  DEBUG(dbgs() << "Allocating increment indirection arrays\n");

  // Increment/weight indirection array: edge id -> [task id -> increment]
  // TODO: optimize by doing indirection only for edges with more than one weight
  std::map<EdgeId, GlobalVariable *> incIndirArrays;
  for (auto edge = dag.getEdges().begin();
            edge != dag.getEdges().end(); ++edge)
  {
    FuncBallLarusEdge *funcEdge = static_cast<FuncBallLarusEdge *>(*edge);
    Twine incIndirGlobalName(Twine(IncIndirSymName) + F.getName() + "__" + Twine((*edge)->Id));
    ArrayType *AI16 = ArrayType::get(Builder.getInt16Ty(), dag.getTasks().size());

    // Initialize the weight array with the weight values calculated earlier
    std::vector<Constant*> incIndirInitializerElems;

    assert(dag.getTasks().size() > 0 && "nothing to profile: no tasks");

    // Initialize every key of the map that maps: task -> weight
    for (auto task = dag.getTasks().begin(); task != dag.getTasks().end(); ++task) {

      unsigned weightVal;
      const auto &weightIter = funcEdge->MultiWeight.find(*task);
      if (weightIter != funcEdge->MultiWeight.end()) {
        weightVal = weightIter->second;
      } else {
        weightVal = 0;
      }

      Constant *weightConst = llvm::ConstantInt::get(I16, weightVal);
      incIndirInitializerElems.push_back(weightConst);
    }

    Constant* incIndirInitializer =
      ConstantArray::get(AI16, incIndirInitializerElems);

    GlobalVariable *incIndir = new GlobalVariable(
        *F.getParent(), AI16, /* const */ false, GlobalValue::ExternalLinkage,
        incIndirInitializer, incIndirGlobalName);
    incIndirArrays[funcEdge->Id] = incIndir;
  }

  Constant *zero = llvm::ConstantInt::get(I16, 0);

  DEBUG(dbgs() << "Allocating path register\n");

  // We (have to) rely on the optimizer to allocate this to a register
  Twine pathRegName(Twine(PathRegSymName) + F.getName());
  Value *pathReg = Builder.CreateAlloca(Builder.getInt16Ty(),
                                        /* init */ zero, /* NOTE: no effect! */
                                        pathRegName);

  DEBUG(dbgs() << "Allocating task id register\n");

  Twine taskRegName(Twine(TaskSymName) + F.getName());
  Value *taskReg = Builder.CreateAlloca(Builder.getInt16Ty(),
                                        /* init */ zero, /* NOTE: no effect! */
                                        taskRegName);


  // Manually initialize the registers, because the initializers
  // set in CreateAlloca above are not having any effect.
  //
  // TODO: initializing to 0 is not strictly correct. The first task (task idx
  // 0) is going to get an extra count, when the first boundary will be
  // crossed. One approach is to index tasks starting at 1, but that introduces
  // complexity in the index calculation. Perhaps we can try this approach
  // again after we switch to a C function.

  // Keep track of the ID of the currently executing task 
  instrumentWithSet(Builder, taskReg, 0);
  // Reset path register (accumulator for unique sum along a path)
  instrumentWithSet(Builder, pathReg, 0);

  DEBUG(dbgs() << "Instrumenting intra-task edges\n");

  for (auto edge = dag.getEdges().begin();
            edge != dag.getEdges().end(); ++edge) {
    assert((*edge)->getType() == BallLarusEdge::TYPE_REAL);

    FuncBallLarusEdge *funcEdge = static_cast<FuncBallLarusEdge *>(*edge);

    // Do not instrument zero-weight edges
    // NOTE: This is not just an optimization. First of all, having edge
    // instrumentation on an exit edge doesn't make sense (we're exiting the
    // task (and an exit edge is always an exit for any task which contains
    // that edge, because exit edge is defined by its destination having a task
    // boundary). Whether or not such instrumentation is harmful is not
    // immediately obvious, but let's not insert it in the first place.
    // TODO: ^^^ is this comment correct? There was a major bug (fixed)
    // that precisely added instrumentation to exit edges.
    if (std::all_of(funcEdge->MultiWeight.begin(), funcEdge->MultiWeight.end(),
                     [] (std::pair<Task *, unsigned> p)
                     { return p.second == 0; })) {
      continue;
    }

    DEBUG(dbgs() << "Instrumenting edge "
        << (*edge)->getSource()->getBlock()->getName() << " -> "
        << (*edge)->getDst()->getBlock()->getName()
        << ": r+={Inc(e)=inc[edge_id][task_id][path_sum]" << "}\n");

    auto instrumBlock = spliceEdge(*edge);
    IRBuilder<> builder(instrumBlock->getFirstInsertionPt());
    instrumentWithIndirectInc(builder, pathReg, incIndirArrays[(*edge)->Id], taskReg);
  }

  DEBUG(dbgs() << "Instrumenting task boundaries\n");

  for (auto task = dag.getTasks().begin(); task != dag.getTasks().end(); ++task) {

    DEBUG(dbgs() << "Instrumenting task " << (*task)->getName() << " id "
                 << (*task)->Id << "'"
                 << (*task)->Dag->getEntry()->getBlock()->getName() << "'\n");

    BallLarusNode *taskEntry = (*task)->Dag->getEntry();
    BasicBlock *taskEntryBlock = taskEntry->getBlock();

    // Normal task entry blocks include a task boundary instruction, but
    // fake task boundaries from loops do not insert a boundary instruction.
    auto boundaryInstr = taskEntryBlock->begin();
    if (boundaryInstr != taskEntryBlock->end() &&
           isTaskBoundaryInstr(boundaryInstr)) {
        boundaryInstr++;
    }

    // new block has old block's content, old block is empty
    const std::string taskEntryBlockName = taskEntryBlock->getName();
    taskEntryBlock->setName(InstrumentationPrefix + taskEntryBlockName);
    BasicBlock *createdBlock = taskEntryBlock->splitBasicBlock(boundaryInstr, taskEntryBlock->getName());
    createdBlock->setName(taskEntryBlockName);

    IRBuilder<> builder(taskEntryBlock->getFirstInsertionPt());

    if (!((*task)->IsEntry)) {

      // Increment the path counter for the preceding task that we just came from:
      //   pathCounts[taskReg][pathReg]++
      instrumentWithIncIndirectX2ArrayElement(builder, mod, pathCounts,
                                              taskReg, pathReg);
    } else {
      DEBUG(dbgs() << "task '" << (*task)->Dag->getEntry()->getBlock()->getName()
                   << "' is the entry task, no predecessor\n");
    }

    // Keep track of the ID of the currently executing task 
    instrumentWithSet(builder, taskReg, (*task)->Id);
    // Reset path register (accumulator for unique sum along a path)
    instrumentWithSet(builder, pathReg, 0);

    // Increment the path counter at the end of each path through the task
#if 0
    std::vector<BallLarusNode *> taskExits;
    findTaskExits((*task)->Dag, (*task)->Dag->getEntry(), taskExits);

    for (auto exit = taskExits.begin(); exit != taskExits.end(); ++exit) {
        DEBUG(dbgs() << "Instrumenting exit edge "
                     << (*edge)->getSource()->getBlock()->getName() << "->"
                     << (*edge)->getDst()->getBlock()->getName()
                     << ": count[r]++" << "\n");

        BasicBlock *instrBlock = spliceEdge(*edge);
        IRBuilder<> builder(instrBlock->getFirstInsertionPt());
        instrumentWithIncArrayElement(builder, mod,
                                      pathCountsArrays[*task], pathReg, 1);
    }
#endif

#if 0 // TODO: delete -- there can never be backedges given our loop cutting
    auto backedges = (*task)->Dag->getBackedges();
    for (auto edge = backedges.begin(); edge != backedges.end(); ++edge) {

      DEBUG(dbgs() << "Instrumenting backedge "
          << (*edge)->getSource()->getBlock()->getName() << " -> "
          << (*edge)->getDst()->getBlock()->getName() << ": count[r]++; r = 0\n");

      auto instrumBlock = spliceEdge(*edge);
      IRBuilder<> builder(instrumBlock->getFirstInsertionPt());
      instrumentWithIncIndirectArrayElement(builder, mod,
                                    pathCountsArrays[*task], pathReg);
      instrumentWithSet(builder, pathReg, 0);
    }
#endif
  }

  DEBUG(dbgs() << "Instrumenting function exits\n");

  std::vector<BasicBlock *> path;
  std::set<BasicBlock *> returnBlocks;
  instrumentFunctionExits(dag.getEntry()->getBlock(), path, returnBlocks,
                          mod, pathCounts, taskReg, pathReg);
}

void PathProfiler::saveTaskIds(Function &F, FuncBallLarusDag *dag, const std::string &filename)
{
  for (auto task = dag->getTasks().begin(); task != dag->getTasks().end(); ++task) {
    taskIdsFile << F.getName().str() << "," << (*task)->Id << "," << (*task)->getName() << "\n";
  }
}

bool PathProfiler::runOnFunction(Function &F) {

  // Skip our own generated instrumentation functions
  if (F.empty() || F.getName() == AddIncFunc::IncFuncName ||
                   F.getName() == TaskBoundaryFuncName)
    return false;

  FuncBallLarusDag dag(&F.getEntryBlock(), this,
                       stripExtension(F.getParent()->getName()) + "-" + F.getName());
  if (dag.getTasks().size() > 0)
    instrumentEdges(F, dag);
  if (TaskIdsFilename.size())
    saveTaskIds(F, &dag, TaskIdsFilename);

  return true; // modified
}

char PathProfiler::ID = 0;
static RegisterPass<PathProfiler> X("instrument-paths", "Ball-Larus Path Profiler Pass");

} // namespace edbprof
