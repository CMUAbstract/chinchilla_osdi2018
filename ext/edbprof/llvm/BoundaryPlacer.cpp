#include "BoundaryPlacer.h"

#include "FatalOptimizationFailure.h"
#include "Tasks.h"
#include "CLI.h"

#include "llvm/Pass.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <sstream>
#include <fstream>
#include <cstdlib>

#define DEBUG_TYPE "BoundaryPlacer"

using namespace llvm;

namespace {

typedef struct {
  std::string Function;
  std::string Name;
} BlockId;

// The task boundary function is defined in libedbprof
Function *declareVoidVoidTaskBoundaryFunc(Module &M, const std::string &funcName) {
  LLVMContext &ctx = M.getContext();
  auto funcTy = FunctionType::get(Type::getVoidTy(ctx), /* isVarArg */ false);
  auto func = Function::Create(funcTy, GlobalValue::ExternalLinkage, funcName, &M);
  func->setCallingConv(CallingConv::C);
  return func;
}

Function *declareVoidUnsignedTaskBoundaryFunc(Module &M, const std::string &funcName) {
  LLVMContext &ctx = M.getContext();
  auto I16 = IntegerType::get(ctx, 16);
  SmallVector<Type*, 1> argsTy(1);
  argsTy[0] = I16;
  auto funcTy = FunctionType::get(Type::getVoidTy(ctx), argsTy, /* isVarArg */ false);
  auto func = Function::Create(funcTy, GlobalValue::ExternalLinkage, funcName, &M);
  func->setCallingConv(CallingConv::C);
  return func;
}

std::vector<std::string> tokenize(const std::string &str, char separator = ' ')
{
  std::vector<std::string> tokens;

  size_t begin = 0;
  do
  {
    size_t end = str.find(separator, begin);
    if (end == std::string::npos)
      end = str.size();
    if (end > begin) // else: back to back separators
        tokens.push_back(str.substr(begin, end - begin));
    begin = end + 1;
  } while (begin < str.size());

  return tokens;
}

} // anon namespace

namespace edbprof {

char BoundaryPlacer::ID = 0;

static RegisterPass<BoundaryPlacer> X("place-boundaries",
    "Place boundaries according to a location spec");

// TODO: factor this into a class and use it from here and from PathProfiler
const char *BoundaryPlacer::TaskBoundaryFuncName = "edbprof__task_boundary"; // TODO: add __
const char *BoundaryPlacer::DinoTaskBoundaryFuncName = "__dino_task_boundary";

BoundaryPlacer::BoundaryPlacer()
  : ModulePass(ID)
{
  loadBoundarySpec(SpecFilename);
}

void BoundaryPlacer::loadBoundarySpec(std::string &specFilename)
{
  std::ifstream specFile(specFilename.c_str());
  if (specFile.fail()) {
    DEBUG(dbgs() << "failed to open file " << specFilename << ": " << strerror(errno) << "\n");
    assert(false && "File open failed.");
  }

  // Read (and throw away) CSV header
  std::string header;
  specFile >> header;

  DEBUG(dbgs() << "load boundary spec: CSV header: " << header << "\n");

  while (!specFile.eof()) {
    std::string line;
    specFile >> line;

    // For some reason we get blank lines at the end of the file
    if (line.size() == 0)
      continue;

    DEBUG(dbgs() << "load boundary spec: line: " << line << "\n");

    const auto &tokens = tokenize(line, ',');

    assert(tokens.size() == 2 && "failed to parse line in boundary spec file");
    const std::string &funcName = tokens[0];
    const std::string &blockName = tokens[1];

    boundarySpec[funcName].insert(blockName);
  }

  specFile.close();
}

void BoundaryPlacer::placeBoundaries(llvm::Function &F, const std::set<std::string> &boundaryBlocks)
{
  DEBUG(dbgs() << "Placing boundaries in function " << F.getName() << "\n");

  // TODO: consolidate? see TODO in placeBoundaries

  // TODO: this pass should be per-module, so this on-demand init would go away

  auto taskBoundaryFunc = F.getParent()->getFunction(TaskBoundaryFuncName);
  if (!taskBoundaryFunc)
    taskBoundaryFunc = declareVoidVoidTaskBoundaryFunc(*F.getParent(), TaskBoundaryFuncName);

  // See DINO_TASK_BOUNDARY* in libdino/dino.h
  auto dinoTaskBoundaryFunc = F.getParent()->getFunction(DinoTaskBoundaryFuncName);
  if (!dinoTaskBoundaryFunc)
    dinoTaskBoundaryFunc = declareVoidUnsignedTaskBoundaryFunc(*F.getParent(), DinoTaskBoundaryFuncName);

  std::set<BasicBlock *> processedBlocks;
  placeBoundaries(&F.getEntryBlock(), boundaryBlocks, processedBlocks, /* taskId */ 0,
                  taskBoundaryFunc, dinoTaskBoundaryFunc, F.getContext());
}

void BoundaryPlacer::placeBoundaries(BasicBlock *block,
                                     const std::set<std::string> &boundaryBlocks,
                                     std::set<BasicBlock *> &processedBlocks,
                                     unsigned taskId,
                                     Function *taskBoundaryFunc, Function *dinoTaskBoundaryFunc,
                                     LLVMContext &ctx)
{

  // Do not follow backedges and do not re-visit nodes
  if (processedBlocks.find(block) != processedBlocks.end())
    return;

  processedBlocks.insert(block);

  DEBUG(dbgs() << "traversing block " << block->getName() << "\n");

  if (boundaryBlocks.find(block->getName()) != boundaryBlocks.end()) {
    DEBUG(dbgs() << "inserting boundary at block " << block->getName() << "\n");

    // TODO: have a mode: edbprof boundaries vs dino boundaries?
    //       or change edbprof to work with dino boundary everywhere?

    // NOTE: could easily extend this to support any location within the block
    IRBuilder<> builder(block->getFirstInsertionPt());
    builder.CreateCall(taskBoundaryFunc);

    auto I16 = IntegerType::get(ctx, 16);
    Value *taskIdVal = llvm::ConstantInt::get(I16, taskId++);
    SmallVector<Value * ,1> params(1);
    params[0] = taskIdVal;
    builder.CreateCall(dinoTaskBoundaryFunc, params);
  }

  for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
    placeBoundaries(*succ, boundaryBlocks, processedBlocks, taskId,
                    taskBoundaryFunc, dinoTaskBoundaryFunc, ctx);
  }
}

bool BoundaryPlacer::runOnModule(llvm::Module &M)
{
  DEBUG(dbgs() << "placing boundaries into module " << M.getName() << "\n");
  for (auto &F : M) {
    const auto &boundaryBlocks = boundarySpec.find(F.getName());
    if (boundaryBlocks != boundarySpec.end()) // any boundaries at func's blocks?
        placeBoundaries(F, boundaryBlocks->second);
  }

  return true;
}

} // namespace edbprof
