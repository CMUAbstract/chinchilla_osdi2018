#ifndef EDBPROF_BLOCK_HASH_H
#define EDBPROF_BLOCK_HASH_H

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <string>
#include <sstream>

namespace edbprof {

struct BlockHash {
    static const int NUM_BITS = 128; // md5
    static const int NUM_BYTES = NUM_BITS / 8;
    static const int NUM_BYTES_IN_WORD = sizeof(unsigned long long);
    static const int NUM_WORDS = NUM_BYTES / NUM_BYTES_IN_WORD;

    BlockHash();
    BlockHash(const std::string &s);

  private:
    unsigned long long words[NUM_WORDS];

    void init();

  friend std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, const BlockHash &h);
};

std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, const BlockHash &h);
llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const BlockHash &h);

} // namespace edbprof

#endif // EDBPROF_BLOCK_HASH_H
