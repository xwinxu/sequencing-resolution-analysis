#!/bin/bash
#$ -t 1
#$ -cwd

source activate segway

ACCESSIONS=(MCF7_CTCF_SRR6710671.genomedata MCF7_ERalpha_SRR6710667.genomedata MCF7_Reb1_SRR5179209.genomedata MCF7_TFIIB_SRR770751_1.genomedata)

AGPS=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/chip-exo/genomedata/MCF7

TRAIN=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-23_Segway_Run_1

segway --exclude-coords="/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed" --bigBed=$TRAIN/annotate_results3/segway.layered.bb annotate $AGPS/${ACCESSIONS[0]} $AGPS/${ACCESSIONS[1]} $AGPS/${ACCESSIONS[2]} $AGPS/${ACCESSIONS[3]} $TRAIN/train_results3 $TRAIN/annotate_results3
