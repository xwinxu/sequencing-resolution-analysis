#!/bin/bash
#$ -cwd

HOMEPATH=$1
module load ucsctools/315

ACCESSIONS=()
LONG_ACCESSIONS=()
for file in $HOMEPATH/*.bigWig;
do
  	LONG_ACCESSIONS+=($file)
        LENGTH=$((${#HOMEPATH}+1))
        bWig=${file:$LENGTH}
        SRR=${bWig%%.bigWig}
        ACCESSIONS+=($SRR)
done
echo ${LONG_ACCESSIONS[@]}
echo ${ACCESSIONS[@]}

#ID=$((SGE_TASK_ID-1))
#ACCESS=${ACCESSIONS[$ID]}
#bigwig=${LONG_ACCESSIONS[$ID]}

bigwig=$2
ACCESS=${file%%.bigWig}

#bigWigToWig $bigwig $HOMEPATH/${ACCESS}.wig
bigWigToWig $bigwig ${ACCESS}.wig
