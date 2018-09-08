#!/bin/bash


ARRAY=(2677662)

RANGE=$((${#ARRAY[@]}-1))

LINK=https://www.ncbi.nlm.nih.gov/sra\?LinkName=biosample_sra\&from_uid=

#assure that special characters & and ? are enclosed in quotation marks in the url or have \ backslash before them
#append all codes onto into a text file
#can potentially append the url beside the SSR code

for i in $(seq 0 $RANGE);
do
	CODE=${ARRAY[i]}
	wget -qO- $LINK$CODE | 
grep -o "SRR[0-9]\+" |
 head -1 >> /mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-05-07_Webscrap/ssrcodes.txt

done
