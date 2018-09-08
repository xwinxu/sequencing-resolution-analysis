#!/bin/bash
#$ -cwd

HOMEPATH=$1
TRACKHUB=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-23_Segway_Run_1/trackhub

module load ucsctools/315

CHROM_SIZE=/mnt/work1/users/home2/winniexu/chipdata/BDGP6.chrom.sizes

ACCESSIONS=()
LONG_ACCESSIONS=()
for file in $HOMEPATH/*.bedgraph;
do
  	LONG_ACCESSIONS+=($file)
        LENGTH=$((${#HOMEPATH}+1))
        BED=${file:$LENGTH}
        SRR=${BED%%.bedgraph}
        ACCESSIONS+=($SRR)
done
echo ${LONG_ACCESSIONS[@]}
echo ${ACCESSIONS[@]}

ID=$((SGE_TASK_ID-1))
ACCESS=${ACCESSIONS[$ID]}
echo $ACCESS
bedfile=${LONG_ACCESSIONS[$ID]}

#file=$2

sort -k1,1 -k2,2n $bedfile > $HOMEPATH/${ACCESS}_sorted.filtered.bedGraph
bedGraphToBigWig $HOMEPATH/${ACCESS}_sorted.filtered.bedGraph $CHROM_SIZE ${TRACKHUB}/${ACCESS}.bigWig
#bedGraphToBigWig $HOMEPATH/${ACCESS}_sorted.filtered.bedGraph $CHROM_SIZE ${TRACKHUB}/hg38/${ACCESS}.bigWig

