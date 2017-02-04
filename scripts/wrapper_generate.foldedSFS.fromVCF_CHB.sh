#!/bin/bash
. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
variant='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_variants_format/CHB/chr'${chrNum}'_10CHB.GT.FORMAT'
numAllele=20
passCoord='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
outfile='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/foldedSFS/CHB/chr'${chrNum}'_foldedSFS.txt'
python /u/project/klohmuel/tanya_data/1000G_Summary_Stats/scripts/generate_foldedSFS_fromVCF.py --variant ${variant} --numAllele ${numAllele} --pass_coordinates ${passCoord} --outfile ${outfile}
done
