TOOLS = \
	dino \
	ratchet \
	mementos \
	alpaca \
	chinchilla \
	edbprof

TOOLCHAINS = \
	gcc \
	clang \
	dino \
	alpaca \
	ratchet \
	chinchilla \
	edbprof

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
export SYS = alpaca
export ENERGY ?= 0

include ext/maker/Makefile

# Paths to toolchains here if not in or different from defaults in Makefile.env

export EDBPROF_ROOT ?= $(LIB_ROOT)/edbprof
export MEMENTOS_ROOT = $(LIB_ROOT)/mementos
export DINO_ROOT = $(LIB_ROOT)/dino
export ALPACA_ROOT = $(LIB_ROOT)/alpaca
export CHINCHILLA_ROOT = $(LIB_ROOT)/chinchilla
export RATCHET_ROOT = $(LIB_ROOT)/ratchet


clean:
	rm *.ll *.bc *.log *.out *.map *.S
