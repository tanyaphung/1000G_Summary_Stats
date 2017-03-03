import os
import sys
import argparse


def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script filters out variants where the genomic coordinates do not fall into a desired list. This script is a variation of the script susbsetVCF_basedOnPositions.py. This script is written to deal with the case where the coordinates you want to keep is in the BED format.")

	parser.add_argument(
            "--VCF", required=True,
            help="REQUIRED. VCF file")
	parser.add_argument(
			"--coordinates", required=True,
			help="REQUIRED. Input is the file that lists the coordinates that you want to keep in the VCF file. Input is in BED format. For example, one could input the BED file specifying the start and end position of 10kb neutral regions. NOTE that BED format is 0-based.")
	parser.add_argument(
			"--outfile", required=True,
			help="REQUIRED. Name of the output file")

	args = parser.parse_args()
	return args

def main():
	args = parse_args()
	coordinates = set()
	with open(args.coordinates, "r") as f:
		for line in f:
			line = line.rstrip("\n")
			line = line.split("\t")
			for i in range(int(line[1]), int(line[2])):
				coordinates.add(i + 1)

	outfile = open(args.outfile, "w")

	with open(args.VCF, "r") as VCF:
		for orig_line in VCF:
			orig_line.rstrip("\n")
			if orig_line.startswith("#"):
				print >>outfile, orig_line.rstrip("\n")
			if not orig_line.startswith("#"):
				line = orig_line.split("\t")
				if int(line[1]) in coordinates:
					print >>outfile, orig_line.rstrip("\n")
main()