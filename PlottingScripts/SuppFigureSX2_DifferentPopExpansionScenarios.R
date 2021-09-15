library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

##########

Plot <- paste("../Figures/SuppFigureSX2_PopExpansionDifferentTimesSelInference.pdf",sep="")
PlotC <- paste("../Figures/SuppFigureSX2_PopExpansionDifferentTimesSelInferenceCompressed.pdf",sep="")

pdf(Plot, width = 7*5, height = 7*4)
par(mfrow=c(4,5), mar=c(5,5,5,2) + 0.1)

### Figure 3

Selection4Ns_0_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo0_N10000.txt")
Selection4Ns_50_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo50_N10000.txt")
Selection4Ns_100_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo100_N10000.txt")
Selection4Ns_Minus50_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo-50_N10000.txt")
Selection4Ns_Minus100_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100GensAgo-100_N10000.txt")

Selection4Ns_0_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo0_N10000.txt")
Selection4Ns_50_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo50_N10000.txt")
Selection4Ns_100_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo100_N10000.txt")
Selection4Ns_Minus50_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo-50_N10000.txt")
Selection4Ns_Minus100_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion1000GensAgo-100_N10000.txt")

Selection4Ns_0_10000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo0_N10000.txt")
Selection4Ns_50_10000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo50_N10000.txt")
Selection4Ns_100_10000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo100_N10000.txt")
Selection4Ns_Minus50_10000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo-50_N10000.txt")
Selection4Ns_Minus100_10000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion10000GensAgo-100_N10000.txt")

Selection4Ns_0_100000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100000GensAgo0_N10000.txt")
Selection4Ns_50_100000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100000GensAgo50_N10000.txt")
Selection4Ns_100_100000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100000GensAgo100_N10000.txt")
Selection4Ns_Minus50_100000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100000GensAgo-50_N10000.txt")
Selection4Ns_Minus100_100000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100000GensAgo-100_N10000.txt")


plot(c(100000,100000-150,100000-1000),c(50000,5000,5000),type="s",xlim=c(100000-300,100000),ylim=c(0,50000),ylab="Effective Population Size",xlab="Time before the present",main="A) Population Expansion \nModel",xaxt='n',yaxt='n',cex.main=2.5,cex.lab=2.5,col="red",lwd=6)
axis(1,at=c(100000,100000-150),labels = c("Present","100"),cex.axis=2.5)
axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)


beanplot(Selection4Ns_0_100Gens$V1-200,Selection4Ns_50_100Gens$V1-200,Selection4Ns_Minus50_100Gens$V1-200,Selection4Ns_100_100Gens$V1-200,Selection4Ns_Minus100_100Gens$V1-200,names=c("0","10","-10","20","-20"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main=" Inference of Selection\n(Expansion time = 100 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)

beanplot(abs(Selection4Ns_0_100Gens$V1-200),abs(Selection4Ns_50_100Gens$V1-200),abs(Selection4Ns_Minus50_100Gens$V1-200),abs(Selection4Ns_100_100Gens$V1-200),abs(Selection4Ns_Minus100_100Gens$V1-200),names=c("0","10","-10","20","-20"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="Inference of Selection in terms of |4Ns| values\n(Expansion time = 100 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)

############## Trajectories
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100GensAgo4Ns0.txt",sep="")
    Data <- read.table(TrajectoryFile)
    ColorViridis <- viridis(5)
    ColorViridisAlpha <- viridis(5,alpha=0.6)
    Color <- col2rgb("black")
    MaxFreq <- max(Data$V2)

    plot(Data$V1[10000:1],Data$V2[1:10000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(8200,10000),ylim=c(0,0.012),main="Average Frequency Trajectory\n(Expansion time = 100 generations ago)",xaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=2.5,lwd=6,col=ColorViridis[3])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    abline(v=9900, lty = "dashed")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100GensAgo4Ns-50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("purple")
    lines(Data$V1[10000:1],Data$V2[1:10000],lwd=6,col=ColorViridis[2])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")
    
#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100GensAgo4Ns-100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("orange")
    lines(Data$V1[10000:1],Data$V2[1:10000],lwd=6,col=ColorViridis[1])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")
    
#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100GensAgo4Ns50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[10000:1],Data$V2[1:10000],lty=5,lwd=6,col=ColorViridis[4])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100GensAgo4Ns100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[10000:1],Data$V2[1:10000],lty=5,lwd=6,col=ColorViridis[5])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")
legend("topleft",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
    axis(1,at=c(10000,9500,9000,8500,8000,0),labels=c("Present","500","1000","1500","2000","10000"),cex.lab=2,cex.axis=2.5)
    

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL100GensAgo.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(Min,Max), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="Probability Distribution of L\n(Expansion time = 100 generations ago)", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")





plot(c(100000,100000-150,100000-1000),c(50000,5000,5000),type="s",xlim=c(100000-300,100000),ylim=c(0,50000),ylab="Effective Population Size",xlab="Time before the present",main="B) Population Expansion \nModel",xaxt='n',yaxt='n',cex.main=2.5,cex.lab=2.5,col="red",lwd=6)
axis(1,at=c(100000,100000-150),labels = c("Present","1000"),cex.axis=2.5)
axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)


beanplot(Selection4Ns_0_1000Gens$V1-200,Selection4Ns_50_1000Gens$V1-200,Selection4Ns_Minus50_1000Gens$V1-200,Selection4Ns_100_1000Gens$V1-200,Selection4Ns_Minus100_1000Gens$V1-200,names=c("0","10","-10","20","-20"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection\n(Expansion time = 1000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)

beanplot(abs(Selection4Ns_0_1000Gens$V1-200),abs(Selection4Ns_50_1000Gens$V1-200),abs(Selection4Ns_Minus50_1000Gens$V1-200),abs(Selection4Ns_100_1000Gens$V1-200),abs(Selection4Ns_Minus100_1000Gens$V1-200),names=c("0","10","-10","20","-20"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="Inference of Selection in terms of |4Ns| values\n(Expansion time = 1000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)


############## Trajectories
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion1000GensAgo4Ns0.txt",sep="")
    Data <- read.table(TrajectoryFile)
    ColorViridis <- viridis(5)
    ColorViridisAlpha <- viridis(5,alpha=0.6)
    Color <- col2rgb("black")
    MaxFreq <- max(Data$V2)

    plot(Data$V1[10000:1],Data$V2[1:10000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(0,10000),ylim=c(0,0.013),main="Average Frequency Trajectory\n(Expansion time = 1000 generations ago)",xaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=2.5,lwd=6,col=ColorViridis[3])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
abline(v=9000, lty = "dashed")

    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion1000GensAgo4Ns-50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("purple")
    lines(Data$V1[10000:1],Data$V2[1:10000],lwd=6,col=ColorViridis[2])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")
    
#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion1000GensAgo4Ns-100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("orange")
    lines(Data$V1[10000:1],Data$V2[1:10000],lwd=6,col=ColorViridis[1])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")
    
#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion1000GensAgo4Ns50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[10000:1],Data$V2[1:10000],lty=5,lwd=6,col=ColorViridis[4])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion1000GensAgo4Ns100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[10000:1],Data$V2[1:10000],lty=5,lwd=6,col=ColorViridis[5])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")
legend("topleft",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
    axis(1,at=c(10000,8000,6000,4000,2000,0),labels=c("Present","2000","4000","6000","8000","10000"),cex.lab=2,cex.axis=2.5)
    
DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL1000GensAgo.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(Min,Max), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="Probability Distribution of L\n(Expansion time = 1000 generations ago)", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")





plot(c(100000,100000-150,100000-1000),c(50000,5000,5000),type="s",xlim=c(100000-300,100000),ylim=c(0,50000),ylab="Effective Population Size",xlab="Time before the present",main="C) Population Expansion \nModel",xaxt='n',yaxt='n',cex.main=2.5,cex.lab=2.5,col="red",lwd=6)
axis(1,at=c(100000,100000-150),labels = c("Present","10000"),cex.axis=2.5)
axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)


beanplot(Selection4Ns_0_10000Gens$V1-200,Selection4Ns_50_10000Gens$V1-200,Selection4Ns_Minus50_10000Gens$V1-200,Selection4Ns_100_10000Gens$V1-200,Selection4Ns_Minus100_10000Gens$V1-200,names=c("0","10","-10","20","-20"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection\n(Expansion time = 10000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)

beanplot(abs(Selection4Ns_0_10000Gens$V1-200), abs(Selection4Ns_50_10000Gens$V1-200),abs(Selection4Ns_Minus50_10000Gens$V1-200),abs(Selection4Ns_100_10000Gens$V1-200),abs(Selection4Ns_Minus100_10000Gens$V1-200),names=c("0","10","-10","20","-20"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="Inference of Selection in terms of |4Ns| values\n(Expansion time = 10000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)


############## Trajectories
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion10000GensAgo4Ns0.txt",sep="")
    Data <- read.table(TrajectoryFile)
    ColorViridis <- viridis(5)
    ColorViridisAlpha <- viridis(5,alpha=0.6)
    Color <- col2rgb("black")
    MaxFreq <- max(Data$V2)

    plot(Data$V1[20000:1],Data$V2[1:20000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(0,20000),ylim=c(0,0.011),main="Average Frequency Trajectory\n(Expansion time = 10000 generations ago)",xaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=2.5,lwd=6,col=ColorViridis[3])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
abline(v=10000, lty = "dashed")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion10000GensAgo4Ns-50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("purple")
    lines(Data$V1[20000:1],Data$V2[1:20000],lwd=6,col=ColorViridis[2])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")
    
#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion10000GensAgo4Ns-100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("orange")
    lines(Data$V1[20000:1],Data$V2[1:20000],lwd=6,col=ColorViridis[1])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")
    
#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion10000GensAgo4Ns50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[20000:1],Data$V2[1:20000],lty=5,lwd=6,col=ColorViridis[4])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion10000GensAgo4Ns100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[20000:1],Data$V2[1:20000],lty=5,lwd=6,col=ColorViridis[5])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")
legend("topleft",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
    axis(1,at=c(20000,16000,12000,8000,4000,0),labels=c("Present","4000","8000","12000","16000","20000"),cex.lab=2,cex.axis=2.5)
    
DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL10000GensAgo.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(Min,Max), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="Probability Distribution of L\n(Expansion time = 10000 generations ago)", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")






plot(c(100000,100000-150,100000-1000),c(50000,5000,5000),type="s",xlim=c(100000-300,100000),ylim=c(0,50000),ylab="Effective Population Size",xlab="Time before the present",main="D) Population Expansion \nModel",xaxt='n',yaxt='n',cex.main=2.5,cex.lab=2.5,col="red",lwd=6)
axis(1,at=c(100000,100000-150),labels = c("Present","100000"),cex.axis=2.5)
axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)

beanplot(Selection4Ns_0_100000Gens$V1-200,Selection4Ns_50_100000Gens$V1-200,Selection4Ns_Minus50_100000Gens$V1-200,Selection4Ns_100_100000Gens$V1-200,Selection4Ns_Minus100_100000Gens$V1-200,names=c("0","10","-10","20","-20"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection\n(Expansion time = 100000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)

beanplot(abs(Selection4Ns_0_100000Gens$V1-200),abs(Selection4Ns_50_100000Gens$V1-200),abs(Selection4Ns_Minus50_100000Gens$V1-200),abs(Selection4Ns_100_100000Gens$V1-200),abs(Selection4Ns_Minus100_100000Gens$V1-200),names=c("0","10","-10","20","-20"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="Inference of Selection in terms of |4Ns| values\n(Expansion time = 100000 generations ago)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, -20, -10, 0, 10, 20, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=10,lty=3)
abline(h=-10,lty=3)
abline(h=20,lty=3)
abline(h=-20,lty=3)


############## Trajectories
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100000GensAgo4Ns0.txt",sep="")
    Data <- read.table(TrajectoryFile)
    ColorViridis <- viridis(5)
    ColorViridisAlpha <- viridis(5,alpha=0.6)
    Color <- col2rgb("black")
    MaxFreq <- max(Data$V2)

    plot(Data$V1[20000:1],Data$V2[1:20000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(0,20000),ylim=c(0,0.011),main="Average Frequency Trajectory\n(Expansion time = 100000 generations ago)",xaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=2.5,lwd=6,col=ColorViridis[3])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100000GensAgo4Ns-50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("purple")
    lines(Data$V1[20000:1],Data$V2[1:20000],lwd=6,col=ColorViridis[2])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")
    
#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100000GensAgo4Ns-100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    Color <- col2rgb("orange")
    lines(Data$V1[20000:1],Data$V2[1:20000],lwd=6,col=ColorViridis[1])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")
    
#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100000GensAgo4Ns50.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[20000:1],Data$V2[1:20000],lty=5,lwd=6,col=ColorViridis[4])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")
    
    TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTrajPopExpansion100000GensAgo4Ns100.txt",sep="")
    Data <- read.table(TrajectoryFile)
    
    lines(Data$V1[20000:1],Data$V2[1:20000],lty=5,lwd=6,col=ColorViridis[5])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")
legend("topleft",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
    axis(1,at=c(20000,16000,12000,8000,4000,0),labels=c("Present","4000","8000","12000","16000","20000"),cex.lab=2,cex.axis=2.5)

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL100000GensAgo.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(Min,Max), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="Probability Distribution of L\n(Expansion time = 100000 generations ago)", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-20","-10","0","10","20"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")




dev.off()

# pdf_compress(Plot, output = PlotC, gs_quality = "printer")
