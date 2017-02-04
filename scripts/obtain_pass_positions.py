import os
import sys
import argparse
import csv
from Bio import SeqIO

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script takes in the fasta 1000G mask file and output the position of the genome (1-based) that is annotated with P (passing). This script is run once to obtain the genomic positions.")

	parser.add_argument(
            "--fasta", required=True,
            help="REQUIRED. fasta file.")
	parser.add_argument(
			"--masks_summary", required=True,
			help="REQUIRED. Input the file that tabulates the total number of sites and the total number of pass sites for all chromosomes.")
	parser.add_argument(
			"--chrName", required=True,
			help="REQUIRED. Indicate which chromosome to compute in the form chr1, chr2, etc.")
	parser.add_argument(
	        "--outfile", required=True,
	        help="REQUIRED. Path to output file name")

	args = parser.parse_args()
	return args

def main():
	args = parse_args()
	sequence = ""
	fasta_file = SeqIO.parse(open(args.fasta), 'fasta')
	for record in fasta_file:
		sequence+=record.seq

	pass_count = 0
	pass_position_list = [] #record position in 1-based
	for i in range(0, len(sequence)):
		if sequence[i] == 'P':
			pass_count += 1
			pass_position_list.append(i+1) # because python index starts with 0

	with open(args.outfile, "w") as f:
		for position in pass_position_list:
			f.write("%s\n" % position)
	
	# Do some sanity check. It seems silly to do the checking after making the file. But this will work for now. TODO: change the order of the script so that the checking is done first before doing work
	all_chr_total = {}
	all_chr_pass = {}

	with open(args.masks_summary, "r") as file:
		for line in file:
			line = line.rstrip("\n")
			line = line.split("\t")
			all_chr_total[line[0]] = int(line[1])
			all_chr_pass[line[0]] = int(line[2])
	inputChr = args.chrName

	print len(sequence)
	print all_chr_total[inputChr]
	print pass_count
	print all_chr_pass[inputChr]

	if len(sequence) != all_chr_total[inputChr]:
		print "The length of the sequence obtained from the fasta file does not match with the number indicated by the header"
	if pass_count != all_chr_pass[inputChr]:
		print "The number of sites annotated as pass is not equal to what is indicated from the header."
main()