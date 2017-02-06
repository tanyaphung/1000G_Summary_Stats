# 1000G_Summary_Stats
This repository contains scripts related to the empirical analyses of 1000 Genome dataset associated with Beichman et al. (in progress)

## Subset individuals from 1000G
These individuals are extracted from 1000 Genomes:

#####YRI:
NA18505, NA18517, NA18916, NA18923, NA18877, NA18909, NA18858, NA18865, NA19116, NA19096
#####CEU:
NA06984, NA06985, NA06986, NA06989, NA06994, NA07000, NA07037, NA07051, NA07056, NA07347
#####CHB:
NA18525, NA18526, NA18528, NA18530, NA18531, NA18532, NA18533, NA18534, NA18535, NA18536

To subset the 1000G vcf for each of these populations:

> ./subset_YRI.sh

> ./subset_CEU.sh

> ./subset_CHB.sh

*Note that currenly the script is set up to run on UCLA Hoffman HPC*

## Extract neutral regions using the program Neutral Region Explorer [Arbiza et al. 2012](http://nre.cb.bscb.cornell.edu/nre/)
### Filtering criteria:
##### Select Regions to Exclude: 
1. Known genes 
2. Gene bounds 
3. Spliced ESTs
4. Segmental Duplications
5. CNVs
6. Self chain
7. Reduced Repeat Masker

##### Parameters:
1. Miniumum region size: 200bp
2. Recombination rate (cM/Mb): 0.8
3. Genetic map: Decode
4. Human diversity: YRI; Individuals: All; Mask: Strict

**NOTE: when selecting human diversity, one has to choose either CEU, YRI, or CHB. The neutral regions will likely differ depending which population to choose. Therefore, should we have a consensus neutral regions for all three populations?**



