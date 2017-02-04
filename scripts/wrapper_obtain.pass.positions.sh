#!/bin/bash
#$ -cwd
#$ -V
#$ -N pass_coordinates
#$ -l highp,h_data=16G,time=10:00:00
#$ -M eplau
#$ -m ea

for chrNum in {1..22}
do

fasta='/u/scratch/p/phung428/AnnabelProject/data/1000G_strict_masks/chr'${chrNum}'.strictMask.fasta'
masksSummary='/u/scratch/p/phung428/AnnabelProject/data/1000G_strict_masks/masks_totalN_totalP.txt'
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
python obtain_pass_positions.py --fasta ${fasta} --masks_summary ${masksSummary} --chrName chr${chrNum} --outfile ${out}
done
