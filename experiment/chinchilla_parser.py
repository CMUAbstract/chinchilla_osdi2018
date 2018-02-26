import fileinput
import sys

fileName = sys.argv[1]
start = False
converged_set = []
prev_result = 0
for line in fileinput.input(fileName):
    if ':' in line:
        s = line.split(':')[0].strip()

        time = float(line.split(':')[0].strip())
        log = line.split(':')[1].strip()

        if 'start' in log:
            start = True
            startTime = time

        if start and 'end' in log:
            start = False
            endTime = time
            result = endTime - startTime
            print(result)

            # if error with prev is within 10%
            if (abs(result - prev_result) < result / 10):
                converged_set.append(result)
            else:
                converged_set = []
            prev_result = result
            if (len(converged_set) == 10):
                print('converged')
                # print average
                average = 0;
                for i in range(0,10):
                    average += converged_set[i]
                average /= 10
                print('average:', average)
                break 
