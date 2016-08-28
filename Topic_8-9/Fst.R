#download packages
source("http://bioconductor.org/biocLite.R")
biocLite("gdsfmt")
biocLite("SNPRelate")

#load packages
library(gdsfmt)
library(SNPRelate)

#load snp data in gds format
gds_filename<- c("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D.snps.gds")

#summary
snpgdsSummary(gds_filename)

#open the gds file
genofile <- snpgdsOpen(gds_filename)

#sample IDs
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))

#load info to get population IDs
sampleinfo_filename <- c("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D_popinfo.csv")
sampleinfo<-read.csv(sampleinfo_filename)
pop_code<-sampleinfo$pop

#calculate Fst between the two populations
samp.sel <- sample.id
pop.sel <- pop_code
snpgdsFst(genofile, sample.id=samp.sel, population=as.factor(pop.sel),
    method="W&C84")