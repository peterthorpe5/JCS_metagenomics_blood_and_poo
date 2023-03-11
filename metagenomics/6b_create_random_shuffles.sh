#!/bin/bash

why="ramdomly shuffle the db 31 times so we can map to it and gain an estimation of the false
positive mapping rate. Result: 1 read mapped out of all datasets being mapped/ shuffled 31 times 
at MAPQ2. Very low quality mapping. Thus FP rate is very low."

for i in {1..31}; 
do
   cmd="python shuffle_fasta.py -i plas_outgrps_genomes.fasta   -o random_${i}.fasta"
   echo ${cmd}
   eval ${cmd}
done
