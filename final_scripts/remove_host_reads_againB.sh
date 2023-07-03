#!/bin/bash -l
#SBATCH -J map  #jobname
#SBATCH --partition=long 
#SBATCH --cpus-per-task=16
#SBATCH --mem=78GB
set -e

cd /home/pthorpe/scratch/jcs_blood_samples/poo_samples


conda activate minimap

#The tax_id of this macca is: 9539
#https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=9539&lvl=3&lin=f&keep=1&srchmode=1&unlock

#cat Macaca_nemestrina.genome.fasta GWHBHDT00000000.genome.fasta > M.nemestrina_tonkeana.fasta

#python download_ncbi.py --email pjt6@st-andrews.ac.uk -t 9539 -o macca -f 

#download all of these. 


#cat *.fna > all_tax_id_9539.fasta


#fastq_files="MRC1023_AmM008WB  MRC1123_WuH001WB MRC1123_WuH001WB"
    #    | samtools view -@ 8 -Sh -f 4 -  | 
	#	samtools sort -@ 8 --write-index -o ${fq}_sorted_no_host.bam  -O bam "

#cat /home/pthorpe/scratch/jcs_blood_samples/genome_to_use/all_tax_id_9539.fasta /home/pthorpe/scratch/jcs_blood_samples/MRC0123_AmM001WB.fastq_all_flye/assembly_contanim_cleaned_final.fasta > denovo_and_ref.fasta



fastq_files="MFMRCFS0322_DNA.fastq.gz     MFMRCFS0622_DNA.fastq.gz     MFMRCFS0922_DNA.fastq.gz     MFMRCFS1222_DNA.fastq.gz     MFMRCFS1522_DNA.fastq.gz
MFMRCFS0322_dscDNA.fastq.gz  MFMRCFS0622_dscDNA.fastq.gz  MFMRCFS0922_dscDNA.fastq.gz  MFMRCFS1222_dscDNA.fastq.gz  MFMRCFS1522_dscDNA.fastq.gz
MFMRCFS0422_DNA.fastq.gz     MFMRCFS0722_DNA.fastq.gz     MFMRCFS1022_DNA.fastq.gz     MFMRCFS1322_DNA.fastq.gz     MFMRCFS1622_DNA.fastq.gz
MFMRCFS0422_dscDNA.fastq.gz  MFMRCFS0722_dscDNA.fastq.gz  MFMRCFS1022_dscDNA.fastq.gz  MFMRCFS1322_dscDNA.fastq.gz  MFMRCFS1622_dscDNA.fastq.gz
MFMRCFS0522_DNA.fastq.gz     MFMRCFS0822_DNA.fastq.gz     MFMRCFS1122_DNA.fastq.gz     MFMRCFS1422_DNA.fastq.gz     MFMRCFS1722_DNA.fastq.gz
MFMRCFS0522_dscDNA.fastq.gz  MFMRCFS0822_dscDNA.fastq.gz  MFMRCFS1122_dscDNA.fastq.gz  MFMRCFS1422_dscDNA.fastq.gz  MFMRCFS1722_dscDNA.fastq.gz"

for fq in ${fastq_files}; do
    # -f 4 gets unmapped reads
    if [[ ! -f "${fq}.sam" ]]; then
        cmd="minimap2 -I8G --split-prefix=tmp -t 16 -ax map-ont /home/pthorpe/scratch/jcs_blood_samples/genome_to_use/M.nemestrina_tonkeana_nigra.fasta ${fq} > ${fq}.sam"
        echo ${cmd}
        eval ${cmd}
    else
        echo "Skipping minimap2 step for ${fq}.sam as it already exists"
    fi

    if [[ ! -f "${fq}.bam" ]]; then
        cmd="samtools view -@ 16 -h -Sh -f 4 -F 256 -o ${fq}.bam ${fq}.sam"
        echo ${cmd}
        eval ${cmd}
    else
        echo "Skipping samtools view step for ${fq}.bam as it already exists"
    fi

    if [[ ! -f "${fq}_sorted_no_host.bam" ]]; then
        cmd="samtools sort -@ 16 --write-index -o ${fq}_sorted_no_host.bam -O bam ${fq}.bam"
        echo ${cmd}
        eval ${cmd}
    else
        echo "Skipping samtools sort step for ${fq}_sorted_no_host.bam as it already exists"
    fi

    if [[ ! -f "${fq}.host_removed_bait_nem_ton_nig.fq" ]]; then
        cmd2="bedtools bamtofastq -i ${fq}_sorted_no_host.bam -fq ${fq}.host_removed_bait_nem_ton_nig.fq"
        echo ${cmd2}
        eval ${cmd2}
    else
        echo "Skipping bedtools bamtofastq step for ${fq}.host_removed_bait_nem_ton_nig.fq as it already exists"
    fi
done