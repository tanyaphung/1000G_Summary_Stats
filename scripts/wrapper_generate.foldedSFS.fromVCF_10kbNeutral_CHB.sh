#!/bin/bash

for chrNum in {1..22}
do
variants='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_masksPass_in10kbNeutral/CHB/chr'${chrNum}'_10CHB_rmHomozygous_masksPass_in10kbNeutral.vcf'
numAllele=20
out='/u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/results/foldedSFS_neutral/CHB/chr'${chrNum}'_10kb.neutral.region_CHB.txt'
python /u/project/klohmuel/tanya_data/Constrained_Regions_PopGen/scripts/generate_foldedSFS.py --variants ${variants} --numAllele ${numAllele}  --outfile ${out}
done
