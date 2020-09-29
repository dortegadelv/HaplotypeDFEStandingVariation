library(here)
library(viridis)
### Calculation of means

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_1.txt")
MeanConstantBoyko <- mean(Data$V2[1:50000]*926*2)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_2.txt")
MeanConstantMouse <- mean(Data$V2[1:50000]*1034*2)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_3.txt")
MeanPopExpansionBoyko <- mean(Data$V2[1:50000]*1146*2)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_4.txt")
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

pdf("../Figures/SuppFigure16_MLEDFEHumanMouse2DemScenarios.pdf",width=7*2,height=7*2/4)
par(mfrow = c(1,4),mar=c(5,5,5,5))

MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_1.txt")

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


plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="A) Simulation Replicate 1",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis = 1.5)
#points(50.454203927295,0.184753036884482,col="red",pch=19,lwd=3)
# lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
# legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
legend("topright",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanConstantBoyko/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_2.txt")

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


plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="B) Simulation Replicate 2",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
#points(50.8608219789938,0.109621224838877,col="red",pch=19,lwd=3)
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
# lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("topright",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanConstantMouse/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_3.txt")

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



plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="C) Simulation Replicate 3",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
#points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
#lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("center",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanPopExpansionBoyko/2)/1:350,lty="dashed",lwd=2,col="green")
MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_4.txt")

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



plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="D) Simulation Replicate 4",col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
#points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
#lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("center",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=350, lty= 3)
#lines(1:350,(MeanPopExpansionBoyko/2)/1:350,lty="dashed",lwd=2,col="green")



dev.off()

pdf("../Figures/SuppFigure16_MLEDFEHumanMouse2DemScenarios_10Sims.pdf",width=7*2,height=14*2/4)
par(mfrow = c(2,4),mar=c(5,5,5,5))

Vector <- c("A)", "B)", "C)", "D)", "E)", "F)", "G)", "H)", "I)", "J)")


for (k in 5:10){
    File = paste ("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_",k,".txt", sep = "")
    MLE <- read.table(File)

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

    TitleVector <- paste (Vector[k], " Simulation Replicate ", k ,  sep="")
    FileName <- paste("D) Simulation Replicate 4", sep = "")
    plot(Row*5,Column*.03,xlim=c(0,700),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"), main=TitleVector, col=ColorViridis[ColorsToPrint],cex.lab=2,cex.main=2.5,cex.axis=2,pch=19, xaxt = 'n')
    axis(1,at = c(0,175,350,525,700), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1.5)
    #points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
    #lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
    #lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
    legend("center",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
    abline(v=350, lty= 3)
    #lines(1:350,(MeanPopExpansionBoyko/2)/1:350,lty="dashed",lwd=2,col="green")
    
}

dev.off()
