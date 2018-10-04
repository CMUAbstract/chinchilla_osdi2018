#include <string>
#include <vector>
#include <algorithm>

#include "llvm/ADT/Twine.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include "CommaSeparatedValues.h"

#define DEBUG_TYPE "CommaSeparatedValues"

using namespace llvm;

namespace edbprof {

  int findColumn(const std::vector<std::string>& columns,
                 const std::string& col) {
    auto colIter = std::find(columns.begin(), columns.end(), col);
    if (colIter == columns.end()) {
      errs() << Twine("column '") + col + Twine("' not found in dataset\n");
      assert(false && "Column not found in dataset");
    }
    return colIter - columns.begin();
  }

  std::vector<std::string> tokenize(const std::string &str, char delim) {
    std::vector<std::string> tokens;
    auto start = str.begin();
    do {
      auto end = start;
      while (end != str.end() && *end != delim)
        ++end;
      tokens.push_back(std::string(start, end));
      start = end;
    } while (start++ != str.end());
    return tokens;
  }

  std::vector<unsigned> parseRange(const std::string &range)
  {
    DEBUG(dbgs() << "parsing range: " << range << "\n");

    std::vector<unsigned> values;
    const auto &subranges = tokenize(range, ',');
    for (const auto &subrange : subranges) {
      assert(!subrange.empty() && "invalid range specifier");
      if (subrange.find('-') != std::string::npos) {

        std::string endpointsStr = subrange;
        unsigned step = 1;
        if (subrange.find('^') != std::string::npos) {
          const auto &parts = tokenize(subrange, '^');
          assert(parts.size() == 2 && "invalid range specifier");
          endpointsStr = parts[0];
          step = std::atol(parts[1].c_str());
        }

        const auto &endpoints = tokenize(endpointsStr, '-');
        assert(endpoints.size() == 2 && "invalid range specifier");
        unsigned from = std::atol(endpoints[0].c_str());
        unsigned to = std::atol(endpoints[1].c_str());
        assert(from <= to && "invalid range specifier");
        for (unsigned i = from; i <= to; i += step)
          values.push_back(i);
      } else {
        values.push_back(std::atol(subrange.c_str()));
      }
    }

    DEBUG(dbgs() << "range values: ");
    for (unsigned value : values)
      DEBUG(dbgs() << value << " ");
    DEBUG(dbgs() << "\n");

    return values;
  }

} // namespace edbprof
