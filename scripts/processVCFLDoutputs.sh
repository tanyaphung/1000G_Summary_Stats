#!/bin/bash

#YRI
# for i in {1..22}
# do
# inFile='/u/scratch/p/phung428/AnnabelProject/LD/YRI/chr'${i}'_LD.hap.ld'
# outFile='/u/scratch/p/phung428/AnnabelProject/LD_processed/YRI/chr'${i}'_LD.hap.ld_processed'
# grep -v nan ${inFile} > ${outFile}
# done

#CEU
for i in {1..22}
do
inFile='/u/scratch/p/phung428/AnnabelProject/LD/CEU/chr'${i}'_LD.hap.ld'
outFile='/u/scratch/p/phung428/AnnabelProject/LD_processed/CEU/chr'${i}'_LD.hap.ld_processed'
grep -v nan ${inFile} > ${outFile}
done

#CHB
for i in {1..22}
do
inFile='/u/scratch/p/phung428/AnnabelProject/LD/CHB/chr'${i}'_LD.hap.ld'
outFile='/u/scratch/p/phung428/AnnabelProject/LD_processed/CHB/chr'${i}'_LD.hap.ld_processed'
grep -v nan ${inFile} > ${outFile}
done