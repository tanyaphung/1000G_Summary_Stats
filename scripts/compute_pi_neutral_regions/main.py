import os
import sys
import argparse
import csv
from collections import Counter
from callableEachWin import *
from processVCFsubset import *
from computeAF import *
from computePi import *

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script generates the count for a folded SFS from VCF")
	parser.add_argument(
			"--windows", required=True,
			help="REQUIRED. BED file for nonoverlapping windows")
	parser.add_argument(
			"--callableSet", required=True,
			help="REQUIRED. Input is the file that lists the coordinates (1-based) that are annotated as P (pass) from the masks file. This file is generated from the script obtain_pass_positions.py. The format is a genomic coordinate per line.")
	parser.add_argument(
            "--variants", required=True,
            help="REQUIRED. Variant file. The format should be CHROM POS ind1 ind2 etc. Should be tab delimit. Because of VCF format, it is 1-based")
	parser.add_argument(
			"--numAllele", required=True,
			help="REQUIRED. Indicate the number of alleles, which is equal to the number of individuals in your sample times 2.")
	
	parser.add_argument(
			"--outfile", required=True,
			help="REQUIRED. Name of the output file")

	args = parser.parse_args()
	return args
def main():
	# parsing command-line arguments
	args = parse_args()

	windows = []
	with open(args.windows,"r") as windowsFile:
		for line in windowsFile:
			line = line.split("\t")
			windows.append((int(line[1])+1, int(line[2])+1)) # I add 1 here to make it 1-based exclusive for consistency. So (1, 100001) means from (1, 100000).

	callableSet = set()
	with open(args.callableSet, "r") as pass_file:
		for line in pass_file:
			line = line.rstrip("\n")
			callableSet.add(int(line))

	numAlleles = 0
	variants = [] # this is a list. Each item in this list is a list where the first item is the genomic position (1-based).
	with open(args.variants, "r") as variants_file:
		header = next(variants_file).split("\t")
		numAlleles = int(len(header) - 2)*2
		if numAlleles != int(args.numAllele):
			print "The number of alleles computed is not equal to the number of alleles you think you have. Something is not consistent here. Please check!"
			exit(1)
		else:
			for line in variants_file:
				line = line.rstrip("\n")
				line = line.split("\t")
				to_append = [int(line[1])]
				for i in range(2, len(line)):
					to_append.append(line[i])
				variants.append(to_append)

	# Do stuff:
	winsCallable = callableEachWin(windows, callableSet)

	variants_callable = processVCFsubset(variants, callableSet)

	variants_AF_dict = computeAF(variants_callable, numAlleles)

	variantsSet = set()
	for key in variants_AF_dict:
		variantsSet.add(key)

	winsPi = {}
	for eachWin in windows:
		eachWinAF = []
		for eachPos in range(eachWin[0], eachWin[1]):
			if eachPos in variantsSet:
				eachWinAF.append(variants_AF_dict[eachPos])
		pi = computePi(eachWinAF, numAlleles)
		if pi != 'NA':
			piPerSite = float(pi)/winsCallable[eachWin]
		else:
			piPerSite = 'NA'
		winsPi[eachWin] = (pi, winsCallable[eachWin], piPerSite)

	with open(args.outfile, "w") as f:
		output_list = []
		for k, v in sorted(winsPi.items()):
			output_list.append([k[0], k[1], v[0], v[1], v[2]])
		w = csv.writer(f)
		w.writerows(output_list)

main()