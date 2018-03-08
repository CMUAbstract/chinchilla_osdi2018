import fileinput
import sys
import re
import numpy

def avg(li):
    print(li)
    result = 0;
    assert(len(li) > 50)
    # discard first data
    mean = numpy.mean(li[1:51])
    stddev = numpy.std(li[1:51])
    return mean, stddev

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

mean, std = avg(values)
f.write("mean:" + str(mean) + " std:" + str(std));
print(str(mean) + " " + str(std))
