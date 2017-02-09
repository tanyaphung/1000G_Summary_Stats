import os
import sys
import numpy
import argparse
import csv

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script generates Xkb regions that are putatively neutral. Xkb can be specified by user")

	parser.add_argument(
            "--input", required=True,
            help="REQUIRED. Input file..")
	parser.add_argument(
    		"--length", required=True,
            help="REQUIRED. Specify the length of the region. For example, 10000 means 10kb")
	# parser.add_argument("--outfile", required=True, 
	# 		help="REQUIRED. Name of output file.")

	args = parser.parse_args()
	return args

def main():
	args = parse_args()
	length = float(args.length)

	with open(args.input, "r") as f:
		next(f)
		for line in f:
			line = line.rstrip("\n")
			line = line.split("\t")
			num = int(float(line[3])/length)
			start = float(line[1])
			for i in range(1, num+1):
				if i == 1:
					end = start + length
					toprint = [str(line[0]), str(start), str(end)]
					print "\t".join(x for x in toprint)
				else:
					newStart = start + (i-1)*length
					newEnd = newStart + length
					toprint = [str(line[0]), str(newStart), str(newEnd)]
					print "\t".join(x for x in toprint)


			# if num == 1:
			# 	start = float(line[1])
			# 	end = start + length
			# 	toprint = [str(line[0]), str(start), str(end)]
			# 	print "\t".join(x for x in toprint)
			# if num > 1:
			# 	for i in range(1, num+1):


main()