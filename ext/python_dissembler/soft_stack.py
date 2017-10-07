def shrink(num):
    print "\tpush.w\tr5"
    print "\tmov.w\t&special_sp, r5"
    print "\tsub.w\t#" +str(num*2)+", r5"
    print "\tmov.w\tr5, &special_sp"
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
        # otherwise r5
        reg_tmp = "r5"
    print "\tpush.w\t" + reg_tmp
    # store special_sp to reg_tmp
    print "\tmov.w\t&special_sp, " + reg_tmp
    # store it into appropriate stack 
    print "\tmov.w\t" + reg + ", " + str(nv_sp*2) +"(" + reg_tmp + ")"
    # pop back reg_tmp
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
