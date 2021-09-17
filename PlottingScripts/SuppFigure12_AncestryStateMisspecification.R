library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeAncestryMisspecified0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeAncestryMisspecified50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeAncestryMisspecified100_N10000.txt")

Plot <- paste("../Figures/SuppFigure12_AncStateMisspecification.pdf",sep="")

pdf(Plot,width=14)
par(mfrow=c(1,2),mar=c(5,5,4,2) + 0.1)

### ,mar=c(5,5,4,2) + 0.1

beanplot(abs(Selection4Ns_0$V1-200), abs(Selection4Ns_50$V1-200), abs(Selection4Ns_100$V1-200), names=c("0","50","100"), ylab="Estimated |4Ns| values", xlab="Real 4Ns values", main="Inference of selection with ancestral state\nmisspecification in a constant population size scenario", cex.axis=1.25, cex.lab=2, cex.main=1.45, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=100,lty=3)


######################## Only negative


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionAncestryMisspecified0_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionAncestryMisspecified50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionAncestryMisspecified100_N10000.txt")

beanplot(Selection4Ns_0$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of selection with ancestral state\nmisspecification in a population expansion scenario",cex.axis=1.25,cex.lab=2,cex.main=1.45,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=100,lty=3)

dev.off()


