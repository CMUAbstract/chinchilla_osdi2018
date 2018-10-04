# This makefile is intended to be included from an app's makefile at
# bld/edbprof/plot/Makefile

include ../../Makefile
override SRC_ROOT = ../../../src

EDBPROF_BUILD_DIR = ..

override CHECKER_VALIDATION_DIR := $(EDBPROF_BUILD_DIR)/$(CHECKER_VALIDATION_DIR)
override CHECKER_VALIDATOR_DIR := $(EDBPROF_BUILD_DIR)/$(CHECKER_VALIDATOR_DIR)
override PLACEMENT_DIR := $(EDBPROF_BUILD_DIR)/$(PLACEMENT_DIR)

ARTIFACTS = \
	exec-time.pdf \
	app-observed-completions-by-boundary-count.pdf \
	app-predicted-completions-by-boundary-count.pdf \

prof: $(ARTIFACTS)

$(eval $(call release-target))

exec-time.csv : $(CHECKER_VALIDATION_DIR)/observed.csv \
  $(CHECKER_VALIDATOR_DIR)/observed-completions.csv $(PLACEMENT_DIR)/observed-completions.csv
	$(EDBPROF_BIN_ROOT)/aggregate-exec-time.py -o $@ $^

exec-time.% : exec-time.csv
	$(EDBPROF_BIN_ROOT)/plot-exec-time.py -o $@ $^

run-time.csv : $(CHECKER_VALIDATOR_DIR)/checker-run-time.csv $(PLACEMENT_DIR)/placer-run-time.csv
	$(EDBPROF_BIN_ROOT)/aggregate-run-time.py -o $@ $^

# The manual placement (a description of it, really), we generate
# here within this phase. It could be factored out into a separate
# phase directory, but leave it here for now.
include $(EDBPROF_ROOT)/make/Makefile.placer.manual

app-observed-completions-by-boundary-count.% : $(CHECKER_VALIDATION_DIR)/observed-completions-by-boundary-count.csv \
  $(PLACEMENT_DIR)/boundary-spec.csv boundary-spec.csv
	$(EDBPROF_BIN_ROOT)/plot-completions-by-placer.py -o $@ $(PLOT_COMPLETIONS_ARGS) $^

app-predicted-completions-by-boundary-count.% : $(CHECKER_VALIDATION_DIR)/predicted-completions-by-boundary-count.csv \
  $(PLACEMENT_DIR)/boundary-spec.csv boundary-spec.csv
	$(EDBPROF_BIN_ROOT)/plot-completions-by-placer.py -o $@ $(PLOT_COMPLETIONS_ARGS) $^

clean-phase:
	rm -rf *.csv *.pdf

# do not remove any intermediate artifacts
.SECONDARY:
