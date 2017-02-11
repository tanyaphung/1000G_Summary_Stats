#!/bin/bash
#$ -cwd
#$ -V
#$ -N CHBld_geno
#$ -l h_data=2G,time=24:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load vcftools

for chrNum in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons_pass/CHB/chr'${chrNum}'_10CHB_rmHomozygous_rmSingletons_pass.vcf'
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/LD_geno/VCFtools_out/CHB/chr'${chrNum}'_LD_geno'

vcftools --vcf ${inVCF} --geno-r2 --mac 2 --ld-window-bp 100000 --out ${out}
done
