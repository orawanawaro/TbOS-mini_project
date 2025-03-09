library(data.table)
library(dplyr)
library(ggplot2)
library(stringr)




run <- function(X,Y) {
  #
  df= fread(X) %>% filter(type!="type")
  
  df$num_seqs = gsub(",","",df$num_seqs) %>% as.numeric()
  
  df$file = gsub("dataset/sample/","",df$file)
  df$file = gsub("output/","",df$file)
  
  df$file = gsub("_amplicon_sequencing_of_mycobacterium_tuberculosis_human_being_sputum_1.fastq.gz","",df$file)
  df$file = gsub("/qc.fq","",df$file)
  
  df2=df[1:20,c(1,4)]
  
  df2$type= Y
  
  return(df2)
  
}
before_df=run("QCplot/before_qc.txt","Before QC")
after_df=run("QCplot/after_qc.txt","After QC")


mdf=rbind(before_df,after_df)


ggplot(mdf,aes(file,num_seqs,fill = type)) +
  geom_bar(stat = "identity", position = "dodge") + coord_flip() +
  xlab("") + ylab("Read number") +
  labs(fill="") + theme_bw()


