#!/bin/bash
#$ -cwd
#$ -V
#$ -N subsetCEU
#$ -l highp,h_data=16G,time=5:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
VCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons/CEU/chr'${chrNum}'_10CEU_rmHomozygous_rmSingletons.vcf'
pass='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/1000G_masks_position/chr'${chrNum}'_pass_coordinates.txt'
out='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_rmSingletons_pass/CEU/chr'${chrNum}'_10CEU_rmHomozygous_rmSingletons_pass.vcf'
python subsetVCF_basedOnPositions.py --VCF ${VCF} --pass_coordinates ${pass} --outfile ${out}
done
