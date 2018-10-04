#ifndef ADD_INC_FUNC_H
#define ADD_INC_FUNC_H 

#include "llvm/Pass.h"

#include <string>

namespace edbprof {

  class AddIncFunc : public llvm::ModulePass {
   public:
    static char ID;

    static const std::string IncFuncName;

    AddIncFunc() : ModulePass(ID) {}
    virtual bool runOnModule (llvm::Module &);

    private:
     llvm::Function *declareAddFunc(llvm::Module &M);
     llvm::Function *defineIncFunc(llvm::Module &M, llvm::Function *addFunc);
  };

} // namespace edbprof

#endif // ADD_INC_FUNC_H 
