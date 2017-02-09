import os
import sys
import argparse


def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script filters out variants that are not annotated as Pass from the masks file")

	parser.add_argument(
            "--VCF", required=True,
            help="REQUIRED. VCF file")
	parser.add_argument(
			"--pass_coordinates", required=True,
			help="REQUIRED. Input is the file that lists the coordinates (1-based) that are annotated as P (pass) from the masks file. This file is generated from the script obtain_pass_positions.py. The format is a genomic coordinate per line.")
	parser.add_argument(
			"--outfile", required=True,
			help="REQUIRED. Name of the output file")

	args = parser.parse_args()
	return args

def main():
	args = parse_args()
	pass_coordinates = set()
	with open(args.pass_coordinates, "r") as pass_file:
		for line in pass_file:
			line = line.rstrip("\n")
			pass_coordinates.add(int(line))

	outfile = open(args.outfile, "w")

	with open(args.VCF, "r") as VCF:
		for orig_line in VCF:
			orig_line.rstrip("\n")
			if orig_line.startswith("#"):
				print >>outfile, orig_line.rstrip("\n")
			if not orig_line.startswith("#"):
				line = orig_line.split("\t")
				if int(line[1]) in pass_coordinates:
					print >>outfile, orig_line.rstrip("\n")
main()