import os
import sys

num=int(sys.argv[1])
autosome_eta = {}

for i in range(1, num+1):
	autosome_eta[i] = 0

for i in range(1,23):
	filename = "/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/foldedSFS_neutral/CHB/chr%d_10kb.neutral.region_CHB.txt" %i
	with open(filename, "r") as f:
		for line in f:
			line = line.rstrip("\n")
			line = line.split(",")
			autosome_eta[int(line[0])] += float(line[1])

for k, v in autosome_eta.iteritems():
	toprint = [str(k), str(v)]
	print "\t".join(toprint)
