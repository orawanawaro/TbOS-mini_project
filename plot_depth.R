library(data.table)
library(dplyr)
library(ggplot2)
library(stringr)


fl=list.files("depth/")

paste0("depth/",fl)->fl1

dat=data.frame()
for (v in fl1) {
  print(v)
  
  r=read.delim(v,header = F)
  
  v1=gsub("depth/depth_","",v)
  
  v2=gsub(".txt","",v1)
  
  r$sample=v2
  dat=rbind(dat,r)
}


dat %>% filter(V2 >= 2713907) %>% filter(V2 <= 2715907) %>%
  ggplot(aes(V2,V3,color=sample))+
  geom_line() + ylab("Depth") + xlab("Genomic position") + theme_bw()
ggsave("depth_plot.png")







s=read.delim("sequence.gff3")
