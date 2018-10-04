#include "AddIncFunc.h"

#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/ADT/TinyPtrVector.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#define DEBUG_TYPE "AddIncFunc"

using namespace llvm;

namespace {

const char AddFuncName[] = "llvm.uadd.with.overflow.i16";

} // anon namespace

namespace edbprof {

char AddIncFunc::ID = 0;
static RegisterPass<AddIncFunc> A("add-inc-func",
    "Add function for incrementing path count used by path profiler",
    /* does not modify CFG? */ true,
    /* is analysis pass? */ false);

const std::string AddIncFunc::IncFuncName("__edbprof_inc_pathcount");

Function *AddIncFunc::declareAddFunc(Module &M) {
  LLVMContext &ctx = M.getContext();
  auto I16 = IntegerType::get(ctx, 16);
  SmallVector<Type*, 2> retFields(2);
  retFields[0] = I16;
  retFields[1] = IntegerType::get(ctx, 1);
  auto retTy = StructType::get(ctx, retFields, /* isPacked */ false);

  SmallVector<Type*, 2> argsTy(2);
  argsTy[0] = I16;
  argsTy[1] = I16;

  auto funcTy = FunctionType::get(retTy, argsTy, /* isVarArg */ false);

  auto func = Function::Create(funcTy, GlobalValue::ExternalLinkage,
                               AddFuncName, &M);
  func->setCallingConv(CallingConv::C);
  return func;
}

Function *AddIncFunc::defineIncFunc(Module &M, Function *addFunc) {
  LLVMContext &ctx = M.getContext();

  // Prototype: inc(u16* memloc)
  // Increments the value at memory location and halts (inf loop) on overflow

  auto I16 = IntegerType::get(ctx, 16);
  PointerType* intPtrType = PointerType::get(I16, 0);

  TinyPtrVector<Type *> argsTy;
  argsTy.push_back(intPtrType);
  auto retTy = Type::getVoidTy(ctx);
  auto funcTy = FunctionType::get(retTy, argsTy, /* isVarArg */ false);

  auto func = Function::Create(funcTy, GlobalValue::PrivateLinkage,
                               IncFuncName, &M);
  func->setCallingConv(CallingConv::C);

  Function::arg_iterator args = func->arg_begin();
  Value* locPtr = args++;
  locPtr->setName("loc");

  BasicBlock* entry = BasicBlock::Create(ctx, "entry", func, 0);
  IRBuilder<> builder(entry);
  
  Value *val = builder.CreateLoad(locPtr);

  Value *increment = llvm::ConstantInt::get(I16, 1);
  SmallVector<Value * ,2> addParams(2);
  addParams[0] = val;
  addParams[1] = increment;
  auto addRes = builder.CreateCall(addFunc, addParams, "res");
  SmallVector<unsigned, 1> fieldIdxes(1);
  fieldIdxes[0] = 0;
  auto sum = builder.CreateExtractValue(addRes, fieldIdxes, "sum");
  fieldIdxes[0] = 1;
  auto obit = builder.CreateExtractValue(addRes, fieldIdxes, "obit");

  auto haltBlock = BasicBlock::Create(ctx, "halt", func, nullptr);
  IRBuilder<> haltBuilder(haltBlock);
  haltBuilder.CreateBr(haltBlock);

  auto continueBlock = BasicBlock::Create(ctx, "continue", func, nullptr);
  IRBuilder<> continueBuilder(continueBlock);
  continueBuilder.CreateStore(sum, locPtr);
  continueBuilder.CreateRetVoid();

  builder.CreateCondBr(obit, haltBlock, continueBlock);

  return func;
}

bool AddIncFunc::runOnModule (Module &M) {
    DEBUG(dbgs() << "Declaring " << AddFuncName << "\n");
    auto addFunc = declareAddFunc(M);

    DEBUG(dbgs() << "Defining " << IncFuncName << "\n");
    defineIncFunc(M, addFunc);

    return true;
}

} // namespace edbprof
