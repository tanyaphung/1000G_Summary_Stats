#!/bin/bash
#$ -cwd
#$ -V
#$ -N binGenetic
#$ -l highp,h_data=32G,time=24:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for i in {1..22}
do
input='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan_geneticMap_modify/YRI/chr'${i}'_LD_genetic_all'
outfile='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/LD_geno/bins_genetic/YRI/chr'${i}'_LD_genetic_bins'
python /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/scripts/estimateLDdecay_genetic.py --input ${input} --format vcftools_genetic --bin 100 --max_genetic 0.7 --outfile ${outfile}
done
