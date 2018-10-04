EXEC = $(SRC)
OBJECTS = \
    main_$(SRC).o 

DEPS += \
	libmsp \
	libmspmath \
#	libio \
#	libwispbase \
#	libmspconsole \
#	libmspprintf \

# Relative from toolchain build dir (one down from this file's dir)
SRC_ROOT = ../../src

include $(LIB_ROOT)/libmspbuiltins/bld/Makefile.target

#include ../Makefile.config
LOGIC = 0

ifeq ($(ENERGY), 1)
CONFIG_PRINTF_LIB = libedb
CONFIG_EDB = 1
#DEPS += libedb
else
CONFIG_PRINTF_LIB = libmspconsole
endif

override CFLAGS += \
	-DENERGY=$(ENERGY) \

ifeq ($(SYS), ratchet)
override CFLAGS += -DRATCHET
else ifeq ($(SYS), chinchilla)
override CFLAGS += -DCHINCHILLA
endif

ifeq ($(LOGIC), 1)
override CFLAGS += \
	-DLOGIC=1 
endif

include $(LIB_ROOT)/maker/Makefile.console

#include $(LIB_ROOT)/libedb/bld/Makefile.target

export LIBMSP_CLOCK_SOURCE = DCO
export LIBMSP_DCO_FREQ = 8000000ull
export LIBEDB_BOARD_VERSION_MAJOR=1
export LIBEDB_BOARD_VERSION_MINOR=1
