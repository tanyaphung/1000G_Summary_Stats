import os
import sys

bins_sumRSquare_dict = {}
bins_totalSNPs_dict = {}

with open("/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/bins/CHB/bins_range.txt", "r") as f:
	for line in f:
		line = line.rstrip("\n")
		line = line.split("\t")
		bins_sumRSquare_dict[(float(line[0]), float(line[1]))] = []
		bins_totalSNPs_dict[(float(line[0]), float(line[1]))] = []

for i in range(1, 23):
	file = "/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/bins/CHB/chr%d_LD_geno_100bins.txt" % i
	with open(file, "r") as f:
		for line in f:
			line = line.rstrip("\n")
			line = line.split("\t")
			bins_sumRSquare_dict[(float(line[0]), float(line[1]))].append(float(line[2]))
			bins_totalSNPs_dict[(float(line[0]), float(line[1]))].append(float(line[3]))

bins_avg_sumRSquared = {}
for bin in bins_sumRSquare_dict:
	rSquaredAvg = float(sum(bins_sumRSquare_dict[bin]))/sum(bins_totalSNPs_dict[bin])
	bins_avg_sumRSquared[bin] = rSquaredAvg

for k, v in sorted(bins_avg_sumRSquared.items()):
	toprint = [str(k[0]), str(k[1]), str(v)]
	print"\t".join(x for x in toprint)
