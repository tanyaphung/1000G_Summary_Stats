#!/bin/bash
#$ -cwd
#$ -V
#$ -N ld_CHB
#$ -l highp,h_data=16G,time=24:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for i in {1..22}
do
input='/u/scratch/p/phung428/AnnabelProject/LD_processed/CHB/chr'${i}'_LD.hap.ld_processed'
output='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/LD/CHB/chr'${i}'_LD_100bins.txt'
python estimateLDdecay.py --input ${input} --format vcftools --bin 101 --outfile ${output}
done
