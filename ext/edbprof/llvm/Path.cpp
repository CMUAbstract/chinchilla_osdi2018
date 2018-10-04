#include "Path.h"

#include "BallLarusGraph.h"

#include <string>

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#define DEBUG_TYPE "Path"

using namespace llvm;

namespace edbprof {

void PathElem::debugPrint(unsigned level) const
{
    std::stringstream os;
    this->print(os, level);
    DEBUG(dbgs() << os.str());
}

bool Path::compareByEnergy(const PathPtr &lhs, const PathPtr &rhs)
{
  assert(lhs->Energy);
  assert(rhs->Energy);
  return *lhs->Energy < *rhs->Energy;
}

bool Path::compareByMaxEnergy(const PathPtr &lhs, const PathPtr &rhs)
{
  assert(lhs->Energy);
  assert(rhs->Energy);
  return lhs->Energy->MaxValue < rhs->Energy->MaxValue;
}

void Path::print(std::ostream &os, unsigned level) const
{
  std::string indent(level * 4, ' ');
#if 0
  if (Energy.get())
    os << "(energy " << *Energy << ")";
#endif
  os << "\n";
  for (auto elem = Elems.rbegin(); elem != Elems.rend(); ++elem)
    (*elem)->print(os, /* level */ 0);
}

void Path::debugPrint(unsigned level) const
{
    std::stringstream os;
    this->print(os, level);
    DEBUG(dbgs() << os.str());
}

void BlockPathElem::print(std::ostream &os, unsigned level) const
{
  std::string indent(level * 4, ' ');
  os << indent << Node->getName()
#if 0
      << " " << *Energy
#endif
      << "\n";
}

void LoopPathElem::print(std::ostream &os, unsigned level) const
{
  std::string indent(level * 4, ' ');
  os << indent << "LOOP: #paths " << LoopPaths.size() << "\n";
  unsigned pathIdx = 0;
  for (const auto& path: LoopPaths) {
    os << indent << "  path " << pathIdx++ << ":\n";
    for (auto elem = path->Elems.rbegin(); elem != path->Elems.rend(); ++elem)
      (*elem)->print(os, level + 1);
  }
}

void Path::printPaths(std::vector<PathPtr> &paths)
{
  unsigned pathIdx = 0;
  DEBUG(dbgs() << "paths (total " << paths.size() << ")\n");
  for (const auto &path : paths) {
    DEBUG(dbgs() << "path " << pathIdx++ << ":\n");
    std::ostringstream os;
    DEBUG(path->print(os, /* level */ 0));
    DEBUG(dbgs() << os.str());
  }
}

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const PathType &pathType)
{
  const char *s;
  switch (pathType) {
    case PATH_TYPE_NONE: s = "none"; break;
    case PATH_TYPE_PLAIN: s = "plain"; break;
    case PATH_TYPE_LOOP: s = "loop"; break;
    default: assert(false && "invalid path type");
  }
  return os << s;
}

std::ostream& operator<<(std::ostream& os, const Path &path)
{
    path.print(os, /* level */ 0);
    return os;
}

} // edbprof
