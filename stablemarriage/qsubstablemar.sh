#!/bin/bash
#$ -cwd

qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/annotate_results2.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/annotate_results2.1/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5seq100v1/

qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5ex1bpv1bpwRNADNA/

#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-10-Segway_Run_10_wRNADNAseq/K562seq/annotate_results2.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5ex1bpv1bpwDNARNA/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/annotate_results2.1/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5seq100vex1bp/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-08_Segway_Run_9/MCF7ex2.0/annotate_results4.1/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/MCF7ex/annotate_results4.1/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rMCFex1Rand20180808v17723/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-08_Segway_Run_9/K562ex/annotate_results1.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5ex1bprand20180808v17723/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/annotate_results2.2/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5seq1bpvex1bp/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/MCF7ex/annotate_results4.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/MCF7seq/annotate_results3.2/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rMCFseq1vex1/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/MCF7ex/annotate_results4.2/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/MCF7ex/annotate_results4.1/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rMCex100v1/
#
#qsub -q hoffmangroup -t 1 -N stablemarriage ./helperscript.sh /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562ex/annotate_results1.1/segway.bed.gz /mnt/work1/users/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/annotate_results2.1/segway.bed.gz 10 /mnt/work1/users/hoffmangroup/wxu/data/2018-08-16_Stable_Marriage_Run_8_Reverse/rK5seq100vex100/
