import sys
import dissemble_function
from collections import namedtuple

def find_nopable_address(prev_inst, cbw_address, gv_address):
    state = 0
    result = []
    # 0: start
    # 1: mov passed. looking for call check_before_write
    # 2: call passed. looking for mov size, r14 or mov address, r15
    # 3: r14 passed. looking for r15
    # 4: r15 passed. looking for r14
    # 5: done
    for inst in reversed(prev_inst):
        parsed = dissemble_function.parse_line(inst)
        if state == 0:
            # we already checked this. just as a sanity check..
            if 'mov' in inst and gv_address in inst:
                state = 1
            else:
                assert(False)
        elif state == 1:
            if 'call' in inst:
                call_addr = inst.split(';')[1]
                if cbw_address in call_addr:
                    result.append(parsed[0].lstrip())
                    state = 2
                else:
                    assert(False)
        elif state == 2:
            if 'mov' in inst:
                dst = inst.split(',')[1]
                if 'r14' in dst:
                    state = 3
                    result.append(parsed[0].lstrip())
                elif 'r15' in dst:
                    state = 4
                    result.append(parsed[0].lstrip())
        elif state == 3:
            if 'mov' in inst:
                dst = inst.split(',')[1]
                if 'r14' in dst:
                    assert(False)
                elif 'r15' in dst:
                    state = 5
                    result.append(parsed[0].lstrip())
        elif state == 4:
            if 'mov' in inst:
                dst = inst.split(',')[1]
                if 'r14' in dst:
                    state = 5
                    result.append(parsed[0].lstrip())
                elif 'r15' in dst:
                    assert(False)
        if state == 5:
            assert(len(result) == 3)
            return result
    assert(False)
    return result


f = open('./bld/alpaca/chkpt_bv.log', 'r')

i = 0
global_vars = []
chkpt_bitvector = []
for line in f:
    if i == 0:
        # this line is var line
        global_vars = line.split(',')
        del global_vars[-1]
    else:
        # this line is bv line
        chkpt_bitvector.append(line.split(':')[1].strip('\n'))
    i += 1

assert(len(chkpt_bitvector[0]) == len(global_vars))

for i in reversed(range(0, len(global_vars))):
    isCut = False
    hasZeros = False
    for bv in chkpt_bitvector:
        # all one or all zero is not considerable
        if bv[i] == '1':
            isCut = True
        if bv[i] == '0':
            hasZeros = True
    # for every chkpt, if bv is 0, it is not global
    if isCut == False or hasZeros == False:
        for j in range(0,len(chkpt_bitvector)):
            chkpt_bitvector[j] = chkpt_bitvector[j][:i] + \
                    chkpt_bitvector[j][i+1:]
        del global_vars[i]

print(global_vars)
print(chkpt_bitvector)
assert(len(chkpt_bitvector[0]) == len(global_vars))

cutnum_per_vars = [0] * len(global_vars)

for i in range(0, len(global_vars)):
    for bv in chkpt_bitvector:
        if bv[i] == '1':
           cutnum_per_vars[i] += 1 

print(cutnum_per_vars)

f.close()

f = open('./ext/python_dissembler/mem.src', 'r')

GV = namedtuple("GV", "address name count removable")

GVlist = []
for line in f:
    if '_global_' in line and '_bak' not in line:
        found = False
        for i in range(0,len(global_vars)):
            if global_vars[i] in line:
                # found the global var
                temp = GV(line.split(' ')[0].lstrip('0')
                        , global_vars[i], cutnum_per_vars[i], 0)
                GVlist.append(temp)
                found = True

assert(len(GVlist) == len(global_vars))

f.close()

f = open('./ext/python_dissembler/source.src', 'r')

cbw_address = dissemble_function.get_check_before_write(f)

f = open('./ext/python_dissembler/source.src', 'r')
prev_inst = []
for line in f:
    prev_inst.append(line)
    if '\tmov\t' in line:
        #if mov
        dst = line.split('\tmov\t')[1].split(',')[1]
        dst = dst.split(';')[0]
        dst = dst.strip()
        if '&0x' in dst:
            # absolutely saving to global (mustalias)
            for gv in GVlist:
                if gv.address in dst:
                    #writing to global!!
                    # for now, what is definitely erasable is
                    # mov address, r15
                    # mov size, r14
                    # call check_before_write
                    nopable_address = find_nopable_address(prev_inst,
                           cbw_address, gv.address)
                    print(nopable_address)
                    # TODO: two movs can be 2 byte or 4 byte
                    # since it is hard to tell which is which, we only
                    # remove the call inst for now
                    prev_inst = []
                    GVlist.append(GV(gv.address, 
                        gv.name, gv.count, int(nopable_address[0], 16)))
                    GVlist.remove(gv)
                    break
print(GVlist)
f.close()

f2 = open(sys.argv[1], 'r')
out2 = open('./bld/alpaca/cem_mod2.out', 'w')
addr = 0;
j = 0
prev_char = ['','','']
save_bitvector = 0
save_removable = 0
save_counter = 0
for line in f2:
    for char in line:
        # this part is acutally generationg binary
        if len(char) != 0 and \
                len(prev_char[0]) != 0 and \
                len(prev_char[1]) != 0 and \
                len(prev_char[2]) != 0:
            if 0x66 == ord(char) and \
                    0x66 == ord(prev_char[0]) and \
                    0x66 == ord(prev_char[1]) and \
                    0x66 == ord(prev_char[2]):
                save_bitvector = 1

        if len(char) != 0 and \
                len(prev_char[0]) != 0 and \
                len(prev_char[1]) != 0 and \
                len(prev_char[2]) != 0:
            if 0x55 == ord(char) and \
                    0x55 == ord(prev_char[0]) and \
                    0x55 == ord(prev_char[1]) and \
                    0x55 == ord(prev_char[2]):
                save_removable = 1

        if j < 3:
            j += 1
        else:
            if save_bitvector == 1:
                # this is the start of the array
                print(((int(chkpt_bitvector[int(save_counter / 4)], 2) \
                        >> ((save_counter % 4)*8)) % 0x100))
                out2.write(chr((int(chkpt_bitvector[int(save_counter / 4)], 2) \
                        >> ((save_counter % 4)*8)) % 0x100))
                save_counter += 1
                if save_counter / 4 == len(chkpt_bitvector):
                    save_bitvector = 0
                    save_counter = 0
            elif save_removable == 1:
                # this is the start of the array
                gvar = global_vars[int(save_counter / 4)]
                if (save_counter % 4) < 2:
                    # save cutted num
                    cutted_num = 0
                    for gv in GVlist:
                        if gv.name in gvar:
                            cutted_num = gv.count
                    assert(cutted_num != 0)
                    out2.write(chr((cutted_num >> ((save_counter % 2)*8)) % 0x100))
                else:
                    # save nopable address
                    nopable_address = 0
                    for gv in GVlist:
                        if gv.name in gvar:
                            nopable_address = gv.removable
                    assert(nopable_address != 0)
                    out2.write(chr((nopable_address >> \
                            ((save_counter % 2)*8)) % 0x100))
                save_counter += 1
                if save_counter / 4 == len(GVlist):
                    save_removable = 0
                    save_counter = 0
            else:
                out2.write(prev_char[2])
        prev_char[2] = prev_char[1]
        prev_char[1] = prev_char[0]
        prev_char[0] = char
    #j = 0
    #i = 0
    out2.write(prev_char[2])
    out2.write(prev_char[1])
    out2.write(prev_char[0])
    prev_char = ['','','']
