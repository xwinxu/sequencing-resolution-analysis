#!/bin/bash
#$ -cwd

for i in $(seq 13 28);
do
	qsub -q hoffmangroup -l hostname=n${i}vm1 -b y find /tmp -user winniexu -execdir rm -rfv {} \+
done
