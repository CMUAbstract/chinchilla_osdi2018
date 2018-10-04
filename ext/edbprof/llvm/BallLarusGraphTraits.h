#ifndef EDBPROF_BALLLARUSGRAPHTRAITS_H
#define EDBPROF_BALLLARUSGRAPHTRAITS_H

#include "BallLarusGraph.h"

#include "llvm/IR/Module.h"

#include "llvm/ADT/GraphTraits.h"
#include "llvm/Support/DOTGraphTraits.h"

#include <sstream>

namespace llvm {

  // For using GraphWriter with this graph type
  template <>
  struct GraphTraits<edbprof::BallLarusDag *> {

    typedef typename edbprof::BallLarusNode NodeType;
    typedef typename edbprof::BLNodeIterator ChildIteratorType;
    typedef typename edbprof::BLNodeIterator nodes_iterator;

    static NodeType *getEntryNode(edbprof::BallLarusDag *G) {
       return G->getEntry();
    }

    static ChildIteratorType child_begin(NodeType *node) {
      return node->childBegin();
    }

    static ChildIteratorType child_end(NodeType *node) {
      return node->childEnd();
    }

    static nodes_iterator nodes_begin(edbprof::BallLarusDag *G) {
      return G->getNodes().begin();
    }
    static nodes_iterator nodes_end(edbprof::BallLarusDag *G) {
      return G->getNodes().end();
    }

    static unsigned size(edbprof::BallLarusDag *G) {
      return G->getNodes().size();
    }
  };

  template <>
  struct DOTGraphTraits<edbprof::BallLarusDag *> : public DefaultDOTGraphTraits {

    explicit DOTGraphTraits(bool simple = false)
      : DefaultDOTGraphTraits(simple) { }

    static std::string getGraphName(const edbprof::BallLarusDag *G) {
      return G->getName().str();
    }

    std::string getNodeLabel(const edbprof::BallLarusNode *node, const edbprof::BallLarusDag *G) {

      // TODO: draw the boundary as a dedicated graphical element using addCustomGraphFeatures

      std::ostringstream label;

      if (node->IsTaskEntry) {
        label << "*****";
        if (node->IsPseudoTask) {
          label << "PSEUDO:";
        }
        label << "*****";
        label << "\n";
      }
      if (node->IsLoopEntry)
        label << "LOOP:ENTRY\n";
      if (node->IsLoopExit)
        label << "LOOP:EXIT\n";
      label << node->getName();
      return label.str();
    }
  };

} // namespace llvm

#endif // EDBPROF_BALLLARUSGRAPHTRAITS_H
