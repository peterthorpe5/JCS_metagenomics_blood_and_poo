#!/usr/bin/bash
#!/bin/bash -l
#SBATCH -J random_map  #jobname
#SBATCH --partition=long 
#SBATCH --cpus-per-task=16
#SBATCH --mem=20GB


cd /mnt/shared/scratch/doresegu/private/JCS_MetaGenome_Project/Outputs/genomes_to_use


conda activate minimap


#fastq_file=../*/Host_Free_Reads/*_DNAVsRef_unmapped.fastq*
#fastq_file="../MFMRCFS0322_WuM010/Host_Free_Reads/MFMRCFS0322_DNAVsRef_unmapped.fastq.gz ../MFMRCFS0422_WuM009/Host_Free_Reads/MFMRCFS0422_DNAVsRef_unmapped.fastq ../MFMRCFS0522_WuM008/Host_Free_Reads/MFMRCFS0522_DNAVsRef_unmapped.fastq ../MFMRCFS0622_WuM004/Host_Free_Reads/MFMRCFS0622_DNAVsRef_unmapped.fastq ../MFMRCFS0722_WuM006/Host_Free_Reads/MFMRCFS0722_DNAVsRef_unmapped.fastq ../MFMRCFS0822_AmM001/Host_Free_Reads/MFMRCFS0822_DNAVsRef_unmapped.fastq ../MFMRCFS0922_AmM002/Host_Free_Reads/MFMRCFS0922_DNAVsRef_unmapped.fastq ../MFMRCFS1022_AmM005/Host_Free_Reads/MFMRCFS1022_DNAVsRef_unmapped.fastq ../MFMRCFS1122_AmM009/Host_Free_Reads/MFMRCFS1122_DNAVsRef_unmapped.fastq ../MFMRCFS1222_AmM010/Host_Free_Reads/MFMRCFS1222_DNAVsRef_unmapped.fastq ../MFMRCFS1322_AmM004/Host_Free_Reads/MFMRCFS1322_DNAVsRef_unmapped.fastq ../MFMRCFS1422_BiM001/Host_Free_Reads/MFMRCFS1422_DNAVsRef_unmapped.fastq ../MFMRCFS1522_BiM002/Host_Free_Reads/MFMRCFS1522_DNAVsRef_unmapped.fastq ../MFMRCFS1622_BiM004/Host_Free_Reads/MFMRCFS1622_DNAVsRef_unmapped.fastq ../MFMRCFS1722_BiM003/Host_Free_Reads/MFMRCFS1722_DNAVsRef_unmapped.fastq"
fastq_file="../MFMRCFS0322_WuM010/Host_Free_Reads/MFMRCFS0322_DNAVsRef_unmapped.fastq.gz ../MFMRCFS0422_WuM009/Host_Free_Reads/MFMRCFS0422_DNAVsRef_unmapped.fastq ../MFMRCFS0422_WuM009/Host_Free_Reads/MFMRCFS0422_DNAVsRef_unmapped.fastq_sorted_nodup.bam ../MFMRCFS0422_WuM009/Host_Free_Reads/MFMRCFS0422_DNAVsRef_unmapped.fastq_sorted_nodup.bed ../MFMRCFS0522_WuM008/Host_Free_Reads/MFMRCFS0522_DNAVsRef_unmapped.fastq ../MFMRCFS0622_WuM004/Host_Free_Reads/MFMRCFS0622_DNAVsRef_unmapped.fastq ../MFMRCFS0722_WuM006/Host_Free_Reads/MFMRCFS0722_DNAVsRef_unmapped.fastq ../MFMRCFS0822_AmM001/Host_Free_Reads/MFMRCFS0822_DNAVsRef_unmapped.fastq ../MFMRCFS0922_AmM002/Host_Free_Reads/MFMRCFS0922_DNAVsRef_unmapped.fastq ../MFMRCFS1022_AmM005/Host_Free_Reads/MFMRCFS1022_DNAVsRef_unmapped.fastq ../MFMRCFS1122_AmM009/Host_Free_Reads/MFMRCFS1122_DNAVsRef_unmapped.fastq ../MFMRCFS1222_AmM010/Host_Free_Reads/MFMRCFS1222_DNAVsRef_unmapped.fastq ../MFMRCFS1322_AmM004/Host_Free_Reads/MFMRCFS1322_DNAVsRef_unmapped.fastq ../MFMRCFS1422_BiM001/Host_Free_Reads/MFMRCFS1422_DNAVsRef_unmapped.fastq ../MFMRCFS1522_BiM002/Host_Free_Reads/MFMRCFS1522_DNAVsRef_unmapped.fastq ../MFMRCFS1622_BiM004/Host_Free_Reads/MFMRCFS1622_DNAVsRef_unmapped.fastq ../MFMRCFS1722_BiM003/Host_Free_Reads/MFMRCFS1722_DNAVsRef_unmapped.fastq"

for fq in ${fastq_file}:
do
   for i in {1..15};
   do
       cmd="minimap2 -t 14 -ax map-ont random_${i}.fasta ${fq} | samtools view -Sh -q 2 - | \
                samtools sort -O bam - |
                samtools rmdup -s - - |
                tee ${fq}_random_${i}_sorted_nodup.bam |
                bamToBed > ${fq}_random_${i}_sorted_nodup.bed"
        echo ${cmd}
        eval ${cmd}
	# remove the mab to save disk
	rm ${fq}_random_${i}_sorted_nodup.bam
	mv ${fq}_random_${i}_sorted_nodup.bed ./
   done
done

	# -e 'length(seq)>30' in samtools view will filter out read or alignment, not sure which less than value. 
	# I will add this to remove 200bp alignments. lets try 500bp. -q is mapping MAPQ val
