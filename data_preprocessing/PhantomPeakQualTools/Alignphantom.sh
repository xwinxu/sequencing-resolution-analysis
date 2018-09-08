#!/bin/bash
#$ -cwd

module load sambamba/0.6.6
conda activate segway
#don't module load R/3.5.0 because that will use the version of R in the cluster instead of in the conda environment

BAMS=(alnSRR6386688_1.sorted.bam alnSRR6386689_1.sorted.bam alnSRR770729_1.sorted.bam)
TAGS=(alnSRR3105729.sorted.tagAlign.gz alnSRR6386688_1.sorted.tagAlign.gz alnSRR6386689_1.sorted.tagAlign.gz alnSRR770729_1.sorted.tagAlign.gz)

ID=$((SGE_TASK_ID-1))
BAM=${BAMS[$ID]}
ACCESSid=${BAM%%.bam}
TAG=${TAGS[$ID]}
NUM_THREADS=1

echo $ID
echo $TAG
echo $ACCESSid

Rscript ../phantompeakqualtools/run_spp.R -c=${TAG} -p="$NUM_THREADS" -filtchr=chrM -savp=${ACCESSid}.cc.plot.pdf -out=${ACCESSid}.cc.qc

# write only the first value for estimated fragment length into output file. This is best estimate for predominant fragment length
sed -i -r 's/,[^\t]+//g' ${ACCESSid}.cc.qc

# sambamba view --nthreads "$NUM_THREADS" --filter 'not(unmapped or mate_is_unmapped or failed_quality_control or secondary_alignment or duplicate)' $BAM | awk 'BEGIN{OFS="\t"} {if(and($2, 16) > 0) {print $3, ($4 - 1), ($4 - 1 + length($10)), "N", "1000", "-"} else {print $3, ($4 - 1), ($4 - 1 + length($10)), "N", "1000", "+"}}' | gzip -c > ${ACCESSid}.tagAlign.gz
