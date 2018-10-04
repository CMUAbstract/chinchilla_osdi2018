def shrink(num):
    print "\tpush.w\tr5"
    print "\tpush.w\tr6"
    print "\tmov.w\t&special_sp, r5"
    print "\tsub.w\t#" +str(num*2)+", r5"
    print "\tmov.w\tr5, &special_sp"
    print "\tmov.w\t&stack_tracer, r6"
    print "\tcmp.w\tr6, r5"
    print "\tjhs\t+4"
    print "\tmov.w\tr5, &stack_tracer"
    print "\tpop.w\tr6"
    print "\tpop.w\tr5"

def grow(num):
    print "\tpush.w\tr5"
    print "\tmov.w\t&special_sp, r5"
    print "\tadd.w\t#" +str(num*2)+", r5"
    print "\tmov.w\tr5, &special_sp"
    print "\tpop.w\tr5"

def write(reg, nv_sp):
    reg_tmp = ""
    if "r5" in reg:
        # if we are spilling r5,
        # use r6
        reg_tmp = "r6"
    else:
        reg_tmp = "r5"
    print "\tpush.w\t" + reg_tmp
    # store special_sp to reg_tmp
    print "\tmov.w\t&special_sp, " + reg_tmp
    # store it into appropriate stack 
    print "\tmov.w\t" + reg + ", " + str(nv_sp*2) +"(" + reg_tmp + ")"
    # TODO: update stack tracker!!!!
    # pop back reg_tmp
    print "\tpop.w\t" + reg_tmp

def write_spill(reg, nv_sp):
    reg_tmp = ""
    reg_tmp2 = ""
    if "r5" in reg:
        # if we are spilling r5,
        # use r6
        reg_tmp = "r6"
        reg_tmp2 = "r7"
    elif "r6" in reg:
        # otherwise r5
        reg_tmp = "r5"
        reg_tmp2 = "r7"
    else:
        reg_tmp = "r5"
        reg_tmp2 = "r6"
    print "\tpush.w\t" + reg_tmp
    if nv_sp < 0:
        print "\tpush.w\t" + reg_tmp2
    # store special_sp to reg_tmp
    print "\tmov.w\t&special_sp, " + reg_tmp
    # store it into appropriate stack 
    print "\tmov.w\t" + reg + ", " + str(nv_sp*2) +"(" + reg_tmp + ")"
    # TODO: update stack tracker!!!!
    assert(nv_sp <= 0)
    if nv_sp < 0:
        print "\tadd.w\t#" +str((nv_sp-1)*2) + ", " + reg_tmp
        print "\tmov.w\t&stack_tracer, " + reg_tmp2
        print "\tcmp.w\t" + reg_tmp2 + ", " + reg_tmp
        print "\tjhs\t+4"
        print "\tmov.w\t" + reg_tmp + ", &stack_tracer"
    # pop back reg_tmp
    if nv_sp < 0:
        print "\tpop.w\t" + reg_tmp2
    print "\tpop.w\t" + reg_tmp

def read(reg, nv_sp):
    reg_tmp = ""
    if "r5" in reg:
        # if we are spilling r5,
        # use r6
        reg_tmp = "r6"
    else:
        # otherwise r5
        reg_tmp = "r5"
    print "\tpush.w\t" + reg_tmp
    # store special_sp to reg_tmp
    print "\tmov.w\t&special_sp, " + reg_tmp
    # store it into appropriate stack 
    print "\tmov.w\t" + str(nv_sp*2) + "(" + reg_tmp + "), " + reg 
    # pop back reg_tmp
    print "\tpop.w\t" + reg_tmp
