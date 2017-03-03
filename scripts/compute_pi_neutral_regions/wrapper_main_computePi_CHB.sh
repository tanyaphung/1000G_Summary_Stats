#!/bin/bash
#$ -cwd
#$ -V
#$ -N CHB_pi_neutral
#$ -l highp,h_data=20G,time=12:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
windows='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/10kb_neutral_regions/chr'${chrNum}'_10kb_neutral_region.txt'
callable='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
variants='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_variants_format/CHB/chr'${chrNum}'_10CHB.GT.FORMAT'
numAllele=20
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi_neutral/10kb/CHB/chr'${chrNum}'_10CHB_pi_neutral.txt'

python main.py --windows ${windows} --callableSet ${callable} --variants ${variants} --numAllele ${numAllele} --outfile ${out}
done

for chrNum in {1..22}
do
cat '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi_neutral/10kb/CHB/chr'${chrNum}'_10CHB_pi_neutral.txt' >> '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi_neutral/10kb/CHB/autosomes_10CHB_pi_neutral.txt'
done
