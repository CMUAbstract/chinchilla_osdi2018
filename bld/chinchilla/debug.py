f2 = open('cem.out', 'r')
f3 = open('cem_mod.out', 'r')
out = open('dissemble.out', 'w')
out2 = open('dissemble_mod.out', 'w')
addr = 0;
i = 0
j = 0
prev_char = ['','','','','']
save_chkpt = 0
save_counter = 0
for line in f2:
    for char in line:
        # this part if for debug
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
#    i = 0
i = 0
addr = 0;
for line in f3:
    for char in line:
        # this part if for debug
        if i == 0:
            out2.write(format(addr, '04x'))
            out2.write(':\t')
            addr += 4;
        out2.write(format(ord(char), '02x'))
        out2.write('\t')
        i += 1
        if i == 4:
            out2.write('\n')
            i = 0
#    i = 0
