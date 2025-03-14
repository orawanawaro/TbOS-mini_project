
echo #1.Generate FASTA and FASTQ to SAM
#minimap2 -ax map-ont ref/sequence.fasta SRR16094814.fastq.gz > aln.sam

echo #2.Sort SAM file (convert SAM to BAM)
#./program/samtools-1.9/samtools sort aln.sam -o aln.bam


echo #3.Create BAM index
#./program/samtools-1.9/samtools index aln.bam

echo #3.1 Filter mapped read
#./program/samtools-1.9/samtools view -b  -F 4 aln.bam > mapped.bam
#./program/samtools-1.9/samtools index mapped.bam


#4. igv input- ncbi fasta, bam output

echo #5. convert bam to vcf
#./program/bcftools-1.21/bcftools mpileup -Ov -f ref/sequence.fasta mapped.bam | ./program/bcftools-1.21/bcftools call -mv -o sample.vcf

#6. funtion annotation

mkdir output
for i in $( ls dataset/sample/*.gz);

do
    echo $i
    fl=$(echo $i | cut -d"/" -f3 | cut -d"_" -f1)
    echo $fl
    mkdir -p output/$fl
   
    #step 0 count read
    seqkit stat $i > output/$fl/stat.txt


    #1.Generate FASTA and FASTQ to SAM
    minimap2 -ax map-ont ref/sequence.fasta $i > output/$fl/aln.sam


    #2.Sort SAM file (convert SAM to BAM)
    ./program/samtools-1.9/samtools sort output/$fl/aln.sam -o output/$fl/aln.bam


    #3.Create BAM index
    ./program/samtools-1.9/samtools index output/$fl/aln.bam


    #3.1 Filter mapped read
    ./program/samtools-1.9/samtools view -b  -F 4 output/$fl/aln.bam > output/$fl/mapped.bam

    ./program/samtools-1.9/samtools index output/$fl/mapped.bam


    #4.convert bam to vcf
    ./program/bcftools-1.21/bcftools mpileup -Ov -f ref/sequence.fasta output/$fl/mapped.bam | ./program/bcftools-1.21/bcftools call -mv -o output/$fl/sample.vcf


    #5 annotate drug resistance snp
    Rscript Test.R  output/$fl/sample.vcf ref/annotation_file.txt output/$fl/sample_report.csv

done 





