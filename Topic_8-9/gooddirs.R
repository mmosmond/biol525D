sampleinfo <- read.csv("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D_popinfo.csv",header=T)
#data name and directory
name <- "/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D"

vcf_filename<- c("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D.snps.vcf")
gds_filename<- c("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D.snps.gds")
sampleinfo_filename <- c("/Users/mmosmond/Documents/PHD/biol525D/Topic_8-9/biol525D_popinfo.csv")

library(reshape)
library(dplyr)
library(ggplot2)

data.full <- data.frame(name=character(),
                        pop=character(),
                        lat=numeric(),
                        long=numeric(),
                        variable=character(),
                        value=numeric(),
                        k=numeric())
#Now we loop through each K output
for (k in 1:10){
  #Load the data file
  data <- read.table(paste(name, k, "meanQ",sep="."),colClasses="numeric")
  #Label the columns (one for each group)
  Qnames <-paste("Q",seq(1:k),sep = "")
  colnames(data) <- Qnames
  #Add sample info to Q values
  data.info <- cbind(data, sampleinfo)
  #Melt the data into long format
  data.melt <- melt(data.info, id.var=c("name","pop","lat","long","color"))
  #We have to make sure to include the K value for each file
  data.melt$k <- k
  #Now rbind it to the data frame outside the loop
  data.full <- rbind(data.full, data.melt)
}
#Lets try plotting for k=2
data.full %>% filter(k == 2) %>% #This selects only the k=2 lines out of the full set
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack")
  
  data.full %>%
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack") +
  facet_wrap(~k, nrow=5)
  
  data.full %>%
  mutate(name = factor(name, levels = name[order(color)])) %>%
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack") +
  facet_wrap(~k, nrow=5)
  
  data.full %>%
  mutate(name = factor(name, levels = name[order(color)])) %>%
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack") +
  facet_wrap(~k, nrow=5) +
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(), 
        axis.line = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=16),
        strip.background = element_blank()) +
  ylab("q-value")+
  guides(fill = guide_legend(title = "Group", title.position = "left"))
  
## Plotting challenge 1 * For K = 2, plot the faststructure results and divide your samples by populations. Furthermore, make group 1 red and group 2 blue. Title the plot "Helianthus annuus is great!"
  
data.full %>% filter(k == 2) %>%
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack") +
  labs(title = expression(paste(italic("Helianthus annuus")," is great!")))+
  ylab("q-value")+
  xlab("sample")+
  guides(fill = guide_legend(title = "Group", title.position = "top"))+
  facet_wrap(~pop,nrow=1,scales="free")+
  scale_fill_manual(values=c("red","blue"))
  
#Plotting challenge 2 * Download the "biol525D_FSexample" datasets from the github/Topic 8-9 page. Plot each of these as structure results and order the individuals by their admixture scores.
                 
#Load the data file
data.full <- data.frame(name=character(),
                        variable=character(),
                        value=numeric(),
                        k=numeric())

for (k in 2:3){
  data <- read.csv(paste(name, "_FSexample.k", k, ".csv",sep=""),colClasses="numeric")
  #Label the columns (one for each group)
  Qnames <-paste("Q",seq(1:k),sep = "")
  colnames(data) <- Qnames
  #sort b yq
  data<-data[order(data$Q1,data$Q2),]
  #Add sample info to Q values
  data.info <- cbind(data, name=c(1,2,3,4,5,6,7))
  #Melt the data into long format
  data.melt <- melt(data.info, id.var=c("name"))
  #We have to make sure to include the K value for each file
  data.melt$k <- k
  #Now rbind it to the data frame outside the loop
  data.full <- rbind(data.full, data.melt)
}

#Lets try plotting for k=2
data.full %>% filter(k == 2) %>% #This selects only the k=2 lines out of the full set
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack")

#Lets try plotting for k=2 and k=3
data.full %>%
  ggplot(.,aes(x=name,y=value,fill=factor(variable))) +
  geom_bar(stat = "identity",position="stack") +
  facet_wrap(~k, nrow=5)