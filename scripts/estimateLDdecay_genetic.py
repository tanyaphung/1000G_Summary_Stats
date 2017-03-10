import os
import sys
import numpy
import argparse
import csv

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script estimates LD decay in bins. Bins can be specified by user")

	parser.add_argument(
            "--input", required=True,
            help="REQUIRED. Input file. This is usually output from plink or vcftools.")
	parser.add_argument(
			"--format", required=True,
			help="REQUIRED. Enter plink or vcftools or vcftools_genetic. Specify which file format")
	parser.add_argument(
    		"--bin", required=True,
            help="REQUIRED. Specify the number of bins")
	parser.add_argument(
    		"--max_genetic", required=True,
            help="REQUIRED. Specify the maximum genetic distance.")
	parser.add_argument("--outfile", required=True, 
			help="REQUIRED. Name of output file.")

	args = parser.parse_args()
	return args

def binning(distance_array, rsquared_array, max_genetic, numBin):
	"""
	This function takes in a distance array and an rsquared array. It will output a dictionary where key is the range of the bin and values are (1) the sum of rsquared and (2) number of SNPs in that bin.
	"""
	bins_before = numpy.linspace(0, max_genetic, numBin) # create bins
	bins = numpy.append(bins_before, 1)
	digitized = numpy.digitize(distance_array, bins)

	rsquared_in_bins_sum = [rsquared_array[digitized == i].sum() for i in range(1, len(bins))]
	rsquared_in_bins_len = [len(rsquared_array[digitized == i]) for i in range(1, len(bins))]

		
	returnDict_out = {}
	for i in range(0, len(bins)-1):
		region = (bins[i], bins[i+1])
		returnDict_out[region] = (rsquared_in_bins_sum[i], rsquared_in_bins_len[i])

	return returnDict_out

def main():
	# Parsing command-line arguments
	args = parse_args()

	distance = []
	rsquared = []
	if args.format == "plink":
		with open(args.input, "r") as f:
			next(f)
			for line in f:
				line = line.rstrip("\n")
				line = line.split("\t")
				bp = int(line[4]) - int(line[1])
				r2 = float(line[6])
				distance.append(bp)
				rsquared.append(r2)

	if args.format == "vcftools":
		"""
		Header from VCFtools: CHR     POS1    POS2    N_CHR   R^2     D       Dprime
		"""
		with open(args.input, "r") as f:
			next(f)
			for line in f:
				line = line.rstrip("\n")
				line = line.split("\t")
				bp = int(line[2]) - int(line[1])
				r2 = float(line[4])
				distance.append(bp)
				rsquared.append(r2)

	if args.format == "vcftools_genetic":
		"""
		Header from VCFtools: POS1    POS2    GeneticDistance	Physical	R^2
		"""
		with open(args.input, "r") as f:
			next(f)
			for line in f:
				line = line.rstrip("\n")
				line = line.split("\t")
				cM = float(line[2])
				r2 = float(line[4])
				distance.append(cM)
				rsquared.append(r2)

	# There are more efficient ways to create the numpy array. But this will do for now. 
	distance_array = numpy.asarray(distance)
	rsquared_array = numpy.asarray(rsquared)

	numBin = int(args.bin)

	max_genetic = float(args.max_genetic)

	results = binning(distance_array, rsquared_array, max_genetic, numBin)

	with open(args.outfile,"w") as f:
		output_list = []
		for k, v in sorted(results.items()):
			output_list.append([str(k[0]), str(k[1]), str(v[0]), str(v[1])])
		
		w = csv.writer(f, delimiter = "\t")
		w.writerows(output_list)

main()