#ifndef EDBPROF_BLOCK_HASH_MAP_H
#define EDBPROF_BLOCK_HASH_MAP_H

#include "BlockHash.h"

#include <string>
#include <map>
#include <utility>

namespace edbprof {
  typedef std::map<std::string, BlockHash> BlockHashMap;
  typedef std::shared_ptr<BlockHashMap> BlockHashMapPtr;

  BlockHashMapPtr LoadBlockHashMap(const std::string& blockMapFilename);
} // namespace edbprof

#endif // EDBPROF_BLOCK_HASH_MAP_H
