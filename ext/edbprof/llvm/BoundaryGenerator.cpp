#include "BoundaryGenerator.h"

#include "FatalOptimizationFailure.h"
#include "Tasks.h"
#include "BallLarusGraph.h"
#include "CLI.h"
#include "CommaSeparatedValues.h"

#include "llvm/Pass.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Analysis/LoopInfo.h"

#include <sstream>
#include <fstream>
#include <cstdlib>

#include <sys/stat.h>
#include <dirent.h>

#define DEBUG_TYPE "BoundaryGenerator"

using namespace llvm;

namespace {

} // anon namespace

namespace edbprof {

char BoundaryGenerator::ID = 0;

static RegisterPass<BoundaryGenerator> X("generate-boundaries",
    "Generate a set of boundary placements");

BoundaryGenerator::BoundaryGenerator()
  : ModulePass(ID)
{
  srand(BoundaryGenSeed);

  if (FuncBlacklistFilename.size())
    loadFuncBlacklist(FuncBlacklistFilename);

  specListFile.open(SpecListFilepath.c_str());

  if (specListFile.fail()) {
    DEBUG(dbgs() << "Failed to open file: " << SpecListFilepath << "\n");
    assert(false && "Failed to open spec list file");
  }

  specListFile << "spec_id,boundary_count,sample_index\n"; // CSV header
}

void BoundaryGenerator::loadFuncBlacklist(const std::string &filename)
{
  DEBUG(dbgs() << "Loading function blacklist: '" << filename << "'\n");

  std::ifstream blacklistFile(filename);

  std::string func;
  unsigned count = 0;

  while (blacklistFile.good()) {
    blacklistFile >> func; // discard CSV header
    if (count++ == 0)
      continue;
    funcBlacklist.insert(func);
  }
  count = count > 0 ? count - 1 : count;
  DEBUG(dbgs() << "Loaded function blacklist: " << count << " total\n");
}

bool BoundaryGenerator::isFunctionBlacklisted(Function &F)
{
  return funcBlacklist.find(F.getName()) != funcBlacklist.end();
}

bool BoundaryGenerator::runOnModule(llvm::Module &M)
{
  DEBUG(dbgs() << "Generating boundary specs for module " << M.getName() << "\n");

  // We always put a boundary at the entry, else energy cost won't capture all code
  Function *entryFunc = getEntryFunction(M);

  std::set<BasicBlock *> blocks;
  for (auto &F : M) {
    if (!isFunctionBlacklisted(F) && !isFunctionSpecial(F)) {
      DEBUG(dbgs() << "extracting blocks from function " << F.getName() << "\n");

      std::set<BasicBlock *> funcBlocks;
      buildBlockList(&F.getEntryBlock(), funcBlocks);

      for (auto &block : funcBlocks)
        blocks.insert(block);

    } else {
      DEBUG(dbgs() << "skipping blacklisted function: " << F.getName() << "\n");
    }
  }

  const std::vector<unsigned> &boundaryCounts = parseRange(BoundaryCountsRange);

  for (unsigned boundaryCount : boundaryCounts) {

    DEBUG(dbgs() << "boundary count: " << boundaryCount << "\n");

    if (boundaryCount > blocks.size()) {
      DEBUG(dbgs() << "WARNING: requested more boundaries (" << boundaryCount << ") "
                   << "than blocks (" << blocks.size() << "): skipping\n");
      break;
    }

    std::vector< std::set<BasicBlock *> > placements;

    for (unsigned idx = 0; idx < NumBoundarySpecs; ++idx) {

      std::set<BasicBlock *> placement;

      unsigned attempts = 5; // how many times to try to find a distinct placement
      bool distinct;
      do {

          DEBUG(dbgs() << "generating a placement: attempts left " << attempts << "\n");

          // Randomly pick the blocks at which to place boundaries

          // We will select blocks to put boundaries on without replacement, so make a copy
          // NOTE: we need both random access and erase, so whether we pick list/set or vector,
          // we will still need linear time.
          std::vector<BasicBlock *> blocksCopy(blocks.begin(), blocks.end());

          if (boundaryCount > 0) {
            // We include a boundary at entry block into every placmeent. This is
            // not strictly necessary, but the energy cost prediction becomes not
            // very meaningful if there is no boundary at the entry, since the
            // blocks that precede the first boundary are totally unaccounted for
            // (and the energy-capacity measurement becomes irrelevant, since the
            // cap will never be full at the first boundary unless its the entry
            // block).
            auto entryBlock = std::find(blocksCopy.begin(), blocksCopy.end(),
                                        &entryFunc->getEntryBlock());
            // NOTE: the only way this could happen is if entry block was a loop head
            //       and the hack above removed it from the candidate set
            assert(entryBlock != blocksCopy.end() && "entry block not in candidate set\n");
            placement.insert(*entryBlock);
            blocksCopy.erase(entryBlock);
            DEBUG(dbgs() << "placed first boundary at entry block: "
                         << (*entryBlock)->getName() << "\n");
          }

          for (unsigned i = 0; boundaryCount > 0 && i < boundaryCount - 1; ++i) {
            unsigned blockIdx = rand() % blocksCopy.size();
            BasicBlock *block = blocksCopy[blockIdx];
            assert(blocksCopy.size() > blockIdx &&
                   "about to delete non-existing element");
            blocksCopy.erase(blocksCopy.begin() + blockIdx);

            placement.insert(block);
          }

          distinct = true;
          for (auto existingPlacement = placements.begin();
                    existingPlacement != placements.end(); ++existingPlacement) {

            assert((*existingPlacement).size() == placement.size() &&
                   "comparing placements from two different boundary counts");

            // placement == existingPlacement?
            // TODO: do we have to explicitly sort the keys? or are they always sorted in std::set?
            std::vector<BasicBlock *> commonBlocks(placement.size());
            const auto& commonBlocksEnd = std::set_intersection((
                  *existingPlacement).begin(), (*existingPlacement).end(),
                  placement.begin(), placement.end(), commonBlocks.begin());
            commonBlocks.resize(commonBlocksEnd - commonBlocks.begin());
            distinct = commonBlocks.size() != placement.size();

            if (distinct)
              break;

          }

          if (!distinct)
            placement.clear(); // clear and try again

      } while (!distinct && --attempts);

      if (attempts == 0) { // distinct placement not found
        continue; // have fewer placements for this boundary count than requested
      }

      placements.push_back(placement);

      // TODO: should be per function

      std::stringstream specId;
      specId << "count-" << boundaryCount << "--idx-" << idx;

      std::stringstream specDirpath;
      specDirpath << BoundariesDir << "/" << specId.str();
      DEBUG(dbgs() << "create dir " << specDirpath.str() << "\n");

      if (!opendir(specDirpath.str().c_str())) {
        if (mkdir(specDirpath.str().c_str(), S_IRWXU | S_IRWXG | S_IRWXO)) {
          DEBUG(dbgs() << "error while creating dir '" << specDirpath.str() << "': "
                << strerror(errno) << "\n");
          assert(false && "failed to create dir for spec file");
        }
      }

      std::stringstream specFilepath;
      specFilepath << specDirpath.str() << "/" << SpecOutputFilename;
      DEBUG(dbgs() << "create file " << specFilepath.str() << "\n");

      // Record the id of the generated spec in the list
      specListFile << specId.str() << "," << boundaryCount << "," << idx << "\n";

      std::ofstream specFile(specFilepath.str().c_str());

      if (specFile.fail()) {
        DEBUG(dbgs() << "WARNING: failed to open file " << specFilepath.str() << "\n");
        assert(false && "Failed to open file");
      }

      specFile << "function,block\n"; // CSV header
      for (auto boundary = placement.begin(); boundary != placement.end(); ++boundary) {
        specFile << (*boundary)->getParent()->getName().str() << ","
                 << (*boundary)->getName().str() << "\n";
      }
      specFile.close();
    }
  }

  return false;
}

void BoundaryGenerator::buildBlockList(BasicBlock *block, std::set<BasicBlock *> &blocks)
{
  // Do not follow backedges and do not re-visit nodes
  if (blocks.find(block) != blocks.end())
    return;

  blocks.insert(block);

  DEBUG(dbgs() << "added block " << block->getName() << "\n");
  for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
    buildBlockList(*succ, blocks);
  }
}

void BoundaryGenerator::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
}

} // namespace edbprof
