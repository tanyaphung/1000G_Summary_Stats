# 1000G_Summary_Stats
This repository contains scripts related to the empirical analyses of 1000 Genome dataset associated with Beichman et al. (in progress)

## Subset individuals from 1000G
These individuals are extracted from 1000 Genomes:

#####YRI:
NA18505, NA18517, NA18916, NA18923, NA18877, NA18909, NA18858, NA18865, NA19116, NA19096
#####CEU:
NA06984, NA06985, NA06986, NA06989, NA06994, NA07000, NA07037, NA07051, NA07056, NA07347
#####CHB:
NA18525, NA18526, NA18528, NA18530, NA18531, NA18532, NA18533, NA18534, NA18535, NA18536

To subset the 1000G vcf for each of these populations:

> ./subset_YRI.sh

> ./subset_CEU.sh

> ./subset_CHB.sh

*Note that currenly the script is set up to run on UCLA Hoffman HPC*

## Extract neutral regions using the program Neutral Region Explorer [Arbiza et al. 2012](http://nre.cb.bscb.cornell.edu/nre/)
### Filtering criteria:
##### Select Regions to Exclude: 
1. Known genes 
2. Gene bounds 
3. Spliced ESTs
4. Segmental Duplications
5. CNVs
6. Self chain
7. Reduced Repeat Masker

##### Parameters:
1. Miniumum region size: 200bp
2. Recombination rate (cM/Mb): 0.8
3. Genetic map: Decode
4. Human diversity: YRI; Individuals: All; Mask: Strict

**NOTE: when selecting human diversity, one has to choose either CEU, YRI, or CHB. The neutral regions will likely differ depending which population to choose. Therefore, should we have a consensus neutral regions for all three populations?**

## Obtain nonoverlapping windows
1. 
>wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes


2. 
>for chrNum in {1..22}; do
grep -w "chr${chrNum}" hg19.chrom.sizes > chr${chrNum}.g
done;

3. 
>./makeWindows.sh 100000 100kb

## Compute genetic diversity (pairwise pi) in 100kb nonoverlapping windows

1. All functions required to compute genetic diversity can be found in scripts/compute_pi
2. Explanation of each function:

### callableEachWin.py
This script tabulates the number of callable sites for each nonoverlapping window.
Input 1: a list where each item in the list is a tuple of the form (start, end).
Input 2: a set where each item is the callable position (1-based).
Return: a dictionary where key is window in the form (start, end) and value is the count of callable sites.

### processVCFsubset.py
This script cleans the VCF after subsetting. Specifically, it will (1) remove any site where the genotype for all subsetted individuals is 0|0. The reason for this is that vcf-subset does not do this automatically, (2) only keep the biallelic allele, in other words, remove 1|2, 2|1, and 2|2, and (3) remove any site that is not callable, meaning where it is not annotated with a P in the mask file.
Input 1: a list. Each item in this list is a list where the first item is the genomic position (1-based).
Input 2: a set where each item is the callable position (1-based).
Return: a list. Each item in this list is a list where the first item is the genomic position (1-based). Basically the same as Input 1 but fewer variants.

### computeAF.py
This script computes the allele frequency for each variant.

### computePi.py
This script computes pairwise pi. 
3. How to run?
### For a list of inputs, do:

>python main.py -h 

### To run, do:

>python main.py --windows /path/to/window/file --callableSet /path/to/callableSet --variants /path/to/variants --numAllele int --outfile /path/to/outfile

## Estimate LD decay
### Remove variants from the VCF files where the genotypes of all the individuals in the subset are 0|0
* vcftools subset is used to subset 10 YRI individuals, 10 CEU individuals, and 10 CHB individuals from 1000 Genome VCF file. However, the problem was that this does not remove variants where the genotypes for all of the subset individuals are 0|0. 
* When dealing with this previously when estimating the SFS, I wrote it directly into the Python script generate_foldedSFS_fromVCF.py. 
* However, here, it is better to deal with this using grep. Basically, if the genotypes for all of the individuals are 0|0, the AC will be equal to 0. I can use grep to remove it. 
* The script is rmHomozygous_from_subsetVCF.sh

### Use vcftools to calculate rsquared

>vcftools --vcf <input vcf> --hap-r2 --ld-window-bp 100000

>./vcftools_ld_YRI.sh

>./vcftools_ld_CEU.sh

>./vcftools_ld_CHB.sh
