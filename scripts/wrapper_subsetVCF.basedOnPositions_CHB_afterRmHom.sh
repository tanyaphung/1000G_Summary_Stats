#!/bin/bash
#$ -cwd
#$ -V
#$ -N subsetCHB
#$ -l highp,h_data=24G,time=5:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
VCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous/CHB/chr'${chrNum}'_10CHB_rmHomozygous.vcf'
pass='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
out='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_masksPass/CHB/chr'${chrNum}'_10CHB_rmHomozygous_masksPass.vcf'
python subsetVCF_basedOnPositions.py --VCF ${VCF} --pass_coordinates ${pass} --outfile ${out}
done
