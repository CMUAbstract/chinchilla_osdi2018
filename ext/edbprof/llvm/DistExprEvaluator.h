#ifndef EDBPROF_DIST_EXPR_EVALUATOR_H
#define EDBPROF_DIST_EXPR_EVALUATOR_H

#include "EnergyDist.h"

#include <fstream>

namespace edbprof {

class DistExprEvaluator {
   public:

    DistExprEvaluator();
    void setCollapse(bool val);
    bool getCollapse();
    float evalMax(const DistExpr &expr);

  private:
    std::fstream inPipe;
    std::fstream outPipe;

    // collapse distributions to their expected values for faster evaluation
    bool collapse;
};

} // namespace edbprof

#endif // EDBPROF_DIST_EXPR_EVALUATOR_H
