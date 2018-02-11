rm -rf ./ext/python_dissembler/*.src
make bld/gcc/depclean BOARD=$1 SRC=$2
make bld/gcc/dep BOARD=$1
#make bld/gcc/all BOARD=$1 SRC=$2
make bld/alpaca/depclean BOARD=$1 SRC=$2
make bld/alpaca/dep BOARD=$1
make bld/alpaca/all BOARD=$1 SRC=$2 VERBOSE=$3
/opt/ti/mspgcc/bin/msp430-elf-objdump -S ./bld/alpaca/$2.out >> ./ext/python_dissembler/source.src
/opt/ti/mspgcc/bin/msp430-elf-objdump -x ./bld/alpaca/$2.out >> ./ext/python_dissembler/mem.src
#python2 ./ext/python_dissembler/dissembler.py ./bld/alpaca/$2.out
#python2 ./ext/python_dissembler/deal_with_return.py ./bld/alpaca/$2.S
#python2 ./ext/python_dissembler/global_tracer.py ./bld/alpaca/$2_mod.out
#mspdebug -v 3300 -d /dev/ttyACM0 tilib "prog bld/$1/$3.out"
echo "BOARD=$1, SRC=$2"
