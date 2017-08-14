

f = open("templog.out", "r")
for line in f:
#    print(line)
    index = 0
    w = ['','']
    for c in line:
        print(hex(ord(c)))
    for c in line:
        if index % 2 == 0:
            w[1] = c
        else:
            w[0] = c
        if index == 1:
            index = 0
            if ord(w[0]) == 0x12 and (ord(w[1]) & 0x80) == 0x80:
                print('Call?')
                print(hex(ord(w[0])), hex(ord(w[1])))
                print('\n')
        else:
            index = index + 1
    break
