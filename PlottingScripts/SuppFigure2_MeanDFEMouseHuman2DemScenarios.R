setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

### Calculation of means

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesConstantBoyko.txt")
MeanConstantBoyko <- mean(Data$V2[1:50000]*40000)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesConstantMouse.txt")
MeanConstantMouse <- mean(Data$V2[1:50000]*40000)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesPopExpansionBoyko.txt")
MeanPopExpansionBoyko <- mean(Data$V2[1:50000]*20000)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesPopExpansionMouse.txt")
MeanPopExpansionMouse <- mean(Data$V2[1:50000]*20000)

### Reading DFE parameters and 4Ns values from the truncated gamma distributions used

DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

pdf("../Figures/SuppFigure2_MeanDFEMouseHuman2DemScenarios.pdf")
par(mfrow = c(2,2))
par(mar=c(2.1,5.1,4.1,1.1))
MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <- (Column[i]-1)*70 + Row[i]
    FourNsMeans[i] <- 0
for (j in 3:303){
    FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[DFEParameterNumber,j]
}
}

beanplot(-FourNsMeans,main="Constant Boyko",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,10),cex.axis=1.5, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
points(1,-MeanConstantBoyko,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <- (Column[i]-1)*70 + Row[i]
    FourNsMeans[i] <- 0
    for (j in 3:303){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[DFEParameterNumber,j]
    }
}

beanplot(-FourNsMeans,main="Constant Mouse",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,10),cex.axis=1.5, cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
points(1,-MeanConstantMouse,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <- (Column[i]-1)*70 + Row[i]
    FourNsMeans[i] <- 0
    for (j in 3:303){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[DFEParameterNumber,j]
    }
}

beanplot(-FourNsMeans,main="Pop expansion Boyko",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,10),cex.axis=1.5, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
points(1,-MeanPopExpansionBoyko,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <- (Column[i]-1)*70 + Row[i]
    FourNsMeans[i] <- 0
    for (j in 3:303){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[DFEParameterNumber,j]
    }
}

beanplot(-FourNsMeans,main="Pop expansion Mouse",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,10),cex.axis=1.5, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
points(1,-MeanPopExpansionMouse,col="red",pch=19)

dev.off()
