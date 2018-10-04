#ifndef EDBPROF_CLI_H
#define EDBPROF_CLI_H

#include "llvm/Support/CommandLine.h"

#include <string>

namespace edbprof {

extern llvm::cl::opt<std::string> BlockEnergyFilename;
extern llvm::cl::opt<std::string> BlockHashMapFilename;
extern llvm::cl::opt<std::string> PathCountsFilename;
extern llvm::cl::opt<std::string> FuncEnergyFilename;
extern llvm::cl::opt<std::string> PathEnergyFilename;
extern llvm::cl::opt<bool> RecordPaths;
extern llvm::cl::opt<std::string> SpecFilename;
extern llvm::cl::opt<std::string> TaskIdsFilename;
extern llvm::cl::opt<std::string> OpaqueFunctionsFilename;
extern llvm::cl::opt<std::string> LoopIterCountsFilename;
extern llvm::cl::opt<bool> InlineCalls;
extern llvm::cl::opt<bool> IsolateLoops;
extern llvm::cl::opt<bool> ConstructTaskDAGs;
extern llvm::cl::opt<std::string> SpecListFilepath;
extern llvm::cl::opt<std::string> BoundariesDir;
extern llvm::cl::opt<std::string> SpecOutputFilename;
extern llvm::cl::opt<unsigned> BoundaryGenSeed;
extern llvm::cl::opt<unsigned> NumBoundarySpecs;
extern llvm::cl::opt<std::string> BoundaryCountsRange;
extern llvm::cl::opt<std::string> FuncBlacklistFilename;
extern llvm::cl::opt<std::string> EnergyCapacityFilename;
extern llvm::cl::opt<std::string> GreedyRunningTimeFilename;
extern llvm::cl::opt<float> GreedyScoreWeightLength;
extern llvm::cl::opt<float> GreedyScoreWeightCheckpoint;
extern llvm::cl::opt<std::string> DistExprEvaluatorPipes;


} // namespace edbprof

#endif // EDBPROF_CLI_H
