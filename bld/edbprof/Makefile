# Profiling config
#
# NOTE: The split between system-specific config that goes into Makefile.sys
# (not version controlled) and into this file is somewhat arbitrary. We do
# want to keep as more config in version control rather than less. However,
# we don't want to keep having changed files because e.g. EDB device number
# has changed. So, the guideline we use, is: parameters needed for reproducing
# the experiment go here, into version control. Any value that is trivial
# to come up with when reproducing (e.g. device number, hostname), we keep
# in Makefile.sys, outside of the version control.

PROFILED_OBJECTS = app

# Config specific to a system (not version controlled)
-include Makefile.sys
EDB_DEVICE ?=
RFID_READER_HOST ?=

export EDB_DEVICE
export RFID_READER_HOST

EDBPROF_VERBOSE ?= 0

# Config specific to the experimental parameters
export RFID_READER_POWER_DBM = 16
export MEASURE_DURATION = 15
export BLOCK_ENERGY_MEASURE_DURATION = 30
export START_ENERGY_MEASURE_DURATION = 15
export PATH_FREQ_MEASURE_DURATION = 10
export ENERGY_CAPACITY_MEASURE_DURATION = 30
export FAILURE_RATE_MEASURE_DURATION = 15
export STUCK_TASK_RESTARTS = 10
export CHECKER_MIN_SUCCESS_PROBABILITY = 0.90
export CHECKER_PROB_TH_RANGE = 0.50 0.75 0.80 0.85 0.90 0.95 0.99 0.995
export CHECKER_PATH_VALIDATOR_MEASURE_DURATION = 30
export LOOP_ITERS_MEASURE_DURATION = 30
export INSTRUCTIONS_PER_TRIAL = 3000
export ENERGY_DIST_EXPR_EVALUATOR_GRID = 0 200 0.005
export BLOCK_ENERGY_HIST_BIN_SIZE = 0.01

export GREEDY_SCORE_WEIGHT_LENGTH = 0.5
export GREEDY_SCORE_WEIGHT_CHECKPOINT = 0.5

# The first several samples turn out to be disproportionately noisy
# NOTE: Instead of this, we added a timeout after reader turn on
export ENERGY_CAPACITY_SAMPLES_TO_DROP = 0
export READER_INIT_TIMEOUT = 0

export DEVICE_CAPACITANCE_UF = 47
export DEVICE_BROWN_OUT_THRES_V = 1.80
export DEVICE_TURN_ON_VOLTAGE = 2.4

# 5, 1-8: ~72 mins
export BOUNDARY_GEN_SEED = 12
export BOUNDARY_GEN_SPECS = 5
#export BOUNDARY_GEN_BOUNDARY_COUNTS = 1-8,17,35
export BOUNDARY_GEN_BOUNDARY_COUNTS = 1-10
export BOUNDARY_GEN_FUNC_BLACKLIST = boundary-gen-func-blacklist.csv

export CHECKER_RECALL_ENERGY_CAPACITY_RANGE = 25 60 5

# 1 200 1 : ~25 mins
export PLACER_VALIDATION_ENERGY_CAPACITY_RANGE = 1 200 1

#export EDBPROF_OPAQUE_FUNCTIONS = opaque-functions.csv

#export PATH_ENERGY_INCLUDE_TASKS_REGEXP = featurize

#export EDBPROF_PATH_ENERGY_VALIDATOR_PATH_ID = PATH_FEATURIZE_0
#export EDBPROF_PATH_ENERGY_VALIDATOR_PATH_ID = PATH_ACQUIRE_WINDOW_0
#export EDBPROF_PATH_ENERGY_VALIDATOR_PATH_ID = PATH_CLASSIFY_0
#export EDBPROF_PATH_ENERGY_VALIDATOR_PATH_ID = PATH_SPI_WAIT_FOR_RX
#export EDBPROF_PATH_ENERGY_VALIDATOR_PATH_ID = PATH_SQRT

export DINO_MODE = auto
export MEMENTOS_STUCK_PATH_WATCHPOINT = 0
export EDBPROF_PROGRAM_MARKER_RESTART = $(MEMENTOS_STUCK_PATH_WATCHPOINT)

export PLOT_PLACER_TIMES_BY_CAPACITY_ARGS = --range 0 100
export PLOT_CHECKER_TIMES_BY_BOUNDARY_COUNT_ARGS = --range 0 10
export PLOT_COMPLETIONS_ARGS = --range 0 10
export TOTAL_ACCURACY_ARGS = --range 0 10

include ../Makefile
include $(EDBPROF_ROOT)/make/Makefile.target
