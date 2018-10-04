Chinchilla
========================================

This repo contains code for Chinchilla, an
energy-harvesting system published in OSDI 2018.

6 apps (cem, cuckoo, rsa, ar, blowfish, bc) are
contained.
To profile energy, an EDB hardware and a FET brick attached
using a level shifter is needed.

Before building the applications, you have to first build
the compiler pass.

Build Compiler Pass:

	$ cd ./ext/chinchilla/LLVM
	$ mkdir build
	$ cd build
	$ LLVM_DIR=$DIR_TO_CMAKE cmake ..
	$ make

Build:

	$ ./compile chinchilla wisp $APP_NAME 0 0 (for normal execution)
	$ ./compile chinchilla wisp $APP_NAME 0 1 (for checker)

Profile Energy Use:

	$ make bld/edbprof/block-energy/block-harness.out SRC=$APP_NAME
	$ make bld/edbprof/block-energy/energy.pdf SRC=$APP_NAME

Flash:

	$ mspdebug -v 3300 tilib "prog bld/chinchilla/$APP_NAME.out"
