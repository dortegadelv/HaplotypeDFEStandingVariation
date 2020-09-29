### Set directory to the place where you have the 'PlottingScripts' folder

library(here)
library(viridis)
library(jpeg)
library(plotrix)

DemScenario <- c()
DemScenario <- c(DemScenario,"AncientBottleneck")
DemScenario <- c(DemScenario,"AncientBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"ConstantPopSize")
DemScenario <- c(DemScenario,"ConstantPopSizePointFivePercent")
DemScenario <- c(DemScenario,"MediumBottleneck")
DemScenario <- c(DemScenario,"MediumBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"PopExpansion")
DemScenario <- c(DemScenario,"PopExpansionPointFivePercent")
DemScenario <- c(DemScenario,"RecentBottleneck")
DemScenario <- c(DemScenario,"RecentBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"ConstantPopSizePopFrequency")

Selection <- c()
Selection <- c(Selection,"4Ns0")
Selection <- c(Selection,"4Ns-50")
Selection <- c(Selection,"4Ns-100")
Selection <- c(Selection,"4Ns50")
Selection <- c(Selection,"4Ns100")


SelectionTest <- c()
SelectionTest <- c(SelectionTest,"4Ns_0")
SelectionTest <- c(SelectionTest,"4Ns_-50")
SelectionTest <- c(SelectionTest,"4Ns_-100")
SelectionTest <- c(SelectionTest,"4Ns_50")
SelectionTest <- c(SelectionTest,"4Ns_100")

ListMaxFreq <- c()
ListMaxAge <- c()
ListMaxT2 <- c()

Ne <- c()
Ne[1]=10000
Ne[2]=10000
Ne[3]=20000
Ne[4]=20000
Ne[5]=10000
Ne[6]=10000
Ne[7]=100000
Ne[8]=100000
Ne[9]=10000
Ne[10]=10000
Ne[11]=20000

XLimFigureOne <- c()
XLimFigureOne[1]=2500
XLimFigureOne[2]=2500
XLimFigureOne[3]=1000
XLimFigureOne[4]=1000
XLimFigureOne[5]=2500
XLimFigureOne[6]=2500
XLimFigureOne[7]=3500
XLimFigureOne[8]=3500
XLimFigureOne[9]=3500
XLimFigureOne[10]=3500
XLimFigureOne[11]=1000

XLimFigureTwo <- c()
XLimFigureTwo[1]=1500
XLimFigureTwo[2]=900
XLimFigureTwo[3]=3000
XLimFigureTwo[4]=2000
XLimFigureTwo[5]=1500
XLimFigureTwo[6]=900
XLimFigureTwo[7]=1750
XLimFigureTwo[8]=1000
XLimFigureTwo[9]=2000
XLimFigureTwo[10]=900
XLimFigureTwo[11]=3000

YLimFigureTwo <- c()
YLimFigureTwo[1]=0.225
YLimFigureTwo[2]=0.3
YLimFigureTwo[3]=0.125
YLimFigureTwo[4]=0.175
YLimFigureTwo[5]=0.2
YLimFigureTwo[6]=0.3
YLimFigureTwo[7]=0.275
YLimFigureTwo[8]=0.325
YLimFigureTwo[9]=0.35
YLimFigureTwo[10]=0.5
YLimFigureTwo[11]=0.125

XLimFigureThree <- c()
XLimFigureThree[1]=350
XLimFigureThree[2]=150
XLimFigureThree[3]=650
XLimFigureThree[4]=400
XLimFigureThree[5]=300
XLimFigureThree[6]=150
XLimFigureThree[7]=400
XLimFigureThree[8]=300
XLimFigureThree[9]=300
XLimFigureThree[10]=150
XLimFigureThree[11]=650

ColorViridis <- viridis(5)

Plot <- paste("../Figures/SuppFigure24_LDistributionComparison.pdf",sep="")

pdf(Plot, width=21)
par(mfrow = c(1,3))
par(mar=c(5,5,5,2) + 0.1)

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(0.05,0.41), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="A) Probability Distribution of L\n in a constant population size scenario", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[4],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[5],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[2],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[1],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-100","-50","0","50","100"), lty=c(6,6,1,1,1),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfLPopExpansion.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(0.05,0.41), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="B) Probability Distribution of L\n in a population expansion scenario", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[4],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[5],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[2],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[1],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-100","-50","0","50","100"), lty=c(6,6,1,1,1),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfLUK10K.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(0.05,0.41), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="C) Probability Distribution of L\n in the scaled UK10K demographic model", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[4],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[5],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[2],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[1],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-50","-25","0","50","100"), lty=c(6,6,1,1,1),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

dev.off()

File = c("../Results/DistributionOfL/DistributionOfL.txt", "../Results/DistributionOfL/DistributionOfLPopExpansion.txt", "../Results/DistributionOfL/DistributionOfLUK10K.txt")

Numbers <- c(1,4,5)
TotalConcatenateSums <- c()
for (i in 1:3){
    
     DistributionOfL <- read.table(File[i])
     ConcatenateSums <- c()
     for (j in Numbers){
         for (k in Numbers){
             AbsoluteSum <- 0
             for (l in 1:5){
                 AbsoluteSum <- AbsoluteSum + abs(DistributionOfL[j,l] - DistributionOfL[k,l])
             }
             ConcatenateSums <- c(ConcatenateSums, AbsoluteSum)
         }
     }
     TotalConcatenateSums <- c(TotalConcatenateSums, ConcatenateSums[2], ConcatenateSums[3], ConcatenateSums[6])
}


Plot <- paste("../Figures/SuppFigure24_LDistributionBoxplot.pdf",sep="")

pdf(Plot, width=21)
par(mfrow = c(1,3))
par(mar=c(5,5,5,5) + 0.1)

plot(1:3,TotalConcatenateSums[1:3], type="o",pch=19,ylab=" Absolute difference between probability distributions of L", xaxt = "n",xlab= "", ylim = c(0,0.075), cex.axis = 2, cex.lab = 2, main = "D) Constant population size scenario", cex.main = 2.5)

axis (1, at=c(1,2,3), labels = c("4Ns = 0 vs 4Ns = 50","4Ns = 0 vs 4Ns = 100","4Ns = 50 vs 4Ns = 100"), cex.axis = 1.5 )

plot(1:3,TotalConcatenateSums[4:6], type="o",pch=19,ylab=" Absolute difference between probability distributions of L", xaxt = "n",xlab= "", ylim = c(0,0.075), cex.axis = 2, cex.lab = 2, main = "E) Population expansion scenario", cex.main = 2.5)

axis (1, at=c(1,2,3), labels = c("4Ns = 0 vs 4Ns = 50","4Ns = 0 vs 4Ns = 100","4Ns = 50 vs 4Ns = 100"), cex.axis = 1.5 )

plot(1:3,TotalConcatenateSums[7:9], type="o",pch=19,ylab=" Absolute difference between probability distributions of L", xaxt = "n",xlab= "", ylim = c(0,0.075), cex.axis = 2, cex.lab = 2, main = "F) Scaled UK10K demographic model", cex.main = 2.5)

axis (1, at=c(1,2,3), labels = c("4Ns = 0 vs 4Ns = 25","4Ns = 0 vs 4Ns = 50","4Ns = 25 vs 4Ns = 50"), cex.axis = 1.5 )

dev.off()
