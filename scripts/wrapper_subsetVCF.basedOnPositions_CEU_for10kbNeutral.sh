#!/bin/bash
#$ -cwd
#$ -V
#$ -N subsetCEU
#$ -l highp,h_data=24G,time=5:00:00
#$ -M eplau
#$ -m ea

. /u/local/Modules/default/init/modules.sh
module load python

for chrNum in {1..22}
do
VCF='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_masksPass/CEU/chr'${chrNum}'_10CEU_rmHomozygous_masksPass.vcf'
neutralBed='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/10kb_neutral_regions/chr'${chrNum}'_10kb_neutral_region.txt'
out='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset_rmHomozygous_masksPass_in10kbNeutral/CEU/chr'${chrNum}'_10CEU_rmHomozygous_masksPass_in10kbNeutral.vcf'
python subsetVCF_basedOnPositions_inBedFile.py --VCF ${VCF} --coordinates ${neutralBed} --outfile ${out}
done
