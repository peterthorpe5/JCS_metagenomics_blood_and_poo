#!/usr/bin/bash

why="base calling puts out 10s thousands of fq files. We want them as one fq.gz. Hence this script. "

folders="MRC0123_AmM001WB
MRC0223_AmM002WB
MRC0323_BiM003WB
MRC0423_BiM001WB
MRC0523_AmM006WB
MRC0623_BiM002WB
MRC0723_AmM007WB
MRC0823_BiM004WB"

for f in ${folders}:
do
	rm ./${folder}/*.log
	cat ./${f}/pass/*.gz > ./${f}.fastq.gz
done 

