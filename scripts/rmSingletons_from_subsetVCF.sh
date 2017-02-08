#!/bin/bash

# YRI
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/YRI/chr'${i}'_10YRI_rmHomozygous.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons/YRI/chr'${i}'_10YRI_rmHomozygous_rmSingletons.vcf'
grep -w -v "AC=1" ${inVCF} | grep -w -v "AC=19" > ${outVCF}
done

# CEU
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/CEU/chr'${i}'_10CEU_rmHomozygous.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons/CEU/chr'${i}'_10CEU_rmHomozygous_rmSingletons.vcf'
grep -w -v "AC=1" ${inVCF} | grep -w -v "AC=19" > ${outVCF}
done

# CHB
for i in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/CHB/chr'${i}'_10CHB_rmHomozygous.vcf'
outVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons/CHB/chr'${i}'_10CHB_rmHomozygous_rmSingletons.vcf'
grep -w -v "AC=1" ${inVCF} | grep -w -v "AC=19" > ${outVCF}
done

