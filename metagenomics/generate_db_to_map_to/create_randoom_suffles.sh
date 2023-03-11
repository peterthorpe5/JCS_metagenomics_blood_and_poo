#!/bin/bash

for i in {1..31}; 
do
   cmd="python shuffle_fasta.py -i plas_outgrps_genomes.fasta   -o random_${i}.fasta"
   echo ${cmd}
   eval ${cmd}
done
