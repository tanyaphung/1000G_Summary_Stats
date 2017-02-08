#!/bin/bash
#$ -cwd
#$ -V
#$ -N CHBld
#$ -l h_data=2G,time=12:00:00
#$ -M eplau
#$ -m ea
#$ -t 1-22:1

. /u/local/Modules/default/init/modules.sh
module load vcftools

chrNum=${SGE_TASK_ID}
inVCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons_pass/CHB/chr'${chrNum}'_10CHB_rmHomozygous_rmSingletons_pass.vcf'
out='/u/scratch/p/phung428/AnnabelProject/LD/CHB/chr'${chrNum}'_LD'

vcftools --vcf ${inVCF} --hap-r2 --ld-window-bp 100000 --out ${out}
