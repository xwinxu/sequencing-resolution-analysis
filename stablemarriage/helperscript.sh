#!/bin/bash
#$ -cwd

annotation1=$1
annotation2=$2
num_labels=$3
out_dir=$4

conda activate segway

python overlap.py ${annotation1} ${annotation2} ${num_labels} ${out_dir}
