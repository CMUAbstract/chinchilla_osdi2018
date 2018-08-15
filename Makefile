TOOLS = \
	dino \
	ratchet \
	mementos \
	chinchilla \
	edbprof

TOOLCHAINS = \
	gcc \
	clang \
	dino \
	chinchilla \
	ratchet \
	edbprof

#OPTED ?= 0
#GBUF ?= 1
#SBUF ?= 0
#TIME ?= 1
#VERBOSE = 0

#CFLAGS += \
#	-DOPTED=$(OPTED) \
#	-DGBUF=$(GBUF) \
#	-DSBUF=$(SBUF) \
#	-DTIME=$(TIME) \
#	-DVERBOSE=$(VERBOSE) \

#export BOARD = mspts430
export BOARD = mspts430
export SRC = rsa
export ENERGY ?= 0

include ext/maker/Makefile

# Paths to toolchains here if not in or different from defaults in Makefile.env

export EDBPROF_ROOT ?= $(LIB_ROOT)/edbprof
export MEMENTOS_ROOT = $(LIB_ROOT)/mementos
export DINO_ROOT = $(LIB_ROOT)/dino
export ALPACA_ROOT = $(LIB_ROOT)/chinchilla
export RATCHET_ROOT = $(LIB_ROOT)/ratchet


clean:
	rm *.ll *.bc *.log *.out *.map *.S
