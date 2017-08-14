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
#VERBOSE = 1

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


wisp:
	/opt/llvm/llvm-install/bin/clang -emit-llvm -c -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspbuiltins/src/include -DTEST_WATCHPOINTS -DCONFIG_LIBEDB_PRINTF -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspprintf/src/include -DCONFIG_EDB -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libedb/src/include  -DCONFIG_ENABLE_WATCHPOINTS -DCONFIG_ENABLE_TARGET_SIDE_DEBUG_MODE -DCONFIG_PASSIVE_BREAKPOINT_IMPL_C -DALPACA -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libwispbase/src/include -DCONFIG_LIBEDB_PRINTF_EIF -DVERBOSE=1 -I/src/include -DOPTED=0 -DGBUF=1 -DSBUF=0 -DTIME=1 -DRTIME= -DOVERHEAD=0 -DCTIME=0  -DBOARD_WISP --target=msp430 -D__MSP430FR5969__ -nobuiltininc -nostdinc++ -isysroot /none -O0 -std=c99 -Wall -MD -I /opt/ti/mspgcc/lib/gcc/msp430-elf/4.9.1/include -I /opt/ti/mspgcc/msp430-elf/include -I /opt/ti/mspgcc/include -I /home/reviewer/src/apps/app-auto-alpaca-new/src  -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspmath/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/src/include /home/reviewer/src/apps/app-auto-alpaca-new/src/main.c -o main.bc
	/opt/llvm/llvm-install/bin//opt -always-inline -o main-ai.bc main.bc
	/opt/llvm/llvm-install/bin//opt -mem2reg -o main-m2r.bc main-ai.bc
	/opt/llvm/llvm-install/bin/llvm-dis main.bc
	/opt/llvm/llvm-install/bin/llvm-dis main-m2r.bc
	/opt/llvm/llvm-install/bin/llvm-dis main-ai.bc
#	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM_auto/build/src/libAlpacaPass.so -getloopcount -o main.lc.bc main-m2r.bc
#	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM_auto/build/src/libAlpacaPass.so -transform -o main.ts.bc main-ai.bc
#	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libDynamicVersioning.so -dvpass -o main.dv.bc main.ts.bc
#	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libDynamicVersioning.so -dvpass -o main.dv.bc main-ai.bc
#	/opt/llvm/llvm-install/bin/llvm-dis main.ts.bc
#	/opt/llvm/llvm-install/bin/llvm-dis main.dv.bc
	/opt/llvm/llvm-install/bin//llvm-link -o templog.a.bc main-ai.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspmath/bld/clang/libmspmath.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/bld/clang/libmsp.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/bld/clang/libio.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang/libalpaca.a.bc
	#/opt/llvm/llvm-install/bin//llvm-link -o templog.a.bc main.dv.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspmath/bld/clang/libmspmath.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/bld/clang/libmsp.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/bld/clang/libio.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang/libalpaca.a.bc
	/opt/llvm/llvm-install/bin/llc -O0 -march=msp430 templog.a.bc -o templog.S
	/opt/ti/mspgcc/bin/msp430-elf-gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspbuiltins/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspprintf/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libedb/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libwispbase/bld/gcc -L/bld/gcc -Wl,-Map=templog.out.map -T /home/reviewer/src/apps/app-auto-alpaca-new/ext/maker/linker-scripts/msp430fr5969.ld -L /opt/ti/mspgcc/include  -o templog.out templog.S -lmspbuiltins -lmspprintf -ledb -lwispbase


shell:
	/opt/llvm/llvm-install/bin/clang -emit-llvm -c -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspbuiltins/src/include -DTEST_WATCHPOINTS -DCONFIG_LIBMSPCONSOLE_PRINTF -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspprintf/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspmath/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspconsole/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libwispbase/src/include -DVERBOSE=1 -I/src/include -DOPTED=1 -DGBUF=1 -DSBUF=0 -DTIME=1 -DRTIME= -DOVERHEAD=0 -DCTIME=0  -DBOARD_MSP_TS430 --target=msp430 -D__MSP430FR5969__ -nobuiltininc -nostdinc++ -isysroot /none -O0 -std=c99 -Wall -MD -I /opt/ti/mspgcc/lib/gcc/msp430-elf/4.9.1/include -I /opt/ti/mspgcc/msp430-elf/include -I /opt/ti/mspgcc/include -I /home/reviewer/src/apps/app-auto-alpaca-new/src  -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/src/include -I/home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/src/include /home/reviewer/src/apps/app-auto-alpaca-new/src/main.c -o main.bc
	/opt/llvm/llvm-install/bin//opt -always-inline -o main-ai.bc main.bc
	/opt/llvm/llvm-install/bin//opt -mem2reg -o main-m2r.bc main-ai.bc
	/opt/llvm/llvm-install/bin/llvm-dis main.bc
	/opt/llvm/llvm-install/bin/llvm-dis main-m2r.bc
	/opt/llvm/llvm-install/bin/llvm-dis main-ai.bc
	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM_auto/build/src/libAlpacaPass.so -getloopcount -o main.lc.bc main-m2r.bc
	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM_auto/build/src/libAlpacaPass.so -transform -o main.ts.bc main-ai.bc
	/opt/llvm/llvm-install/bin/llvm-dis main.ts.bc
	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libDynamicVersioning.so -dvpass -o main.dv.bc main.ts.bc
#	/opt/llvm/llvm-install/bin//opt -load /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/LLVM/build/src/libDynamicVersioning.so -dvpass -o main.dv.bc main-ai.bc
	/opt/llvm/llvm-install/bin/llvm-dis main.dv.bc
	/opt/llvm/llvm-install/bin//llvm-link -o templog.a.bc main.dv.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspmath/bld/clang/libmspmath.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libmsp/bld/clang/libmsp.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/libio/bld/clang/libio.a.bc /home/reviewer/src/apps/app-auto-alpaca-new/ext/alpaca/AlpacaRuntime/libalpaca/bld/clang/libalpaca.a.bc
	/opt/llvm/llvm-install/bin/llc -O0 -march=msp430 templog.a.bc -o templog.S
	/opt/llvm/llvm-install/bin/llvm-dis templog.a.bc
	/opt/ti/mspgcc/bin/msp430-elf-gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspbuiltins/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspprintf/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libmspconsole/bld/gcc -L/home/reviewer/src/apps/app-auto-alpaca-new/ext/libwispbase/bld/gcc -L/bld/gcc -Wl,-Map=templog.out.map -T /home/reviewer/src/apps/app-auto-alpaca-new/ext/maker/linker-scripts/msp430fr5969.ld -L /opt/ti/mspgcc/include  -o templog.out templog.S -lmspbuiltins -lmspprintf -lmspconsole -lwispbase

prog:
	mspdebug -v 3300 -d /dev/ttyACM0  tilib "prog templog.out"

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
