#ifndef EDBPROF_CPU_TIME_STOP_WATCH_H
#define EDBPROF_CPU_TIME_STOP_WATCH_H

namespace edbprof {

class CpuTimeStopWatch {

 public:
  CpuTimeStopWatch(float *elapsedSec);
  ~CpuTimeStopWatch();

 private:
  float *elapsedSecPtr;
  double startTime;
};

} // namespace edbprof

#endif // EDBPROF_CPU_TIME_STOP_WATCH_H
