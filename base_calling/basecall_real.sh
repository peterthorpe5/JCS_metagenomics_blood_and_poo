#!/bin/bash
#script for GPU basecalling of Oxford Nanopore raw FAST5 files
#outputs multiple FASTQ files
#using nvidia card on jaws or thanos
#@author Micha Bayer, James Hutton Institute
#Slurm flags
#SBATCH --partition=gpu
#SBATCH --gpus=2
#SBATCH -w n19-64-3072-thanos
#SBATCH --export=ALL
############################IMPORTANT#####################

############################IMPORTANT#####################
cd /home/pthorpe/projects/Janet_Cox_Singh/Sulawesi_Macaque

echo "starting the basecalling script"

""" believe that the guppy_basecaller on mnt/shared/apps/guppy/6.0.6/bin/ is GPU accelerated only so needs some cuda dependencies only available on the GPU nodes? I had the same issue with guppy's vague memory handling...
$guppyBin/guppy_basecaller \
-i $fast5Folder \
-s $outputFolder \
-x cuda:0 \
--flowcell $flowcellVersion \
--kit $sequencingKit \
--records_per_fastq 0 \
--num_callers 8
Is what worked for me in the end. For some reason --device auto wasn't working, but -x cuda:0 does, even though cuda:0 is the default auto setting... This was on jaws"""
#in order to check there isn't a job running on the GPU already, we first need to ssh onto the node and execute the following command:
# nvidia-smi
#This will list any running jobs
###########################################################
#location of the raw ONT data
#contains multiple fast5 files 
fast5Folder=/home/pthorpe/projects/Janet_Cox_Singh/Sulawesi_Macaque/
#other run parameters required
# Flow Cell Type: FLO-FLG001 and Kit: SQK-RBK004
flowcellVersion=FLO-MIN106
sequencingKit=SQK-RBK004
#this is where we write the fastq files
outputFolder=/home/pthorpe/scratch/jcs_blood_samples/
#path to guppy GPU version
guppyBin=/mnt/shared/apps/guppy/6.0.6/bin/
#check for the correct number of args

folders="MRC0123_AmM001WB
MRC0223_AmM002WB
MRC0323_BiM003WB
MRC0423_BiM001WB
MRC0523_AmM006WB
MRC0623_BiM002WB
MRC0723_AmM007WB
MRC0823_BiM004WB
MRC0923_BiM005WB
MRC1023_AmM008WB
MRC1123_WuH001WB"

#go process
echo "starting guppy run"
date
for fol in ${folders}:
do
    cmd="$guppyBin/guppy_basecaller \
    -i $fast5Folder/${fol}/*/*/fast5 \
    -s $outputFolder/${fol} \
    --device auto \
    --flowcell $flowcellVersion \
    --kit $sequencingKit \
    --records_per_fastq 0 \
    --num_callers 8"
    echo ${cmd}
    eval ${cmd}
done
echo "run complete"
exit
