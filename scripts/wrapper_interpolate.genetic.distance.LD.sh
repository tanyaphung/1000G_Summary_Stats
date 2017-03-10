#!/bin/bash
#$ -cwd
#$ -V
#$ -N interpolate
#$ -l highp,h_data=8G,time=24:00:00
#$ -M eplau
#$ -m ea

for i in {1..22}
do
python interpolate_genetic_distance_LD.py --genetic_map /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/decode_genetic_map/chr${i}_average_noncarrier.gmap --coordinates /u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/YRI/chr${i}_LD_geno.geno.ld_rm.nan --outfile /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/decode_genetic_map/interpolate_genetic_map_YRI/YRI/chr${i}_average_noncarrier.gmap_interpolate_YRI.txt
done
