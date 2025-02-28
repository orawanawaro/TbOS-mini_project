
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
