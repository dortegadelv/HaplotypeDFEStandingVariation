library(here)
library(viridis)
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

DFEPars <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
FourNsMeans <- c()

for (i in 1:nrow(DFEPars)){
FourNsMeans[i] <- 0

for (j in 3:203){
FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[i,j]
}
}

DFEPars <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")
# FourNsMeans <- c()

for (i in 1:nrow(DFEPars)){
FourNsMeans[i+nrow(DFEPars)] <- 0

for (j in 3:203){
FourNsMeans[i+nrow(DFEPars)] <- FourNsMeans[i+nrow(DFEPars)] + (j-3)* DFEPars[i,j]
}
}

pdf("../Figures/SuppFigureSX9_MLEDFEHumanPopExpansion.pdf",width=7*2,height=7*4/4)
par(mfrow = c(1,2),mar=c(5,5,5,3))

MLE <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBoykoDifRecRate.txt")

Row <- c()
Column <- c()

for (i in 1:nrow(MLE)){
    if (MLE$V1[i] < 2100 ){
CurRow <- ( MLE$V1[i] ) %% 70 + 1
CurColumn <- floor(( MLE$V1[i] ) / 70) + 1
Row <- c(Row, CurRow)
Column <- c(Column, CurColumn)
    }else{
CurRow <- (( MLE$V1[i] ) %% 70) + 1 + 70
CurColumn <- floor(( MLE$V1[i] - 2100 ) / 70) + 1
Row <- c(Row, CurRow)
Column <- c(Column, CurColumn)
    }
}

BestFit <- c()
Differences <- c()
for (i in 1:70){
BestFit[i] <- 1
for (j in 1:30){
    DifferenceOne <- abs(FourNsMeans[(j-1) * 70 + i] - MeanConstantBoyko)
    DifferenceTwo <- abs(FourNsMeans[(BestFit[i]-1) * 70 + i] - MeanConstantBoyko)
    Differences <- c(Differences,DifferenceOne)
    if (DifferenceOne < DifferenceTwo){
        BestFit[i] <- j
    }
}
}

for (i in 1:70){
BestFit[i+70] <- 1
for (j in 1:30){
    DifferenceOne <- abs(FourNsMeans[(j-1) * 70 + i + 2100] - MeanConstantBoyko)
    DifferenceTwo <- abs(FourNsMeans[(BestFit[i+70]-1) * 70 + i + 2100] - MeanConstantBoyko)
    Differences <- c(Differences,DifferenceOne)
    if (DifferenceOne < DifferenceTwo){
        BestFit[i+70] <- j
    }
}
}

Test <- as.data.frame(table(MLE))
UniqueNumbers <- sort(unique(Test$Freq))
ColorViridis <- viridis(length(UniqueNumbers))

ColorsToPrint <- c()
for (i in 1:nrow(MLE)){
    
    CurrentColor <- Test[Test$MLE==MLE$V1[i],]$Freq
    Index <- match(CurrentColor,UniqueNumbers)
    ColorsToPrint <- c(ColorsToPrint, Index)
}


plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="A) Population expansion\nHuman DFE",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis = 1.5)
#points(50.454203927295,0.184753036884482,col="red",pch=19,lwd=3)
lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
# legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
legend("topright",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanConstantBoyko/2)/1:350,lty="dashed",lwd=2,col="green")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(here)

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

DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

# pdf("../Figures/SuppFigure2_MeanDFEMouseHuman2DemScenarios.pdf")
# par(mfrow = c(2,2))
# par(mar=c(2.1,5.1,4.1,1.1))
MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <- MLE$V1[i]
    FourNsMeans[i] <- 0
for (j in 3:203){
    FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[MLE$V1[i]+1,j]
}
}

MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <-  MLE$V1[i]
    FourNsMeans[i] <- 0
    for (j in 3:203){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[MLE$V1[i]+1,j]
    }
}

MLE <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBoykoDifRecRate.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <-  MLE$V1[i]
    FourNsMeans[i] <- 0
    for (j in 3:203){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[MLE$V1[i]+1,j]
    }
}

beanplot(-FourNsMeans,main="B) Population expansion\nHuman DFE",ylab="Mean 4Ns value",cex.lab=2,cex.main=2.5,cex.axis=2,ylim=c(-200,10), col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)
points(1,-MeanPopExpansionBoyko,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <-  MLE$V1[i]
    FourNsMeans[i] <- 0
    for (j in 3:203){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[MLE$V1[i]+1,j]
    }
}

dev.off()



# dev.off()


