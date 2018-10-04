//===- PathProfile.cpp "Code to distinguish different paths in each function"--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Attributes.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DIBuilder.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/MC/MCSymbol.h"

#include "llvm/Support/GraphWriter.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"

#include "FatalOptimizationFailure.h"
#include "Tasks.h"
#include "BallLarusGraphTraits.h"
#include "CommaSeparatedValues.h"
#include "CLI.h"
#include "Loops.h"

#include "BallLarusGraph.h"

#define DEBUG_TYPE "BallLarusGraph"

// #define DEBUG_LOG_MARK_LOOPS

using namespace llvm;

namespace {

  // legacy compatibility
  void logGraph(const std::string& name, edbprof::BallLarusDag *G) {
    G->log(name);
  }

} // namespace anon

namespace edbprof {

BallLarusNode::BallLarusNode(llvm::BasicBlock *BB)
  : IsTaskEntry(false),
    IsPseudoTask(false),

    TaskObj(NULL),

    IsLoopEntry(false),
    IsLoopExit(false),
    IsLoopBody(false),
    LoopId(0),
    LoopIterCount(0),

    ParentLoopHead(nullptr),

    IsCaller(false),
    IsCallee(false),

    OpaqueCallee(nullptr),

    NextBlockNode(nullptr),

    _basicblock(BB),
    _color(WHITE),

    numPaths(0)
{
    static unsigned uuid = 0;
    uid = uuid++;
    next = NULL;
}

BasicBlock * BallLarusNode::getBlock(void) const {
    return (_basicblock);
}

Function * BallLarusNode::getFunc(void) const {
    return _basicblock->getParent();
}

std::string BallLarusNode::getName(void) const {
    assert(_basicblock);
    assert(_basicblock->getParent());
    return (_basicblock->getParent()->getName() + "-" + _basicblock->getName()).str();
}

void BallLarusNode::setBlock(llvm::BasicBlock* block) {
  _basicblock = block;
}

void BallLarusNode::setColor(BallLarusNode::NodeColor color) {
    _color = color;
}

BallLarusNode::NodeColor BallLarusNode::getColor(void) {
    return _color;
}

void BallLarusNode::addSuccEdge(BallLarusEdge *edge) {
    assert(edge->getSource()->getBlock() == getBlock() &&
            "Edge being added does not originate from this node");
    succEdges.push_back(edge);
}

void BallLarusNode::removeSuccEdge(BallLarusEdge *edge) {
    for (auto succ = succEdges.begin(); succ != succEdges.end(); ++succ) {
      if (*succ== edge) {
        succEdges.erase(succ);
        break;
      }
    }
}

void BallLarusNode::addPredEdge(BallLarusEdge *edge) {
    assert(edge->getDst()->getBlock() == getBlock() &&
            "Edge being added does not point to this node");
    predEdges.push_back(edge);
}

void BallLarusNode::removePredEdge(BallLarusEdge *edge) {
    for (auto pred = predEdges.begin(); pred != predEdges.end(); ++pred) {
      if (*pred == edge) {
        predEdges.erase(pred);
        break;
      }
    }
}

void BallLarusNode::addChild(BallLarusNode *node) {
    children.push_back(node);
}

void BallLarusNode::setNumPaths(unsigned n) {
   numPaths = n; 
}

unsigned BallLarusNode::getNumPaths(void) const {
    return numPaths;
}

BallLarusNode * BallLarusNode::getNextNode() {
    return next;
}

void BallLarusNode::setNextNode(BallLarusNode *node) {
    next = node;
}

BLEdgeIterator BallLarusNode::succBegin() {
    return succEdges.begin();
}

BLEdgeIterator BallLarusNode::succEnd() {
    return succEdges.end();
}

BLEdgeIterator BallLarusNode::predBegin() {
    return predEdges.begin();
}

BLEdgeIterator BallLarusNode::predEnd() {
    return predEdges.end();
}

BLNodeIterator BallLarusNode::childBegin() {
    return children.begin();
}

BLNodeIterator BallLarusNode::childEnd() {
    return children.end();
}

int BallLarusNode::getNumPred() {
    return predEdges.size();
}

int BallLarusNode::getNumSucc() {
    return succEdges.size();
}

BallLarusNode * BallLarusEdge::getSource() {
    return _source;
}
BallLarusNode * BallLarusEdge::getDst() {
    return _dst;
}

void BallLarusEdge::print()
{
      DEBUG(dbgs() << ": weight " << Weight << " inc " << Increment);
}

void FuncBallLarusEdge::print()
{
      DEBUG(dbgs() << ": weight " << Weight
            << " inc " << Increment
            << " weights ");

    for (auto weight = MultiWeight.begin(); weight != MultiWeight.end(); ++weight)
    {
      DEBUG(dbgs() << " (task " << weight->first->getName() << ", weight " << weight->second << "),");
    }
}


BallLarusEdge *BallLarusDag::addEdge(BallLarusEdge *edge) {
#if 0
    for (BLEdgeIterator edge = src->succBegin(), end = src->succEnd(); edge != end; ++edge) {
        if ((*edge)->getDst() == dst)
            return *edge;
    }
#else
    assert(std::all_of(edge->getSource()->succBegin(), edge->getSource()->succEnd(),
           [&] (BallLarusEdge *e) { return e->getDst() != edge->getDst(); })
          && "edge already exists");
#endif
#if 0
    BallLarusEdge *edge = new BallLarusEdge(type, src, dst);
#endif

    assert(edge->getSource() && "Edge without a source");
    assert(edge->getDst() && "Edge without a dest");

    DEBUG(dbgs() << "adding successor to "
        << edge->getSource()->getBlock()->getName() << ": "
        << edge->getSource()->getBlock()->getName() << " -> "
        << edge->getDst()->getBlock()->getName() << "\n");

    edge->getSource()->addSuccEdge(edge);
    edge->getDst()->addPredEdge(edge);

    edge->Id = edges.size();

    edges.push_back(edge);

    edge->getSource()->addChild(edge->getDst());

    return edge;
}

void BallLarusDag::removeEdge(BallLarusEdge *edge) {
    BLEdges::iterator e;
    for (e = edges.begin(); e != edges.end(); ++e) {
      if (*e == edge)
        break;
    }
    assert(e != edges.end() && "Edge to be removed not found");

    edge->getSource()->removeSuccEdge(edge);
    edge->getDst()->removePredEdge(edge);

    edges.erase(e);
}

BallLarusNode * BallLarusDag::createNode(BasicBlock *BB) {
    auto count = blockInstanceCount.find(BB);
    if (count == blockInstanceCount.end())
        blockInstanceCount[BB] = 1;
    else
        count->second++;
    return (new BallLarusNode(BB));
}

BallLarusNode *BallLarusDag::addNode(BasicBlock *BB) {
    BallLarusNode *Node = createNode(BB);
    nodes.push_back(Node);
    return Node;
}

bool BallLarusDag::isLeafNode(BallLarusNode *node) {
    // Don't count dummy backedge from EXIT to ENTRY
    return node->succBegin() == node->succEnd() ||
           (*(node->succBegin()))->getDst() == root;
}

BallLarusDag::BallLarusDag(BasicBlock *entry, llvm::Pass *pass, const llvm::Twine &name)
    : root(nullptr), exit(nullptr), edges(), nodes(), pass(pass), instanceName(name)
{
#if 0 // TODO: delete
  construct(F, &F.getEntryBlock(), nullptr /* parent */);
  DEBUG(dbgs() << "Control flow DAG:\n");
  DEBUG(print());
  DEBUG(dbgs() << "\n");

  const auto& backedges = findBackedges();
  _backedges = backedges; // save to expose via public iface

  eliminateBackedges(backedges);
  DEBUG(dbgs() << "Control flow DAG without backedges:\n");
  DEBUG(print());
  DEBUG(dbgs() << "\n");

  // TODO: Sort the nodes array in place
  BLNodes topoSort;
  sortTopo(root, topoSort);
  DEBUG(printTopology(topoSort));
  DEBUG(dbgs() << "\n");

  // Add the dummy backedge from EXIT to ENTRY required for weight calc
  // but only if this is not a self-loop.
  if (nodes.size() > 1)
    addEdge(BallLarusEdge::TYPE_DUMMY, exit, root);

  numberEdges(topoSort);
  DEBUG(dbgs() << "Node num paths:\n");
  DEBUG(printNodes(nodes));
  DEBUG(dbgs() << "Edge weights:\n");
  DEBUG(printEdges(edges));
  DEBUG(dbgs() << "\n");

  const auto& spanningTree = findSpanningTree();
  DEBUG(dbgs() << "Spanning tree:\n");
  DEBUG(printEdges(spanningTree));
  DEBUG(dbgs() << "\n");

  const auto& chords = findChords(spanningTree);
  _chords = chords; // save to expose via public iface

  DEBUG(dbgs() << "Chords:\n");
  DEBUG(printEdges(chords));
  DEBUG(dbgs() << "\n");

  calculateIncrement(spanningTree, chords, 0, root, NULL);
  for (auto chord = chords.begin(); chord != chords.end(); ++chord) {
    (*chord)->setIncrement((*chord)->Increment + (*chord)->Weight);
  }

  DEBUG(dbgs() << "Chord increments:\n");
  DEBUG(printEdges(chords));
#endif
}

BallLarusDag::~BallLarusDag() {
    for (BLNodeIterator node=nodes.begin(), enode = nodes.end(); node != enode; ++node)
        delete *node;
    for (BLEdgeIterator edge=edges.begin(), end = edges.end(); edge != end; ++edge)
        delete (*edge);
}


unsigned BallLarusDag::getBlockInstanceCount(BasicBlock *block)
{
  return blockInstanceCount[block];
}

unsigned BallLarusDag::countLoopReps(BallLarusNode *node)
{
  unsigned reps = 1;
  BallLarusNode *loopHead = node->ParentLoopHead;
  while (loopHead) {
#ifdef DEBUG_LOG_MARK_LOOPS
    DEBUG(dbgs() << "loop reps: node " << node
                 << " loop head " << node->ParentLoopHead
                 << " id " << node->ParentLoopHead->LoopId
                 << " count " << node->ParentLoopHead->LoopIterCount << "\n");
#endif
    reps *= loopHead->LoopIterCount;
    loopHead = loopHead->ParentLoopHead;
  }

#ifdef DEBUG_LOG_MARK_LOOPS
  DEBUG(dbgs() << "loop reps: node " << node << " reps " << reps << "\n");
#endif
  return reps;
}

#if 0 // TODO: delete
void BallLarusDag::construct(Function &F, BasicBlock *block,
                             BallLarusNode *parent)
{
  auto node = addNode(block);

  DEBUG(dbgs() << "found block: " << block->getName() << "\n");

  if (parent) { // root doesn't have a parent
    addEdge(BallLarusEdge::TYPE_REAL, parent, node);
  } else {
    root = node;
  }

#if 0
  // Detect and record the exit block (we support only one exit)
  if (succ_begin(block) == succ_end(block)) {
    DEBUG(dbgs() << "found exit block: " << block->getName() << "\n");
    if (exit) {
      block->getContext().diagnose(
          DiagnosticInfoFatalOptimizationFailure(
            F, block->getFirstNonPHI()->getDebugLoc(),
            "more than one exit block, only one supported"));
    }
    exit = node;
  }
#endif

  for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
    std::vector<BallLarusNode *>::iterator dagNode;
    for (dagNode = nodes.begin(); dagNode != nodes.end(); ++dagNode) {
      if ((*dagNode)->getBlock() == *succ)
        break;
    }
    if (dagNode != nodes.end()) { // add the edge, but don't follow
      addEdge(BallLarusEdge::TYPE_REAL, node, *dagNode);
    } else {
      construct(F, *succ, node);
    }
  }
}
#endif

FuncBallLarusDag::FuncBallLarusDag(BasicBlock *entry, llvm::Pass *pass, const llvm::Twine &name)
    : BallLarusDag(entry, pass, name)
{
    if (OpaqueFunctionsFilename.size())
      loadOpaqueFunctions(OpaqueFunctionsFilename);
    if (LoopIterCountsFilename.size())
      loadLoopIterCounts(LoopIterCountsFilename);

    DEBUG(dbgs() << "creating func DAG '" << getName() << "'\n");
    std::vector<StackFrame> callStack;
    root = construct(entry, /* parent */ nullptr, callStack);
    print();

    DEBUG(dbgs() << "mark loops\n");
    std::vector<BallLarusNode *> funcPath; // passed by ref
    std::vector<BallLarusNode *> taskPath; // passed by value
    markLoops(root, funcPath, taskPath);

    logGraph("func", this);

    DEBUG(dbgs() << "Constructed func DAG:\n");
    printNodes(nodes);
    printEdges(edges);

    if (IsolateLoops) {
      DEBUG(dbgs() << "isolate loops: cut loops\n");
      std::set<BallLarusNode *> visitedNodes;
      cutLoops(root, visitedNodes);
      logGraph("loopless", this);
    }

    if (ConstructTaskDAGs) {
      std::vector<BallLarusNode *> path;
      constructTaskDags(root, path, /* isEntryTask */ true);

      std::set<BallLarusNode *> seenNodes;
      calcWeights(root, seenNodes);
    }

    DEBUG(dbgs() << "Func DAG:\n");
    printNodes(nodes);
    printEdges(edges);
}


void FuncBallLarusDag::loadOpaqueFunctions(const Twine &fname)
{
  DEBUG(dbgs() << "loading opaque function list: " << fname << "\n");

  std::ifstream fin(fname.str().c_str());
  assert(fin.good() && "failed to open opaque func list file");

  // Skip CSV header
  std::string header;
  fin >> header;

  while (fin.good()) {
    std::string line;
    fin >> line;

    if (line.size() == 0)
      continue;

    const auto &tokens = tokenize(line);
    assert(tokens.size() == 3 && "failed to parse opaque functions dataset");

    const std::string &func = tokens[0];

    DEBUG(dbgs() << "loaded opaque func: '" << func << "'\n");

    opaqueFunctions.insert(func);
  }
}

void FuncBallLarusDag::loadLoopIterCounts(const Twine &fname)
{
  DEBUG(dbgs() << "loading loop iter counts profile: " << fname << "\n");

  std::ifstream fin(fname.str().c_str());
  assert(fin.good() && "failed to open loop iter counts list file");

  // Skip CSV header
  std::string header;
  fin >> header;

  while (fin.good()) {
    std::string line;
    fin >> line;

    if (line.size() == 0)
      continue;

    const auto &tokens = tokenize(line);
    assert(tokens.size() == 4 && "failed to parse opaque functions dataset");

    const std::string &func = tokens[0];
    unsigned loopId = std::atoi(tokens[1].c_str());
    const std::string &var = tokens[2];
    unsigned iterCount = std::atoi(tokens[3].c_str());

    // ignore lines for other variables
    if (var != "max")
      continue;

    DEBUG(dbgs() << "loaded loop: '" << func << "' loop " << loopId << ": "
                 << "iter count " << iterCount << "\n");

    if (loopIterCountProfile.find(func) == loopIterCountProfile.end())
        loopIterCountProfile[func] = std::map<unsigned, unsigned>();
    loopIterCountProfile[func][loopId] = iterCount;
  }
}

unsigned FuncBallLarusDag::lookupProfiledLoopIterCount(llvm::Pass *pass, BallLarusNode *loopHead)
{
    unsigned loopId = lookupLoopId(pass, loopHead->getBlock());
    if (!loopId) // loop wasn't profiled
      return 0;

    const auto &funcName = loopHead->getBlock()->getParent()->getName();
    const auto &funcLoops = loopIterCountProfile.find(funcName);
    if (funcLoops != loopIterCountProfile.end()) {
      const auto &iterCount = funcLoops->second.find(loopId);
      if (iterCount != funcLoops->second.end()) {
        return iterCount->second;
      }
    }
    return 0;
}

// Compare a given call stack to a call stack reconstructed by traversing
// the BLD from a node backwards.
//
// Returns true on match, false otherwise.
//
// NOTE: returnStack exists to eat up call/return pairs which are not present
// in the reference call stack (because they happend in the past), but are
// visible to the comparison candidate, as we traverse the BLD backwards.
// We could just keep a depth, but we keep the function names for cross-checking
// purposes. We don't know the call/return blocks, we can check only function.
// This is evident if we consider a callee with many blocks between entry and
// return -- when we hit the return, we have no information linking that return
// to the entry block that we will eventually find, other than that both should
// be in the same function.
bool FuncBallLarusDag::compareCallStack(BallLarusNode *node, CallStack &callStack,
                                        std::vector<Function *> &returnStack)
{

  DEBUG(dbgs() << "comparing call stack: node " << node->getName() << " call stack:\n");
  for (auto &frame : callStack)
    DEBUG(dbgs() << "(" << frame.Caller->getParent()->getName() << ":"
                 << frame.Caller->getName()
                 << " " << frame.Callee->getParent()->getName() << ":"
                 << frame.Callee->getName()
                 << " " << frame.CallerSucc->getParent()->getName() << ":"
                 << frame.CallerSucc->getName() << ")\n");
  DEBUG(dbgs() << " paired reverse stack:\n");
  for (auto &F : returnStack)
    DEBUG(dbgs() << F->getName() << " ");
  DEBUG(dbgs() << "\n");


  // assert: upward path along any of the predecessors has the same call stack
  // so we pick the first one

  auto predEdge = node->predBegin();

  // if we are at root, call stack needs to be empty to match
  if (predEdge == node->predEnd()) {
    DEBUG(dbgs() << "compare call stack: no predecessors, call stack size "
                 << callStack.size() << "\n");
    return callStack.size() == 0;
  }

  BallLarusNode *pred = (*predEdge)->getSource();
  DEBUG(dbgs() << "compare call stack: pred " << pred->getName() << "\n");

  // Is the current block a return destination (i.e. we are the caller, our
  // predecessor is the callee)?
  if (pred->IsCallee) {
    DEBUG(dbgs() << "pred " << pred->getName() << " is callee: "
                 << "pushing func on reverse stack: "
                 << pred->getBlock()->getParent()->getName() << "\n");
    returnStack.push_back(pred->getBlock()->getParent());
    return compareCallStack(pred, callStack /* unchanged */, returnStack);
  }

  // Is the current block a call destination (i.e. we are the callee, our
  // predecessor is the caller)?
  if (pred->IsCaller) {
    DEBUG(dbgs() << "pred " << pred->getName() << " is caller: "
                 << "reverse stack size: " << returnStack.size() << "\n");
    if (returnStack.size() > 0) {
      DEBUG(dbgs() << "popping func from reverse stack: "
                   << returnStack.back()->getName()
                   << "(node " << node->getBlock()->getParent()->getName() << ")\n");
      assert(returnStack.back() == node->getBlock()->getParent());
      returnStack.pop_back();
      return compareCallStack(pred, callStack /* unchanged */, returnStack);
    } else {
      if (callStack.size() == 0) {
        DEBUG(dbgs() << "call stack does not match: ref stack empty, but we have a caller\n");
        return false;
      }

      StackFrame frame = callStack.back();
      callStack.pop_back(); 

      DEBUG(dbgs() << "popped frame from ref stack: "
                   << "(" << frame.Caller->getParent()->getName() << ":"
                   << frame.Caller->getName()
                   << " " << frame.Callee->getParent()->getName() << ":"
                   << frame.Callee->getName()
                   << " " << frame.CallerSucc->getParent()->getName() << ":"
                   << frame.CallerSucc->getName() << ") "
                   << " node " << node->getName()
                   << " pred " << pred->getName() << "\n");

      if (!(frame.Callee == node->getBlock() &&
            frame.Caller == pred->getBlock())) {
        DEBUG(dbgs() << "call stack mismatch: callee and/or caller differ\n");
        return false;
      }

      DEBUG(dbgs() << "matched: comparing remaining frames\n");
      return compareCallStack(pred, callStack /* one smaller */, returnStack);
    }
  }

  DEBUG(dbgs() << "edge to predecessor has neither call nor return\n");
  return compareCallStack(pred, callStack /* unchanged */, returnStack); 
}

// Find if we already were 'here' where 'here' is at the same basic block with
// the same call stack (not necessarily having traversed the same path). Note:
// in our BLD, we inline (expand) functions, but we do not expand paths!
BallLarusNode *FuncBallLarusDag::lookupNode(BasicBlock *block, const CallStack &callStack)
{
  // Look for the head node of the list of nodes, which wrap the given block
  auto nodeList = blockNodeLists.find(block); // get head of the linked-list
  if (nodeList == blockNodeLists.end()) {
    DEBUG(dbgs() << "lookup node for block " << block->getParent()->getName()
                 << ":" << block->getName() << " + call stack [...]: "
                 << "no nodes found\n");
    return nullptr;
  }

  // Traverse the list and look for a matching call stack
  BallLarusNode *node = nodeList->second;
  while (node) {
    // make a copy b/c comparison is destructive for efficiency purposes
    std::vector<StackFrame> callStackCopy(callStack);
    std::vector<Function *> returnStack; // state for recursive call
    if (compareCallStack(node, callStackCopy, returnStack)) {
      DEBUG(dbgs() << "lookup on block " << block->getParent()->getName()
                   << " + call stack [...]:"
                   << block->getName() << " found a matching node: "
                   << node->getName() << "\n");
      return node;
    }
    node = node->NextBlockNode;
  }

  DEBUG(dbgs() << "lookup on block " << block->getParent()->getName() << ":"
               << block->getName() << " + call stack [...]: "
               << "did not find a matching node\n");
  return nullptr;
}

// Lookup the list of nodes that all wrap the given block. Return the tail of
// that list, or null if there are no nodes that wrap the given block.
BallLarusNode * FuncBallLarusDag::lookupBlockNodeListTail(BasicBlock *block)
{
  // Look for the head node of the list of nodes, which wrap the given block
  auto nodeList = blockNodeLists.find(block); // get head of the linked-list
  if (nodeList == blockNodeLists.end()) {
    DEBUG(dbgs() << "lookup node list for block " << block->getParent()->getName()
                 << ":" << block->getName() << ": not found\n");
    return nullptr;
  }

  // Traverse the list and look for a matching call stack
  BallLarusNode *node = nodeList->second;
  while (node->NextBlockNode)
    node = node->NextBlockNode;

  DEBUG(dbgs() << "lookup node list for block " << block->getParent()->getName()
               << ":" << block->getName() << ": tail node "
               << node->getName() << "\n");
  return node;
}

void FuncBallLarusDag::appendNodeToBlockNodeList(BallLarusNode *node)
{
  BallLarusNode *blockNodeListTail = lookupBlockNodeListTail(node->getBlock());
  if (blockNodeListTail) {
    DEBUG(dbgs() << "appending node to block node list: "
                 << node->getName() << "\n");
    blockNodeListTail->NextBlockNode = node;
  } else {
    DEBUG(dbgs() << "creating block node list: " << node->getName() << "\n");
    blockNodeLists[node->getBlock()] = node;
  }
}

BallLarusNode *FuncBallLarusDag::construct(BasicBlock *block, BallLarusNode *parent, CallStack callStack)
{
  auto node = addNode(block);
  appendNodeToBlockNodeList(node);

  if (parent) { // the root node will have no incoming edge
    auto edge = new FuncBallLarusEdge(BallLarusEdge::TYPE_REAL, parent, node);
    // TODO: cleanup

    DEBUG(dbgs() << "new block " << block->getParent()->getName() << ":" << block->getName()
                 << ":  adding edge: "
                 << edge->getSource()->getBlock()->getParent()->getName() << ":"
                 << edge->getSource()->getBlock()->getName()
                 << "->"
                 << edge->getDst()->getBlock()->getParent()->getName() << ":"
                 << edge->getDst()->getBlock()->getName() << "\n");
    addEdge(edge);
  }

  node->IsTaskEntry = isTaskBoundary(block);

  DEBUG(dbgs() << "func dag: added block: " << block->getParent()->getName()
               << "-" << block->getName()
               << " isTaskEntry " << node->IsTaskEntry << "\n");


  // Check for calls. The call is never a terminator, but the instruction
  // before the terminator, i.e. penultimate instruction. Note that we
  // assume the TaskSplitter pass has split blocks at calls (such that
  // the call is part of the preceding block). Because the call is
  // never a terminator, the size of a block that "ends" with a call must
  // be at least two instructions long.
  bool hasCall = false, hasReturn = false;
  CallInst *callInst = nullptr;
  ReturnInst *retInst = nullptr;
  if (InlineCalls) {
    Instruction *termInst = block->getTerminator();
    Instruction *penultimateInst;

    assert(termInst && "block without a terminator instruction");

    if (block->size() > 1) { // call is never last (see comment above)
      penultimateInst = termInst->getPrevNode();
      assert(penultimateInst && "no penultimate instruction in block");
      callInst = llvm::dyn_cast<CallInst>(penultimateInst);
    }

    retInst = llvm::dyn_cast<ReturnInst>(termInst);

    hasCall = callInst != nullptr && !isCallTo(*callInst, TaskBoundaryFunctionName); // TODO: exclude DINO func too
    hasReturn = retInst != nullptr && callStack.size() > 0; // exclude "final" returns

    DEBUG(dbgs() << "construct: block " << block->getParent()->getName() << ":"
                 << block->getName() << " terminator "
                 << termInst->getOpcodeName() << " penultimate inst "
                 << (penultimateInst ? penultimateInst->getOpcodeName() : nullptr)
                 << " hasCall " << hasCall << " hasReturn " << hasReturn << "\n");
  }

  BallLarusNode *child;

  // Need to do some filtering ahead of time
  Function *func = nullptr;
  if (hasCall) {
      DEBUG(dbgs() << "construct: block ends with a call: checking callee\n");

      hasCall = false; // deny by default

      assert(callInst && "call without a call instruction");
      func = callInst->getCalledFunction();
      if (func) {
        DEBUG(dbgs() << "checking filter criteria for call to: " << func->getName() << "\n");

        if (!isFunctionSpecial(*func)) {
          if (!func->empty()) {
            if (opaqueFunctions.find(func->getName()) == opaqueFunctions.end()) {
              DEBUG(dbgs() << "processing call to function '" << func->getName() << "'\n");
              hasCall = true;
            } else {
              DEBUG(dbgs() << "function excluded from profiling since it is marked opaque\n");
              node->OpaqueCallee = func;
            }
          } else {
            assert(false && "not supported: external (out-of-module) function call");
            //DEBUG(dbgs() << "skipping function '" << func->getName() << "': external\n");
          }
        } else {
          DEBUG(dbgs() << "call: callee func " << func->getName() << " blacklisted\n");
        }
      } else {
        DEBUG(dbgs() << "WARNING: call without a called function (ignored)\n");
      }
  }

  if (hasCall || hasReturn) {
    if (hasCall) {

      DEBUG(dbgs() << "construct: handling call\n");

      node->IsCaller = true;

      assert(func && "call without a called function"); // internal double-check

      BasicBlock *callee = &func->getEntryBlock();
      DEBUG(dbgs() << "construct: handling call: callee " << callee << "\n");

      BasicBlock *callSuccessor = block->getSingleSuccessor();
      assert(callSuccessor && "more than one successor in calling block\n");
      callStack.push_back(StackFrame(block, callee, callSuccessor));

      DEBUG(dbgs() << "construct: call to callee " << callee->getParent()->getName()
                   << ":" << callee->getName()
                   << " successor " << callSuccessor->getParent()->getName() << ":"
                   << callSuccessor->getName() << "\n");

      if (!(child = lookupNode(callee, callStack))) {
        DEBUG(dbgs() << "construct: recurring to creating a new node for block "
                     << callee->getParent()->getName() << ":" << callee->getName() << "\n");
        child = construct(callee, node, callStack);
      } else {
        auto edge = new FuncBallLarusEdge(BallLarusEdge::TYPE_REAL, node, child);
        // TODO: cleanup

        DEBUG(dbgs() << "callee block " << block->getParent()->getName() << ":" << block->getName()
                     << ":  already traversed, adding edge: "
                     << edge->getSource()->getBlock()->getParent()->getName() << ":"
                     << edge->getSource()->getBlock()->getName()
                     << "->"
                     << edge->getDst()->getBlock()->getParent()->getName() << ":"
                     << edge->getDst()->getBlock()->getName() << "\n");
        addEdge(edge);
      }

    } else if (hasReturn) {

      DEBUG(dbgs() << "construct: handling return\n");

      node->IsCallee = true;

      assert(callStack.size() > 0 && "return with empty stack");
      StackFrame &frame = callStack.back();
      BasicBlock *callerSucc = frame.CallerSucc;
      callStack.pop_back();

      DEBUG(dbgs() << "construct: returning from call, to caller block "
                   << callerSucc->getParent()->getName() << ":" << callerSucc->getName() << "\n");

      if (!(child = lookupNode(callerSucc, callStack))) {
          child = construct(callerSucc, node, callStack);
      } else {
          auto edge = new FuncBallLarusEdge(BallLarusEdge::TYPE_REAL, node, child);
          // TODO: cleanup

          DEBUG(dbgs() << "caller block " << block->getParent()->getName() << ":" << block->getName()
                       << ":  already traversed, adding edge: "
                       << edge->getSource()->getBlock()->getParent()->getName() << ":"
                       << edge->getSource()->getBlock()->getName()
                       << "->"
                       << edge->getDst()->getBlock()->getParent()->getName() << ":"
                       << edge->getDst()->getBlock()->getName() << "\n");
          addEdge(edge);
      }
    }
  } else { // the block is neither a caller nor a callee
      for (auto succ = succ_begin(block); succ != succ_end(block); ++succ) {
        if (!(child = lookupNode(*succ, callStack))) {
          DEBUG(dbgs() << "succ node not seen : " << (*succ)->getName() << "\n");
          child = construct(*succ, node, callStack);
        } else {
            auto edge = new FuncBallLarusEdge(BallLarusEdge::TYPE_REAL, node, child);
            // TODO: cleanup

            DEBUG(dbgs() << "child block " << (*succ)->getParent()->getName()
                         << ":" << (*succ)->getName()
                         << ": already traversed, adding edge: "
                         << edge->getSource()->getBlock()->getName()
                         << "->"
                         << edge->getDst()->getBlock()->getName() << "\n");
            addEdge(edge);
        }

      }
  }
  return node;
}

void FuncBallLarusDag::constructTaskDags(BallLarusNode *node,
                                         std::vector<BallLarusNode *> &path,
                                         bool isEntryTask)
{
  path.push_back(node);

  DEBUG(dbgs() << "constructTaskDags: traversing block "
               << node->getBlock()->getName() << "\n");

  if (node->IsTaskEntry && !node->TaskObj) {

    DEBUG(dbgs() << "found task head at block '"
                 << node->getBlock()->getName() << "'\n");

    llvm::Twine taskDagName = getName() + "-" +
        node->getBlock()->getParent()->getName() + "-" + node->getBlock()->getName();
    TaskBallLarusDag *taskDag = new TaskBallLarusDag(node, pass, taskDagName);
    // TODO: cleanup

    TaskId taskId = tasks.size();
    Task *task = new Task(taskId, node->getBlock()->getName(), taskDag);
    // TODO: cleanup

    // If node is marked as loop entry, then there was no boundary in the loop
    // body. And, we have automatically cut loop with pseudo loop boundaries.
    task->IsLoop = node->IsLoopEntry;

    task->IsEntry = isEntryTask;
    task->IsPseudo = node->IsPseudoTask;

    DEBUG(dbgs() << "task at block '" << node->getBlock()->getName() << "': "
                 << "loop " << task->IsLoop << " entry " << task->IsEntry
                 << " pseudo " << task->IsPseudo << "\n");

    // It is true only once
    if (isEntryTask)
      isEntryTask = false;

    tasks.push_back(task);

    node->TaskObj = task;

    logGraph((Twine("task-") + Twine(taskId)).str(), taskDag);
  }

  for (auto child = node->childBegin(); child != node->childEnd(); ++child) {
    if (std::find(path.rbegin(), path.rend(), *child) == path.rend()) {
      constructTaskDags(*child, path, isEntryTask);
    }
  }

  path.pop_back();
}

void FuncBallLarusDag::calcWeights(BallLarusNode *node,
                                   std::set<BallLarusNode *>& seenNodes)
{
  seenNodes.insert(node);
  DEBUG(dbgs() << "traversing node " << node->getBlock()->getName() << "\n");

  if (node->TaskObj != NULL) {
    transferWeights(node->TaskObj, node, node->TaskObj->Dag->getEntry());
  }

  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
    auto child = (*succ)->getDst();
    if (seenNodes.find(child) == seenNodes.end()) { // Recur only on unseen nodes
        calcWeights(child, seenNodes);
    }
  }
}

void FuncBallLarusDag::transferWeights(Task *task, BallLarusNode *funcNode, BallLarusNode *taskNode)
{
  DEBUG(dbgs() << "transfer weights: " << funcNode->getBlock()->getName()
               << " -> " << taskNode->getBlock()->getName() << "\n");

  assert(funcNode->getBlock() == taskNode->getBlock() &&
         "per-task and per-func graph out of sync");


  for (auto taskNodeChild = taskNode->succBegin();
      taskNodeChild != taskNode->succEnd(); ++taskNodeChild) {

    BallLarusEdge *edge = *taskNodeChild;

    DEBUG(dbgs() << " task edge: " << edge->getSource()->getBlock()->getName()
                 << "->" << edge->getDst()->getBlock()->getName() << "\n");

    auto taskEdge = static_cast<TaskBallLarusEdge *>(edge);

    FuncBallLarusEdge *funcEdge = NULL;
    for (auto funcNodeChild = funcNode->succBegin();
        funcNodeChild != funcNode->succEnd(); ++funcNodeChild) {

      DEBUG(dbgs() << "   func edge: "
                   << (*funcNodeChild)->getSource()->getBlock()->getName()
                   << "->" << (*funcNodeChild)->getDst()->getBlock()->getName() << "\n");

      assert((*funcNodeChild)->getSource()->getBlock() == taskEdge->getSource()->getBlock()
          && "per-task and per-func edges have different sources");

      if ((*funcNodeChild)->getDst()->getBlock() == taskEdge->getDst()->getBlock()) {
        funcEdge = static_cast<FuncBallLarusEdge *>(*funcNodeChild);
      }
    }

    assert(funcEdge != NULL && funcNode->succBegin() != funcNode->succEnd() &&
        "edge in per-task graph has no corresponding edge in per-func DAG");

    // Add the weight assigned by this task's DAG to the set of weights for the edge
    funcEdge->MultiWeight[task] = taskEdge->Weight;
    DEBUG(dbgs() << "   assign weight: task " << task->getName() << " : "
                 << taskEdge->Weight << "\n");

    transferWeights(task, funcEdge->getDst(), (*taskNodeChild)->getDst());
  }
}

TaskBallLarusDag::TaskBallLarusDag(BallLarusNode *funcNode, llvm::Pass *pass, const llvm::Twine &name)
    : BallLarusDag(funcNode->getBlock(), pass, name)
{
  assert(funcNode->IsTaskEntry &&
         "Per-task DAGs must be rooted at a task boundary");
  DEBUG(dbgs() << "Constructing per-task DAG rooted at boundary: "
               << funcNode->getBlock()->getName() << "\n");

  std::vector<BallLarusNode *> path;
  root = construct(funcNode, path);
  print();

#if 0
      // calculation (no reducing instrumented edges with a spanning tree, etc)?
  const auto& backedges = findBackedges();
  _backedges = backedges; // save to expose via public iface

  eliminateBackedges(backedges);
  DEBUG(dbgs() << "Control flow DAG without backedges:\n");
  DEBUG(print());
  DEBUG(dbgs() << "\n");
#endif

  // TODO: Sort the nodes array in place
  BLNodes topoSort;
  sortTopo(root, topoSort);
  DEBUG(printTopology(topoSort));
  DEBUG(dbgs() << "\n");

#if 0 // this is not needed for simple num paths value calculation
  // Add the dummy backedge from EXIT to ENTRY required for weight calc
  // but only if this is not a self-loop.
  if (nodes.size() > 1)
    addEdge(BallLarusEdge::TYPE_DUMMY, exit, root);
#endif

  numberEdges(topoSort);
  printNodes(nodes);
  printEdges(edges);
}

// Walk over per-function DAG
BallLarusNode *TaskBallLarusDag::construct(BallLarusNode *funcNode,
                                           std::vector<BallLarusNode *> &path)
{
  DEBUG(dbgs() << "task dag: adding block: " << funcNode->getBlock()->getName() << "\n");

  // create separate objects for per-task DAG
  auto node = addNode(funcNode->getBlock());

  path.push_back(node);

  for (auto funcSucc = funcNode->succBegin(); funcSucc != funcNode->succEnd(); ++funcSucc) {

    DEBUG(dbgs() << "block " << funcNode->getBlock()->getName()
                 << " func node succ: "
                 << (*funcSucc)->getSource()->getBlock()->getName() << " -> "
                 << (*funcSucc)->getDst()->getBlock()->getName() << "\n");

    assert((*funcSucc)->getSource() == funcNode &&
            "Parent node is not edge source");

    // either an existing node, or the root of a recursively created subtree
    BallLarusNode *child = NULL;
    for (auto seenNode = nodes.begin(); seenNode != nodes.end(); ++seenNode) {
         if ((*seenNode) == (*funcSucc)->getDst()) {
           child = *seenNode;
           break;
         }
    }

    if (!child) {
      DEBUG(dbgs() << "child of block " << node->getBlock()->getName() << ": not seen\n");

      // assume blocks have already been split at task boundaries, so can ask
      if (!(*funcSucc)->getDst()->IsTaskEntry) { // child belongs to this
        child = construct((*funcSucc)->getDst(), path);
      } else { // child belongs to another task

        // The edge leading into the other task needs to be part of the current
        // task's DAG, else the path profile won't have this path.
        // NOTE: technically, we could omit the actual BasicBlock * reference
        // for this node -- it should never be accessed.

        DEBUG(dbgs() << "adding leaf node " << (*funcSucc)->getDst()->getBlock()->getName() << "\n");

        assert((*funcSucc)->getDst() && "Successor edge without a destination");
        child = addNode((*funcSucc)->getDst()->getBlock()); // leaf node
      }
    } else {
      DEBUG(dbgs() << "child of block " << node->getBlock()->getName()
                   << ": seen: " << child->getBlock()->getName() << "\n");
    }

    assert(child && "Child neither found nor created.");

    // NOTE: Normally we include an edge to a node that crosses a task boundary,
    // however we are making an exception for backedges. Is this correct?
    // I think this is correct if there is only one path from the source of
    // the backedge, so that the path across the backedge has probability 1.0.
    //
    // TODO: we need to assert this assumption at least.
    //
    if (std::find(path.rbegin(), path.rend(), child) == path.rend()) {
      DEBUG(dbgs() << "creating edge: " << node->getBlock()->getName()
                   << " -> " << child->getBlock()->getName() << "\n");

      auto edge = new TaskBallLarusEdge(BallLarusEdge::TYPE_REAL, node, child);
      // TODO: cleanup

      addEdge(edge);
    } else {
      DEBUG(dbgs() << "not creating backedge: " << node->getBlock()->getName()
                   << " -> " << child->getBlock()->getName() << "\n");
    }
  }

  path.pop_back();

  return node;
}

void BallLarusDag::findBackedges(BallLarusNode *node,
                                 std::vector<BallLarusNode *> &path,
                                 std::set<BallLarusEdge *> &backedges)
{
  path.push_back(node);

  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {

    // Is the edge to this successor a backedge?
    if (std::find(path.rbegin(), path.rend(), (*succ)->getDst()) != path.rend()) {
      DEBUG(dbgs() << "found backedge: "
          << (*succ)->getSource()->getBlock()->getName() << " -> "
          << (*succ)->getDst()->getBlock()->getName() << "\n");
      backedges.insert(*succ);
    } else {
      findBackedges((*succ)->getDst(), path, backedges);
    }
  }

  path.pop_back();
}

BLEdges BallLarusDag::findBackedges()
{
  // Replace backedges with two dummy edges
  std::set<BallLarusEdge *> backedgeSet;
  std::vector<BallLarusNode *> path;
  findBackedges(root, path, backedgeSet);

  std::vector<BallLarusEdge *> backedgeVec(backedgeSet.size());
  copy(backedgeSet.begin(), backedgeSet.end(), backedgeVec.begin());
  return backedgeVec;
}

void FuncBallLarusDag::markLoops(BallLarusNode *node,
                                     std::vector<BallLarusNode *> &funcPath,
                                     std::vector<BallLarusNode *> taskPath)
{
#ifdef DEBUG_LOG_MARK_LOOPS
  DEBUG(dbgs() << "markLoops: traversing node " << node->getName() << "\n");
#endif

  funcPath.push_back(node);
  taskPath.push_back(node);

  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {

#ifdef DEBUG_LOG_MARK_LOOPS
    DEBUG(dbgs() << "markLoops: considering successor "
                 << (*succ)->getDst()->getName() << "\n");
#endif

    bool taskBackedge = false;

    // Did we loop in the per-task CFG? If so, create a pseudo-boundary.

    bool isLoop = false;
    std::vector<BallLarusNode *>::reverse_iterator loopBlock;
    for (loopBlock = taskPath.rbegin(); loopBlock != taskPath.rend(); ++loopBlock) {
      if (*loopBlock == (*succ)->getDst()) {
        isLoop = true;
        break;
      }
    }

    if (isLoop) {
      BallLarusNode *loopHead = (*succ)->getDst();
      loopHead->IsLoopEntry = true;


      // If we have profiled this loop, then use the profiled data,
      // else use the static bound declared by the programmer.

#ifdef DEBUG_LOG_MARK_LOOPS
      DEBUG(dbgs() << "markLoops: getting iter count for loop: "
                   << loopHead << "\n");
#endif
      if (!(loopHead->LoopIterCount = lookupProfiledLoopIterCount(pass, loopHead)))
        loopHead->LoopIterCount = lookupLoopIterCount(pass, loopHead->getBlock());
      assert(loopHead->LoopIterCount > 0 && "Invalid loop iter count");

      loopBlocks.insert(loopHead->getBlock());

      // rewind one step on the path through the loop that "begins" with the backedge 
      auto bodyEntry = loopBlock;
      bodyEntry--;

#ifdef DEBUG_LOG_MARK_LOOPS
      DEBUG(dbgs() << "Loop entry at " << loopHead->getName()
                   << ": body entry " << *bodyEntry
                   << " id " << loopHead->LoopId
                   << " iters " << loopHead->LoopIterCount << "\n");
#endif

      // Mark loop exit. NOTE: in practice, we only support the for-loop
      // structure, where there is only two paths from the condition: one into
      // the loop and the other one out of the loop. So, this loop should have
      // only two iterations.
      for (auto loopHeadSibling = loopHead->childBegin();
           loopHeadSibling != loopHead->childEnd(); ++loopHeadSibling) {
        if (*loopHeadSibling != *bodyEntry) {
#ifdef DEBUG_LOG_MARK_LOOPS
          DEBUG(dbgs() << "marking sibling " << (*loopHeadSibling)
                       << " of loop head " << loopHead << " as loop exit\n");
#endif
          (*loopHeadSibling)->IsLoopExit = true;
        }
      }

      // Mark loop bodies -- TODO: what is this for?

      unsigned loopReps = countLoopReps(loopHead);

      for (auto bodyNode = taskPath.rbegin(); bodyNode != loopBlock /* head */; ++bodyNode) {
#ifdef DEBUG_LOG_MARK_LOOPS
        DEBUG(dbgs() << "marking loop body: " << *bodyNode << "\n");
#endif

        (*bodyNode)->IsLoopBody = true;
        (*bodyNode)->ParentLoopHead = loopHead;
        loopBlocks.insert((*bodyNode)->getBlock());

        assert(blockInstanceCount.find((*bodyNode)->getBlock()) != blockInstanceCount.end());
        blockInstanceCount[(*bodyNode)->getBlock()] += loopReps;
      }

      taskBackedge = true;
    }

    // Did we loop in the per-function CFG? If so, simply don't follow the backedge.
    auto funcLoopStart = std::find(funcPath.rbegin(), funcPath.rend(), (*succ)->getDst());
    if (funcLoopStart != funcPath.rend()) {

#ifdef DEBUG_LOG_MARK_LOOPS
      DEBUG(dbgs() << "not following func backedge: "
          << (*succ)->getSource()->getName() << " -> "
          << (*succ)->getDst()->getName() << "\n");
#endif

    } else { // not a backedge, follow it, but mind the task boundaries

      assert(!taskBackedge &&
             "A backedge in per-task CFG is not a backedge in per-func CFG");
        
      BallLarusNode *dest = (*succ)->getDst();
#ifdef DEBUG_LOG_MARK_LOOPS
      DEBUG(dbgs() << "markLoops: succ " << dest->getName()
                   << " task entry " << dest->IsTaskEntry << "\n");
#endif
      if (dest->IsTaskEntry) {
        std::vector<BallLarusNode *> taskPath; // starting new task, so blank task path
        markLoops((*succ)->getDst(), funcPath, taskPath);
      } else {
#ifdef DEBUG_LOG_MARK_LOOPS
        DEBUG(dbgs() << "markLoops: not task entry, recurring\n");
#endif
        markLoops((*succ)->getDst(), funcPath, taskPath);
      }
    }
  }

  // don't modify taskPath: task path changes only upon crossing a task boundary
  funcPath.pop_back();
}

void FuncBallLarusDag::unmarkLoops(BallLarusNode *node,
                                   std::set<BallLarusNode *> &visitedNodes)
{
  visitedNodes.insert(node);

  if (node->ParentLoopHead) {
    assert(blockInstanceCount.find(node->getBlock()) != blockInstanceCount.end());
    blockInstanceCount[node->getBlock()] -= countLoopReps(node->ParentLoopHead);
  }

  node->IsLoopEntry = false;
  node->IsLoopExit = false;
  node->IsLoopBody = false;
  node->LoopId = 0;
  node->LoopIterCount = 0;
  node->ParentLoopHead = nullptr;

  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
    if (visitedNodes.find((*succ)->getDst()) == visitedNodes.end())
      unmarkLoops((*succ)->getDst(), visitedNodes);
  }
}

void FuncBallLarusDag::cutLoops(BallLarusNode *node,
                                std::set<BallLarusNode *> &visitedNodes)
{
  visitedNodes.insert(node);

  DEBUG(dbgs() << "cut loops: traversing " << node->getBlock()->getName()
               << " IsLoopEntry " << node->IsLoopEntry
               << " IsLoopExit" << node->IsLoopExit << "\n");

  // Node is a loop header or footer that has not been seen traversed already
  if ((node->IsLoopEntry || node->IsLoopExit) && !node->IsTaskEntry) {

      node->IsPseudoTask = !node->IsTaskEntry; // fake if wasn't set by programmer
      node->IsTaskEntry = true; // Create a pseudo task boundary
  }

  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
    BallLarusNode *dest = (*succ)->getDst();
    if (visitedNodes.find(dest) == visitedNodes.end()) {
      DEBUG(dbgs() << "cutLoops: unseen child: " << dest->getName() << "\n");
      cutLoops(dest, visitedNodes);
    } else {
      DEBUG(dbgs() << "cutLoops: skipping child: "
                   << dest->getName() << ": already visisted\n");
    }
  }
}

bool FuncBallLarusDag::isLoopBlock(BasicBlock *block)
{
  return loopBlocks.find(block) != loopBlocks.end();
}

void BallLarusDag::eliminateBackedges(const BLEdges &backedges)
{
#if 0 // TODO:
  for (auto edge = backedges.begin(); edge != backedges.end(); ++edge) {
      addEdge(BallLarusEdge::TYPE_DUMMY, root, (*edge)->getDst());
      addEdge(BallLarusEdge::TYPE_DUMMY, (*edge)->getSource(), exit);
      removeEdge(*edge);
  }
#endif
}

void BallLarusDag::sortTopo(BallLarusNode *node, BLNodes &nodes) {
  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
    auto succNode = (*succ)->getDst();
    if (std::find(nodes.begin(), nodes.end(), succNode) == nodes.end())
        sortTopo(succNode, nodes);
  }
  nodes.push_back(node);
}

void BallLarusDag::print() const {
  for (auto node = nodes.begin(); node != nodes.end(); ++node) {
    DEBUG(dbgs() << (*node)->getBlock()->getName() << ": ");
    for (auto edge = (*node)->succBegin(); edge != (*node)->succEnd(); ++edge) {
      assert((*edge)->getDst() && "Edge without a destination");
      auto block = (*edge)->getDst()->getBlock();
      assert(block && "Destination node without a block");
      DEBUG(dbgs() << block->getName() << " ");
    }
    DEBUG(dbgs() << "\n");
  }
}

void BallLarusDag::printTopology(const BLNodes &topoSort) const {
  DEBUG(dbgs() << "Topologically ordered nodes:\n");
  for (auto node = topoSort.begin(); node != topoSort.end(); ++node) {
    DEBUG(dbgs() << (*node)->getBlock()->getName() << "\n");
  }
}

// TODO: could this be a recursive function; then no need for topo sort step?
void BallLarusDag::numberEdges(const BLNodes &topoSort) {
  DEBUG(dbgs() << "number edges\n");
  for (auto node = topoSort.begin(); node != topoSort.end(); ++node) {
    DEBUG(dbgs() << "  node " << (*node)->getBlock()->getName()
                 << " leaf " << isLeafNode(*node) << "\n");
    if (isLeafNode(*(node))) {
      (*node)->setNumPaths(1);
    } else {
      (*node)->setNumPaths(0);
      for (auto succEdge = (*node)->succBegin(); succEdge != (*node)->succEnd();
          ++succEdge) {
        (*succEdge)->Weight = (*node)->getNumPaths();
        unsigned new_weight =
            (*node)->getNumPaths() + ((*succEdge)->getDst())->getNumPaths();
        DEBUG(dbgs() << "   new weight " << new_weight << "\n");
        (*node)->setNumPaths(new_weight);
      }
    }
  }
}

// Simplified Kruskal's MST algorithm with equal weights
// TODO: The weights should be edge frequencies obtained from preliminary profiling.
BLEdges BallLarusDag::findSpanningTree()
{
  // Note can't use llvm::SmallSet/SmallPtrSet because they don't implement ==, <
  typedef std::set<BallLarusNode *> Tree;
  typedef std::set<Tree> Forest;

  BLEdges spanningTree;

  // Create a forest of trees, i.e. a set of sets of nodes
  Forest forest;
  for (auto node = nodes.begin(); node != nodes.end(); ++node) {
    Tree tree;
    tree.insert(*node);
    forest.insert(tree);
  }

  // Coerce dummy edges into the tree, so that they don't get instrumented
  auto realEdges = std::partition(edges.begin(), edges.end(),
                            [] (BallLarusEdge *e) { return e->isDummy(); });

  // Consider each edge for inclusion into the MST. For non-equal weights the
  // edges would be stored in a min-heap and this loop would be changed to a
  // while-loop that pops from the heap on each iteration.
  for (auto edge = edges.begin(); edge != edges.end(); ++edge) {

    // Find two distinct trees that this node connects, if any
    Forest::iterator tree_a, tree_b;
    for (tree_a = forest.begin(); tree_a != forest.end(); ++tree_a) {
      if (tree_a->find((*edge)->getSource()) != tree_a->end())
        break;
    }
    for (tree_b = forest.begin(); tree_b != forest.end(); ++tree_b) {
      if (tree_b->find((*edge)->getDst()) != tree_b->end())
        break;
    }
    if (tree_a == tree_b)
      continue;

    spanningTree.push_back(*edge);

    // Merge the trees connected by the edge
    // NOTE: compiler does not allow modifying tree A or B via iterator
    Tree tree;
    for (auto node = tree_a->begin(); node != tree_a->end(); ++node)
        tree.insert(*node);
    for (auto node = tree_b->begin(); node != tree_b->end(); ++node)
        tree.insert(*node);
    forest.erase(*tree_a);
    forest.erase(*tree_b);
    forest.insert(tree);
  }

  // Check that coercion worked and we won't try to instrumment any dummy edges
  assert(std::all_of(edges.begin(), realEdges,
        [&] (BallLarusEdge *e) {
            return std::find(spanningTree.begin(), spanningTree.end(), e)
                          != spanningTree.end(); }) &&
        "not all dummy edges are in the spanning tree");

  return spanningTree;
}

void BallLarusDag::printEdges(const BLEdges& edges) const {
  for (auto edge = edges.begin(); edge != edges.end(); ++edge) {
    BasicBlock *srcBlock = (*edge)->getSource()->getBlock();
    BasicBlock *dstBlock = (*edge)->getDst()->getBlock();

    assert(srcBlock != NULL && dstBlock != NULL && "A node has no block");

    std::string src(srcBlock->getName());
    std::string dst(dstBlock->getName());

    std::string srcFmtted, dstFmtted;

    const int WIDTH = 32;
    if (src.size() < WIDTH && dst.size() < WIDTH) {
      assert(src.size() < WIDTH && dst.size() < WIDTH && "Padding buf overflow");
      std::string srcPadded(WIDTH, ' '), dstPadded(WIDTH, ' ');
      std::copy(src.begin(), src.end(), srcPadded.begin());
      std::copy(dst.begin(), dst.end(), dstPadded.begin());
      srcFmtted = srcPadded;
      dstFmtted = dstPadded;
    } else {
      srcFmtted = src;
      dstFmtted = dst;
    }

    DEBUG(dbgs() << "Edge: " << srcFmtted << "\t-> " << dstFmtted);
    (*edge)->print();
    DEBUG(dbgs() << "\n");
  }
}

void BallLarusDag::printNodes(const BLNodes &nodes) const {
  DEBUG(dbgs() << "Nodes:\n");
  for (auto node = nodes.begin(); node != nodes.end(); ++node) {

    std::string name((*node)->getBlock()->getName());

    std::string nameFmtted;

    const int WIDTH = 32;
    if (name.size() < WIDTH) {
      assert(name.size() < WIDTH && "Padding buf overflow");
      std::string namePadded(WIDTH, ' ');
      std::copy(name.begin(), name.end(), namePadded.begin());
      nameFmtted = namePadded;
    } else {
      nameFmtted = name;
    }

    DEBUG(dbgs() << nameFmtted << " " << (*node)->getNumPaths() << "\n");
  }
}

BLEdges BallLarusDag::findChords(const BLEdges &spanningTree) {
  BLEdges chords;
  for (auto edge = edges.begin(); edge != edges.end(); ++edge) {
    if (std::find(spanningTree.begin(), spanningTree.end(), *edge)
         == spanningTree.end())
      chords.push_back(*edge);
  }
  return chords;
}

int BallLarusDag::getDir(BallLarusEdge *e, BallLarusEdge *f) {
  if (e == NULL)
    return 1;
  if ((e->getDst() == f->getSource()) || (e->getSource() == f->getDst()))
    return 1;
  else 
    return -1;
}

/* Calculate values per chord that identify paths uniquely 
 * events: Weight of each edge
 * node: Active node in the DFS
 * edge: Incoming or Outgoing edge from node
 * */
void BallLarusDag::calculateIncrement(const BLEdges &spanningTree,
                                      const BLEdges &chords,
                                      int events, BallLarusNode *node,
                                      BallLarusEdge *theEdge)
{
  for (auto edge = spanningTree.begin(); edge != spanningTree.end(); ++edge) {
    if ((theEdge != (*edge)) && (node == (*edge)->getDst())) {
      int nestedEvents = events * getDir(theEdge, *edge) + (*edge)->Weight;
      calculateIncrement(spanningTree, chords, nestedEvents,
                         (*edge)->getSource(), *edge);
    }
  }
  for (auto edge = spanningTree.begin(); edge != spanningTree.end(); ++edge) {
    if ((theEdge != (*edge)) && (node == (*edge)->getSource())) {
      int nestedEvents = events * getDir(theEdge, *edge) + (*edge)->Weight;
      calculateIncrement(spanningTree, chords, nestedEvents,
                         (*edge)->getDst(), *edge);
    }
  } 
  for (auto chord = chords.begin(); chord != chords.end(); ++chord) {
    if ((node == (*chord)->getDst()) || (node == (*chord)->getSource())) {
      (*chord)->Increment = (*chord)->Increment + events*getDir(theEdge, *chord);
    }
  }
}

BallLarusDag::Path BallLarusDag::regenPath(unsigned sum) {
  Path path;
  path.type = regenPath(sum, root, PATH_TYPE_NONE, path.blocks);
  return path;
}

BallLarusDag::PathType BallLarusDag::regenPath(unsigned sum,
    BallLarusNode *node, PathType pathType, std::vector<BasicBlock *> &path) {

  path.push_back(node->getBlock());

  if (node == exit) {
    // For single-node graphs, return LINEAR
    return pathType != PATH_TYPE_NONE ? pathType : PATH_TYPE_LINEAR;
  }

  unsigned maxWeight = 0;
  BallLarusEdge *nextEdge = nullptr;
  for (auto succ = node->succBegin(); succ != node->succEnd(); ++succ) {
    if ((*succ)->Weight <= sum && (*succ)->Weight >= maxWeight) {
      maxWeight = (*succ)->Weight;
      nextEdge = *succ;
    }
  }
  assert(nextEdge != nullptr || node == exit);

  // Set only once: when traversing edge ENTRY->*
  if (pathType == PATH_TYPE_NONE) {
    pathType = (node == root && nextEdge->isDummy()) ?
                  PATH_TYPE_LOOP : PATH_TYPE_LINEAR;
  }

  if (nextEdge) {
    return regenPath(sum - nextEdge->Weight, nextEdge->getDst(),
                     pathType, path);
  }

  return pathType;
}

std::string BallLarusDag::pathTypeToStr(PathType pathType) {
  switch (pathType) {
    case PATH_TYPE_NONE: return "none";
    case PATH_TYPE_LINEAR: return "linear";
    case PATH_TYPE_LOOP: return "loop";
  }
  return "<unset>";
}

void BallLarusDag::log(const std::string &name)
{
  std::error_code errorCode;
  Twine fileName(Twine(getName()) + "-" + name + ".dot");

  DEBUG(dbgs() << "writing DOT file: " << fileName << "\n");

  raw_fd_ostream dotFile(fileName.str(), errorCode, sys::fs::F_Text);

  WriteGraph(dotFile, this);
}


std::string Task::getName() const {
  assert(Dag && "asked name of task without a dag");
  assert(Dag->getEntry() && "task DAG has no entry");
  // NOTE: since we (have to) rename blocks as part of instrumentation, we
  // store the name at task construction time, instead of doing the following.
  //return Dag->getEntry()->getBlock()->getName();
  return Name;
}

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, BallLarusNode *node)
{
  os << node->getName();
  return os;
}

} // namespace edbprof
