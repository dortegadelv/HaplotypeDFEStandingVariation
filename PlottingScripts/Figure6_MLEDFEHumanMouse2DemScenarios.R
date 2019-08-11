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

DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
FourNsMeans <- c()

for (i in 1:nrow(DFEPars)){
FourNsMeans[i] <- 0

for (j in 3:303){
FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[i,j]
}
}

pdf("../Figures/Figure6_MLEDFEHumanMouse2DemScenarios.pdf",width=7*2,height=7*2/4)
par(mfrow = c(1,4),mar=c(5,5,5,3))

MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

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


plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="A) Constant size\nHuman DFE",cex.lab=2,cex.main=2.5,cex.axis=2,pch=19)
#points(50.454203927295,0.184753036884482,col="red",pch=19,lwd=3)
lines(1:70*5,BestFit*0.01,lty="dashed",lwd=2,col="red")
#lines(1:350,(MeanConstantBoyko/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1


BestFit <- c()
Differences <- c()
for (i in 1:70){
    BestFit[i] <- 1
    for (j in 1:30){
        DifferenceOne <- abs(FourNsMeans[(j-1) * 70 + i] - MeanConstantMouse)
        DifferenceTwo <- abs(FourNsMeans[(BestFit[i]-1) * 70 + i] - MeanConstantMouse)
        Differences <- c(Differences,DifferenceOne)
        if (DifferenceOne < DifferenceTwo){
            BestFit[i] <- j
        }
    }
}


plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="B) Constant size\nMouse DFE",cex.lab=2,cex.main=2.5,cex.axis=2,pch=19)
#points(50.8608219789938,0.109621224838877,col="red",pch=19,lwd=3)
lines(1:70*5,BestFit*0.01,lty="dashed",lwd=2,col="red")

#lines(1:350,(MeanConstantMouse/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1


BestFit <- c()
Differences <- c()
for (i in 1:70){
    BestFit[i] <- 1
    for (j in 1:30){
        DifferenceOne <- abs(FourNsMeans[(j-1) * 70 + i] - MeanPopExpansionBoyko)
        DifferenceTwo <- abs(FourNsMeans[(BestFit[i]-1) * 70 + i] - MeanPopExpansionBoyko)
        Differences <- c(Differences,DifferenceOne)
        if (DifferenceOne < DifferenceTwo){
            BestFit[i] <- j
        }
    }
}


plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="C) Population expansion\nHuman DFE",cex.lab=2,cex.main=2.5,cex.axis=2,pch=19)
#points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
lines(1:70*5,BestFit*0.01,lty="dashed",lwd=2,col="red")
#lines(1:350,(MeanPopExpansionBoyko/2)/1:350,lty="dashed",lwd=2,col="green")

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

BestFit <- c()
Differences <- c()
for (i in 1:70){
    BestFit[i] <- 1
    for (j in 1:30){
        DifferenceOne <- abs(FourNsMeans[(j-1) * 70 + i] - MeanPopExpansionMouse)
        DifferenceTwo <- abs(FourNsMeans[(BestFit[i]-1) * 70 + i] - MeanPopExpansionMouse)
        Differences <- c(Differences,DifferenceOne)
        if (DifferenceOne < DifferenceTwo){
            BestFit[i] <- j
        }
    }
}


plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="D) Population expansion\nMouse DFE",cex.lab=2,cex.main=2.5,cex.axis=2,pch=19)
#points(30.9631108230993,0.112475018218557,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionMouse/1:350,lty="dashed",lwd=2,col="red")
lines(1:70*5,BestFit*0.01,lty="dashed",lwd=2,col="red")
#lines(1:350,(MeanPopExpansionMouse/2)/1:350,lty="dashed",lwd=2,col="green")

dev.off()


