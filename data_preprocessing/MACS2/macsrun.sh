#!/bin/bash
#$ -cwd

conda activate segway
module load bedtools/2.27.1
module load ucsctools/315
module load MACS/2.1.1

HOMEPATH=$1
CELL=$2
FRAGMENTLEN=$3
TAG=$4
GSIZE=2100540389
PVAL=0.01

ID=$((SGE_TASK_ID-1))
LEN=${#HOMEPATH}
#tag=${TAG:$LEN}
tag=`basename $TAG`
ACCESSid=${tag%%.sorted.tagAlign.gz}

#Generate narrow peaks and preliminary signal tracks
macs2 callpeak --treatment $TAG --format BED --name /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid} --gsize ${GSIZE} --pvalue ${PVAL} --nomodel --extsize ${FRAGMENTLEN} --keep-dup all --bdg --SPMR --shift 0

#Generate final fold-enrichment signal tracks
macs2 bdgcmp --tfile /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_treat_pileup.bdg --cfile /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_control_lambda.bdg --outdir /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL} --ofile /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_FE.bdg --method FE

grep -P "chr([0-9]{1,2}|X|Y)\t" /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_FE.bdg > /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}grepped${ACCESSid}.bdg

mv /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}/grepped${ACCESSid}.bdg /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_FE.bdg

#Use bedtools and bedClip to remove coordintes outside those specified in chrom sizes file
bedtools slop -i /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}_FE.bdg -g /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/GRCh38.chrom.sizes -b 0 | awk '{if ($3 != -1) print $0}' | $HOME/.local/bin/bedClip stdin /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/GRCh38.chrom.sizes /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}.fc.signal.bedGraph

sort -k 1,1 -k2,2n /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}.fc.signal.bedGraph &> /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}${ACCESSid}.fc.signal.sorted.bedGraph

#optional: use bedGraphtobigwig to convert bedgraph into bigwig. Use this to better visualize on ucsc genome browser, segway can runwith bedgraphs.
#bedGraphToBigWig /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}/${ACCESSid}.fc.signal.sorted.bedGraph GRCh38.chrom.sizes /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/${CELL}/${ACCESSid}.fc.signal.sorted.bigWig
