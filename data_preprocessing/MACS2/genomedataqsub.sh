#!/bin/bash
#$ -cwd

#K562_exo
qsub -q hoffmangroup -t 1-5 -N K562_exgenomedataarc ./bedgraph_to_genomedata.sh /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/K562_ex/ K562_ex /mnt/work1/users/hoffmangroup/wxu/data/2018-07-26_MACS2_BAM_Preprocessing/macsrun/K562_ex.txt

#K562_seq
qsub -q hoffmangroup -t 1-5 -N K562_seqgenomedataarc ./bedgraph_to_genomedata.sh /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/K562_seq/ K562_seq /mnt/work1/users/hoffmangroup/wxu/data/2018-07-26_MACS2_BAM_Preprocessing/macsrun/K562_seq.txt

#MCF7_exo
qsub -q hoffmangroup -t 1-3 -N MCF7_exgenomedataarc ./bedgraph_to_genomedata.sh /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/MCF7_ex/ MCF7_ex /mnt/work1/users/hoffmangroup/wxu/data/2018-07-26_MACS2_BAM_Preprocessing/macsrun/MCF7_ex.txt

#MCF7_seq
qsub -q hoffmangroup -t 1-3 -N MCF7_seqgenomedataarc ./bedgraph_to_genomedata.sh /mnt/work1/users/home2/winniexu/hwd/2018-07-26_MACS2_BAM_Preprocessing/macsrun/MCF7_seq/ MCF7_seq /mnt/work1/users/hoffmangroup/wxu/data/2018-07-26_MACS2_BAM_Preprocessing/macsrun/MCF7_seq.txt
