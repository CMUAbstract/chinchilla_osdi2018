import sys
import dissemble_function
import fileinput

def get_name(line):
    return line.split('_kw_')[1].split(':')[0]

found_func = False
func_name = ''
for line in fileinput.input(sys.argv[1], inplace=1):
    if found_func == True:
        if "\tpush.w\t" in line:
            reg_name = line.split('\tpush.w\t')[1].strip()
            print '\tmov.w\t'+reg_name+',\t&_'+reg_name+'_' + func_name
            print line,
        elif "\tpop.w\t" in line:
            reg_name = line.split('\tpop.w\t')[1].strip()
            print line,
            print '\tmov.w\t&_'+reg_name+'_' + func_name + ',\t' + reg_name
        else:
            if "\tret\n" in line:
                found_func = False
                print '\tmov.w\t&_ret_' + func_name + ",\t0(r1)"
            print line,
    else:
        print line,

    if "_kw_" in line and ":" in line:
        # this is targeted function
        # insert at the beginning
        func_name = get_name(line)
        print '\tmov.w\t0(r1),\t&_ret_' + func_name
        found_func = True

