#!/bin/bash
#$ -cwd
#$ -V
#$ -N YRIld_geno
#$ -l h_data=2G,time=24:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load vcftools

for chrNum in {1..22}
do
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons_pass/YRI/chr'${chrNum}'_10YRI_rmHomozygous_rmSingletons_pass.vcf'
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/LD_geno/VCFtools_out/YRI/chr'${chrNum}'_LD_geno'

vcftools --vcf ${inVCF} --geno-r2 --mac 2 --ld-window-bp 100000 --out ${out}
done
