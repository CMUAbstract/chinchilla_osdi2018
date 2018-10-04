#!/usr/bin/python
import copy
import os
import argparse
import re
import hashlib
import pandas as pd

from nvmem import *


class ChinchillaBlock():
    def __init__(self, funcName, content):
        self.funcName = funcName
        self.content = content
        self.nextBlock = None
        self.nextChkptBlock = None
        self.prevBlock = None
        self.prevChkptBlock = None
    # Next block without checkpoint (connected by call)
    # is prev call? or Return
    def setPrevBlock(self, cblock, isCall):
        self.prevBlock = cblock
        self.isPrevCall = isCall
    # is next call? or Return
    def setNextBlock(self, cblock, isCall):
        self.nextBlock = cblock
        self.isNextCall = isCall
    # Next block after checkpoint
    def setNextChkptBlock(self, cblock):
        self.nextChkptBlock = cblock
    def __repr__(self):
        string = '====block====\n'
        for line in self.content:
            string += line + '\n'
        if self.nextBlock != None:
            string += '==next block==\n'
            string += repr(self.nextBlock)
        return string

parser = argparse.ArgumentParser(
            description="Extract basic blocks from assembly source file")
parser.add_argument('in_source',
            help="Input assembly source file from which to extract basic blocks")
#parser.add_argument('in_ll',
#            help="Input source file in intermediate LLVM language")
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

def getUnsafeCall(line):
    if re.search("call", line, 0):
        assert('call\t#' in line)
        funcName = line.split('#')[1]
        if '_kw_' in funcName:
            return funcName
    return None

def getSafeCall(line):
    if re.search("call", line, 0):
        assert('call\t#' in line)
        funcName = line.split('#')[1]
        if '_safe_' in funcName:
            return funcName
    return None

def isTooSmall(raw_block):
    for line in raw_block:
        if ':' in line:
            # This is declaration
            pass
        elif re.match('j', line):
            # Starting with j is a jump
            pass
        elif re.match('br', line):
            # Starting with br is a branch
            pass
        else:
            # There is other inst than those!
            return False
    return True

def isWhiteListBlock(raw_block):
    # omit some blocks that we know is not an issue
    # (such as block with energy guard)
    for line in raw_block:
        if re.search("call", line, 0):
            funcName = line.split('#')[1]
            #whitelist
            #if 'printf' in funcName or \
            #    '_debug_mode' in funcName\
            #    or 'resume_application' in funcName\
            if '_kw_end_run' in funcName:
                return True
    return False

def containsSafeCall(block):
    for line in block:
        # when call, check called func
        if getSafeCall(line) != None:
            return getSafeCall(line)
    return None

def containsUnsafeCall(block):
    for line in block:
        # when call, check called func
        if getUnsafeCall(line) != None:
            return getUnsafeCall(line)
    return None

def getRetBlock(func):
    for blockName, block in func.items():
        for line in block:
            if re.match('ret', line):
                return block
    assert(False)

def getWatchPoint(idx):
    result = ''
    result += 'mov.b\t&0x0222, r12'
    result += '\nand.w\t#207, r12'
    if idx == 1:
        result += '\nbis.w\t#32, r12'
    elif idx == 0:
        result += '\nbis.w\t#16, r12'
    else:
        assert(False)
    result += '\nmov.b\tr12, r13'
    result += '\nmov.b\tr13, &0x0222'
    result += '\npushm.a #1, r13'
    result += '\nmov\t#7, r13'
    result += '\ndec\tr13'
    result += '\njnz\t$-2'
    result += '\npopm.a\t#1, r13'
    result += '\nnop'
    result += '\nmov.b\t&0x0222, r12'
    result += '\nand.w\t#239, r12'
    result += '\nmov.b\tr12, r13'
    result += '\nmov.b\tr13, &0x0222'
    result += '\npushm.a\t#1, r13'
    result += '\nmov\t#47, r13'
    result += '\ndec\tr13'
    result += '\njnz\t$-2'
    result += '\npopm.a\t#1, r13'
    result += '\nnop'
    return result

def brToTermination(block):
    # remove the last branches and jumps
    isRet = False
    seenBranch = False
    for i in reversed(range(len(block))):
        # if there is a tailing jump
        if re.match('j', block[i], 0):
            # Watchpoint!
            # sw reset!
            if not seenBranch:
                block[i] = getWatchPoint(1)
                block[i] += '\nmov.w\t#-23288, &0x0120'
                seenBranch = True
            else:
                del block[i]
        elif re.match('br', block[i], 0):
            # sw reset!
            if not seenBranch:
                block[i] = getWatchPoint(1)
                block[i] += '\nmov.w\t#-23288, &0x0120'
                seenBranch = True
            else:
                del block[i]
        elif re.match('ret', block[i], 0):
            isRet = True
        elif re.match('\t*\.', block[i], 0):
            pass
        else:
            break
    # if there are no ret at the end, add one
    if not isRet:
        if not seenBranch:
            # Sometimes there is no branch / jump and no return
            # Just goes to the next block
            block += [getWatchPoint(1)]
            block += ['\nmov.w\t#-23288, &0x0120']
        block += ['ret']
    return block

def addFuncEnds(block):
    funcCounter = 0
    func_name = 'main'
    newBlock = []
    for line in block:
        newBlock.append(line)
        func_opening_match = re.search(r'\t*\.globl\t(?P<name>[A-Za-z0-9_]+)', line)
        if func_opening_match is not None:
            func_name = func_opening_match.group('name')
        if re.match('ret', line):
            newBlock.append(getFuncEnd(func_name.replace('_kw_', '_safe_'), funcCounter))
            funcCounter += 1
    return newBlock


def getFuncEnd(funcName, funcCounter):
    # add end
    return '.Lfunc_end' + str(funcCounter) + ':\n' + '\t.size '\
            + funcName + ', ' + '.Lfunc_end' + str(funcCounter) + '-'\
            + funcName

def generateCodeBlock(block):
    result = []

    alreadyUsedName = []

    # First, find the lowest func in call stack and it will be main
    mainBlock = block
    mainDepth = 0
    depth = 0
    curBlock = block
    while True:
        if depth < mainDepth:
            assert(mainBlock.funcName != 'main')
            mainBlock = curBlock
            mainDepth = depth
        nextBlock = curBlock.nextBlock
        if nextBlock == None:
            break
        else:
            if curBlock.isNextCall:
                depth += 1
            else:
                depth -= 1
        curBlock = nextBlock

    mainBlock.funcName = 'main'

    while True:
        result += [getFuncId(block.funcName.replace('_kw_', '_safe_'))]
        if block.funcName == 'main':
            # For main
            result += ['mov.w\tr1, r4']
            result += ['call\t#init']
            # set r5 to safe location. Every unknown reg based
            # memory access are redirected to 2(r5)
            # R5 instead of r5 so that it does not gets translated
            result += ['mov.w\t&special_sp, R5']
            result += [getWatchPoint(0)]

        # If prev block is return, add call at the beginning of here
        # so that it makes sense
        if block.prevBlock != None and block.isPrevCall == False:
            result += ['call\t#' + block.prevBlock.funcName.replace('_kw_', '_safe_')]

        for line in block.content:
            result += [line]

        alreadyUsedName.append(block.funcName)

        # To next
        nextBlock = block.nextBlock
        if nextBlock == None:
            break
        if block.isNextCall:
            # Check naming collision
            if nextBlock.funcName in alreadyUsedName:
                nextBlock.funcName = nextBlock.funcName + '_n_'
            # if next is call
            result += ['call\t#' + nextBlock.funcName.replace('_kw_', '_safe_')]
            result += ['ret']

        block = nextBlock
    result = brToTermination(result)
    return result

def getChinchillaBlocks(block):
    chinBlocks = []
    curBlock = ChinchillaBlock('main', block)
    tempBlocks = [curBlock]
    _tmp_flag = 0
    while len(tempBlocks) > 0:
        startBlock = tempBlocks.pop(0)
        curBlock = startBlock
        while True:
            unsafeCallPoint = containsUnsafeCall(curBlock.content)
            # If cur block does not contain unsafe func call
            if unsafeCallPoint == None:
                # And it does not connect to others via func call
                if curBlock.nextBlock == None:
                    # We found one complete Chinchilla block
                    newBlock = generateCodeBlock(startBlock)
                    chinBlocks.append(newBlock)
                    break
                # Else traverse
                else:
                    curBlock = curBlock.nextBlock
            # If cur block contains unsafe func call,
            # We need to split it in half
            else:
                _tmp_flag = 1
                headContent = []
                tailContent = []

                isHeadBlock = True
                for line in curBlock.content:
                    # Filling headContent
                    if isHeadBlock:
                        if getUnsafeCall(line) != None:
                            #newLine = line.replace('_kw_', '_safe_')
                            #headContent += [newLine]
                            #headContent += ['ret']
                            # head block end
                            unsafeFuncName = getUnsafeCall(line)
                            #tailContent += [newLine]
                            isHeadBlock = False
                        else:
                            headContent += [line]
                    # Filling tailContent
                    else:
                        tailContent += [line]

                headNextContent = funcs[unsafeFuncName]['entry']
                retContent = getRetBlock(funcs[unsafeFuncName])

                # Edge case where the _kw_ function has only single block
                # This occurs when _kw_ function cantains call to other _kw_
                # In this case headNextContent and retContent has
                # duplicate code, so we divide it in half
                if headNextContent == retContent:
                    tmpContent = headNextContent + []
                    headNextContent = []
                    retContent = []

                    isHeadBlock = True
                    for line in tmpContent:
                        # Filling headContent
                        if isHeadBlock:
                            if getUnsafeCall(line) != None:
                                #newLine = line.replace('_kw_', '_safe_')
                                #headContent += [newLine]
                                #headContent += ['ret']
                                # head block end
                                #unsafeFuncName = getUnsafeCall(line)
                                #tailContent += [newLine]
                                headNextContent += [line]
                                retContent += [line]
                                isHeadBlock = False
                            else:
                                headNextContent += [line]
                        # Filling tailContent
                        else:
                            retContent += [line]

                if len(headContent) > 0:
                    headNextBlock = ChinchillaBlock(unsafeFuncName, headNextContent)
                    headBlock = ChinchillaBlock(curBlock.funcName, headContent)
                    headBlock.setNextBlock(headNextBlock, True)
                    headNextBlock.setPrevBlock(headBlock, True)
                    if curBlock == startBlock:
                        tempBlocks.append(headBlock)
                    else:
                        tempBlocks.append(startBlock)

                    if curBlock.prevBlock != None:
                        curBlock.prevBlock.setNextBlock(headBlock, curBlock.prevBlock.isNextCall)
                        headBlock.setPrevBlock(curBlock.prevBlock, curBlock.prevBlock.isNextCall)

                # remove the last branches and jumps
                #tailContent += [getFuncId(unsafeFuncName.replace('_kw_', '_safe_'))]
                tailPrevContent = []
                # tailContent start from the middle of the function call,
                # So it won't work correctly.
                # We need to put some pushs where there is a dangling pop
                pushedReg = []
                for line in retContent:
                    push = re.match(r'push\.w\t(?P<name>[A-Za-z0-9_]+)', line)
                    if push is not None:
                        pushedReg.append(push.group('name'))
                    pop = re.match(r'pop\.w\t(?P<name>[A-Za-z0-9_]+)', line)
                    if pop is not None:
                        popName = pop.group('name')
                        if len(pushedReg) == 0 or pushedReg[-1] != popName:
                            # This is dangling pop
                            # Need to insert push!
                            tailPrevContent += ['push.w\t'+popName]
                        else:
                            pushedReg = pushedReg[:-1]
                    # TODO: This part is needed if we will keep r1 in our code
                    # If we only use r5, r6 then we are good
                    spAdd = re.match(r'add\.w\t#(?P<name>[A-Za-z0-9_]+), r1$', line)
                    if spAdd is not None:
                        # It is incrementing sp for return. Since we never actually
                        # decremented sp, we do it now
                        tailPrevContent += ['sub.w\t#'+spAdd.group('name')+', r1$']
                    tailPrevContent += [line]
                assert(len(pushedReg) == 0)

                if len(tailContent) > 0:
                    tailPrevBlock = ChinchillaBlock(unsafeFuncName, tailPrevContent)
                    tailBlock = ChinchillaBlock(curBlock.funcName, tailContent)
                    tailBlock.setPrevBlock(tailPrevBlock, False)
                    tailPrevBlock.setNextBlock(tailBlock, False)

                    if curBlock.nextBlock != None:
                        curBlock.nextBlock.setPrevBlock(tailBlock, curBlock.isNextCall)
                        tailBlock.setNextBlock(curBlock.nextBlock, curBlock.isNextCall)

                    tempBlocks.append(tailPrevBlock)
                break

    return chinBlocks

def getFuncId(funcName):
    return '\n\t.globl\t' + funcName + '\n'\
            + '\t.align\t2\n'\
            + '\t.type\t' + funcName + ',@function\n'\
            + funcName + ':'

def addFuncs(lines, func):
    lines.append(getFuncId(func[0]))
    # add func def to lines
    for blockName, block in func[1].items():
        for line in block:
            lines.append(line)
    return lines

def canonicalize_block(raw_block):
    canon_block = []
    tmp_block = []
    safe_funcs = []

    for line in raw_block:
        canon_block.append(line)

    tmp_block = canon_block + []

    # Stupid and inefficient way of adding all the dependancies
    while True:
        isChanged = False
        for line in tmp_block:
            # when call, called function should be included
            if re.search("call", line, 0):
                assert('_kw_' not in line)
                funcName = line.split('#')[1]
                #whitelist
                if 'printf' not in funcName and \
                        '_debug_mode' not in funcName\
                        and 'resume_application' not in funcName\
                        and 'edb_init' not in funcName\
                        and '_safe_' not in funcName:
                        # No need to deal with saf-ifyed unsafe func
                    alreadyAdded = False
                    # search for duplicate
                    for funcTuple in safe_funcs:
                        if funcTuple[0] == funcName:
                            alreadyAdded = True
                            break

                    if not alreadyAdded:
                        try:
                            safe_funcs.append((funcName, funcs[funcName]))
                            isChanged = True
                        except KeyError:
                            print(funcName, "not a user-defined function.")

        for func in safe_funcs:
            tmp_block = addFuncs(tmp_block, func)

        if not isChanged:
            break

    translated_block = []
    # Translate the codes in main and _kw_ functions
    for idx, raw_instr in enumerate(canon_block):
        #raw_instr = re.sub("\s+", "\t", raw_instr) # homogenize whitespace

        for canon_instr in translate(raw_instr, idx, canon_block):
            translated_block.append(canon_instr)

    # add safe functions
    for func in safe_funcs:
        translated_block = addFuncs(translated_block, func)

    translated_block = addFuncEnds(translated_block)
        # translation might be one-to-many

        #for canon_instr in translate(raw_instr, idx, raw_block):
        #    canon_block.append(canon_instr)
    #return canon_block
    return translated_block

def createBlockForMeasurement(blockInsts, funcName, blockName):
    global block_hashes
    global global_decls
    # Entry contains init and restore. Deal seperately
    # add codes that needs measurement
    measuredBlock = blockInsts + []
    # add called code as well when there is a function call
    # We do not care about non-_kw_ functions (function calls
    # that does not contain checkpoints). Otherwish,
    # We emulate with jumps

    # Chinchilla style block declaration is different
    chinchillaBlocks = getChinchillaBlocks(measuredBlock)

    for block in chinchillaBlocks:
        canon_block = canonicalize_block(block)

        canon_block += global_decls
        bb_hash = hash_block(canon_block)
        block_hashes += [bb_hash]

        map_file.write(funcName + "," + blockName + "," + bb_hash + "\n")

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

        #if not skip and os.path.isfile(bb_file):
        #    print("existing block:\n", "\n".join(existing_block))
        #    print("updated block:\n", "\n".join(canon_block))

        if not skip:
            bb_file_p = open(bb_file, "w")
            bb_file_p.write("\n".join(canon_block) + "\n")
            bb_file_p.close()

def translate(line, idx, block):

    SRC_REG = "r5"
    DST_REG = "r6"

    RET_REGS = ["r15", "r14"] # order matters! how multi-word return values are encoded

    # First, transform arguments (generic across instructions)

    #remove comments
    line = re.sub("([^;]+);.*", "\\1", line)

    #account for registers
    #line = re.sub("r\d+,", SRC_REG + ",", line)   #src reg
    #line = re.sub("(r\d+)$", DST_REG, line)  #dst reg

    # Switch reg based memory access to 2(r5) which is known to be safe
    line = re.sub("\((r|R)\d+\)","(r5)", line) #memory ref
    line = re.sub("-?[0-9a-zA-Z_.]+([-\+]\d+)?(\((r|R)\d+\))","2\\2", line) # replace all offsets with same one
    # To make above code correct, switch everything that changes r5 to r6
    line = re.sub("r5$", "r6", line)  #dst reg

                                                 # (to reduce edits affecting block hashes)
    #line = re.sub("\@r\d+","@r5", line) #memory ref

    #account for memory
    '''
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
    #if (re.search("(j\S\S?|br)(\s*\S*)*", line, 0)):
    #    translated = ["jmp $+4", "nop"]
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
    '''
    translated = [line]

    return [instr.strip() for instr in translated]

# Construct global var list needed for translation
#for line in open(args.in_ll, "r"):
#    #search for the table of globals
#    if (re.search("global", line, 0)):
#        each_line = line.split("=")
#        v = each_line[0].rstrip().lstrip("@")
#        if (re.search("nv_vars", each_line[1], 0)):
#            variables[v] = "fram"
#        else:
#            variables[v] = "sram"
#
#    #end of global table
#    if (re.search("Function Attrs", line, 0)):
#        break
#
#print("VARIABLES=", variables)

if not os.path.isdir(args.blocks_dir):
    os.mkdir(args.blocks_dir)

map_file = open(args.map, "w") # blk id -> blk (content) hash
map_file.write("func,block_name,block_hash\n") # CSV header

block_hashes = []
canon_blocks = []
funcs = {}
blocks_in_func = {}

func = None # name of function that contains the current block
block = None
block_func = None
block_name = None
unnamed_block_idx = 0
global_start = False
global_decls = []

for line in open(args.in_source, "r"):
    line = line.strip()

    global_opening_match = re.search(r'\.type.*,@object', line)
    if global_opening_match is not None:
        # From here, global var decl starts
        global_start = True

    if global_start:
        global_decls.append(line)

    else:
        # Function parsing
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
            blocks_in_func = {}

        close_block = False
        close_function = False
        open_block = False
        #block_opening_match = re.match(r'^(; |.L)BB#?\d+(_\d+)?\s*:\s*(;\s*%(?P<name>.*))?', line)
        block_opening_match = re.match(r'^(; |.L)BB#?\d+(_\d+)?\s*:\s*(;\s*%(?P<name>.*))?', line)
        if block_opening_match is not None: # basic block begins
            block_name_in_source = block_opening_match.group('name')

            if block is not None:
                close_block = True

            if func is not None and not block_name_in_source.startswith(INSTRUMENTATION_PREFIX):
                open_block = True

        elif block is not None and re.match(r'^.Lfunc_end', line): # basic block ends
        #elif block is not None and re.search(r'\.size\t', line): # basic block ends
            close_function = True
            close_block = True

        elif block is not None:
            line = line.strip()
            if len(line) == 0 or line[0] == ';': # skip blank lines or comments
                continue
            raw_block.append(line)

        if close_block:
            #canon_block = canonicalize_block(raw_block)
            canon_block = raw_block
            if block_name != None:
                # sometimes the block_name getting code is buggy
                # so it returns the same name
                while block_name in blocks_in_func:
                    block_name += '_new'
                if not isWhiteListBlock(raw_block):
                    # Heuristics: do not test block with zero instructions (jump only)
                    if 'main' in func or '_kw_' in func:
                        if isTooSmall(raw_block):
                            #print(raw_block)
                            pass
                        else:
                            blocks_in_func[block_name] = raw_block
                    else:
                        blocks_in_func[block_name] = raw_block
                        print(blocks_in_func)
            else:
                assert(False)

            if close_function:
                # function end
                if func != None:
                    funcs[func] = copy.deepcopy(blocks_in_func)
                else:
                    assert(False)

            #bb_hash = hash_block(canon_block)
            #block_hashes += [bb_hash]

            #map_file.write(block_func + "," + block_name + "," + bb_hash + "\n")

            #bb_dir = os.path.join(args.blocks_dir, str(bb_hash))

            #if not os.path.isdir(bb_dir):
            #    os.mkdir(bb_dir)

            #bb_file = os.path.join(bb_dir, block_asm_file)

            # If this block already exists, do not overwrite it unless it changed
            #skip = False
            #if os.path.isfile(bb_file):
            #    with open(bb_file, "r") as existing_bb_file_p:
            #        existing_block = []
            #        for existing_instr in existing_bb_file_p:
            #            existing_block.append(existing_instr.strip())
            #    existing_bb_hash = hash_block(existing_block)
            #    if existing_bb_hash == bb_hash:
            #        skip = True

            #if not skip and os.path.isfile(bb_file):
            #    print("existing block:\n", "\n".join(existing_block))
            #    print("updated block:\n", "\n".join(canon_block))

            #if not skip:
            #    bb_file_p = open(bb_file, "w")
            #    bb_file_p.write("\n".join(canon_block) + "\n")
            #    bb_file_p.close()

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
            raw_block.append(line)

for funcName, funcBlocks in funcs.items():
    if funcName == 'main':
        for blockName, blockInsts in funcBlocks.items():
            # Not for checkpoint codes
            if 'condBB' not in blockName and 'newBB' not in blockName \
                    and 'entry' not in blockName:
                createBlockForMeasurement(blockInsts, funcName, blockName)

    elif '_kw_' in funcName: #Non-main blocks: only those with checkpoint is important
        retBlock = getRetBlock(funcBlocks)
        for blockName, blockInsts in funcBlocks.items():
            # Not for checkpoint codes, entry, exit (dealt seperately)
            if 'condBB' not in blockName and 'newBB' not in blockName \
                    and 'entry' not in blockName and retBlock != blockInsts:
                createBlockForMeasurement(blockInsts, funcName, blockName)
