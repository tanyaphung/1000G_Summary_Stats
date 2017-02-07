#!/bin/bash

# YRI
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/YRI/chr'${i}'_10YRI.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/YRI/chr'${i}'_10YRI_rmHomozygous.vcf'
grep -w -v "AC=0" ${inVCF} > ${outVCF}
done

# CEU
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/CEU/chr'${i}'_10CEU.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/CEU/chr'${i}'_10CEU_rmHomozygous.vcf'
grep -w -v "AC=0" ${inVCF} > ${outVCF}
done

# CHB
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/CHB/chr'${i}'_10CHB.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/CHB/chr'${i}'_10CHB_rmHomozygous.vcf'
grep -w -v "AC=0" ${inVCF} > ${outVCF}
done

