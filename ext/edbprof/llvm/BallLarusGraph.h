#ifndef EDBPROF_BALLLARUSGRAPH_H
#define EDBPROF_BALLLARUSGRAPH_H

#include "llvm/Pass.h"
#include "llvm/ADT/Twine.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"

#include <vector>
#include <map>
#include <set>

// Forward declarations
namespace llvm {
  class BasicBlock;
}

namespace edbprof {

  class BallLarusNode;
  class BallLarusEdge;
  class TaskBallLarusDag;

  typedef std::map<llvm::BasicBlock*, BallLarusNode *> BLBlkNodeMap;
  typedef std::vector<BallLarusEdge *> BLEdges;
  typedef std::vector<BallLarusNode *> BLNodes;
  typedef std::vector<BallLarusEdge *>::iterator BLEdgeIterator;
  typedef std::vector<BallLarusNode *>::iterator BLNodeIterator;

  typedef unsigned TaskId;
  typedef unsigned EdgeId;

  class Task {
   public:

    Task(TaskId id, std::string name, TaskBallLarusDag *dag)
      : Id(id), Name(name), Dag(dag),
        IsLoop(false), IsEntry(false), IsPseudo(false),
        PathProbSum(0.0) { }

    std::string getName() const;

    TaskId Id;
    std::string Name; // block names change as a result of instrumentation, so store
    TaskBallLarusDag *Dag;

    // This task was formed from a loop (by cutting with boundaries at loop entry and exit)
    bool IsLoop;

    // The first task in a function (it has no predecessor task)
    bool IsEntry;

    // Whether this task was inserted by edbprof to cut a loop, as opposed to
    // being created by the programmer with an explicit task boundary.
    bool IsPseudo;

    float PathProbSum; // sum of probabilities of all paths (for checking; should be 1.0)
  };

  class BallLarusNode {
  public:
    enum NodeColor {WHITE, GRAY, BLACK};
    BallLarusNode(llvm::BasicBlock *BB);
    llvm::BasicBlock* getBlock() const;
    llvm::Function* getFunc() const;
    void setBlock(llvm::BasicBlock* block);
    NodeColor getColor(void);
    void setColor(NodeColor color);
    void addSuccEdge(BallLarusEdge *edge);
    void removeSuccEdge(BallLarusEdge *edge);
    void addPredEdge(BallLarusEdge *edge);
    void removePredEdge(BallLarusEdge *edge);
    void addChild(BallLarusNode *node);
    BLEdgeIterator succBegin();
    BLEdgeIterator succEnd();
    BLEdgeIterator predBegin();
    BLEdgeIterator predEnd();
    BLNodeIterator childBegin();
    BLNodeIterator childEnd();
    int getNumSucc();
    int getNumPred();
    void setNumPaths(unsigned npaths);
    unsigned getNumPaths(void) const;
    void setNextNode(BallLarusNode *node);
    BallLarusNode * getNextNode(void);
    std::string getName(void) const;

  public:
    // TODO: move to a FuncBallLarusNode?
    bool IsTaskEntry;
    bool IsPseudoTask; // implies IsTaskEntry, and is an auto-inserted fake boundary
    Task *TaskObj;

    bool IsLoopEntry;
    bool IsLoopExit;
    bool IsLoopBody;
    unsigned LoopId;
    unsigned LoopIterCount;

    // Identifies the loop that contains this block (if any)
    BallLarusNode *ParentLoopHead;

    // These could be deduced by re-analyzing instructions in the block, but we
    // avoid the duplicate work by saving the result into these fields.
    bool IsCaller;
    bool IsCallee;

    // Loop entry nodes contain a reference to the *unique* loop exit node.
    // Assumption: all loops have unique exit nodes.  See some details about
    // this assumption in TaskEnergyEstimator comments.
    BallLarusNode *LoopExitNode;

    // This block contains a call to a function (and nothing else) whose energy
    // will be provided out-of-band, in a file
    llvm::Function *OpaqueCallee;

    // For linked-list of nodes that wrap the same basic block
    BallLarusNode *NextBlockNode;
    
  private:
    unsigned int uid;
    llvm::BasicBlock * _basicblock;    
    NodeColor _color;
    unsigned numPaths;

    std::vector<BallLarusNode *> children;
    BLEdges succEdges;
    BLEdges predEdges;
    BallLarusNode *next; // To implement Kruskals algo for spanning tree
  };

  class BallLarusEdge {
  public:
    enum Type {
      TYPE_REAL,
      TYPE_DUMMY,
    };

    BallLarusEdge(Type typ, BallLarusNode *src, BallLarusNode *dst):
        type(typ), _source(src), _dst(dst), Weight(0), Increment(0) { }
    virtual ~BallLarusEdge() {}

    Type getType() { return type; }
    bool isDummy() { return type != TYPE_REAL; }
    BallLarusNode * getSource();
    BallLarusNode * getDst();

    virtual void print();

  private:
    Type type;
    BallLarusNode * _source, *_dst;

  public:
    EdgeId Id; // uniquely identifies this edge in the DAG

    // The sum of weight values along a path is unique.
    unsigned Weight;

    // The set of edge increments contains the same information as the set of
    // edge weights, for identifying a path. However, while each edge has a
    // weight, only instrumented edges have an increment
    int Increment;
  };

  // An edge in per-task graph.
  class TaskBallLarusEdge : public BallLarusEdge {
   public:

    TaskBallLarusEdge(Type typ, BallLarusNode *src, BallLarusNode *dst)
      : BallLarusEdge(typ, src, dst) { }
  };

  // An edge in the per-function graph. A per-function graph object aggregates
  // the edge-weight assignments from per-task graph objects. That is, each
  // task assigns a weight to the same edge.
  class FuncBallLarusEdge : public BallLarusEdge {
   public:
    FuncBallLarusEdge(Type typ, BallLarusNode *src, BallLarusNode *dst)
      : BallLarusEdge(typ, src, dst), IsExit(false) { }

    void print();

    std::map<Task *, unsigned> MultiWeight; // task -> weight
    bool IsExit; // Whether the edge is the last edge before a task boundary
  };

  class BallLarusDag {
  public:

    typedef enum {
     PATH_TYPE_NONE,
     PATH_TYPE_LINEAR,
     PATH_TYPE_LOOP,
    } PathType;

    typedef struct {
      PathType type;
      std::vector<llvm::BasicBlock *> blocks;
    } Path;

    BallLarusDag(llvm::BasicBlock *entry, llvm::Pass *pass, const llvm::Twine &name);
    virtual ~BallLarusDag();

    const BallLarusNode * getExit(void) const { return exit; }
    /* const */ BallLarusNode * getEntry(void) const { return root; }
    const BLEdges &getChords() const { return _chords; }
    const BLEdges &getBackedges() const { return _backedges; }
    const BLEdges &getEdges() const { return edges; }
    /* const */ BLNodes &getNodes() /* const */ { return nodes; }

    unsigned getBlockInstanceCount(llvm::BasicBlock *block);
    unsigned countLoopReps(BallLarusNode *node);

    Path regenPath(unsigned sum);

    void print() const;
    void printTopology(const BLNodes &topoSort) const;
    void printEdges(const BLEdges &edges) const;
    void printNodes(const BLNodes &nodes) const;

    void log(const std::string &name);

    const llvm::Twine &getName() const { return instanceName; }

    static std::string pathTypeToStr(PathType pathType);

  protected:
    BallLarusNode *createNode(llvm::BasicBlock *BB);
    BallLarusNode *addNode(llvm::BasicBlock *BB);
    void setExit(BallLarusNode *node);
    void setEntry(BallLarusNode *node);
    BallLarusEdge *addEdge(BallLarusEdge *edge);
    void removeEdge(BallLarusEdge *edge);
    bool isLeafNode(BallLarusNode *node);

    void eliminateBackedges(const BLEdges &backedges);
    void findBackedges(BallLarusNode *node, std::vector<BallLarusNode *> &path,
                       std::set<BallLarusEdge *> &backedges);
    BLEdges findBackedges();
    void sortTopo(BallLarusNode *node, BLNodes &nodes);
    BLEdges findSpanningTree();
    BLEdges findChords(const BLEdges &spanningTree);
    void numberEdges(const BLNodes &topoSort);
    int getDir(BallLarusEdge *e, BallLarusEdge *f);
    void calculateIncrement(const BLEdges &spanningTree, const BLEdges &chords,
                            int events, BallLarusNode *node,
                            BallLarusEdge *theEdge);
    PathType regenPath(unsigned sum, BallLarusNode *node, PathType pathType,
                       std::vector<llvm::BasicBlock *> &path);

    BallLarusNode *root;
    BallLarusNode *exit;
    BLEdges edges;
    BLNodes nodes;

    BLEdges _chords;
    BLEdges _backedges;

    std::map<llvm::BasicBlock *, unsigned> blockInstanceCount;

    llvm::Pass *pass;
    llvm::Twine instanceName;
  };

  // A per-function DAG. Each function contains a set of tasks.
  // Instrumentation is done based on information in this object.
  class FuncBallLarusDag : public BallLarusDag {

   public:
    FuncBallLarusDag(llvm::BasicBlock *entry, llvm::Pass *pass, const llvm::Twine &name);

    std::vector<Task *>& getTasks() { return tasks; }
    bool isLoopBlock(llvm::BasicBlock *block);

    void markLoops(BallLarusNode *node,
                   std::vector<BallLarusNode *> &funcPath,
                   std::vector<BallLarusNode *> taskPath);

    void unmarkLoops(BallLarusNode *node, std::set<BallLarusNode *> &visitedNodes);

   private: 

    struct StackFrame {
      llvm::BasicBlock *Caller;
      llvm::BasicBlock *Callee;
      llvm::BasicBlock *CallerSucc;

      StackFrame(llvm::BasicBlock *caller, llvm::BasicBlock *callee,
                 llvm::BasicBlock *callerSucc) :
        Caller(caller), Callee(callee), CallerSucc(callerSucc) { }
    };

    typedef std::vector<StackFrame> CallStack;

    BallLarusNode *construct(llvm::BasicBlock *block, BallLarusNode *parent, CallStack callStack);

    void constructTaskDags(BallLarusNode *node, std::vector<BallLarusNode *> &path,
                           bool isEntryTask);

    bool compareCallStack(BallLarusNode *node, CallStack &callStack,
                          std::vector<llvm::Function *> &returnStack);
    BallLarusNode *lookupNode(llvm::BasicBlock *block, const CallStack &callStack);
    BallLarusNode * lookupBlockNodeListTail(llvm::BasicBlock *block);
    void appendNodeToBlockNodeList(BallLarusNode *node);


    void calcWeights(BallLarusNode *node, std::set<BallLarusNode *>& seenNodes);
    void transferWeights(Task *task, BallLarusNode *funcNode, BallLarusNode *taskNode);

    // Place a pseudo task boundary before and after each *intra-task* loop
    void cutLoops(BallLarusNode *node, std::set<BallLarusNode *> &visistedNodes);

    void loadOpaqueFunctions(const llvm::Twine &fname);
    void loadLoopIterCounts(const llvm::Twine &fname);

    unsigned lookupProfiledLoopIterCount(llvm::Pass *pass, BallLarusNode *loopHead);

   private:
    std::vector<Task *> tasks;
    std::set<std::string> opaqueFunctions;

    // profiled loop iter counts: (func x loop id) -> count
    std::map< std::string, std::map<unsigned, unsigned> > loopIterCountProfile;

    // basic block -> list of BLD nodes that wrap that block
    // NOTE: The list is a linked list using a pointer in BallLarusNode type.
    // These lists are used to determine wether we have reached a
    // node that we already visited (same block *and* same call stack
    // -- note that these do not imply "reached via same path").
    std::map<llvm::BasicBlock *, BallLarusNode *> blockNodeLists;

    // TODO: factor into a dedicated loop marking pass
    std::set<llvm::BasicBlock*> loopBlocks;
  };

  // A per-task DAG.
  class TaskBallLarusDag : public BallLarusDag {
   public:
    TaskBallLarusDag(BallLarusNode *node, llvm::Pass *pass, const llvm::Twine &name);

  private:
    BallLarusNode *construct(BallLarusNode *node, std::vector<BallLarusNode *> &path);
  };

  llvm::raw_ostream& operator<<(llvm::raw_ostream& os, BallLarusNode *node);

} // end edbprof namespace

#endif // EDBPROF_BALLLARUSGRAPH_H
