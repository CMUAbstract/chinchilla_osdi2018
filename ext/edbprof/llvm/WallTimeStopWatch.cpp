#include "WallTimeStopWatch.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <chrono>

#define DEBUG_TYPE "WallTimeStopWatch"

using namespace llvm;

namespace edbprof {

WallTimeStopWatch::WallTimeStopWatch(float *elapsedSec)
  : elapsedSecPtr(elapsedSec)
{
  startTime = std::chrono::system_clock::now();
}

WallTimeStopWatch::~WallTimeStopWatch()
{
  auto duration = std::chrono::high_resolution_clock::now() - startTime;
  auto durationSec = std::chrono::duration_cast<std::chrono::seconds>(duration);
  *elapsedSecPtr = static_cast<float>(durationSec.count()) *
    std::chrono::seconds::period::num / std::chrono::seconds::period::den;
}

} // namespace edbprof
