#!/bin/bash
#$ -cwd

HOMEPATH=$1
NAME=$2

module load bwa/0.7.15
#module load bwa/0.7.2
module load igenome-human/hg38
module load samtools/1.3.1

ACCESSIONS=()
for file in $HOMEPATH/*.fastq.gz;
do
  	LENGTH=$((${#HOMEPATH}+1))
        FQ=${file:$LENGTH}
        SRR=${FQ%%.fastq.gz}
        if [[ ${SRR:${#SRR}-1} != "2" ]]; then
                ACCESSIONS+=($FQ)
        fi
done
echo ${ACCESSIONS[@]}


ID=$((SGE_TASK_ID-1))
file=${ACCESSIONS[$ID]}

#file=$2
ACCESS=${file%%_1.fastq.gz}
echo $ACCESS
        if [[ ! -f $HOMEPATH/${ACCESS}_2.fastq.gz ]]; then
                echo ${ACCESS}_2.fastq.gz doesnt exist!
                bwa aln $BWAINDEX $HOMEPATH/$file > $HOMEPATH/read${ACCESS}_1.sai
                echo bwa aln $BWAINDEX $HOMEPATH/$file $HOMEPATH/read${ACCESS}_1.sai
                bwa samse $BWAINDEX $HOMEPATH/read${ACCESS}_1.sai $HOMEPATH/$file > $HOMEPATH/aln${ACCESS}_1.sam
                echo passed samsee $BWAINDEX $HOMEPATH/read${ACCESS}_1.sai $HOMEPATH/$file $HOMEPATH/aln${ACCESS}_1.sam
                samtools view -S -b -q 5 $HOMEPATH/aln${ACCESS}_1.sam > $HOMEPATH/aln${ACCESS}_1.bam
                echo view passed
                samtools sort -o $HOMEPATH/aln${ACCESS}_1.sorted.bam $HOMEPATH/aln${ACCESS}_1.bam
                echo sort passed
                samtools index $HOMEPATH/aln${ACCESS}_1.sorted.bam
                echo index passed
                echo running bam to bedgraph conversion
                qsub -q hoffmangroup -t 1 -N $NAME ./bam_to_bedgraph.sh $HOMEPATH
                echo bam_to_bamgraph.sh passed
        else
            	echo ${file%%.fastq.gz}_2.fastq.gz exists!
                bwa aln $BWAINDEX $HOMEPATH/${ACCESS}_1.fastq.gz > $HOMEPATH/read${ACCESS}_1.sai
                bwa aln $BWAINDEX $HOMEPATH/${ACCESS}_2.fastq.gz > $HOMEPATH/read${ACCESS}_2.sai
                echo aln passed
                bwa sampe $BWAINDEX $HOMEPATH/read${ACCESS}_1.sai $HOMEPATH/read${ACCESS}_2.sai $HOMEPATH/${ACCESS}_1.fastq.gz $HOMEPATH/${ACCESS}_2.fastq.gz > $HOMEPATH/aln${ACCESS}.sam
                echo passed bwa sampee $BWAINDEX $HOMEPATH/read${ACCESS}_1.sai $HOMEPATH/read${ACCESS}_2.sai $HOMEPATH/${ACCESS}_1.fastq.gz $HOMEPATH/${ACCESS}_2.fastq.gz $HOMEPATH/aln${ACCESS}.sam
                samtools view -S -b -q 5 $HOMEPATH/aln${ACCESS}.sam > $HOMEPATH/aln${ACCESS}.bam
                echo view passed
                samtools sort $HOMEPATH/aln${ACCESS}.bam > $HOMEPATH/aln${ACCESS}.sorted.bam
                echo sort passed
                samtools index $HOMEPATH/aln${ACCESS}.sorted.bam
                echo index passed
                echo running bam to bedgraph conversion
                qsub -q hoffmangroup -t 1 -N $NAME ./bam_to_bedgraph.sh $HOMEPATH
                echo bam_to_bamgraph.sh passed
        fi
