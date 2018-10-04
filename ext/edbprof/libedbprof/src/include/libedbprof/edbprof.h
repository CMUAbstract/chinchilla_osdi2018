#ifndef EDBPROF_EDBPROF_H
#define EDBPROF_EDBPROF_H

// This header has no effect except when comping the app binary
// instrumented for measuring task start energy, or failure rate,
// or path frequency profile.

#ifdef EDBPROF // support building with/without EDBprof without source changes

#include <libedb/edb.h>

void edbprof__task_boundary(); // NOTE: name must match llvm/BallLarusGraph.cpp

#endif // EDBPROF

// EDBPROF_BOOT_MAKER and EDBPROF_TASK_MARKER

#if defined(EDBPROF) && defined(START_ENERGY_TASK)

// We use only one watchpoint at a time. We do have two on EDB board,
// so could take advantage of it, but unless we can instrument all
// functions at once, using more than one checkpoint is an optimization
// that adds quite a bit of complexity, so we start with using one.
// TODO: can't use this in the watchpoint macro since it wants a resolved number
// #define START_ENERGY_WATCHPOINT 0

// Must be placed after each task boundary inside and '#if' of the form:
//    #if START_ENERGY_TASK == TASK_MY_TASK
//    EDB_TASK_MARKER()
//	  #endif
// NOTE: START_ENERGY_TASK is set by edbprof on the command line when
//       compiling the app version instrumented for starte energy
//       measurement. Edbprof sets it to each function in turn.
// NOTE: Unfortunately we can't put the "if" branch inside the macro
// NOTE: Number 0 is the watchpoint ID used by EDBprof (see comment above)
#define EDBPROF_BOOT_MARKER()
#define EDBPROF_TASK_MARKER() WATCHPOINT(EDBPROF_TASK_MARKER_WATCHPOINT)

#elif defined(EDBPROF) && defined(EDBPROF_FAILURE_PROFILE)

#define EDBPROF_BOOT_MARKER() WATCHPOINT_0()
#define EDBPROF_TASK_MARKER(idx) WATCHPOINT(idx)

#else // un-instrumentated build

#define EDBPROF_BOOT_MARKER()
#define EDBPROF_TASK_MARKER(idx)

#endif // EDBPROF instrumentation mode

// EDBPROF_TASK_BOUNDARY

// TODO: including boundaries in BLOCK_ENERGY should not be happening.
// We do that as a workaround to make the block energy profile
// compatible with manually-inserted boundaries in source code
// (because those boundaries cause splits, which renames blocks). The
// root issue here is that block boundaries inserted in the code
// do not necessarily fall on existing basic block boundaries.
// To make that happen, need a separate pass that would convert
// calls to boundary functions to metadata.

#define DEFINE_TASK_BOUNDARY \
    (defined(EDBPROF) || \
    defined(EDBPROF_BLOCK_ENERGY) || \
    defined(EDBPROF_PATH_FREQ_PROFILE) || \
    defined(EDBPROF_SPLIT_TASKS) || \
    defined(EDBPROF_TASK_ENERGY) || \
    defined(START_ENERGY_TASK))

#if DEFINE_TASK_BOUNDARY

// For path profiling, this function call denotes a task boundary. We do not
// use the DINO boundary as the marker, for simplicity: we don't want to
// compile+link wih DINO for path profiling build, because DINO modifies the
// CFG.
//
// TODO: Merge with TASK_MARKER: the difficulty is that the marker must
// be under '#ifdef START_ENERGY_TASK == TASK_NAME', but for path profiling
// the marker must be unconditional.
#define EDBPROF_TASK_BOUNDARY() edbprof__task_boundary()

#else

#define EDBPROF_TASK_BOUNDARY()

#endif

// EDBPROF_PROGRAM_{START,END}

#define DEFINE_PROGRAM_MARKERS \
    (defined(EDBPROF_CHECKER_VALIDATION) || \
     defined(EDBPROF_CHECKER_VALIDATOR) || \
     defined(EDBPROF_PLACEMENT))

#if DEFINE_PROGRAM_MARKERS

#define EDBPROF_PROGRAM_START() WATCHPOINT(0)
#define EDBPROF_PROGRAM_END() WATCHPOINT(1)

#else // !DEFINE_PROGRAM_MARKERS

#define EDBPROF_PROGRAM_START()
#define EDBPROF_PROGRAM_END()

#endif // !DEFINE_PROGRAM_MARKERS

// EDBPROF_PATH_{START,END}
//
// TODO: make this take a path ID argument and let us build per path by
// changing a compile flag, without having to comment out the statements in the
// code (similarly to START_TASK_ENERGY).

#if defined(EDBPROF_PATH_ENERGY_VALIDATOR)

#define EDBPROF_PATH_START() WATCHPOINT(0)
#define EDBPROF_PATH_END() WATCHPOINT(1)

#else // !EDBPROF_PATH_ENERGY_VALIDATOR

#define EDBPROF_PATH_START()
#define EDBPROF_PATH_END()

#endif // !EDBPROF_PATH_ENERGY_VALIDATOR

// EDBPROF_BLOCK_ENERGY_PLACHOLDER

#ifdef EDBPROF_BLOCK_ENERGY

#define EDBPPROF_NVMEM_REGION_SIZE 32
#define EDBPROF_BLOCK_ENERGY_PLACEHOLDER \
            static __nv unsigned __edbprof__nv_region[EDBPPROF_NVMEM_REGION_SIZE]; \
            (void)__edbprof__nv_region; \
            WATCHPOINT(0); \
            __asm__ volatile( \
                "mov #0x1d1e, r5\n" \
                "mov #1, r6\n" \
                "; BLOCK_PLACEHOLDER\n" \
            ); \
            WATCHPOINT(1); \
            while (1) { } \

#else // !EDBPROF_BLOCK_ENERGY

#define EDBPROF_BLOCK_ENERGY_PLACEHOLDER

#endif // !EDBPROF_BLOCK_ENERGY

// EDBPROF_LOOP_ITER_*

#ifdef EDBPROF_LOOP_ITERS

#define _LOOP_VAR_INNER(name, loop) __edbprof_loop_iters__ ## name ## __loop__ ## loop
#define _LOOP_VAR(name, loop) _LOOP_VAR_INNER(name, loop)

#define EDBPROF_LOOP_ITERS_BEGIN(loop) \
    static __nv unsigned _LOOP_VAR(max, loop) = 0; \
    unsigned _LOOP_VAR(count, loop) = 0;

// NOTE: overflow is not handled
#define EDBPROF_LOOP_ITERS_BODY(loop) ++_LOOP_VAR(count, loop)

#define EDBPROF_LOOP_ITERS_END(loop) \
      if (_LOOP_VAR(count, loop) > _LOOP_VAR(max, loop)) \
        _LOOP_VAR(max, loop) = _LOOP_VAR(count, loop);

#else // !EDBPROF_LOOP_ITERS

#define EDBPROF_LOOP_ITERS_BEGIN(loop)
#define EDBPROF_LOOP_ITERS_BODY(loop)
#define EDBPROF_LOOP_ITERS_END(loop)

#endif // !EDBPROF_LOOP_ITERS

#ifdef EDBPROF_BLOCK_ENERGY

// NOTE: address here does not matter (as long as it is in FRAM), since it will
// be replaced with a random one during the generation of the harness for the
// basic block.
#define __edbprof__nv_loc ((volatile unsigned *)0x4400)

// For wrapping statements with indirect reads/writes (via pointer) from non-volatile memory
// These macros simply add a direct memory op for EDBprof to add to the energy cost.
// Yes, we overestimate, since the original statement generate ops to volatile memory,
// but those are a lot less costly than non-volatile ops, and overestimating is ok.
#define EDBPROF_NVMEM_RD(stmt) stmt; *__edbprof__nv_loc;
#define EDBPROF_NVMEM_WR(stmt) stmt; *__edbprof__nv_loc = 0xbeef;

#else // !EDBPROF_BLOCK_ENERGY

#define EDBPROF_NVMEM_RD(stmt) stmt
#define EDBPROF_NVMEM_WR(stmt) stmt

#endif // !EDBPROF_BLOCK_ENERGY

#endif // EDBPROF_EDBPROF_H
