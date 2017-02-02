#!/bin/bash
#$ -cwd
#$ -V
#$ -N subsetCEU
#$ -l h_data=2G,time=24:00:00
#$ -M eplau
#$ -m ea
#$ -t 1-22:1

. /u/local/Modules/default/init/modules.sh
module load perl

export PERL5LIB=$PERL5LIB:/u/project/klohmuel/tanya_data/softwares/vcftools_perl/src/perl/

chrNum=${SGE_TASK_ID}
vcf='/u/project/klohmuel/1000genomes/vcfs_zipped/ALL.chr'${chrNum}'.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'
outfile='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/CEU/chr'${chrNum}'_10CEU.vcf'
/u/project/klohmuel/tanya_data/softwares/vcftools_perl/src/perl/vcf-subset -c NA06984,NA06985,NA06986,NA06989,NA06993,NA06994,NA07000,NA07022,NA07031,NA07034 ${vcf} > ${outfile}
