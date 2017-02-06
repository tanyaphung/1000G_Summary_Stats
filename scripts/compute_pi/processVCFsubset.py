import os
import sys
def processVCFsubset (variants, callableSet):
	"""
	This script cleans the VCF after subsetting. Specifically, it will (1) remove any site where the genotype for all subsetted individuals is 0|0. The reason for this is that vcf-subset does not do this automatically, (2) only keep the biallelic allele, in other words, remove 1|2, 2|1, and 2|2, and (3) remove any site that is not callable, meaning where it is not annotated with a P in the mask file.
	Input 1: a list. Each item in this list is a list where the first item is the genomic position (1-based).
	Input 2: a set where each item is the callable position (1-based).
	Return: a list. Each item in this list is a list where the first item is the genomic position (1-based). Basically the same as Input 1 but fewer variants,
	"""
	homozygous_variants = 0
	actual_variants = 0
	actual_variants_callable_count = 0
	variants_callable = []

	for record in variants:
		record_GT = record[1:]
		if all(x=='0|0' for x in record_GT):
			homozygous_variants += 1
		else:
			actual_variants += 1
			if '1|2' not in record_GT and '2|1' not in record_GT and '2|2' not in record_GT:
				if record[0] in callableSet:
					actual_variants_callable_count += 1
					variants_callable.append(record)
	return variants_callable

#TODO: print out statistics