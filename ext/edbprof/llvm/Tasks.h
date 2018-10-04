#include "llvm/IR/BasicBlock.h"

namespace edbprof {

extern const char *TaskBoundaryFunctionName;

// Entry function into the module (programmer expected to follow naming convention).
// main() calls this function.
// TODO: do this via attribute; also unclear how we will support multiple modules
extern const char *EntryTaskFunctionName;

// TODO: we have at least one other definition of this: consolidate
extern const char *DINOTaskBoundaryFunctionName;

bool isTaskBoundaryInstr(llvm::Instruction *instr);
bool isTaskBoundary(llvm::BasicBlock *block);
bool isCall(llvm::Instruction &I);
bool isCallTo(llvm::Instruction &instr, llvm::StringRef funcName); // TODO: factor into another file
llvm::Function *getCallee(llvm::Instruction &I);
bool isFunctionSpecial(llvm::Function &F);

llvm::Function *getEntryFunction(llvm::Module &M);

std::string stripExtension(const std::string &name);

} // namespace edbprof
