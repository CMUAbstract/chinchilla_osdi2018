import sys
import fileinput
import re

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


roi_start = False

prevLine = ''
# pop and ret patch
for line in fileinput.input(sys.argv[1], inplace=1):
    if not roi_start:
        func = re.match(r"^(?P<name>[A-Za-z0-9_]+):", line)
        if func is not None:
            func_name = func.group("name")
            if re.search("_ratchet_", func_name):
                roi_start = True
        print line,
    elif roi_start:
        isChanged = False
        popped_reg = re.search(r"pop\.w\t(?P<name>r[0-9]+)", line)
        if popped_reg is not None:
            reg_name = popped_reg.group("name")
            print "\tmov.w\t0(r1), " + reg_name
            print "\tcall\t#checkpoint"
            print "\tadd.w\t#2, r1"
            isChanged = True

        ret = re.search("\tret$", line)
        if ret is not None:
            # Temp idea: on return, r14 is no longer alive
            # because it's lifetime is within the callee.
            # So we assume that r14 is empty and leverage that
            print "\tmov.w\t0(r1), r14"
            print "\tcall\t#checkpoint"
            print "\tadd.w\t#2, r1"
            print "\tmov.w\tr14, r0"
            isChanged = True




        # For the checkpoint function (which automatically writes to the stack
        # the PC whenever it is called) to never corrupt the stack,
        # every stack pointer increase (stack shrink) should be guarded by
        # the checkpoint before.
        # pop and ret is already dealt above, and we need to put checkpoint
        # before every add.w #constant, r1
        # In theory, we also have to guard every inc r1, incd r1, ..
        # every instruction that can increase r1. But lets hope that
        # never occurs for now...
        spIncrease = re.search(r"add\.w\t#[0-9]+, r1$", line)
        if spIncrease is not None:
            if re.match("\tcall\t#checkpoint", prevLine) is None:
                # is there was no guarding checkpoint
                print "\tcall\t#checkpoint"
        prevLine = line

        if not isChanged:
            print line,

        func_end = re.match(".Lfunc_end", line)
        if func_end is not None:
            roi_start = False

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

