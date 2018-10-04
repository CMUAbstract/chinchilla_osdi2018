#ifndef EDBPROF_PATH_H
#define EDBPROF_PATH_H

#include "EnergyDist.h"

#include <vector>
#include <utility>

namespace edbprof {

class BallLarusNode;

typedef enum {
    PATH_ELEM_BLOCK,
    PATH_ELEM_LOOP,
} PathElemType;

typedef enum {
  PATH_TYPE_NONE = 0, // for legacy code
  PATH_TYPE_LOOP,
  PATH_TYPE_PLAIN,
} PathType;

// An element that makes up a path through a task: a block or a loop
struct PathElem {
  PathElemType Type;
  DistExprPtr Energy;

  PathElem(PathElemType type, const DistExprPtr &energy) :
      Type(type), Energy(energy) { }

  virtual void print(std::ostream &os, unsigned level) const = 0;
  void debugPrint(unsigned level) const;
  virtual BallLarusNode *node() = 0;
};

typedef std::shared_ptr<PathElem> PathElemPtr;

struct Path;
typedef std::shared_ptr<Path> PathPtr;

struct Path {
  std::vector<PathElemPtr> Elems;
  DistExprPtr Energy;
  PathType Type;

  Path() : Type(PATH_TYPE_NONE) { } // for legacy code
  Path(PathType type) : Type(type) { }

  void print(std::ostream &os, unsigned level) const;
  void debugPrint(unsigned level) const;

  static bool compareByEnergy(const PathPtr &lhs, const PathPtr &rhs);
  static bool compareByMaxEnergy(const PathPtr &lhs, const PathPtr &rhs);
  static void printPaths(std::vector<PathPtr> &paths);
};

// A block and its energy
struct BlockPathElem : public PathElem {
  BallLarusNode *Node;

  BlockPathElem(const DistExprPtr &energy, BallLarusNode *node) :
    PathElem(PATH_ELEM_BLOCK, energy), Node(node) { }

  void print(std::ostream &os, unsigned level) const override;
  BallLarusNode *node() override { return Node; }
};

// The set of all paths through a loop body and meta info about the loop
struct LoopPathElem : public PathElem {
  BallLarusNode *Head;
  std::vector<PathPtr> LoopPaths;
  unsigned IterCount;

  LoopPathElem(const DistExprPtr &energy, BallLarusNode *head,
               std::vector<PathPtr> &loopPath, unsigned iterCount) :
    PathElem(PATH_ELEM_LOOP, energy), Head(head), LoopPaths(loopPath), IterCount(iterCount) { }

  void print(std::ostream &os, unsigned level) const override;
  BallLarusNode *node() override { return Head; }
};

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const PathType &pathType);
std::ostream& operator<<(std::ostream& os, const Path &path);

} // namespace edbprof

#endif // EDBPROF_PATH_H
