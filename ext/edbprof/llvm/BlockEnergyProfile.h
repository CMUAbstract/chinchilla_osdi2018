#ifndef EDBPROF_BLOCK_ENERGY_PROFILE_H
#define EDBPROF_BLOCK_ENERGY_PROFILE_H

#include "EnergyDist.h"
#include "BallLarusGraph.h"

#include <string>
#include <map>

namespace edbprof {

class BlockEnergyProfile
{
  public:
    // func name -> (block -> energy stats)
    typedef std::map<std::string, std::map<std::string, EnergyDist> > BlockEnergyMap;

    void load(const std::string& blockEnergyFilename,
              const std::string& opaqueFunctionsFilename);
    void print();
    EnergyDist lookup(BallLarusNode *node);

  private:
    void loadOpaqueFunctionEnergyDataset(const std::string &file);

    BlockEnergyMap blockEnergy;

    // TODO: remove from this class; encapsulate into block energy profiling
    // stage (see more comments near where this is used).
    std::map<std::string, EnergyDist> opaqueFunctionEnergy;
};

} // namespace edbprof

#endif // EDBPROF_BLOCK_ENERGY_PROFILE_H
