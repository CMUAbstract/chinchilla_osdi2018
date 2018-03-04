import fileinput
import sys
import re

fileName = sys.argv[1]
chkpts = {}
runTime = -1

f = open(fileName + "_processed", "w")
iterCount = 0

startTime = None
for line in fileinput.input(fileName):
    start = re.search(r"(?P<name>[0-9]+\.[0-9]+): start", line)
    if start is not None:
        if runTime != -1:
            f.write("iter:" + str(iterCount) + " time:" + str(runTime))
            f.write(" chkpt status:" + repr(chkpts) + "\n")
            iterCount += 1
            chkpts = {}
        startTime = float(start.group("name"))

    end = re.search(r"(?P<name>[0-9]+\.[0-9]+): end", line)
    if end is not None:
        endTime = float(end.group("name"))
        if startTime is not None:
            runTime = endTime - startTime

    chkpt = re.search(r"chkpt\[(?P<name1>[0-9]+)\]=(?P<name2>[0-9]+)", line)
    if chkpt is not None:
        chkptId = int(chkpt.group("name1"))
        unrollFactor = int(chkpt.group("name2"))
        chkpts[chkptId] = unrollFactor

