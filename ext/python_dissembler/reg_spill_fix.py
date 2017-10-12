import sys
import dissemble_function
import soft_stack
import fileinput

def get_name(line):
    return line.split('type\t')[1].split(',')[0]

def flush(prev_line, func_name, problematic_location):
    nv_sp = 0
    global saved_reg_num
    global saved_reg_sp
    push_counter = 0
    pop_counter = 0
    nv_v_map_loc = []
    nv_v_map_sp = []
    problematic_num = len(problematic_location)
    problematic_stack_allocated = False

    if "_kw_" not in func_name and problematic_num == 0:
        # dont need to deal with push / pop / lr saving
        for line in prev_line:
            print line,
    else:
        for line in prev_line:
            if "\tpush.w\t" in line:
                push_counter += 1
            elif "\tpop.w\t" in line:
                pop_counter += 1
        assert(push_counter == 0 or pop_counter == 0 or push_counter == pop_counter)

        for line in prev_line:
            # We know ret address saving and pushing, popping only occurs at the
            # beginning and end of function. No SR needs to be concerned.
            # in stack shrinking at the end of BB, SR need to be maintained
            if push_counter > 0:
                # if it is beginning bb of function
                if line == prev_line[1]:
                    # at the beginning, increase sp (this stack grows up)
                    soft_stack.grow(push_counter + 1)
                    nv_sp = 0
                    # on first line, save lr
                    saved_reg_num.append("ret")
                    saved_reg_sp.append(nv_sp)
                    print "\tpush.w\tr5"
                    # 2 instead of 0 because r5, r6 is pushed
                    print "\tmov.w\t2(r1), r5"
                    soft_stack.write("r5", nv_sp)
                    print "\tpop.w\tr5"
                    nv_sp -= 1

            if "\tpush.w\t" in line:
                print line,
                reg_name = line.split('\tpush.w\t')[1].strip()
                if reg_name not in saved_reg_num:
                    # allocate stack location to int
                    saved_reg_num.append(reg_name)
                    saved_reg_sp.append(nv_sp)
                    soft_stack.write(reg_name, nv_sp)
                    nv_sp -= 1
                else:
                    soft_stack.write(reg_name, saved_reg_sp[saved_reg_num.index(reg_name)])
            elif "\tpop.w\t" in line:
                print line,
                reg_name = line.split('\tpop.w\t')[1].strip()
                if reg_name not in saved_reg_num:
                    assert(False)
                else:
                    soft_stack.read(reg_name, saved_reg_sp[saved_reg_num.index(reg_name)])
            elif "2-byte Folded Spill" in line:
                if problematic_stack_allocated == False and problematic_num > 0:
                    # at the beginning, increase sp (this stack grows up)
                    soft_stack.grow(problematic_num)
                    nv_sp = 0
                    problematic_stack_allocated = True

                loc = get_spilled_location(line)
                if loc in problematic_location:
                    reg = line.split('mov.w\t')[1].split(',')[0]
                    if loc not in nv_v_map_loc:
                        nv_v_map_loc.append(loc)
                        nv_v_map_sp.append(nv_sp)
                        soft_stack.write(reg, nv_sp)
                        nv_sp -= 1
                    else:
                        soft_stack.write(reg, nv_v_map_sp[nv_v_map_loc.index(loc)])
                else:
                    print line,
            elif "2-byte Folded Reload" in line:
                loc = get_reload_location(line)
                if loc in problematic_location:
                    reg = line.split(', ')[1].split('\t;')[0]
                    if loc not in nv_v_map_loc:
                        assert(False)
                    else:
                        soft_stack.read(reg, nv_v_map_sp[nv_v_map_loc.index(loc)])
                else:
                    print line,
            else:
                if pop_counter > 0:
                    # this bb is end of function
                    if line == prev_line[-2]:
                        print "\tpush.w\tr5"
                        soft_stack.read("r5", saved_reg_num.index("ret"))
                        # 2 instead of 0 because r5 is pushed
                        print "\tmov.w\tr5, 2(r1)"
                        print "\tpop.w\tr5"
                        soft_stack.shrink(pop_counter + problematic_num +1)
                else:
                    if line == prev_line[-1] and problematic_num > 0:
                        # this is branching. if it is conditional branch,
                        # we nned to save SR (Or better, we can shrink the stack
                        # before cmp (TODO opt)
                        print "\tpush.w\tr2"
                        soft_stack.shrink(problematic_num)
                        print "\tpop.w\tr2"
                print line,

def get_spilled_location(line):
    location = line.split(', ')[1].split('(')[0]
    return int(location)

def get_reload_location(line):
    location = line.split('mov.w\t')[1].split('(')[0]
    return int(location)

func_start = False
bb_problematic = False
need_fix = False
func_name = ''
prev_insts = []
spilled_location = []
problematic_location = []
bb_start = False
saved_reg_num = []
saved_reg_sp = []

for line in fileinput.input(sys.argv[1], inplace=1):
    if func_start == True:
        if bb_start == True:
            prev_insts.append(line)
            if "\t.LBB" in line or "call\t#_kw_" in line or "Lfunc_end" in line:
                bb_problematic = False
                if "\t.LBB" in line:
                    bb_start = False
                if "call\t#_kw_" in line:
                    # it is calling other functions that has checkpoint inside
                    # this is interesting ones
                    bb_problematic = True
                if "\t.LBB" in line or "Lfunc_end" in line:
                    # TODO: we are assuming problematic region ends with
                    # end of BB. Is it really true?
                    if need_fix == True and len(problematic_location) == 0:
                        assert(False)
                    if need_fix == False and len(problematic_location) > 0:
                        assert(False)
                    flush(prev_insts, func_name, problematic_location)
                    prev_insts = []

                    problematic_location = []
                    need_fix = False
                if "Lfunc_end" in line:
                    # function hit end
                    func_start = False
                    saved_reg_num = []
                    saved_reg_sp = []
                spilled_location = []
            elif bb_problematic == True:
                if "2-byte Folded Spill" in line:
                    # detected spill
                    spilled_location.append(get_spilled_location(line))
                if "2-byte Folded Reload" in line:
                    #detected reload
                    location = get_reload_location(line)
                    if location not in spilled_location and location not in problematic_location:
                        problematic_location.append(location)
                        need_fix = True
        else:
            print line,
            #if ":" in line:
            if line.startswith(".LBB"):
                bb_start = True
    else:
        print line,

    if "@function" in line:
        # this is targeted function
        # insert at the beginning
        func_name = get_name(line)
        func_start = True
        bb_start = True

