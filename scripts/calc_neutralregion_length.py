import os
import sys
out = []
with open(sys.argv[1], "r") as f:
	next(f)
	for line in f:
		line = line.rstrip("\n")
		line = line.split("\t")
		regionLen = float(line[2]) - float(line[1])
		out.append([line[0], float(line[1]), float(line[2]), regionLen, float(line[6]), float(line[8])])
header = ['chr', 'start', 'end', 'length', 'rec', 'bgs']
print "\t".join(x for x in header)
for i in out:
	toprint = [i[0], str(i[1]), str(i[2]), str(i[3]), str(i[4]), str(i[5])]
	print "\t".join(x for x in toprint)