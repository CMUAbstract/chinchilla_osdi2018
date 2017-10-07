import sys
import dissemble_function
import soft_stack
import fileinput

def get_name(line):
    return line.split('type\t')[1].split(',')[0]

def flush(prev_line):
    for line in prev_line:
        print line,

def get_spilled_location(line):
    location = line.split(', ')[1].split('(')[0]
    return int(location)

def get_reload_location(line):
    location = line.split('mov.w\t')[1].split('(')[0]
    return int(location)

def correct_flush(prev_line, problematic_location):
    global nv_sp
    # for simple check
    nv_sp_bak = nv_sp
    problematic_num = len(problematic_location)
    # at the beginning, increase sp (this stack grows up)
    soft_stack.grow(problematic_num)
    nv_v_map_loc = []
    nv_v_map_sp = []
    for line in prev_line:
        if "2-byte Folded Spill" in line:
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
            if line == prev_line[-1]:
                soft_stack.shrink(problematic_num)
            print line,
    # at the end, subtract sp (this stack grows up)
    nv_sp += problematic_num
    assert(nv_sp == nv_sp_bak)

func_start = False
bb_problematic = False
need_fix = False
func_name = ''
prev_insts = []
spilled_location = []
problematic_location = []
bb_start = False
nv_sp = 0

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
                if "Lfunc_end" in line:
                    # function hit end
                    func_start = False
                if "\t.LBB" in line or "Lfunc_end" in line:
                    # TODO: we are assuming problematic region ends with
                    # end of BB. Is it really true?
                    if need_fix == True:
                        correct_flush(prev_insts, problematic_location)
                        prev_insts = []
                    else:
                        flush(prev_insts)
                        prev_insts = []
                spilled_location = []
                problematic_location = []
                need_fix = False
            elif bb_problematic == True:
                if "2-byte Folded Spill" in line:
                    # detected spill
                    spilled_location.append(get_spilled_location(line))
                if "2-byte Folded Reload" in line:
                    #detected reload
                    location = get_reload_location(line)
                    if location not in spilled_location:
                        problematic_location.append(location)
                        need_fix = True
        else:
            print line,
            if ":" in line:
                bb_start = True
    else:
        print line,

    if "@function" in line:
        # this is targeted function
        # insert at the beginning
        func_name = get_name(line)
        func_start = True

