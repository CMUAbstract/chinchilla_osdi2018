OOLS = \
	dino \
	mementos \
	alpaca \

TOOLCHAINS = \
	gcc \
	clang \
	dino \
	mementos \
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
export TEST_WATCHPOINTS = 1

export MEMENTOS_ROOT = $(LIB_ROOT)/mementos
export DINO_ROOT = $(LIB_ROOT)/dino
export ALPACA_ROOT = $(LIB_ROOT)/alpaca


clean:
	rm *.ll *.bc *.log *.out *.map *.S
	 #/opt/llvm/llvm-install/bin/opt -load ./src/libAlpacaPass.so -getloopcount ../test/test1-m2r.bc -o ../test/out
	 #/opt/llvm/llvm-install/bin/opt -load ./src/libAlpacaPass.so -transform ../test/test1-ai.bc -o ../test/out
			#/opt/llvm/llvm-install/bin//opt -debug -stats -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libAlpacaPass.so \
			#	  -alpaca \
			#	    -o main.alpaca.bc main.bc
			#Args: /opt/llvm/llvm-install/bin//opt -debug -stats -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libAlpacaPass.so -alpaca -o main.alpaca.bc main.bc

#Features:
#	CPU:generic

#/opt/llvm/llvm-install/bin//llvm-link -o templog.a.bc main.alpaca.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/bld/clang/libmsp.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/bld/clang/libio.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang/libalpaca.a.bc

#	echo "TEST"
