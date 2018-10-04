rm -rf ./ext/python_dissembler/*.src ENERGY=$5
make bld/gcc/depclean BOARD=$2 SRC=$3 ENERGY=$5
make bld/gcc/dep BOARD=$2 ENERGY=$5
#make bld/gcc/all BOARD=$1 SRC=$2
make bld/$1/depclean BOARD=$2 SRC=$3 ENERGY=$5
make bld/$1/dep BOARD=$2 ENERGY=$5
make bld/$1/all BOARD=$2 SRC=$3 VERBOSE=$4 ENERGY=$5 SYS=$1
/opt/ti/mspgcc/bin/msp430-elf-objdump -S ./bld/$1/$3.out >> ./ext/python_dissembler/source.src
/opt/ti/mspgcc/bin/msp430-elf-objdump -x ./bld/$1/$3.out >> ./ext/python_dissembler/mem.src
#python2 ./ext/python_dissembler/dissembler.py ./bld/alpaca/$2.out
#python2 ./ext/python_dissembler/deal_with_return.py ./bld/alpaca/$2.S
#python2 ./ext/python_dissembler/global_tracer.py ./bld/alpaca/$2_mod.out
#mspdebug -v 3300 -d /dev/ttyACM0 tilib "prog bld/$1/$3.out"
echo "SYS=$1, BOARD=$2, SRC=$3"
