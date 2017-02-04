import os
import sys
import argparse
import csv
from collections import Counter

def parse_args():
	"""
	Parse command-line arguments
	"""
	parser = argparse.ArgumentParser(description="This script generates the count for a folded SFS from VCF")

	parser.add_argument(
            "--variant", required=True,
            help="REQUIRED. Variant file. The format should be CHROM POS ind1 ind2 etc. Should be tab delimit. Because of VCF format, it is 1-based")
	parser.add_argument(
			"--numAllele", required=True,
			help="REQUIRED. Indicate the number of alleles, which is equal to the number of individuals in your sample times 2.")
	parser.add_argument(
			"--pass_coordinates", required=True,
			help="REQUIRED. Input is the file that lists the coordinates (1-based) that are annotated as P (pass) from the masks file. This file is generated from the script obtain_pass_positions.py. The format is a genomic coordinate per line.")
	parser.add_argument(
			"--outfile", required=True,
			help="REQUIRED. Name of the output file")

	args = parser.parse_args()
	return args

def generate_foldedSFS(numAlleles, variant_sites_pass):
	""" Following equation 1.2 from John Wakeley book."""
	altAllele = [] ## This is a list where each item is the count of the number of alternate alleles of each variant. The length of this list is equal to the number of variants you have.
	for record in variant_sites_pass:
		count = 0
		for genotype in record[1:]:
			if genotype == '0|1' or genotype == '1|0':
				count += 1
			if genotype == '1|1':
				count += 2
		altAllele.append(count)

	zeta = Counter(altAllele)
	eta = {} # See Wakeley book equation 1.2
	for i in range(1, (numAlleles/2)+1):
		if i != (numAlleles-i):
			frequency = float(zeta[i] + zeta[numAlleles - i])
			eta[i] = frequency
		if i == (numAlleles - i):
			frequency = float(zeta[i] + zeta[numAlleles - i])/2
			eta[i] = frequency
	return eta

def main():
	# parsing command-line arguments
	args = parse_args()

	# setting variables
	numAlleles = 0
	variant_sites = [] # this is a list. Each item in this list is a list where the first item is the genomic position (1-based).
	variant_sites_pass = [] # this is a list similar to variant sites. However, the variants here are actual variants (excluding homozygous variants) AND variants that are annotated as pass from the masks
	pass_coordinates = set()

	with open(args.variant, "r") as variant_file:
		header = next(variant_file).split("\t")
		numAlleles = int(len(header) - 2)*2
		if numAlleles != int(args.numAllele):
			print "The number of alleles computed is not equal to the number of alleles you think you have. Something is not consistent here. Please check!"
			exit(1)
		else:
			for line in variant_file:
				line = line.rstrip("\n")
				line = line.split("\t")
				to_append = [int(line[1])]
				for i in range(2, len(line)):
					to_append.append(line[i])
				variant_sites.append(to_append)

	with open(args.pass_coordinates, "r") as pass_file:
		for line in pass_file:
			line = line.rstrip("\n")
			pass_coordinates.add(int(line))

	# Computing some summary statistics for sanity check

	print "There are ", len(variant_sites), "variants from the input VCF file"
	homozygous_variants = 0
	actual_variants = 0
	actual_variants_pass_count = 0
	for record in variant_sites:
		record_GT = record[1:]
		if all(x=='0|0' for x in record_GT):
			homozygous_variants += 1
		else:
			actual_variants += 1
			if record[0] in pass_coordinates:
				actual_variants_pass_count += 1
				variant_sites_pass.append(record)

	print "There are ", homozygous_variants, "variants where all individuals genotypes are 0|0. This happens because vcf-subset does not remove variants if all individuals are homozygous."

	if actual_variants == len(variant_sites)-homozygous_variants:
		print "There are ", actual_variants, "actual variants"
	else:
		print "The number of variant sites pass from the dictionary does not match. Quitting"
		exit(1)

	print "There are ", actual_variants_pass_count, "variants that are not homozygous and are also annotated as PASS in the masks. In other words, these variants are high quality."

	pror_high_qual_var = float(actual_variants_pass_count)/actual_variants
	print "Proportion of actual variants that are high quality is ", pror_high_qual_var

	results = generate_foldedSFS(numAlleles, variant_sites_pass) 
	with open(args.outfile, "w") as f:
		out_list = []
		for key in sorted(results):
			out_list.append([key, results[key]])
		w = csv.writer(f)
		w.writerows(out_list)
main()		
