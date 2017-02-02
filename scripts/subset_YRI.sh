#!/bin/bash
#$ -cwd
#$ -V
#$ -N subsetYRI
#$ -l h_data=2G,time=24:00:00
#$ -M eplau
#$ -m ea
#$ -t 1-22:1

. /u/local/Modules/default/init/modules.sh
module load perl

export PERL5LIB=$PERL5LIB:/u/project/klohmuel/tanya_data/softwares/vcftools_perl/src/perl/

chrNum=${SGE_TASK_ID}
vcf='/u/project/klohmuel/1000genomes/vcfs_zipped/ALL.chr'${chrNum}'.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'
outfile='/u/scratch/p/phung428/AnnabelProject/1000GVCF_subset/YRI/chr'${chrNum}'_10YRI.vcf'
/u/project/klohmuel/tanya_data/softwares/vcftools_perl/src/perl/vcf-subset -c NA18505,NA18517,NA18916,NA18923,NA18877,NA18909,NA18858,NA18865,NA19116,NA19096 ${vcf} > ${outfile}
