#!/bin/bash
#$ -cwd

HOMEPATH=$1
ROOTPATH=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/
CELL=$2
FULLPATH=${ROOTPATH}${HOMEPATH}

source activate segway

ANNOTATES=()
IDS=()
for trainresult in ${FULLPATH}/train_results*/;
do
    LENGTH=$((${#FULLPATH}+1))
    DIRNAME=${trainresult:$LENGTH}
    ID=${DIRNAME:13}
    IDS+=($ID)
    ANNOTATES+=($DIRNAME)
done

ID=$((SGE_TASK_ID-1))
traindir=train_results${IDS[$ID]}
echo $traindir
annodir=annotate_results${IDS[$ID]}
echo $annodir

if [ "$CELL" == "K562seq" ]; then 
echo segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_H2AZ_SRR6386684_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_H3K4me3_ENCFF000VDX_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_PolII_SRR6386683_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_TBP_SRR1185445_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_TFIIB_SRR502177.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
    segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_H2AZ_SRR6386684_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_H3K4me3_ENCFF000VDX_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_PolII_SRR6386683_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_TBP_SRR1185445_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562seq_TFIIB_SRR502177.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}

elif [ "$CELL" == "MCF7seq" ]; then
echo segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_CTCF_ENCFF000SAO_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_ERalpha_SRR3170060.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_FOXA1_ERR022028_1.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
    segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_CTCF_ENCFF000SAO_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_ERalpha_SRR3170060.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7seq_FOXA1_ERR022028_1.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}

elif [ "$CELL" == "K562ex" ]; then
echo segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_H2AZ_SRR6386688_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_H3K4me3_SRR6386689_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_PolII_SRR3105728.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_TBP_SRR770729_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_TFIIB_SRR3105729.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
    segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_H2AZ_SRR6386688_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_H3K4me3_SRR6386689_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_PolII_SRR3105728.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_TBP_SRR770729_1.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/K562/K562ex_TFIIB_SRR3105729.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
else
echo segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_CTCF_SRR6710671.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_ERalpha_SRR6710667.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_FOXA1_SRR6710669.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
   segway --mem-usage=10,14,16,20,40,55,64 --cluster-opt="-q hoffmangroup" --exclude-coords=/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-04-27_Train_Segway/exclude_coords.bed --bigBed=${ROOTPATH}${HOMEPATH}/${annodir}segway.layered.bb annotate /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_CTCF_SRR6710671.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_ERalpha_SRR6710667.genomedata /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/genomedata/MCF7/MCF7ex_FOXA1_SRR6710669.genomedata ${ROOTPATH}${HOMEPATH}/${traindir} ${ROOTPATH}${HOMEPATH}/${annodir}
fi
