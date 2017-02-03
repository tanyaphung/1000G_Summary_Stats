#!/bin/bash
#$ -cwd
#$ -V
#$ -N extractGT
#$ -l h_data=4G,time=24:00:00
#$ -M eplau
#$ -m ea
usage()
{
echo 'The goal of this script is to output the genotypes from the VCF file. In other words, from the VCF files, the output should be CHROM POS GT(ind1) GT(ind2) GT(ind3) etc. Note that here I hard-code the individual names here, so to reuse this script, one needs to replace the array with the appropriate names for their individuals. 
TODO: modify the script so that instead of hard-code the individual names, take in an input file.
Here is how to use the script:
./obtain_GTFromVCF.sh'
exit
}
if [ "$#" -eq 1 ]
then
  usage
fi

. /u/local/Modules/default/init/modules.sh
module load vcftools

# For the YRI individuals
for chrNum in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/YRI/chr'${chrNum}'_10YRI.vcf'
outdir='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/1000G_variants_format/YRI'
vcftools --vcf ${inVCF} --indv NA18505 --indv NA18517 --indv NA18916 --indv NA18923 --indv NA18877 --indv NA18909 --indv NA18858 --indv NA18865 --indv NA19116 --indv NA19096 --extract-FORMAT-info GT --out ${outdir}/chr${chrNum}_10YRI
done

# For the CEU individuals
for chrNum in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/CEU/chr'${chrNum}'_10CEU.vcf'
outdir='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/1000G_variants_format/CEU'
vcftools --vcf ${inVCF} --indv NA06984 --indv NA06985 --indv NA06986 --indv NA06989 --indv NA06994 --indv NA07000 --indv NA07037 --indv NA07051 --indv NA07056 --indv NA07347 --extract-FORMAT-info GT --out ${outdir}/chr${chrNum}_10CEU
done

for chrNum in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/CHB/chr'${chrNum}'_10CHB.vcf'
outdir='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/1000G_variants_format/CHB'
vcftools --vcf ${inVCF} --indv NA18525 --indv NA18526 --indv NA18528 --indv NA18530 --indv NA18531 --indv NA18532 --indv NA18533 --indv NA18534 --indv NA18535 --indv NA18536 --extract-FORMAT-info GT --out ${outdir}/chr${chrNum}_10CHB
done