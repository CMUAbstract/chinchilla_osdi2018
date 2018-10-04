#ifndef EDBPROF_WALL_TIME_STOP_WATCH_H
#define EDBPROF_WALL_TIME_STOP_WATCH_H

#include <chrono>

namespace edbprof {

class WallTimeStopWatch {

 public:
  WallTimeStopWatch(float *elapsedSec);
  ~WallTimeStopWatch();

 private:
  float *elapsedSecPtr;
  std::chrono::time_point<std::chrono::high_resolution_clock> startTime;
};

} // namespace edbprof

#endif // EDBPROF_WALL_TIME_STOP_WATCH_H
