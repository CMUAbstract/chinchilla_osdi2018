#ifndef EDBPROF_H
#define EDBPROF_H

// This header is a wrapper that conditionally either includes EDBprof headers
// or stubs its public API. This wrapper exists to be able to build with and
// without EDBprof without having to edit the application source. Note that
// obviously, this functionality cannot be encapsulated into edbprof, because
// the point of building without EDBprof is to not depend on libedbprof.  But,
// we keep this header in the edbprof repo, and let each app copy it as needed.

#ifdef EDBPROF

#include <libedbprof/edbprof.h>

#else // !EDBPROF

#define EDBPROF_BOOT_MARKER()
#define EDBPROF_TASK_MARKER(idx)

#define EDBPROF_TASK_BOUNDARY()

#define EDBPROF_PROGRAM_START()
#define EDBPROF_PROGRAM_END()

#define EDBPROF_PATH_START()
#define EDBPROF_PATH_END()

#define EDBPROF_LOOP_ITERS_BEGIN(loop)
#define EDBPROF_LOOP_ITERS_BODY(loop)
#define EDBPROF_LOOP_ITERS_END(loop)

#define EDBPROF_BLOCK_ENERGY_PLACEHOLDER

#define EDBPROF_NVMEM_RD(stmt) stmt
#define EDBPROF_NVMEM_WR(stmt) stmt

#endif // !EDBPROF

#endif // EDBPROF_H
