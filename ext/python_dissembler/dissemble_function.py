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

def get_check_before_write(f):
    for line in f:
        if '<check_before_write>' in line:
            address = line.split(' ')[0]
            address = address.lstrip('0')
            assert(len(address) == 4)
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

