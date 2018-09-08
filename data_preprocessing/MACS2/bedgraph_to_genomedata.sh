#!/bin/bash
#$ -cwd

#set -x

#LD_PRELOAD=~/miniconda/envs/segway/lib/libz.so
#source activate segway
conda activate segway

#homepath includes the cell folder, includes slash at end
HOMEPATH=$1
CELL=$2
MARKFILE=$3
echo $CELL
#mark is a text file with the apt marks
#echo $MARK

MARKS=()
while IFS='' read -r line || [[ -n "$line" ]];
do
    MARKS+=($line)
done < "$MARKFILE"
echo ${MARKS[@]}

ACCESSIONS=()
for file in $HOMEPATH/*.bedGraph;
do
    BD=`basename $file`
    ACCESSid=${BD%%.fc.signal.sorted.bedGraph}
    ACCESSIONS+=($ACCESSid)
done
echo ${ACCESSIONS[@]}

#AGPS="/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-25_golden_path_file/hs_ref_GRCh38.p*_chr*.agp"

#for drosophila, exclude --assembly and just give in the chrom sizes file (txt file); NO NEED ANYMORE< RELEASE 6
CHROM="/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-07-10_Segway_Run_8_wRseq"

ID=$((SGE_TASK_ID-1))
MARK=${MARKS[$ID]}
ACCESSid=${ACCESSIONS[$ID]}
#fil=${ACCESSION[$ID]}
#ACCESSid=${fil%%_1.fastq.gz}

file=$HOMEPATH/${ACCESSIONS[$ID]}.fc.signal.sorted.bedGraph
genomedata-load --assembly --sequence "/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-25_golden_path_file/hs_ref_GRCh38.p*_chr*.agp" --track ${MARK}=$file --maskfile /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/k36.umap_multiread_filtered.bed $HOMEPATH${CELL}_${MARK}_${ACCESSid}.genomedata
