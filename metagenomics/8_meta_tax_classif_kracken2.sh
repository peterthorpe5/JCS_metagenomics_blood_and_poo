#!/bin/bash -l
#SBATCH -J kr_ly  #jobname
#SBATCH --partition=himem
#SBATCH --cpus-per-task=24
#SBATCH --mem=490GB

cd /home/pthorpe/scratch/jcs_blood_samples
conda activate kraken2

DBNAME=/mnt/shared/apps/databases/kraken/


assemblies="./MRC0123_AmM001WB.host_removed.fq_flye/assembly.fasta
./MRC0123_AmM001WB.host_removed.fq_flye/assembly.fasta
./MRC0523_AmM006WB.host_removed.fq_flye/assembly.fasta
./MRC1023_AmM008WB.host_removed.fq_flye/assembly.fasta"


for assembly in  ${assemblies};
do 
   kraken2 --db $DBNAME ${assembly} --threads 12  --classified-out  ${assembly}.kracken.classified  --output  ${assembly}.kracken.out --use-names  --report  ${assembly}.kracken.report.txt 
done
