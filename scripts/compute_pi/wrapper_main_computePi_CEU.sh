#!/bin/bash
#$ -cwd
#$ -V
#$ -N CEU_pi
#$ -l highp,h_data=12G,time=12:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
windows='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/hg19/100kb_nonoverlapping_windows/chr'${chrNum}'_100kb_nonoverlapping_windows.txt'
callable='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
variants='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_variants_format/CEU/chr'${chrNum}'_10CEU.GT.FORMAT'
numAllele=20
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CEU/chr'${chrNum}'_10CEU_pi.txt'

python main.py --windows ${windows} --callableSet ${callable} --variants ${variants} --numAllele ${numAllele} --outfile ${out}
done

for chrNum in {1..22}
do
cat '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CEU/chr'${chrNum}'_10CEU_pi.txt' >> '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CEU/autosomes_10CEU_pi.txt'
done
