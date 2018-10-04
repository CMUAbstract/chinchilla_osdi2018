#!/usr/bin/python

import os
import argparse
import re
import hashlib
import pandas as pd

from nvmem import *

parser = argparse.ArgumentParser(
            description="Extract basic blocks from assembly source file")
parser.add_argument('in_source',
            help="Input assembly source file from which to extract basic blocks")
parser.add_argument('in_ll',
            help="Input source file in intermediate LLVM language")
parser.add_argument('--blocks-dir', '-o',
            help="Directory where to save extracted basic block source files")
parser.add_argument('--map', '-m',
            help="Output file with the map from block name to block hash")
parser.add_argument('--instructions-per-trial', type=int, default=1000,
            help="Maximum number of instructions that finish on one capacitor charge")
parser.add_argument('--include-functions', type=re.compile,
            help="Regexp pattern that specifies functions to exclude (overrides --exclude-functions)")
parser.add_argument('--exclude-functions', type=re.compile,
            help="Regexp pattern that specifies functions to exclude (overridden by --include-functions)")
parser.add_argument('--opaque-functions',
            help="Path to file with list of opaque functions (CSV)")
args = parser.parse_args()

block_asm_file = "block.asm"

INSTRUMENTATION_PREFIX = "INSTRUMENT." # must match llvm/PathProfiler.h

if args.opaque_functions:
    opaque_functions_dataset = pd.read_csv(args.opaque_functions)
    opaque_functions = list(opaque_functions_dataset["func"])
else:
    opaque_functions = []
print("opaque_functions:", opaque_functions)


def hash_block(block):
    m = hashlib.md5()
    for instr in block:
        m.update(instr.encode('utf-8'))
    return m.hexdigest()

# Holds types of global variables, used for translation
variables = dict()

def canonicalize_block(raw_block):
    canon_block = []
    for idx, raw_instr in enumerate(raw_block):
        raw_instr = re.sub("\s+", "\t", raw_instr) # homogenize whitespace

        # translation might be one-to-many
        for canon_instr in translate(raw_instr, idx, raw_block):
            canon_block.append(canon_instr)
    return canon_block

def translate(line, idx, block):

    SRC_REG = "r5"
    DST_REG = "r6"

    RET_REGS = ["r15", "r14"] # order matters! how multi-word return values are encoded

    # First, transform arguments (generic across instructions)

    #remove comments
    line = re.sub("([^;]+);.*", "\\1", line)

    #account for registers
    line = re.sub("r\d+,", SRC_REG + ",", line)   #src reg
    line = re.sub("(r\d+)$", DST_REG, line)  #dst reg
    line = re.sub("\(r\d+\)","(r5)", line) #memory ref
    line = re.sub("-?[0-9a-zA-Z_.]+(\+\d+)?(\(r\d+\))","2\\2", line) # replace all offsets with same one
                                                 # (to reduce edits affecting block hashes)
    line = re.sub("\@r\d+","@r5", line) #memory ref

    #account for memory
    var = re.findall('&\S*', line) #memory reference
    if (var):
         saved_var = var[0]
         var[0] = var[0].lstrip('&')
         #strip references with this var as base ptr
         var[0] = var[0].rstrip(',')
         var[0] = re.sub('\+\d*','', var[0])
         loc = var[0]
         if re.match(r"(0x)?\d+", loc):
            base = 16 if loc.startswith('0x') else 10
            value = int(loc, base)
            if EDBPROF_NVMEM_START <= value and value < EDBPROF_NVMEM_START + EDBPROF_NVMEM_SIZE:
                value = "fram"
            else:
                value = "sram"
         else:
            value = variables.get(loc)

         if value == "fram":
             dest = "&" + EDBPROF_NVMEM_REGION_SYM
             if (re.search(",", saved_var, 0)): #source operand
                 line = re.sub("&[^,]*", dest, line)
             else:                           #dst operand
                 line = re.sub("&\S*", dest, line)
         else:    #default to sram
             if (re.search(",", saved_var, 0)): #source operand
                 line = re.sub("&[^,]*", "&0x1d1e", line)
             else:                           #dst operand
                 line = re.sub("&\S*", "&0x1d1e", line)

    #immediate value
    var = re.findall('#\S*,', line)
    if (var):
       line = re.sub("#\S*,", "#15,", line) # a value with half bits set (#0f)

    # Next, switch on instruction type

    #jmp instruction
    if (re.search("(j\S\S?|br)(\s*\S*)*", line, 0)):
        translated = ["jmp $+4", "nop"]

    #call/ret instructions
    #
    # NOTE: Prior to this decomposition script, we run an LLVM pass that splits
    # basic blocks at calls. So, the call instructions that we see here should
    # be only at the bottom of a block (btw, ret's are terminators so they are
    # always at the bottom of a block). Here, we just need to account for the
    # cost of the call instruction itself (not the callee function!  downstream
    # path energy estimation stages take care of that), to do that we
    # canonicalize call/ret into a jmp (just a crude approximation).
    #
    # NOTE: One nasty exception is calls that are inserted by the compiler
    # target-specific backend. Instances observed in the wild so far, are calls
    # to builtins, like __mulhi3 inserted for array index calculation. Note
    # that these calls are entirely invisible to an LLVM pass, so we have
    # to deal with them here. We deal with them by simply leaving them in,
    # and letting the block call them and consume the respective energy.
    # Note that the block measurement harness app includes all code from
    # the app, including these builtins. We detect such calls by position:
    # at the bottom of a block (see comment above).
    #
    # An exception to exception is calls to EDBprof task boundary function:
    # if such a call is at the beginning of the block, the block is not
    # split, so that call does not become the penultimate instruction
    # in the block, but remains the first instruction in the block. We
    # treat it as we do builtins, and leave it in, so that the
    # call-callee-return are all accounted for during energy measurement.
    # NOTE: In the future, these boundary-marking calls should not end
    # up in the binary, but for now they do, so we account for their energy.

    elif re.search("call", line, 0):
        # if call is at the bottom of the block (the result of a split at a call)
        # NOTE: if callee is non-void, then the block splitting operation in
        # LLVM introduces an addition mov instruction that saves return value
        # on the stack, which is retrieved by the other half of the split block.
        # Example:
        #   ...
        #   mov.w   r12, r14
        #   call    #find_child
        #   mov.w   r15, -32(r4)            ; 2-byte Folded Spill
        #   jmp     .LBB8_15
        # .LBB8_15:                               ; %if.end.4.SPLIT.0
        #   ;   in Loop: Header=BB8_3 Depth=1
        #   ;DEBUG_VALUE: stop <- [FP+-15]
        #   mov.w   -32(r4), r12            ; 2-byte Folded Reload
        #   mov.w   r12, -8(r4)
        #   ...
        # NOTE: 32-bit quantities take up two registers
        is_last_instr = False
        for ret_i, ret_reg in enumerate([None] + RET_REGS):
            if idx == len(block) - 2 - ret_i:
                if ret_reg is not None:
                    is_last_instr = re.match(r"mov.*" + ret_reg + r"\s*,", block[idx + ret_i])
                else:
                    is_last_instr = True
        if is_last_instr:
            translated = ["jmp $+4", "nop"]
        else: # in middle of block: pass-through (see second note in comment above)
            translated = [line]

    elif re.search("ret", line, 0):
        translated = ["jmp $+4", "nop"]

    # push/pop: We add a matching pop/push to undo the original operation. We
    # have to, otherwise the program will blow the stack and crash (consider,
    # that we replicate the block thousands of times => thousands pushs). This
    # overestimates energy.
    elif re.search("push|pop", line):
        translated = ["push " + DST_REG, "pop " + DST_REG]
    else:
        translated = [line]

    return [instr.strip() for instr in translated]

# Construct global var list needed for translation
for line in open(args.in_ll, "r"):
    #search for the table of globals
    if (re.search("global", line, 0)):
        each_line = line.split("=")
        v = each_line[0].rstrip().lstrip("@")
        if (re.search("nv_vars", each_line[1], 0)):
            variables[v] = "fram"
        else:
            variables[v] = "sram"

    #end of global table
    if (re.search("Function Attrs", line, 0)):
        break

print("VARIABLES=", variables)

if not os.path.isdir(args.blocks_dir):
    os.mkdir(args.blocks_dir)

map_file = open(args.map, "w") # blk id -> blk (content) hash
map_file.write("func,block_name,block_hash\n") # CSV header

block_hashes = []

func = None # name of function that contains the current block
block = None
block_func = None
block_name = None
unnamed_block_idx = 0
for line in open(args.in_source, "r"):
    line = line.strip()

    func_opening_match = re.match(r'^(?P<name>[A-Za-z0-9_]+):', line)
    if func_opening_match is not None:
        func_candidate = func_opening_match.group('name')

        include = False
        if args.include_functions is not None:
            include = args.include_functions.match(func_candidate)
        elif args.exclude_functions is not None:
            include = not args.exclude_functions.match(func_candidate)
        else:
            include = func_candidate not in opaque_functions

        #if not include:
        #    continue

        func = func_candidate if include else None

    close_block = False
    open_block = False
    block_opening_match = re.match(r'^(; |.L)BB#?\d+(_\d+)?\s*:\s*(;\s*%(?P<name>.*))?', line)
    if block_opening_match is not None: # basic block begins
        block_name_in_source = block_opening_match.group('name')

        if block is not None:
            close_block = True

        if func is not None and not block_name_in_source.startswith(INSTRUMENTATION_PREFIX):
            open_block = True

    elif block is not None and re.match(r'^.Lfunc_end', line): # basic block ends
        close_block = True

    elif block is not None:
        line = line.strip()
        if len(line) == 0 or line[0] == ';': # skip blank lines or comments
            continue
        raw_block.append(line)

    if close_block:

        canon_block = canonicalize_block(raw_block)
        bb_hash = hash_block(canon_block)
        block_hashes += [bb_hash]

        map_file.write(block_func + "," + block_name + "," + bb_hash + "\n")

        bb_dir = os.path.join(args.blocks_dir, str(bb_hash))

        if not os.path.isdir(bb_dir):
            os.mkdir(bb_dir)

        bb_file = os.path.join(bb_dir, block_asm_file)

        # If this block already exists, do not overwrite it unless it changed
        skip = False
        if os.path.isfile(bb_file):
            with open(bb_file, "r") as existing_bb_file_p:
                existing_block = []
                for existing_instr in existing_bb_file_p:
                    existing_block.append(existing_instr.strip())
            existing_bb_hash = hash_block(existing_block)
            if existing_bb_hash == bb_hash:
                skip = True

        if not skip and os.path.isfile(bb_file):
            print("existing block:\n", "\n".join(existing_block))
            print("updated block:\n", "\n".join(canon_block))

        if not skip:
            bb_file_p = open(bb_file, "w")
            bb_file_p.write("\n".join(canon_block) + "\n")
            bb_file_p.close()

        block = None
        block_name = None
        block_func = None
        raw_block = None

    if open_block:
        if block_name_in_source is None:
            block_name_in_source = "<unnamed_block_" + str(unnamed_block_idx) + ">"
            unnamed_block_idx += 1
        block_func = func
        block_name = block_name_in_source
        block = '' # for legacy reasons, takes values '' or None
        raw_block = []
