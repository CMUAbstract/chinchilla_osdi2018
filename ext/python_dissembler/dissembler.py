import sys
import dissemble_function

f = open('./ext/python_dissembler/source.src', 'r')
out = open('./bld/alpaca/dissemble.out', 'w')
addr = 0;
prev_insts = []
found_chkpt = 0
final_result = []
result = [] # source, dest, index
isPhi = False
chkpt_address = dissemble_function.get_chkpt_func_address(f)
print(chkpt_address)
func_name = ''

# re-open f
f = open('./ext/python_dissembler/source.src', 'r')
for line in f:
    # parse address
    parsed = dissemble_function.parse_line(line)
    if "<" in line:
        func_name = line.split("<")[1].split(">")[0]

    if len(parsed) == 3:
        # save prev insts
        if found_chkpt == 1:
            if 'jmp' in parsed[2]:
                found_chkpt = 0
                #result.append(int(parsed[0], 16))
                #TODO: This part can be optimized. Currently it is jumping to jmp.
                # instead it can directly jump
                jmp_dest = dissemble_function.find_jump_dest(line)
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
                    if (ord(result[2]) == 254):
                        result[2] = chr(0)
                        result[3] = chr(ord(result[3]) + 1)
                    else:
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
            if "end_run" not in func_name: 
                print("found checkpoint " + line)
                found_chkpt = 1
                result = dissemble_function.find_fixpoint(prev_insts)
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
out2 = open('./bld/alpaca/mod.out', 'w')
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
