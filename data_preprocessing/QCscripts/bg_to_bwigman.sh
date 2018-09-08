#!/bin/bash
#$ -cwd

#Note: drosophila script is bg_to_bwigd.sh

HOMEPATH=$1
#need to manually organize after dumping into the trackhub
TRACKHUB=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-23_Segway_Run_1/trackhub

module load ucsctools/315

CHROM_SIZE=/mnt/work1/users/home2/winniexu/chipdata/GRCh38.chrom.sizes

SORTED_BED=$2
ACCESS=$3

#sort -k1,1 -k2,2n $bedfile > $HOMEPATH/${ACCESS}_sorted.filtered.bedGraph
bedGraphToBigWig $HOMEPATH/${SORTED_BED} $CHROM_SIZE ${TRACKHUB}/${ACCESS}.bigWig
#bedGraphToBigWig $HOMEPATH/${ACCESS}_sorted.filtered.bedGraph $CHROM_SIZE ${TRACKHUB}/hg38/${ACCESS}.bigWig

