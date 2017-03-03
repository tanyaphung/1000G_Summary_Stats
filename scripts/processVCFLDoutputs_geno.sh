#!/bin/bash

#YRI
for i in {1..22}
do
inFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out/YRI/chr'${i}'_LD_geno.geno.ld'
outFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/YRI/chr'${i}'_LD_geno.geno.ld_rm.nan'
grep -v nan ${inFile} > ${outFile}
done

#CEU
for i in {1..22}
do
inFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out/CEU/chr'${i}'_LD_geno.geno.ld'
outFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/CEU/chr'${i}'_LD_geno.geno.ld_rm.nan'
grep -v nan ${inFile} > ${outFile}
done

#CHB
for i in {1..22}
do
inFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out/CHB/chr'${i}'_LD_geno.geno.ld'
outFile='/u/project/klohmuel/tanya_data/1000G_Summary_Stats/results/LD_geno/VCFtools_out_rm.nan/CHB/chr'${i}'_LD_geno.geno.ld_rm.nan'
grep -v nan ${inFile} > ${outFile}
done
