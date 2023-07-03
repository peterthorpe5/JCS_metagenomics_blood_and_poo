#!/bin/bash -l
#SBATCH -J flya  #jobname
#SBATCH --partition=himem
#SBATCH --cpus-per-task=16
#SBATCH --mem=550GB

set -e

cd /home/pthorpe/scratch/jcs_blood_samples/poo_samples


conda activate flye2



fastq_files="MFMRCFS0322_DNA.fastq.gz  MFMRCFS0622_DNA.fastq.gz  MFMRCFS0922_DNA.fastq.gz  MFMRCFS1222_DNA.fastq.gz  MFMRCFS1522_DNA.fastq.gz
MFMRCFS0422_DNA.fastq.gz  MFMRCFS0722_DNA.fastq.gz  MFMRCFS1022_DNA.fastq.gz  MFMRCFS1322_DNA.fastq.gz  MFMRCFS1622_DNA.fastq.gz
MFMRCFS0522_DNA.fastq.gz  MFMRCFS0822_DNA.fastq.gz  MFMRCFS1122_DNA.fastq.gz  MFMRCFS1422_DNA.fastq.gz  MFMRCFS1722_DNA.fastq.gz"


for fq in ${fastq_files};
do
   echo ${fq}   
   cmd="python remove_dup_fq.py -i ${fq}.host_removed_bait_nem_ton_nig.fq -o ${fq}.dedup.fq"
   echo ${cmd}
   eval ${cmd}

   #pigz MRC0123_AmM001WB.fastq
   cmd="flye --nano-hq  ${fq}.dedup.fq --scaffold --meta -o ${fq}_flye -t  16"
   echo ${cmd}
   eval ${cmd}
done



