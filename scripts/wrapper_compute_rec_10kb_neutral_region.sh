#!/bin/bash
#$ -cwd
#$ -V
#$ -N compute_rec_10kb
#$ -l h_data=4G,time=24:00:00
#$ -M eplau
#$ -m ea

for i in {1..22}
do
python compute_rec_10kb_neutral_region.py --genetic_map /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/decode_genetic_map/interpolate_10kb_neutral_region/chr${i}_average_noncarrier.gmap_interpolate_10kb_neutral_region.txt --coordinates /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/10kb_neutral_regions/chr${i}_10kb_neutral_region.txt --outfile /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/10kb_neutral_regions/chr${i}_10kb_neutral_region_rec.txt
done