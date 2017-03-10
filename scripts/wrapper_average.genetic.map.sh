#!/bin/bash

for i in {1..22}
do
python average_genetic_map.py --female_genetic_map /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/decode_genetic_map/chr${i}_female_noncarrier.gmap --male_genetic_map /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/decode_genetic_map/chr${i}_male_noncarrier.gmap --outfile /u/project/klohmuel/tanya_data/1000G_Summary_Stats/data/decode_genetic_map/chr${i}_average_noncarrier.gmap
done