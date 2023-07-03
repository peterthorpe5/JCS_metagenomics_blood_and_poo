#!/usr/bin/bash
#!/bin/bash -l
#SBATCH -J map  #jobname
#SBATCH --partition=long 
#SBATCH --cpus-per-task=16
#SBATCH --mem=25GB


cd /home/pthorpe/scratch/jcs_blood_samples/poo_samples


conda activate minimap


folders="MFMRCFS0322_DNA.fastq.gz     MFMRCFS0622_DNA.fastq.gz     MFMRCFS0922_DNA.fastq.gz     MFMRCFS1222_DNA.fastq.gz     MFMRCFS1522_DNA.fastq.gz
MFMRCFS0322_dscDNA.fastq.gz  MFMRCFS0622_dscDNA.fastq.gz  MFMRCFS0922_dscDNA.fastq.gz  MFMRCFS1222_dscDNA.fastq.gz  MFMRCFS1522_dscDNA.fastq.gz
MFMRCFS0422_DNA.fastq.gz     MFMRCFS0722_DNA.fastq.gz     MFMRCFS1022_DNA.fastq.gz     MFMRCFS1322_DNA.fastq.gz     MFMRCFS1622_DNA.fastq.gz
MFMRCFS0422_dscDNA.fastq.gz  MFMRCFS0722_dscDNA.fastq.gz  MFMRCFS1022_dscDNA.fastq.gz  MFMRCFS1322_dscDNA.fastq.gz  MFMRCFS1622_dscDNA.fastq.gz
MFMRCFS0522_DNA.fastq.gz     MFMRCFS0822_DNA.fastq.gz     MFMRCFS1122_DNA.fastq.gz     MFMRCFS1422_DNA.fastq.gz     MFMRCFS1722_DNA.fastq.gz
MFMRCFS0522_dscDNA.fastq.gz  MFMRCFS0822_dscDNA.fastq.gz  MFMRCFS1122_dscDNA.fastq.gz  MFMRCFS1422_dscDNA.fastq.gz  MFMRCFS1722_dscDNA.fastq.gz"

for fq in ${folders}:
do 
	# -e 'length(seq)>30' in samtools view will filter out read or alignment, not sure which less than value. 
	# I will add this to remove 200bp alignments. lets try 500bp. -q is mapping MAPQ value
	cmd="minimap2 -t 16 -ax map-ont 
		/home/pthorpe/scratch/jcs_blood_samples/genome_to_use/plas_outgrps_genomes_Hard_MASKED.fasta 
		${fq}.host_removed_bait_nem_ton_nig.fq 
		| samtools view -@ 16 -e 'length(seq)>500' -Sh -q 15 - | \
		samtools sort -@ 16 -O bam - | 
		samtools rmdup -s - - | 
		tee ${f}_sorted_nodup.bam | 
		bamToBed > ${f}_sorted_nodup_poo_samples.MASKED.bed"
	echo ${cmd}
	eval ${cmd}		
done


grep -H "Plas_" *poo_samples.MASKED.bed | awk 'NR == 1 { $7 = "length." } NR >= 3 { $7 = $3 - $2 } 1' | awk '$7 >= 700' | awk '$5 >=30' > mapping_hits_poo_samples_Q30_minlen_700.txt

# to replace the white space for tabs.

#sed 's/[:blank:]+/,/g' mapping_hits_Q30_minlen_700.txt > mapping_hits_Q30_minlen_700_tabs.txt
tr ' ' \\t < mapping_hits_poo_samples_Q30_minlen_700.txt > mapping_hits_poo_samples_Q30_minlen_700_tabs.txt

