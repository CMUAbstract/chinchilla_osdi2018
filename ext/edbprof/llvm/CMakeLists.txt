# Call like cmake -DDINO_LLVM_DIR=/path/to/llvm
#        or cmake -G Xcode -DDINO_LLVM_DIR=/path/to/llvm

cmake_minimum_required(VERSION 2.8)

set(LLVM_DIR ${DINO_LLVM_DIR}/share/llvm/cmake)

# hack for Windows
if(WIN32)
  set(CMAKE_LEGACY_CYGWIN_WIN32 0)
  set(CYGWIN 1)
endif(WIN32)

# Enable debug symbols all warnings
# (except multi-line comment, which triggers within llvm)
set(CMAKE_CXX_FLAGS "-g -Wall -Wno-comment")

option(LOG_PATH_ENERGY "Log distribution expressions for path energies" 0)
if(LOG_PATH_ENERGY)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DLOG_PATH_ENERGY")
  message(STATUS "Will log distribution expressions for path energies")
endif()

find_package(LLVM)

# AddLLVM needs these
set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/lib)

include(HandleLLVMOptions) # important: sets compiler flags

include(AddLLVM)

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(/usr/include)
link_directories(${LLVM_LIBRARY_DIRS})

add_llvm_loadable_module(edbprof
    PathExtractor.cpp
    PathProfiler.cpp
    BallLarusGraph.cpp
    AddIncFunc.cpp
    TaskEnergyEstimator.cpp
    TaskSplitter.cpp
    Tasks.cpp
    Loops.cpp
    BallLarusCfgViewer.cpp
    BoundaryGenerator.cpp
    BoundaryPlacer.cpp
    CommaSeparatedValues.cpp
    EnergyDist.cpp
    BlockEnergyProfile.cpp
    PathEnergyEstimator.cpp
    CLI.cpp
    GreedyBoundaryPlacer.cpp
    CpuTimeStopWatch.cpp
    WallTimeStopWatch.cpp
    Path.cpp
    BlockHash.cpp
    BlockHashMap.cpp
    DistExprEvaluator.cpp
    PathEnergyPass.cpp
)
