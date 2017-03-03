#!/bin/bash
. /u/local/Modules/default/init/modules.sh
module load python

chrNum=2
windows='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/hg19/100kb_nonoverlapping_windows/chr'${chrNum}'_100kb_nonoverlapping_windows.txt'
callable='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
variants='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_variants_format/YRI/chr'${chrNum}'_10YRI.GT.FORMAT'
numAllele=20
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/YRI/chr'${chrNum}'_10YRI_pi.txt'

python main.py --windows ${windows} --callableSet ${callable} --variants ${variants} --numAllele ${numAllele} --outfile ${out}

for chrNum in {1..22}
do
cat '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/YRI/chr'${chrNum}'_10YRI_pi.txt' >> '/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/pi/100kb/YRI/autosomes_10YRI_pi.txt'
done
