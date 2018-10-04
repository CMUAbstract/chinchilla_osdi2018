#include <string>
#include <vector>

namespace edbprof {

int findColumn(const std::vector<std::string>& columns,
               const std::string& col);
std::vector<std::string> tokenize(const std::string &str, char delim = ',');

// Returns a list of values specified by a range, like 1-5,7,9-15^2,9
std::vector<unsigned> parseRange(const std::string &range);

} // namespace edbprof
