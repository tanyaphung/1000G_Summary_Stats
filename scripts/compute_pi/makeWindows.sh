#!/bin/bash

### Use bedtools to generate Xkb nonoverlapping windows from the human genome
### Usage: ./makeWindows.sh $length $lengthFileName
### For example: to make 100kn nonoverlapping windows:
### ./makeWindows.sh 100000 100kb

. /u/local/Modules/default/init/modules.sh
module load bedtools

length=$1
lengthFileName=$2
for chrNum in {1..22}
do
bedtools makewindows -g /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/hg19/chr${chrNum}.g -w ${length} > /u/home/p/phung428/tanya_data_storage/1000G_Summary_Stats/data/hg19/${lengthFileName}_nonoverlapping_windows/chr${chrNum}_${lengthFileName}_nonoverlapping_windows.txt
done