############# Plot Boyko plus positive selection

library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

Data <- read.table("../Results/ExitSValues/ExitOnePercentSValuesPopExpansionBoyko.txt")
MeanPopExpansionBoyko <- mean(Data$V2[1:50000]*20000)

DFEParsOne <- read.table ("../Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesPosBoyko.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/PopExpansionBoykoPlusPositive/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesPosBoykoSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoPositiveMLE.txt")

FourNsMeans <- c()
for (i in 1:100){
    DFEParameterNumber <-  MLE$V1[i]
    FourNsMeans[i] <- 0
    for (j in 3:203){
        FourNsMeans[i] <- FourNsMeans[i] + (j-3)* DFEPars[MLE$V1[i]+1,j]
    }
}

Sel <- MLE$V1 %% 3

hist(Sel)

AllMLEs <- round(MLE / 3,0)

pdf("../Figures/SuppFigure17_PopExpansionPosPlusNegSelection.pdf")
par(mfrow = c(2,2))

Row <- c()
Column <- c()

for (i in 1:nrow(MLE)){
    if (MLE$V1[i] < 1260 ){
CurRow <- ( floor (MLE$V1[i] / 3) ) %% 14 + 1
CurColumn <- floor(( floor (MLE$V1[i] / 3) ) / 14) + 1
Row <- c(Row, CurRow)
Column <- c(Column, CurColumn)
    }else{
CurRow <- ( floor (MLE$V1[i] / 3) ) %% 14 + 1 + 14
CurColumn <- floor(( floor ( MLE$V1[i] - 1260 ) / 3 ) / 14) + 1
Row <- c(Row, CurRow)
Column <- c(Column, CurColumn)
    }
}

Test <- as.data.frame(table(floor(MLE/3)))
UniqueNumbers <- sort(unique(Test$Freq))
ColorViridis <- viridis(length(UniqueNumbers))

ColorsToPrint <- c()
for (i in 1:nrow(MLE)){
    
    CurrentColor <- floor(Test[Test$Var1==floor(MLE$V1[i] /3) ,]$Freq)
    Index <- match(CurrentColor,UniqueNumbers)
    ColorsToPrint <- c(ColorsToPrint, Index)
}



plot(Row*5,Column*.03,xlim=c(0,140),ylim=c(0,0.9),xlab=expression("Shape (" ~ alpha ~ ")"),ylab=expression("Scale (" ~ beta ~ ")"),main="A) Pop expansion\nDeleterious variation DFEf parameters",col=ColorViridis[ColorsToPrint],cex.lab=1,cex.main=1,cex.axis=1,pch=19, xaxt = 'n')
axis(1,at = c(5,35,70,105,140), labels = c("3", "110", "240", "1245", "2310"), cex.axis  = 1)
#points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
#lines(1:350,MeanPopExpansionBoyko/1:350,lty="dashed",lwd=2,col="green")
# lines(1:140*5,BestFit*0.03,lty="dashed",lwd=2,col="red")
legend("center",format(UniqueNumbers), pch=19, col=ColorViridis,cex=1,title="Number of simulations",bty="n")
abline(v=70, lty= 3)

beanplot(-FourNsMeans,main="B) Pop Expansion\nDeleterious variation mean 4Ns value",ylab="Mean 4Ns value",cex.lab=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
points(1,-MeanPopExpansionBoyko,col="red",pch=19)

Sel <- MLE$V1 %% 3
par(mar = c(5,5,4,3))

hist(Sel,main="C) Pop Expansion\nProportion of positive selection variants",axes=FALSE,xlab="Proportion of variants under positive selection",ylab="Number of times a certain proportion of\n variants under positive selection were inferred")
axis(2,)
axis(1,at=c(0.1,0.9,1.9),labels=c("0%","5%","10%"))
dev.off()


