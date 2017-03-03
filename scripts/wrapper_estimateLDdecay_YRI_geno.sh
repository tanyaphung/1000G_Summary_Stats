#!/bin/bash
#$ -cwd
#$ -V
#$ -N ld_YRI_geno
#$ -l highp,h_data=12G,time=24:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for i in {1..22}
do
input='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/YRI/chr'${i}'_LD_geno.geno.ld_rm.nan'
output='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/bins/YRI/chr'${i}'_LD_geno_100bins.txt'
python estimateLDdecay.py --input ${input} --format vcftools --bin 101 --outfile ${output}
done
