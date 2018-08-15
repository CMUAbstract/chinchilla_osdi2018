import sys
'''
f = open('cem.out', 'r')
out = open('dissemble.out', 'w')
addr = 0;
i = 0
for line in f:
    for char in line:
        if i == 0:
            out.write(format(addr, '04x'))
            out.write(':\t')
            addr += 4;
        out.write(format(ord(char), '02x'))
        out.write('\t')
        i += 1
        if i == 4:
            out.write('\n')
            i = 0
'''
def parse_line(line):
    retval = []
    if ':\t' in line:
        retval.append(line.split(':\t')[0])
        # parse bcode and inst name
        if '\t' in line.split(':\t')[1]:
            retval.append(line.split(':\t')[1].split('\t')[0])
            retval.append(line.split(':\t')[1].split('\t')[1])
    return retval

def get_operand(line, index):
    if ':\t' in line:
        # parse bcode and inst name
        if '\t' in line.split(':\t')[1]:
            return (line.split(':\t')[1].split('\t')[2 + index])
    return ''

def find_fixpoint(prev_insts):
    state = 0
    result = []
    # state
    # 0: idle
    # 1: mov (for saving last executed chkpt)
    # 2: mov (for saving last exectued chkpt)
    # 3: mov (for saving last exectued chkpt)
    # 4: jmp +2
    # 5: jnz
    # 6: cmp.b
    # 7: mov.b
    # 8: jmp (may or may not exist)
    # it can have more insts than this (much more)
    # but these are the bare minimum that (I think) should be there
    prev_line = ''
    for line in reversed(prev_insts):
        parsed = parse_line(line)
        #print(parsed[1])
        #print(len(parsed[1].strip()))
        # if the is no state 8 at all
        if state == 7 and '00 3c' not in parsed[1]:
            parsed = parse_line(prev_line)
            # TODO: check Endian
            result.append(chr(int(parsed[0], 16) % 0x100))
            result.append(chr(int(parsed[0], 16) / 0x100))
            return result
        #else
        if 'mov.b' in parsed[2]:
            if state == 6:
                state = 7
        elif 'mov' in parsed[2]:
            if state == 0:
                # read chkpt num from here
                chkpt_num = get_operand(line, 0)
                # if # is not in first operand, it is dealing with phi
                # disregard those
                if '#' in chkpt_num:
                    if '&' not in get_operand(line, 1):
                        chkpt_num = chkpt_num.strip('#')
                        chkpt_num = chkpt_num.strip(',')
                        chkpt_num = int(chkpt_num)
                        chkpt_num_lsb = chr(int(chkpt_num % 0x100))
                        chkpt_num_msb = chr(int(chkpt_num / 0x100))
                        #result.append(int(chkpt_num))
                        result.append(chkpt_num_lsb)
                        result.append(chkpt_num_msb)
                        state += 1
            elif state < 3:
                state += 1
        elif 'jmp' in parsed[2]:
            assert('00 3c' in parsed[1])
            if state == 3:
                state = 4
            elif state == 7:
                state = 8
                result.append(chr(int(parsed[0], 16) % 0x100))
                result.append(chr(int(parsed[0], 16) / 0x100))
                return result
        elif 'jnz' in parsed[2]:
            if state == 4:
                state = 5
        elif 'cmp.b' in parsed[2]:
            if state == 5:
                state = 6
        prev_line = line
    assert(state == 7)
    result.append(chr(int(parsed[0], 16) % 0x100))
    result.append(chr(int(parsed[0], 16) / 0x100))
    return result


f = open('source.src', 'r')
out = open('dissemble.out', 'w')
addr = 0;
prev_insts = []
found_chkpt = 0
final_result = []
result = [] # source, dest, index
isPhi = False;


for line in f:
    # parse address
    parsed = parse_line(line)
    if len(parsed) == 3:
        # save prev insts
        if found_chkpt == 1:
            if 'jmp' in parsed[2]:
                found_chkpt = 0
                #result.append(int(parsed[0], 16))
                #TODO: This part can be optimized. Currently it is jumping to jmp.
                # instead it can directly jump
                offset = int(parsed[0], 16) - (ord(result[2]) + ord(result[3])*0x100)
                assert(offset > 0)
                # TODO: offset size check needed
                new_char = (chr((offset - 2) / 2)) # NOTE: we never do minus
                #TODO: Temp solution. Currently Phi-related checkpoint cannot be removed!!
                if isPhi == True:
                    result.append(chr(0))
                    result.append(chr(0))
                else:
                    result.append(new_char) # offset
                    result.append(chr(0x3c)) # jmp
                final_result.append(result)
                result = []
                
                isPhi = False;
            else:
                # this seems like a Phi node
                isPhi = True;
                print('this must be phi-related');
        elif 'b0 12 64 d1' in parsed[1]:
            found_chkpt = 1
            result = find_fixpoint(prev_insts)
            assert(len(result) == 4)
            prev_insts = []
        else:
            prev_insts.append(line)
#sort
final_result_sorted = []
# for when checkpoint is not compiled
last = len(final_result)
i = 0
while i < last:
    found = 0
    for result in final_result:
        if ord(result[0]) == i:
            final_result_sorted.append(result)
            found = 1
            i += 1
    if found == 0:
        result_blank = [chr(int(i % 0x100)),chr(int(i / 0x100)),chr(0),chr(0),chr(0),chr(0)] # TODO: Fill it
        final_result_sorted.append(result_blank)
        last += 1
        i += 1

print(final_result_sorted)
print(last)
assert(last == len(final_result_sorted))

f2 = open(sys.argv[1], 'r')
out2 = open('cem_mod.out', 'w')
addr = 0;
j = 0
prev_char = ['','','','','']
save_chkpt = 0
save_counter = 0
for line in f2:
    for char in line:
        # this part is acutally generationg binary
        if len(char) != 0 and len(prev_char[0]) != 0 and len(prev_char[1]) != 0 and len(prev_char[2]) != 0 and len(prev_char[3]) != 0 and len(prev_char[4]) != 0:
            if 0x77 == ord(char) and 0x77 == ord(prev_char[0]) and 0x77 == ord(prev_char[1]) and 0x77 == ord(prev_char[2]) and 0x77 == ord(prev_char[3]) and 0x77 == ord(prev_char[4]):
                print('wow!!')
                save_chkpt = 1

        if j < 5:
            j += 1
        else:
            if save_chkpt == 1:
                # this is the start of the array
                out2.write(final_result_sorted[int(save_counter / 6)][save_counter % 6])
                save_counter += 1
                if save_counter / 6 == len(final_result_sorted):
                    save_chkpt = 0
            else:
                out2.write(prev_char[4])
        prev_char[4] = prev_char[3]
        prev_char[3] = prev_char[2]
        prev_char[2] = prev_char[1]
        prev_char[1] = prev_char[0]
        prev_char[0] = char
    #j = 0
    #i = 0
    out2.write(prev_char[4])
    out2.write(prev_char[3])
    out2.write(prev_char[2])
    out2.write(prev_char[1])
    out2.write(prev_char[0])
    prev_char = ['','','','','']
