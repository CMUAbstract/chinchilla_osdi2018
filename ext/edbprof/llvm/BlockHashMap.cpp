#include "BlockHashMap.h"

#include "CommaSeparatedValues.h"
#include "BlockHash.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <string>
#include <map>
#include <fstream>

#define DEBUG_TYPE "BlockHashMap"

using namespace llvm;

namespace edbprof {

BlockHashMapPtr LoadBlockHashMap(const std::string& blockMapFilename)
{
  DEBUG(dbgs() << "Loading block map from: " << blockMapFilename << "\n");
  assert(!blockMapFilename.empty() && "No block map filename specified");

  std::ifstream fin(blockMapFilename.c_str());
  assert(fin.good() && "Failed to open block map file");

  BlockHashMapPtr blockMap(new BlockHashMap());

  std::string line;
  std::getline(fin, line);
  const auto& columns = tokenize(line);

  int funcColIdx = findColumn(columns, "func");
  int nameColIdx = findColumn(columns, "block_name");
  int hashColIdx = findColumn(columns, "block_hash");

  while (std::getline(fin, line)) {
    DEBUG(dbgs() << "load block map: line '" << line << "'\n");
    const auto& fields = tokenize(line);
    std::string name = fields[funcColIdx] + "-" + fields[nameColIdx];
    (*blockMap)[name] = BlockHash(fields[hashColIdx]);
  }

  fin.close();

  return blockMap;
}

} // namespace edbprof
