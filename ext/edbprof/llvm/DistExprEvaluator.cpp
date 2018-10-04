#include "DistExprEvaluator.h"

#include "CLI.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <fstream>

#define DEBUG_TYPE "DistExprEvaluator"

using namespace llvm;

namespace edbprof {

DistExprEvaluator::DistExprEvaluator()
  : collapse(false)
{
  assert(DistExprEvaluatorPipes.size() > 0 && "No pipes to dist evaluator server specified");

  // Extract two pipe names from space-separated list
  size_t sepPos = DistExprEvaluatorPipes.find(' ');
  assert(sepPos != std::string::npos &&
      "No separator between pipe names for dist expr evaluator");
  std::string inPipeName = DistExprEvaluatorPipes.substr(0, sepPos);
  while (sepPos < DistExprEvaluatorPipes.size() && DistExprEvaluatorPipes[sepPos] == ' ')
    ++sepPos;
  std::string outPipeName = DistExprEvaluatorPipes.substr(sepPos);

  DEBUG(dbgs() << "Dist expr pipes: in " << inPipeName << " out " << outPipeName << "\n");

  inPipe.open(inPipeName.c_str(), std::ios_base::out);
  assert(inPipe.good() && "Failed to open in pipe to dist expr evaluator server");

  outPipe.open(outPipeName.c_str(), std::ios_base::in);
  assert(outPipe.good() && "Failed to open out pipe to dist expr evaluator server");

  // Mainly for testing the link
  char response[16];
  inPipe << "version\n";
  inPipe.flush();
  outPipe.getline(response, sizeof(response));
  assert(response[0] != '\0' && "Invalid response to version request");

  DEBUG(dbgs() << "dist expr server version: " << response << "\n");
}

void DistExprEvaluator::setCollapse(bool val)
{
    collapse = val;
}

bool DistExprEvaluator::getCollapse()
{
    return collapse;
}

float DistExprEvaluator::evalMax(const DistExpr &expr)
{
  DEBUG(dbgs() << "evaluating expr\n");
  inPipe << "evalmax ";
  if (collapse)
    inPipe << "--collapse ";
  inPipe  << "'" << expr << "'\n";
  inPipe.flush();

  DEBUG(dbgs() << "waiting for response\n");
  char response[128] = {0};
  while (response[0] == '\0') {
    outPipe.getline(response, sizeof(response));
  }
  DEBUG(dbgs() << "eval result raw: " << response << "\n");

  float maxEnergy = 0.0;
  assert(response[0] != '\0' && "Invalid response from dist expr eval server");
  std::stringstream str(response);
  str >> maxEnergy;
  DEBUG(dbgs() << "eval result converted: " << maxEnergy << "\n");

  return maxEnergy;
}

} // namespace edbprof
