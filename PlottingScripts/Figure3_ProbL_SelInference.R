### Set directory to the place where you have the 'PlottingScripts' folder

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

Plot <- paste("../Figures/","Figure3_ProbLInferenceSelection.pdf",sep="")
ColorViridis <- viridis(5)

pdf(Plot,width=12,height=12/3)
par(mfrow=c(1,3))
par(mar=c(5,5,4,2) + 0.1)


# Image <- readJPEG("PotentialPaperFigures/HaplotypeDivision/Slide1.jpg")
#plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.333333),ylim=c(0,1),main="A) Windows of pairwise haplotypic\n identity by state lengths (L)",cex.main=2)
#rasterImage(Image,0.0,0.0,1.333333,1,bty="n")

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,],col=ColorViridis[3],type="l",lwd=6,ylim=c(Min,Max),ylab="Probability",xlab="L",cex.lab=2,cex.axis=2,xaxt="n",main="A) Probability Distribution of L\ngiven a 1% frequency allele",cex.main=2)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2,cex.axis=2)
legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#LLSurface <- read.table("ResultsSelectionInferred/ExampleLLSurface.txt")
#plot(1:401,LLSurface[1,],type="l",lwd=6,ylab="Log-likelihood",xlab="4Ns",cex.lab=2,cex.axis=2,xaxt="n",main="C) Example Log-Likelihood plot",cex.main=2)
#axis(1,at=c(1,101,201,301,401),labels=c(-200,-100,0,100,200),cex.lab=2,cex.axis=2)
#arrows(201,-15761.78,201,-15666.78)
#legend(131,-15755.78,c("MLE"),bty="n",cex=2)

Selection4Ns_0 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize0_N10000.txt")
Selection4Ns_50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize50_N10000.txt")
Selection4Ns_100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_N10000.txt")
Selection4Ns_Minus50 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-100_N10000.txt")

beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="B) Inference of Selection",cex.axis=1.8,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


beanplot(abs(Selection4Ns_0$V1-200),abs(Selection4Ns_50$V1-200),abs(Selection4Ns_Minus50$V1-200),abs(Selection4Ns_100$V1-200),abs(Selection4Ns_Minus100$V1-200),names=c("0","50","-50","100","-100"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="C) Inference of Selection\n in terms of |4Ns| values",cex.axis=1.8,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


dev.off()
