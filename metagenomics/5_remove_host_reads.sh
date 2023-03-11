#!/bin/bash -l
#SBATCH -J map  #jobname
#SBATCH --partition=long 
#SBATCH --cpus-per-task=16
#SBATCH --mem=40GB

cd /home/pthorpe/scratch/jcs_blood_samples/

conda activate minimap

#The tax_id of this macca is: 9539
#https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=9539&lvl=3&lin=f&keep=1&srchmode=1&unlock

# Example of how to creat and download sone genoems for the DB. 
#python download_ncbi.py --email pjt6@st-andrews.ac.uk -t 9539 -o macca -f 

# download all of these. 


#cat *.fna > all_tax_id_9539.fasta -  Dont do this - it is too big and takes tooooo lonf


fastq_files="MRC0323_BiM003WB  MRC0523_AmM006WB  MRC0723_AmM007WB  MRC0923_BiM005WB  MRC1123_WuH001WB
MRC0223_AmM002WB  MRC0423_BiM001WB  MRC0623_BiM002WB  MRC0823_BiM004WB  MRC1023_AmM008WB  Trial_mk1c_AmM002FS"

# this will map the reads to the host and keep the non mapped reads, thus removing the host
# convert to bam then to fq. ß

for fq in ${fastq_files}:
do 
    # -f 4 get unmapped reads
	cmd="minimap2 -I8G --split-prefix=tmp -t 16 -ax map-ont /home/pthorpe/scratch/jcs_blood_samples/genome_to_use/all_tax_id_9539.fasta ${fq}.fastq.gz > ${fq}.sam"
	echo ${cmd}
	eval ${cmd}
    cmd="samtools view -@ 16 -Sh -f 4 -o ${fq}.bam ${fq}.sam"
	echo ${cmd}
	eval ${cmd}
    cmd="samtools sort -@ 16 --write-index -o ${fq}_sorted_no_host.bam  -O bam ${fq}.bam"
	echo ${cmd}
	eval ${cmd}
    cmd2="bedtools bamtofastq -i ${fq}_sorted_no_host.bam -fq ${fq}.host_removed.fq.gz"
	echo ${cmd2}
	eval ${cmd2}		
done

