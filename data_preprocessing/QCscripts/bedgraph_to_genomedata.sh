#!/bin/bash
#$ -cwd

set -x

#LD_PRELOAD=~/miniconda/envs/segway/lib/libz.so
source activate segway


HOMEPATH=$1
CELL=$2
echo $CELL

ACCESSIONS=(SRR1509032_1.bedgraph SRR1175701_1.bedgraph)
#ACCESSIONS=(SRR6386681_1.bedgraph)
echo ${ACCESSIONS[@]}

MARK=$3
echo $MARK

AGPS="/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-25_golden_path_file/hs_ref_GRCh38.p*_chr*.agp"

#for drosophila, exclude --assembly and just give in the chrom sizes file (txt file); NO NEED ANYMORE< RELEASE 6
CHROM="/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/chip-exo/BDGP6genome.txt"

LENGTH=$((${#ACCESSIONS[@]}-1))
ITERARRAY=($(seq 0 $LENGTH))

for i in ${ITERARRAY[@]}
do
	file=$HOMEPATH/${ACCESSIONS[$i]}
	SRR=${ACCESSIONS[$i]}
	ACCESS=${SRR%%_1.bedgraph}
	echo $ACCESS
        genomedata-load --assembly --sequence "/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/chip-exo/BDGP6_ref_chr*.agp" --track ${MARK}=$file --maskfile k36.umap_multiread_filtered.bed ${CELL}_${MARK}_${ACCESS}.genomedata
done
