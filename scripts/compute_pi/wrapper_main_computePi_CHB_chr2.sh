#!/bin/bash
#$ -cwd
#$ -V
#$ -N CHB_pi_chr2
#$ -l highp,h_data=20G,time=5:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

chrNum=2
windows='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/hg19/100kb_nonoverlapping_windows/chr'${chrNum}'_100kb_nonoverlapping_windows.txt'
callable='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
variants='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_variants_format/CHB/chr'${chrNum}'_10CHB.GT.FORMAT'
numAllele=20
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CHB/chr'${chrNum}'_10CHB_pi.txt'

python main.py --windows ${windows} --callableSet ${callable} --variants ${variants} --numAllele ${numAllele} --outfile ${out}

for chrNum in {1..22}
do
cat '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CHB/chr'${chrNum}'_10CHB_pi.txt' >> '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/CHB/autosomes_10CHB_pi.txt'
done
