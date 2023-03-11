#!/usr/bin/bash
#!/bin/bash -l
#SBATCH -J map  #jobname
#SBATCH --partition=long 
#SBATCH --cpus-per-task=14
#SBATCH --mem=15GB

cd /home/pthorpe/scratch/jcs_blood_samples/

conda activate minimap


folders="MRC0123_AmM001WB MRC0223_AmM002WB MRC0323_BiM003WB MRC0423_BiM001WB MRC0523_AmM006WB MRC0623_BiM002WB MRC0723_AmM007WB MRC0823_BiM004WB"


folders="MRC0923_BiM005WB MRC1023_AmM008WB MRC0823_BiM004WB"

folders="MRC1123_WuH001WB "

folders=Trial_mk1c_AmM002FS

for fq in ${folders}:
do 
	# -e 'length(seq)>30' in samtools view will filter out read or alignment, not sure which less than value. 
	# I will add this to remove 200bp alignments. lets try 500bp. -q is mapping MAPQ value
	cmd="minimap2 -t 12 -ax map-ont /home/pthorpe/scratch/jcs_blood_samples/genome_to_use/plas_outgrps_genomes_Hard_MASKED.fasta ${fq}.fastq.gz 
		| samtools view -e 'length(seq)>500' -Sh -q 15 - | \
		samtools sort -O bam - | 
		samtools rmdup -s - - | 
		tee ${fq}_sorted_nodup.bam | 
		bamToBed > ${fq}_sorted_nodup.MASKED.bed"
	echo ${cmd}
	eval ${cmd}		
done


