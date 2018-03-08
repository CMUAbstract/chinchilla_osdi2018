import fileinput
import sys
import re

def avg(li):
    print(li)
    result = 0;
    for val in li:
        result += val
    result /= len(li)
    return result

fileName = sys.argv[1]

values = []

f = open(fileName + "_processed", "w")
iterCount = 0

for line in fileinput.input(fileName):
    start = re.search(r"(?P<name>[0-9]+\.[0-9]+): start", line)
    if start is not None:
        startTime = float(start.group("name"))

    end = re.search(r"(?P<name>[0-9]+\.[0-9]+): end", line)
    if end is not None:
        endTime = float(end.group("name"))
        runTime = endTime - startTime
        values.append(runTime)
        f.write("time:" + str(runTime) + "\n")

# Mean of last 5 vals
f.write("mean:" + str(avg(values[-5:len(values)])));
print(str(avg(values[-5:len(values)])))
