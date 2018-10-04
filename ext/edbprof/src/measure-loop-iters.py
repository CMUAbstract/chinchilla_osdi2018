#!/usr/bin/python

import argparse
import time
import sys
import re

from collections import namedtuple

from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

from pyedb import edb

parser = argparse.ArgumentParser(
            description="Profile loops and extract iter counts from device memory")
parser.add_argument('exec',
            help="Executable instrumented by PathProfiler LLVM pass")
parser.add_argument('--out', '-o', required=True,
            help="Output file with extracted iter counts (CSV)")
parser.add_argument('--device', default="/dev/ttyUSB0",
            help="Device file for EDB")
parser.add_argument('--duration', type=float, default=10,
            help="Duration to profile for (sec)")
args = parser.parse_args()

def bytes_to_str(bts):
    return ''.join(map(lambda c: '%c' % c, bts))

# Must match what's defined in libedbprof/edbprof.h
iter_counts_sym_re = r'(?P<func>[^.]+).__edbprof_loop_iters__(?P<var>.*)__loop__(?P<loop>.*)'

# We can't pull arbitrary size data from EDB, so we do it in chunks
EDB_MAX_PAYLOAD_SIZE = 32 # bytes

VAR_WIDTH = 2 # 16-bit path counters

Symbol = namedtuple('Symbol', 'name func addr size')

executable = ELFFile(open(args.exec, "rb"))

symtab = executable.get_section_by_name('.symtab')

iter_counts_syms = {}
for sym in symtab.iter_symbols():
    m = re.match(iter_counts_sym_re, bytes_to_str(sym.name))
    if m:
        func = m.group('func')
        loop = int(m.group('loop'))
        var = m.group('var')

        if func not in iter_counts_syms:
            iter_counts_syms[func] = {}

        if loop not in iter_counts_syms[func]:
            iter_counts_syms[func][loop] = {}

        iter_counts_sym = Symbol(sym.name, bytes_to_str(func),
                                 sym.entry['st_value'],
                                 sym.entry['st_size'])
        iter_counts_syms[func][loop][var] = iter_counts_sym

fout = open(args.out, "w")
fout.write("func,loop,var,count\n");

if len(iter_counts_syms) == 0:
    sys.stderr.write("WARNING: no iter counts symbols found (re '%s'): nothing to do" % \
                     iter_counts_sym_re)
    sys.exit(0)

print("Found iter count arrays:")
for func in iter_counts_syms:
    print ("%s" % func)
    for loop in iter_counts_syms[func]:
        print("  loop %u" % loop)
        for var in iter_counts_syms[func][loop]:
            sym = iter_counts_syms[func][loop][var]
            print("    %20s: %50s: addr 0x%04x size %2u bytes" % (var, sym.name, sym.addr, sym.size))

print("Attaching to EDB")
edb = edb.EDB(args.device)

print("Turning on power supply")
edb.cont_power(True)

print("Collecting iter counts for %.2f sec" % args.duration)
time.sleep(args.duration)

print("Retrieving iter count data from device")

print("Interrupting device...")
edb.interrupt()
print("Device interrupted. Reading path count data...")

for func in iter_counts_syms:
    print("%s" % func)
    for loop in iter_counts_syms[func]:
        print("  loop %u" % loop)
        for var in iter_counts_syms[func][loop]:
            print("    %s " % var, end='')
            sym = iter_counts_syms[func][loop][var]
            addr, value = edb.read_mem(sym.addr, VAR_WIDTH)
            assert VAR_WIDTH == 2 # the next line assumes this
            val = (value[1] << 8) | value[0]
            print("%r" % val)
            fout.write("%s,%u,%s,%r\n" % (func, loop, var, val))

print("Exiting device mode")
edb.exit_debug_mode()

print("Turning off power supply")
edb.cont_power(False)

print("Disconnecting from EDB")
edb.destroy()
