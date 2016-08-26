#First we install some packages
source("http://bioconductor.org/biocLite.R")
biocLite("ggtree")
install.packages("phytools")

#Then load some libraries
library(ggtree)
library(phytools)
library(phangorn)

#Then load in our data
filename <- "/Users/mmosmond/Documents/PHD/biol525D/Topic_10/biol525D.snps.fasta.treefile"
tree <- read.tree(filename)

#Lets take a look
ggtree(tree, layout="unrooted") +
  #This labels nodes by their number, so we can work with them.
  geom_text2(aes(subset=!isTip, label=node)) + 
  #This labels tips.
  geom_tiplab() 

#Since we have two populations, we don't have a known root. 
#In this case we should do a midpoint root between the two populations  
tree.midpoint <- midpoint(tree)

ggtree(tree.midpoint) +
  geom_text2(aes(subset=!isTip, label=node)) + 
  geom_tiplab() 
  
#How about we now label our two populations
ggtree(tree.midpoint) +
  geom_text2(aes(subset=!isTip, label=node)) + 
  geom_tiplab() +
  geom_cladelabel(node=15, label="Population 1", align=T, offset=.01) +
  geom_cladelabel(node=12, label="Population 2", align=T, offset=.01)
  
#Uh oh, labels are off the printed screen. Here's a work around
ggtree(tree.midpoint) +
  geom_text2(aes(subset=!isTip, label=node)) + 
  geom_tiplab() +
  geom_cladelabel(node=15, label="Population 1", align=T, offset=.01) +
  geom_cladelabel(node=12, label="Population 2", align=T, offset=.01) + 
  geom_cladelabel(node=12, label="", align=T, offset=.05,color="white")
  
#Using similar grammar, we can also include bootstrap/aLRT support values for nodes. 
#Unfortunately, when we midpoint rooted it, that information is lost, so lets put info on the original tree
ggtree(tree) +
  geom_tiplab() +
  geom_label2(aes(subset=12, label=label)) +
  geom_label2(aes(subset=10, label=label))

#We can also make up our labels
ggtree(tree) +
  geom_tiplab() +
  geom_label2(aes(subset=12, label='Robots')) +
  geom_label2(aes(subset=10, label='Non-robots')) 
  
#Coding challenge 1
#Put bootstrap and aLRT values on all internal nodes of the midpoint rooted tree. For bonus points, highlight the two populations with different colors.

tree.midpoint <- midpoint(tree,node.labels = "label")

cols<-c()
for (x in 0:tree.midpoint$Nnode+1){
	if (grepl("^P1", tree.midpoint$tip.label[x]) ){
		cols[x] <- "red"
	} else {
		cols[x] <- "blue"
	}
}

ggtree(tree.midpoint) +
 geom_label2(aes(label=label, subset=!isTip)) +
 geom_text2(aes(label=label, subset=isTip), col=cols, hjust=-0.1)
 

