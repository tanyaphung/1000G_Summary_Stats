#!/bin/bash
#$ -cwd
#$ -V
#$ -N convertYRI
#$ -l highp,h_data=8G,time=24:00:00
#$ -M eplau
#$ -m ea
#$ -t 1-22:1

chrNum=${SGE_TASK_ID}

python convert_physical_to_genetic.py --genetic_map /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/decode_genetic_map/interpolate_genetic_map_YRI/YRI/chr${chrNum}_average_noncarrier.gmap_interpolate_YRI.txt --VCFtoolsout /u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/YRI/chr${chrNum}_LD_geno.geno.ld_rm.nan --outfile /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan_geneticMap/YRI/chr${chrNum}_LD_geno.geno.ld_rm.nan_geneticMapex