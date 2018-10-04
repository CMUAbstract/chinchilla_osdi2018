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
            description="Extract path freq array from device memory")
parser.add_argument('exec',
            help="Executable instrumented by PathProfiler LLVM pass")
parser.add_argument('--out', '-o', required=True,
            help="Output file with extracted path counts (CSV)")
parser.add_argument('--device', default="/dev/ttyUSB0",
            help="Device file for EDB")
parser.add_argument('--duration', type=float, default=10,
            help="Duration to profile for (sec)")
args = parser.parse_args()

def bytes_to_str(bts):
    return ''.join(map(lambda c: '%c' % c, bts))

# Must match what's defined in llvm/PathProfiler.cpp
pathcounts_sym_re = r'__edbprof_pathcounts__(?P<mod>.*)__(?P<func>.*)__(?P<task>.*)'

# We can't pull arbitrary size data from EDB, so we do it in chunks
EDB_MAX_PAYLOAD_SIZE = 32 # bytes

PATH_COUNTER_WIDTH = 2 # 16-bit path counters

Symbol = namedtuple('Symbol', 'name func addr size')

executable = ELFFile(open(args.exec, "rb"))

symtab = executable.get_section_by_name(b'.symtab')

path_counts_syms = {}
for sym in symtab.iter_symbols():
    m = re.match(pathcounts_sym_re, bytes_to_str(sym.name))
    if m:
        # LLVM includes '.bc' suffix, we truncate it here because it's easier
        # to do it in Python than in the C++ LLVM pass
        mod = re.compile(r'.bc$').sub('', m.group('mod'))
        func = m.group('func')
        task = int(m.group('task'))

        if mod not in path_counts_syms:
            path_counts_syms[mod] = {}

        if func not in path_counts_syms[mod]:
            path_counts_syms[mod][func] = {}

        path_counts_sym = Symbol(sym.name, bytes_to_str(func),
                                 sym.entry['st_value'],
                                 sym.entry['st_size'])
        path_counts_syms[mod][func][task] = path_counts_sym

if len(path_counts_syms) == 0:
    sys.stderr.write("No path counts array symbols found (re '%s')" % \
                     pathcounts_sym_re)
    sys.exit(1)

print("Found path count arrays:")
for mod in path_counts_syms:
    print ("%s" % mod)
    for func in path_counts_syms[mod]:
        print("  %s" % func)
        for task in path_counts_syms[mod][func]:
            sym = path_counts_syms[mod][func][task]
            print("    %20s: %50s: addr 0x%04x size %2u bytes" % (task, sym.name, sym.addr, sym.size))

print("Attaching to EDB")
edb = edb.EDB(args.device)

print("Turning on power supply")
edb.cont_power(True)

print("Collecting path counts for %.2f sec" % args.duration)
time.sleep(args.duration)

print("Retrieving path count data from device")

def read_sym_contents(sym):
    """Read memory at given symbol in chunks"""
    remaining_bytes = sym.size
    sym_contents = []
    offset = 0
    while remaining_bytes > 0:
        chunk = EDB_MAX_PAYLOAD_SIZE if remaining_bytes > EDB_MAX_PAYLOAD_SIZE \
                                     else remaining_bytes
        addr, value = edb.read_mem(sym.addr + offset, chunk)
        sym_contents.extend(value)
        offset += len(value)
        remaining_bytes -= len(value)
        assert remaining_bytes >= 0
    return sym_contents

def decode_path_counts(byte_array):
    path_counts = []
    for i in range(0, len(byte_array), PATH_COUNTER_WIDTH):
        assert PATH_COUNTER_WIDTH == 2 # others not implemented
        count = (byte_array[i + 1] << 8) | byte_array[i]
        path_counts.append(count)
    return path_counts


print("Interrupting device...")
edb.interrupt()
print("Device interrupted. Reading path count data...")

fout = open(args.out, "w")
fout.write("mod,func,task_id,path_id,count\n");

for mod in path_counts_syms:
    print("%s" % mod)
    for func in path_counts_syms[mod]:
        print("  %s" % func)
        for task in path_counts_syms[mod][func]:
            print("    %s" % task)
            sym = path_counts_syms[mod][func][task]
            sym_contents = read_sym_contents(sym)

            # Pretty-print the memory contents
            COLUMNS = 8
            for row in range(len(sym_contents) // (PATH_COUNTER_WIDTH * COLUMNS) + 1):
                offset = row * COLUMNS
                print("      %08x [%04u]: " % (sym.addr + offset, offset), end='')
                for j in range(COLUMNS):
                    idx = (row * COLUMNS + j) * PATH_COUNTER_WIDTH
                    if idx >= len(sym_contents):
                        break
                    print("  %02x%02x " % (sym_contents[idx + 1], sym_contents[idx]), end='')
                print()

            path_counts = decode_path_counts(sym_contents)

            for path_id, count in enumerate(path_counts):
                fout.write("%s,%s,%u,%u,%u\n" % (mod, func, task, path_id, count))

print("Exiting device mode")
edb.exit_debug_mode()

print("Turning off power supply")
edb.cont_power(False)

print("Disconnecting from EDB")
edb.destroy()
