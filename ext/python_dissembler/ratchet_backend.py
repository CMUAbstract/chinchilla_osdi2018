import sys
import fileinput
import re

def insertSafeFuncEnd(stackIncrease, regList):
    # pop all registers
    for reg in regList:
        print "\tmov.w\t" + str(stackIncrease) + "(r1), " + reg
        stackIncrease += 2

    # pop return address
    # Temp idea: on return, r14 is no longer alive
    # because it's lifetime is within the callee.
    # So we assume that r14 is empty and leverage that
    print "\tmov.w\t" + str(stackIncrease) + "(r1), r14"
    stackIncrease += 2

    # insert guarding checkpoint
    print "\tcall\t#checkpoint"

    # increment stack pointer at once
    print "\tadd.w\t#" + str(stackIncrease) + ", r1"

    # return
    print "\tmov.w\tr14, r0"

def insertStackProtection():
    # Check if this is the first execution
    print "\tmov.b\t&chkpt_ever_taken, r12"
    print "\tcmp.b\t#0, r12"
    print "\tjeq\t.LBB_FIRST"
    print "\tjmp\t.LBB_NOTFIRST"

    print ".LBB_NOTFIRST:"
    # When it is not the first time
    # use volatile stack when restoring
    # so that nvstack does not get corrupted on
    # restore sequence
    print "\tmov.w\t#9216, R1"
    print "\tjmp\t.LBB_FIRST"

    # When it is the first time
    # Skip the stack protection
    print ".LBB_FIRST:"


func_start = False
roi_start = False

stack_increase = -1
regList = []
#prevLine = ''
# pop and ret patch
for line in fileinput.input(sys.argv[1], inplace=1):
    if not func_start:
        func = re.match(r"^(?P<name>[A-Za-z0-9_]+):", line)
        if func is not None:
            func_name = func.group("name")
            if re.search("_ratchet_", func_name):
                func_start = True
        print line,
    elif func_start:
        isChanged = False
        # Optimization. We need to guard 3 things.
        # local stack return, pop, and ret
        # We assume that those all only occurs at the
        # end of the function, all at once
        # We use one checkpoint to aggregate all of them
        if not roi_start:
            # local stack return starts the roi
            spIncrease = re.search(r"add\.w\t#(?P<name>[0-9]+), r1$", line)
            popped_reg = re.search(r"pop\.w\t(?P<name>r[0-9]+)", line)
            ret = re.search("\tret$", line)
            if spIncrease is not None:
                roi_start = True
                stack_increase = int(spIncrease.group("name"))
            # No pop or ret precedes local stack return!
            elif popped_reg is not None:
                assert(False)
            elif ret is not None:
                assert(False)
            else:
                print line,
        else:
            # inside roi, there should only be pop and ret
            popped_reg = re.search(r"pop\.w\t(?P<name>r[0-9]+)", line)
            ret = re.search("\tret$", line)
            if popped_reg is not None:
                regList.append(popped_reg.group("name"))
            elif ret is not None:
                roi_start = False

                # Here, we put the modified code and checkpoint
                assert(stack_increase != -1)
                assert(len(regList) != 0)
                insertSafeFuncEnd(stack_increase, regList)
                stack_increase = -1
                regList = []
            else:
                assert(False)


        func_end = re.match(".Lfunc_end", line)
        if func_end is not None:
            func_start = False

# at the beginning of main, guard non-volatile stack from start sequence
# the restore sequence should never touch other part of the application
mainStart = False
for line in fileinput.input(sys.argv[1], inplace=1):
    main = re.match("main:", line)
    if main is not None:
        mainStart = True

    if mainStart:
        # right after the first push of r4
        if re.search("push.w\tr4", line) is not None:
            insertStackProtection()
            print line,
            mainStart = False
        else:
            print line,
    else:
        print line,

