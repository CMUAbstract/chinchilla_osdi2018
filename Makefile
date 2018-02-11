OOLS = \
	dino \
	mementos \
	alpaca \

TOOLCHAINS = \
	gcc \
	clang \
	dino \
	alpaca \

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

include ext/maker/Makefile

# Paths to toolchains here if not in or different from defaults in Makefile.env

export MEMENTOS_ROOT = $(LIB_ROOT)/mementos
export DINO_ROOT = $(LIB_ROOT)/dino
export ALPACA_ROOT = $(LIB_ROOT)/alpaca


clean:
	rm *.ll *.bc *.log *.out *.map *.S
