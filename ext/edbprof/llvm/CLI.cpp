#include "CLI.h"

using namespace llvm;

namespace edbprof {

cl::opt<std::string> BlockEnergyFilename("edbprof-block-energy",
    cl::desc("Path to file with dataset for block energy (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> BlockHashMapFilename("edbprof-block-hash-map",
    cl::desc("Path to file with block name to hash map (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> PathCountsFilename("edbprof-path-counts",
    cl::desc("Path to file with dataset for path counts (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> FuncEnergyFilename("edbprof-task-energy",
    cl::desc("Path to output file with energy estimates for tasks (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> PathEnergyFilename("edbprof-path-energy",
    cl::desc("Path to output file with energy estimates for paths (CSV)"),
    cl::value_desc("filename"));

cl::opt<bool> RecordPaths("edbprof-record-paths",
    cl::desc("Include path contents as a string column in the output dataset(CSV)"),
    cl::value_desc("flag"));

cl::opt<std::string> SpecFilename("edbprof--boundary-placer--spec",
    cl::desc("Spec file that specifies the location of the boundaries"),
    cl::value_desc("filename"));

cl::opt<std::string> TaskIdsFilename("edbprof--path-profiler--task-ids",
    cl::desc("Path to output file with the map from task ID to task name"),
    cl::value_desc("filename"));

cl::opt<std::string> OpaqueFunctionsFilename("edbprof-opaque-functions",
    cl::desc("Path to file with list of opaque functions (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> LoopIterCountsFilename("edbprof-loop-iters",
    cl::desc("Path to file with profiled loop iteration counts (CSV)"),
    cl::value_desc("filename"));

cl::opt<bool> InlineCalls("edbprof-inline-calls",
    cl::desc("Wether to follow function calls and create nodes in CFG"),
    cl::value_desc("flag"));

cl::opt<bool> IsolateLoops("edbprof-isolate-loops",
    cl::desc("Wether to insert pseudo-task-boundaries at loop header and footer"),
    cl::value_desc("flag"));

cl::opt<bool> ConstructTaskDAGs("edbprof-construct-task-dags",
    cl::desc("Wether to construct per-task DAGs"),
    cl::value_desc("flag"));

cl::opt<std::string> SpecListFilepath("edbprof--boundary-gen--spec-list",
    cl::desc("Path to output file for the list of spec filenames (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> BoundariesDir("edbprof--boundary-gen--dir",
    cl::desc("Path to directory where to generate boundary spec files"),
    cl::value_desc("directory"));

cl::opt<std::string> SpecOutputFilename("edbprof--boundary-gen--filename",
    cl::desc("Filename of generated spec file (in a created sub-directory)"),
    cl::value_desc("string"));

cl::opt<unsigned> BoundaryGenSeed("edbprof--boundary-gen--seed",
    cl::desc("Seed for random number generator used by boundary generator"),
    cl::value_desc("number"), cl::init(42));

cl::opt<unsigned> NumBoundarySpecs("edbprof--boundary-gen--specs",
    cl::desc("Number of specs to generate for each boundary count"),
    cl::value_desc("number"));

cl::opt<std::string> BoundaryCountsRange("edbprof--boundary-gen--range",
    cl::desc("Generate specs with this many boundaries in each (accepts range, e.g. 1-10^4,15)"),
    cl::value_desc("number"));

cl::opt<std::string> FuncBlacklistFilename("edbprof--boundary-gen--func-blacklist",
    cl::desc("File with a list of functions in which boundaries are disallowed (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> EnergyCapacityFilename("edbprof--energy-capacity",
    cl::desc("File with the energy capacity dataset (CSV)"),
    cl::value_desc("filename"));

cl::opt<std::string> GreedyRunningTimeFilename("edbprof--greedy-time",
    cl::desc("File where to save measured running time of the pass (CSV)"),
    cl::value_desc("filename"));

cl::opt<float> GreedyScoreWeightLength("edbprof--greedy-score-weight-length",
    cl::desc("Weight of the length score for path splitting fit function"),
    cl::value_desc("weight"), cl::init(0.5));

cl::opt<float> GreedyScoreWeightCheckpoint("edbprof--greedy-score-weight-checkpoint",
    cl::desc("Weight of the checkpoint score for path splitting fit function"),
    cl::value_desc("weight"), cl::init(0.5));

cl::opt<std::string> DistExprEvaluatorPipes("edbprof--dist-expr-evaluator-pipes",
    cl::desc("Name of in and out pipes to the server for dist expr evaluation (space-separated)"),
    cl::value_desc("pipes"));

} // namespace edbprof
