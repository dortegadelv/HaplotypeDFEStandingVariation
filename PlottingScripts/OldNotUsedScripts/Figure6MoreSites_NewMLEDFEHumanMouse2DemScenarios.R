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

pdf("../Figures/Figure6_MLEDFEHumanMouse2DemScenariosMoreSites.pdf",width=7*2,height=7*2/4)
par(mfrow = c(1,4),mar=c(5,5,5,3))

MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLEOneMillion.txt")

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


plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="A) Constant size\nHuman DFE",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis = 1.5)
#points(50.454203927295,0.184753036884482,col="red",pch=19,lwd=3)
lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
# legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
legend("topright",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanConstantBoyko/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLEOneMillion.txt")

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


plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="B) Constant size\nMouse DFE",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
#points(50.8608219789938,0.109621224838877,col="red",pch=19,lwd=3)
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("topright",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanConstantMouse/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLEOneMillion.txt")

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



plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="C) Population expansion\nHuman DFE",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
#points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("center",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanPopExpansionBoyko/2)/1:350,lty="dashed",lwd=2,col="green")

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLEOneMillion.txt")

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




plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="D) Population expansion\nMouse DFE",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)

#points(30.9631108230993,0.112475018218557,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionMouse/1:350,lty="dashed",lwd=2,col="red")
lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend(300, 0.95, format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanPopExpansionMouse/2)/1:350,lty="dashed",lwd=2,col="green")

dev.off()


