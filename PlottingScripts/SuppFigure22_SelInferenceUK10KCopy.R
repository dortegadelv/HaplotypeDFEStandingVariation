library(here)
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

Plot <- paste("../Figures/SuppFigure22_UK10KSelInference.pdf",sep="")

pdf(Plot,width=14)
par(mfrow=c(1,2),mar=c(5,5,4,2) + 0.1)

### ,mar=c(5,5,4,2) + 0.1

beanplot(Selection4Ns_0$V1, Selection4Ns_Minus50$V1, Selection4Ns_Minus100$V1, names=c("0","-25","-50"), ylab="Estimated 4Ns values", xlab="Real 4Ns values", main="Inference of Selection", cex.axis=1.25, cex.lab=2, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)


######################## Only negative


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KOnlyNeg4Ns_0.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KOnlyNeg4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KOnlyNeg4Ns_-50.txt")

beanplot(Selection4Ns_0$V1,Selection4Ns_Minus50$V1,Selection4Ns_Minus100$V1,names=c("0","-25","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection", cex.axis=1.25, cex.lab=2, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
# abline(h=25,lty=3)
# abline(h=50,lty=3)

dev.off()


