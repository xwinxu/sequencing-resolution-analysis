#!/bin/bash
#$ -cwd

count=0;
total=0;

file=$1

#bc command is the built in calculator

cut -f 4 $file > temp.txt
while read i;
do
    echo $i
	total=$(awk "BEGIN { print ${total}+${i}; exit }")
	echo $total
    count=$((${count}+1))
done < temp.txt
#echo $((${total} / ${count}))
final=`$total / $count | bc`
echo $final
#total=$(echo $total+$i | bc)
#total=$((${total}+${i}))
