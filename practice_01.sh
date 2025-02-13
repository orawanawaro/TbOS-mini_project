#!/bin/bash

#1.to repeat work
for i in {1..10};
do
    echo $i


    if  [[ "$i"  ==  10 ]]; then
        seqkit sample -n 10000 SRR16094814.fastq.gz > sampling$i.fastq
    elif [[ "$i"  ==  9 ]] ; then
        seqkit sample -n 2000 SRR16094814.fastq.gz > sampling$i.fastq
    else
        seqkit sample -n 5000 SRR16094814.fastq.gz > sampling$i.fastq
    fi


    mv sampling$i.fastq Read



done

#2.to print stat
seqkit stat Read/sampling*.fastq > Read/sum_stat.txt
cat Read/sum_stat.txt


