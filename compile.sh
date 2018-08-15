rm -rf ./ext/python_dissembler/*.src
make bld/gcc/depclean BOARD=$1 SRC=$2
make bld/gcc/dep BOARD=$1
#make bld/gcc/all BOARD=$1 SRC=$2
make bld/chinchilla/depclean BOARD=$1 SRC=$2
make bld/chinchilla/dep BOARD=$1 ENERGY=$4
make bld/chinchilla/all BOARD=$1 SRC=$2 VERBOSE=$3 ENERGY=$4
/opt/ti/mspgcc/bin/msp430-elf-objdump -S ./bld/chinchilla/$2.out >> ./ext/python_dissembler/source.src
/opt/ti/mspgcc/bin/msp430-elf-objdump -x ./bld/chinchilla/$2.out >> ./ext/python_dissembler/mem.src
#python2 ./ext/python_dissembler/dissembler.py ./bld/chinchilla/$2.out
#python2 ./ext/python_dissembler/deal_with_return.py ./bld/chinchilla/$2.S
#python2 ./ext/python_dissembler/global_tracer.py ./bld/chinchilla/$2_mod.out
#mspdebug -v 3300 -d /dev/ttyACM0 tilib "prog bld/$1/$3.out"
echo "BOARD=$1, SRC=$2"
