#include "BlockEnergyProfile.h"

#include "EnergyDist.h"
#include "BallLarusGraph.h"
#include "CommaSeparatedValues.h"
#include "CLI.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <fstream>

#define DEBUG_TYPE "BlockEnergyProfile"

using namespace llvm;

namespace edbprof {

void BlockEnergyProfile::load(const std::string& blockEnergyFilename,
                              const std::string& opaqueFunctionsFilename = "")
{
  assert(!blockEnergyFilename.empty() && "No block energy dataset filename specified");

  std::ifstream fin(blockEnergyFilename.c_str());
  assert(fin.good() && "Failed to open block energy dataset");

  std::string line;
  std::getline(fin, line);
  const auto& columns = tokenize(line);

  int funcColIdx = findColumn(columns, "func");
  int blockColIdx = findColumn(columns, "block_name");
  int energyMeanColIdx = findColumn(columns, "energy_mean");
  int energyStdDevColIdx = findColumn(columns, "energy_sd");

  while (std::getline(fin, line)) {
    DEBUG(dbgs() << "load block energy profile: line '" << line << "'\n");
    const auto& fields = tokenize(line);
    auto& funcBlockEnergy = blockEnergy[fields[funcColIdx]];
    float mean = std::stof(fields[energyMeanColIdx].c_str());
    assert(!std::isnan(mean) && "invalid block energy mean value");
    float stddev = std::stof(fields[energyStdDevColIdx].c_str());
    assert(!std::isnan(stddev) && "invalid block energy stddev value");
    float variance = stddev * stddev;
    funcBlockEnergy[fields[blockColIdx]] = EnergyDist(mean, variance);
  }

  fin.close();

  // TODO: this should be removed from here, and encapsulated in the block energy
  // profiling phase. That phase needs to be changed to extract the basic
  // blocks using an LLVM pass (and compile them to native assembly), so that
  // we can make use of meta information that's only available within a pass.
  if (opaqueFunctionsFilename.size()) { // supplied by BallLarusGraph
    DEBUG(dbgs() << "Loading opaque function energy dataset...\n");
    loadOpaqueFunctionEnergyDataset(OpaqueFunctionsFilename);
  }
}

void BlockEnergyProfile::loadOpaqueFunctionEnergyDataset(const std::string &file)
{
  DEBUG(dbgs() << "loading opaque function list: " << file << "\n");

  std::ifstream fin(file.c_str());
  assert(fin.good() && "failed to open opaque func list file");

  // Skip CSV header
  std::string header;
  fin >> header;

  while (fin.good()) {
    std::string line;
    fin >> line;

    if (line.size() == 0)
      continue;

    const auto &tokens = tokenize(line);
    assert(tokens.size() == 3 && "failed to parse opaque functions dataset");

    const std::string &func = tokens[0];
    EnergyDist energy(atof(tokens[1].c_str()),atof(tokens[2].c_str()));

    DEBUG(dbgs() << "loaded opaque func energy: '" << func << "': "
                 << "mean " << energy.Mean << " var " << energy.Var << "\n");

    opaqueFunctionEnergy[func] = energy;
  }
}

void BlockEnergyProfile::print()
{
  for (auto blockEnergyEntry = blockEnergy.begin();
       blockEnergyEntry != blockEnergy.end(); blockEnergyEntry++) {
    DEBUG(dbgs() << "func " << blockEnergyEntry->first << ":\n");
    const auto& funcBlockEnergy = blockEnergyEntry->second;
    for (auto block = funcBlockEnergy.begin(); block != funcBlockEnergy.end();
         block++) {
      DEBUG(dbgs() << " block " << block->first << "\n");
    }
  }
}

EnergyDist BlockEnergyProfile::lookup(BallLarusNode *node)
{
  // TODO: this should be removed from here, and encapsulated in the block energy
  // profiling phase. That phase needs to be changed to extract the basic
  // blocks using an LLVM pass (and compile them to native assembly), so that
  // we can make use of meta information that's only available within a pass.
  if (node->OpaqueCallee) {
    DEBUG(dbgs() << "node " << node->getName() << "is an opaque call to "
                 << node->OpaqueCallee->getName() << "\n");
    auto energyEntry = opaqueFunctionEnergy.find(node->OpaqueCallee->getName());
    assert(energyEntry != opaqueFunctionEnergy.end() && "no energy entry for opaque callee\n");
    return energyEntry->second;
  }

  DEBUG(dbgs() << "Looking up energy of block " << node->getName() << " (key '"
               << node->getBlock()->getName() << "')\n");
  const auto &funcBlockEnergyIter = blockEnergy.find(node->getFunc()->getName());
  assert(funcBlockEnergyIter != blockEnergy.end() &&
         "Function not found in block energy dataset");
  const auto &funcBlockEnergy = funcBlockEnergyIter->second;
  const auto &thisBlockEnergy = funcBlockEnergy.find(node->getBlock()->getName());
  assert(thisBlockEnergy != funcBlockEnergy.end() &&
         "Block not found in block energy dataset");
  return thisBlockEnergy->second;
}

} // namespace edbprof
