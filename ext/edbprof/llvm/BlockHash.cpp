#include "BlockHash.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <iomanip>

#define DEBUG_TYPE "BlockHash"

using namespace llvm;

namespace edbprof {

void BlockHash::init() {
  for (int i = 0; i < BlockHash::NUM_WORDS; ++i)
    words[i] = 0;
}

BlockHash::BlockHash()
{
  init();
}

BlockHash::BlockHash(const std::string &s)
{
  init();

  char byte[3] = {0};
  auto siter = s.begin();

  assert(s.size() / 2 == BlockHash::NUM_BYTES && "Invalid hash length");
  int j = 0;
  int w = 0;

  for (int i = 0; i < BlockHash::NUM_BYTES; ++i) {
    byte[0] = *(siter++);
    byte[1] = *(siter++);
    std::stringstream sin(byte);
    unsigned long long b;
    sin >> std::hex >> b;
    words[w] |= b << ((NUM_BYTES_IN_WORD - j - 1) * 8);
    ++j;
    if (j == NUM_BYTES_IN_WORD) {
      j = 0;
      ++w;
    }
  }
}

std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, const BlockHash &h)
{
  for (int i = 0; i < BlockHash::NUM_WORDS; ++i)
    os << std::setfill('0') << std::setw(16) << std::hex << h.words[i] << std::dec;
  return os;
}

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const BlockHash &h)
{
  std::ostringstream ss;
  ss << h;
  return os << ss.str();
}

} // namespace edbprof
