#!/bin/bash
#$ -cwd

HOMEPATH=$1

module load bedtools/2.26.0


ACCESSIONS=()
for file in $HOMEPATH/*.fastq.gz;
do
  	LENGTH=$((${#HOMEPATH}+1))
    echo $LENGTH
    FQ=${file:$LENGTH}
    echo $FQ
    SRR=${FQ%%.fastq.gz}
    echo $SRR
    if [[ ${SRR:${#SRR}-1} != "2" ]]; then
        ACCESSIONS+=($FQ)    
    fi
done
echo ${ACCESSIONS[@]}

ID=$((SGE_TASK_ID-1))
file=${ACCESSIONS[$ID]}
ACCESS=${file%%_1.fastq.gz}
#ACCESS=${file%%.fastq.gz}
echo $ACCESS

if [[ ! -f $HOMEPATH/${ACCESS}_2.fastq.gz ]]; then
    echo ${ACCESS}_2.fastq.gz doesnt exist! 
    bedtools genomecov -split -ibam $HOMEPATH/aln${ACCESS}_1.sorted.bam -g $HOMEPATH/../hg38genome.txt -bg > $HOMEPATH/${ACCESS}_1.bedgraph
else
    echo ${file%%.fastq.gz}_2.fastq.gz exists!
    bedtools genomecov -split -ibam $HOMEPATH/aln${ACCESS}.sorted.bam -g $HOMEPATH/../hg38genome.txt -bg > $HOMEPATH/${ACCESS}.bedgraph
fi
