import sys

def get_jmp_type(inst):
    opcode = int(inst.split(' ')[1], 16)
    opcode = opcode % 32 # get tailing 5 bits
    opcode = opcode / 4 # remove tailing 2 bits
    # the 3 bits indicate the type of jmp
    return str(opcode)


def find_jump_src(address):
    result = []
    address = address.strip(' ')
    f2 = open('./ext/python_dissembler/source.src', 'r')
    for line in f2:
        # search for jump
        if ';abs ' in line:
            dest = line.split(';abs ')[1]
            dest = dest.lstrip('0x')
            if address in dest:
                parsed = parse_line(line)
                result.append(parsed[0])
                result.append(get_jmp_type(parsed[1]))
                return result
        # search for br
        if '\tbr\t' in line:
            if '#0x' in line: 
                dest = line.split('#0x')[1]
                dest = dest.rstrip('\t;')
                if address in dest:
                    parsed = parse_line(line)
                    result.append(parsed[0])
                    result.append('br')
                    return result
    assert(False)
    return ''

def find_jump_dest(line):
    if 'jmp' not in line:
        assert(False)
    if ';abs ' in line:
        dest = line.split(';abs ')[1]
        dest = dest.lstrip('0x')
        return dest
    assert(False)
    return ''

def get_chkpt_func_address(f):
    for line in f:
        if '<checkpoint>' in line:
            address = line.split(' ')[0]
            address = address.lstrip('0')
            assert(len(address) == 4)
            address = 'b0 12 ' + address[2] + address[3] + ' ' + address[0] + address[1]
            return address

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
    # it can have more insts than this (much more)
    # but these are the bare minimum that (I think) should be there
    prev_line = ''
    for line in reversed(prev_insts):
        parsed = parse_line(line)
        #print(parsed[1])
        #print(len(parsed[1].strip()))
        if 'mov.b' in parsed[2]:
            if state == 6:
                state = 7
                # TODO: instead of reading jump or not reading if there isn't
                # do extensive search
                # we make seperate checkpoint for every edge to same bb, so 
                # jmp_src is unique every time
                jmp_src = find_jump_src(parsed[0])
                result.append(chr(int(jmp_src[0], 16) % 0x100))
                result.append(chr(int(jmp_src[0], 16) / 0x100))
                result.append(jmp_src[1])
                return result

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
        elif 'jnz' in parsed[2]:
            if state == 4:
                state = 5
        elif 'cmp.b' in parsed[2]:
            if state == 5:
                state = 6
        prev_line = line
    assert(false)
    return result


f = open('./ext/python_dissembler/source.src', 'r')
out = open('./bld/alpaca/dissemble.out', 'w')
addr = 0;
prev_insts = []
found_chkpt = 0
final_result = []
result = [] # source, dest, index
isPhi = False
chkpt_address = get_chkpt_func_address(f)
print(chkpt_address)

# re-open f
f = open('./ext/python_dissembler/source.src', 'r')
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
                jmp_dest = find_jump_dest(line)
                print('jumping from ' + hex(ord(result[3])) + hex(ord(result[2])) + ' to ' + jmp_dest)
                offset = int(jmp_dest, 16) - (ord(result[2]) + ord(result[3])*0x100)
                # offset size check. new_char should fit in 1 byte,
                # which means (offset - 2) / 2 should be less than 2^9
                # and greater or equal than -2^9
                #TODO: Temp solution. Currently Phi-related checkpoint cannot be removed!!
                if isPhi == True:
                    del result[-1]
                    result.append(chr(0))
                    result.append(chr(0))
                elif offset >= -2**10 + 2 and offset < 2**10 + 2:
                    # Here, we can jmp
                    # TODO: this is different from what I got from googling (it says offset is -1024 ~ 1022.
                    # is that wrong or am I wrong
                    opcode = int(result[-1])
                    assert(opcode < 8)
                    del result[-1]
                    if offset > 0:
                        jmp_val = (offset - 2) / 2;
                        # check that it fits
                        assert(jmp_val / 2**9 < 1);
                        jmp_lsb = jmp_val % 0x100
                        jmp_msb = jmp_val / 0x100
                        
                        assert(jmp_msb < 2)
                        result.append(chr(jmp_lsb)) # offset
                        # 32: 001 (fixed) + opcode*4 + msb
                        result.append(chr(32 + opcode*4 + jmp_msb)) # jmp
                    else:
                        # get 2s complement
                        jmp_val = (offset - 2) / 2
                        twos_comp = (2**10 + jmp_val) % 2**10
                        jmp_lsb = twos_comp % 0x100
                        jmp_msb = twos_comp / 0x100
                        
                        assert(jmp_msb < 4)
                        result.append(chr(jmp_lsb)) # offset
                        result.append(chr(32 + opcode*4 + jmp_msb)) # jmp
                else:
                    # here we do branch.
                    # first, we should change the "address part" of branch inst
                    # I mean, if the inst part is not even branch, we are doomed
                    assert('br' == result[4])
                    del result[-1]
                    # change the fix location
                    result[2] = chr(ord(result[2]) + 2)
                    assert(int(jmp_dest, 16) / 0x10000 < 1)
                    result.append(chr(int(jmp_dest, 16) % 0x100))
                    result.append(chr(int(jmp_dest, 16) / 0x100))
                
                final_result.append(result)
                result = []
                
                isPhi = False;
            else:
                # this seems like a Phi node
                isPhi = True;
        elif chkpt_address in parsed[1]:
            found_chkpt = 1
            result = find_fixpoint(prev_insts)
            assert(len(result) == 5)
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
out2 = open('./bld/alpaca/cem_mod.out', 'w')
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
