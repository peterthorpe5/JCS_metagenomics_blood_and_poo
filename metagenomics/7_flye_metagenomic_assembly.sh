#!/bin/bash -l
#SBATCH -J fly  #jobname
#SBATCH --partition=himem
#SBATCH --cpus-per-task=24
#SBATCH --mem=490GB

set -e

cd /home/pthorpe/scratch/jcs_blood_samples/

conda activate flye2

fq_file="MRC0523_AmM006WB.host_removed.fq  MRC0923_BiM005WB.host_removed.fq
MRC1123_WuH001WB.host_removed.fq MRC1023_AmM008WB.host_removed.fq MRC0323_BiM003WB.host_removed.fq  MRC0723_AmM007WB.host_removed.fq"


for fq in ${fq_file};
do
   echo ${fq}  
   # the basecaller produces stupid - duplicated names. Change them. 
   python remove_dup_fq.py -i ${fq} -o ${fq}.dedup.fq
   # assemble the data
   flye --resume --meta  --nano-hq  ${fq}.dedup.fq   -o ${fq}_flye -t  24 
done


