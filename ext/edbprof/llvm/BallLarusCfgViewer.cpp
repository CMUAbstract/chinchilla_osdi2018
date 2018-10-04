#include "BallLarusCfgViewer.h"

#include "BallLarusGraph.h"
#include "BallLarusGraphTraits.h"
#include "Tasks.h"

#include "llvm/IR/Module.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Support/GraphWriter.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

using namespace llvm;
using namespace edbprof;

#define DEBUG_TYPE "BallLarusCfgViewer"

namespace edbprof {

const char *BallLarusCfgViewer::DotFileSuffix = "bl-cfg";

bool BallLarusCfgViewer::runOnModule(Module &M)
{
  Function *entryFunc = getEntryFunction(M);

  DEBUG(dbgs() << "Constructing CFG for module " << M.getName()
               << " entry func " << entryFunc->getName() << "\n");

  FuncBallLarusDag dag(&entryFunc->getEntryBlock(), this, stripExtension(M.getName()));
  
  Twine cfgDotFileName(stripExtension(M.getName()) + "." + DotFileSuffix + ".dot");

  std::error_code errorCode;
  raw_fd_ostream cfgDotFile(cfgDotFileName.str(),
                            errorCode, sys::fs::F_Text);

  WriteGraph(cfgDotFile, static_cast<BallLarusDag *>(&dag));

  return false; // modified
}

void BallLarusCfgViewer::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}


char BallLarusCfgViewer::ID = 0;
static RegisterPass<BallLarusCfgViewer> X(
    "view-bl-cfg", "Construct and output Ball-Larus CFG to a .dot file");

} // namespace edbprof
