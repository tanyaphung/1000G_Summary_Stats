import os
import sys
import argparse
import csv

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script computes the average of the female genetic map and the male genetic map.")
	parser.add_argument(
			"--female_genetic_map", required=True,
			help="REQUIRED. Female genetic map.")
	parser.add_argument(
			"--male_genetic_map", required=True,
			help="REQUIRED. Male genetic map.")
	parser.add_argument(
			"--outfile", required=True,
			help="REQUIRED. Path to outfile.")
	args = parser.parse_args()
	return args

def main():
	args = parse_args()
	outfile  = open(args.outfile, "w")

	with open(args.female_genetic_map, "r") as f, open(args.male_genetic_map, "r") as m:
		for line1, line2 in zip(f, m):
			line1 = line1.rstrip("\n")
			line1 = line1.split("\t")
			line2 = line2.rstrip("\n")
			line2 = line2.split("\t")
			if line1[3] != 'NA':
				average_cM = (float(line1[3]) + float(line2[3]))/2
				toprint = [str(line1[0]), str(line1[1]), str(line1[2]), str(average_cM)]
				print >>outfile, "\t".join(x for x in toprint)
			else:
				toprint = [str(line1[0]), str(line1[1]), str(line1[2]), 'NA']
				print >>outfile, "\t".join(x for x in toprint)
main()