#include "CpuTimeStopWatch.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <chrono>

#include <ctime>

#define DEBUG_TYPE "CpuTimeStopWatch"

using namespace llvm;

namespace edbprof {

CpuTimeStopWatch::CpuTimeStopWatch(float *elapsedSec)
  : elapsedSecPtr(elapsedSec)
{
  startTime = (double)clock() / CLOCKS_PER_SEC;
}

CpuTimeStopWatch::~CpuTimeStopWatch()
{
  *elapsedSecPtr = ((double)clock() / CLOCKS_PER_SEC) - startTime;
}

} // namespace edbprof
