library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

### Figure 3

Plot <- paste("../Figures/SuppFigure35_PopExpansionConstantPopSizeSelInferenceLowESS.pdf",sep="")

pdf(Plot,width=7*3, height = 7*2)
par(mfrow = c(2,3))
par(mar=c(5,5,5,2) + 0.1)


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-100_N10000.txt")

beanplot(abs(Selection4Ns_0$V1-200),abs(Selection4Ns_50$V1-200),abs(Selection4Ns_Minus50$V1-200),abs(Selection4Ns_100$V1-200),abs(Selection4Ns_Minus100$V1-200),names=c("0","50","-50","100","-100"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="A) Inference of Selection in a Constant\nPopulation Size Model (100,000 trajectories)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_-100_N10000.txt")

beanplot(abs(Selection4Ns_0$V1-200),abs(Selection4Ns_50$V1-200),abs(Selection4Ns_Minus50$V1-200),abs(Selection4Ns_100$V1-200),abs(Selection4Ns_Minus100$V1-200),names=c("0","50","-50","100","-100"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="B) Inference of Selection in a Constant\nPopulation Size Model (1,000 trajectories)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


Data <- read.table("../Results/AllAgeESS/FinalStatsConstantPopSize.txt")
plot(-200:200,Data[403:803],type="l",ylab="ESS",xlab="4Ns", main = "C)", cex.axis=2.2,cex.lab=2.5,cex.main=2.5,lwd=2, ylim= c(0,max(Data[403:803])))

Data <- read.table("../Results/AllAgeESS/LowESSConstantPopSize.txt")

lines(-200:200,Data[403:803],type="l",col="red",cex.lab=1.4,cex.axis=1.5,lwd=2)
legend("left",pch=19,col=c("black","red"),legend=c("100,000 trajectories","1,000 trajectories"), bty = "n", cex = 2)


Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-100_N10000.txt")

beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="D) Inference of Selection in a Population\nExpansion Model (100,000 trajectories)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)

Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_-100_N10000.txt")

beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="E) Inference of Selection in a Population\nExpansion Model (1,000 trajectories)",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


Data <- read.table("../Results/AllAgeESS/FinalStatsPopExpansion.txt")
plot(-200:200,Data[403:803],type="l",ylab="ESS",xlab="4Ns", main = "F) ",cex.axis=2.2,cex.lab=2.5,cex.main=2.5,lwd=2, ylim= c(0,max(Data[403:803])))

Data <- read.table("../Results/AllAgeESS/LowESSPopExpansion.txt")

lines(-200:200,Data[403:803],type="l",col="red", cex.lab=1.4,cex.axis=1.5,lwd=2)

legend("topleft",pch=19,col=c("black","red"),legend=c("100,000 trajectories","1,000 trajectories"), bty = "n", cex = 2)

dev.off()
