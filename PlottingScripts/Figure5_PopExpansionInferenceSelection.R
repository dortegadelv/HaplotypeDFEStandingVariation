library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

### Figure 3


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-100_N10000.txt")

Plot <- paste("../Figures/Figure5_PopExpansionSelInference.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,5,2) + 0.1)


beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in a\nPopulation Expansion Model",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)

dev.off()
