setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_-50.txt")


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_-50.txt")
Selection4Ns_1 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_1.txt")

###Confidence interval
quantile(Selection4Ns_1$V1,prob=seq(from = 0.0,to = 1, by =0.05))


Plot <- paste("../Figures/SuppFigure7_UK10KSelInference.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)   


beanplot(Selection4Ns_0$V1,Selection4Ns_50$V1,Selection4Ns_Minus50$V1,Selection4Ns_100$V1,Selection4Ns_Minus100$V1,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in the\nUK10K Expansion Model",cex.axis=1.25,cex.lab=2,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)

dev.off()
