setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

Plot <- paste("PotentialPaperFigures/","Figure2.pdf",sep="")
ColorViridis <- viridis(5)

pdf(Plot,width=12,height=12)
par(mfrow=c(2,2))
par(mar=c(5,5,4,2) + 0.1)   


Image <- readJPEG("PotentialPaperFigures/HaplotypeDivision/Slide1.jpg")
plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.333333),ylim=c(0,1),main="A) Windows of pairwise haplotypic\n identity by state lengths (L)",cex.main=2)
rasterImage(Image,0.0,0.0,1.333333,1,bty="n")

DistributionOfL <- read.table("DistributionOfL/DistributionOfL.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,],col=ColorViridis[3],type="l",lwd=6,ylim=c(Min,Max),ylab="Probability",xlab="L",cex.lab=2,cex.axis=2,xaxt="n",main="B) Probability Distribution of L\ngiven a 1% frequency allele",cex.main=2)
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

Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize0_N10000.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize50_N10000.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize100_N10000.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize-100_N10000.txt")

beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="C) Inference of Selection",cex.axis=1.3,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


beanplot(abs(Selection4Ns_0$V1-200),abs(Selection4Ns_50$V1-200),abs(Selection4Ns_Minus50$V1-200),abs(Selection4Ns_100$V1-200),abs(Selection4Ns_Minus100$V1-200),names=c("0","50","-50","100","-100"),ylab="Estimated |4Ns| values",xlab="Real 4Ns values",main="D) Inference of Selection\n in terms of |4Ns| values",cex.axis=1.3,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)


dev.off()

### Figure 3


Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionPopExpansion0_N10000.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionPopExpansion50_N10000.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionPopExpansion100_N10000.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionPopExpansion-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionPopExpansion-100_N10000.txt")

Plot <- paste("PotentialPaperFigures/","Figure4.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)   


beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in a\nPopulation Expansion Model",cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)

dev.off()


### Figure 3


Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-50.txt")


Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-50.txt")
Selection4Ns_1 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_1.txt")

###Confidence interval
quantile(Selection4Ns_1$V1,prob=seq(from = 0.0,to = 1, by =0.05))


Plot <- paste("PotentialPaperFigures/","Figure5.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)   


beanplot(Selection4Ns_0$V1,Selection4Ns_50$V1,Selection4Ns_Minus50$V1,Selection4Ns_100$V1,Selection4Ns_Minus100$V1,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in the\nUK10K Expansion Model",cex.axis=1.25,cex.lab=2,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)

dev.off()

### Figure 3 single rec


Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionUK10K4Ns_-50.txt")


Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionUK10KSingleRec4Ns_0.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionUK10KSingleRec4Ns_25.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionUK10KSingleRec4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionUK10KSingleRec4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionUK10KSingleRec4Ns_-50.txt")


Plot <- paste("PotentialPaperFigures/","Figure5SingleRec.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)


beanplot(Selection4Ns_0$V1,Selection4Ns_50$V1,Selection4Ns_Minus50$V1,Selection4Ns_100$V1,Selection4Ns_Minus100$V1,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in the\nUK10K Expansion Model",cex.axis=1.25,cex.lab=2,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)

dev.off()

### Figure 3 power test

Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionCloseQuantileUK10K4Ns_0.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionCloseQuantileUK10K4Ns_25.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionCloseQuantileUK10K4Ns_50.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionCloseQuantileUK10K4Ns_-25.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionCloseQuantileUK10K4Ns_-50.txt")


Plot <- paste("PotentialPaperFigures/","Figure5RecVariation.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)


beanplot(Selection4Ns_0$V1,Selection4Ns_50$V1,Selection4Ns_Minus50$V1,Selection4Ns_100$V1,Selection4Ns_Minus100$V1,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection in the\nUK10K Expansion Model",cex.axis=1.25,cex.lab=2,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=-25,lty=3)
abline(h=-50,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)

dev.off()


### Possible Figure 1


Plot <- paste("PotentialPaperFigures/","PossibleFigure1.pdf",sep="")
ColorViridis <- viridis(5)

pdf(Plot)
# par(mfrow=c(2,2))
par(mar=c(5,5,4,2) + 0.1)


Image <- readJPEG("PotentialPaperFigures/HaplotypeDivision/Slide1.jpg")
plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.333333),ylim=c(0,1),main="Windows of pairwise haplotypic\n identity by state lengths (L)",cex.main=2)
rasterImage(Image,0.0,0.0,1.333333,1,bty="n")
 dev.off()

### Other version Figure 2


Plot <- paste("PotentialPaperFigures/","OtherFigure2.pdf",sep="")
ColorViridis <- viridis(5)

pdf(Plot,width=12,height=12/3)
par(mfrow=c(1,3))
par(mar=c(5,5,4,2) + 0.1)


# Image <- readJPEG("PotentialPaperFigures/HaplotypeDivision/Slide1.jpg")
#plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.333333),ylim=c(0,1),main="A) Windows of pairwise haplotypic\n identity by state lengths (L)",cex.main=2)
#rasterImage(Image,0.0,0.0,1.333333,1,bty="n")

DistributionOfL <- read.table("DistributionOfL/DistributionOfL.txt")
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

Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize0_N10000.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize50_N10000.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize100_N10000.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionConstantPopSize-100_N10000.txt")

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

###Ancient bottleneck
quantile(Selection4Ns_1$V1,prob=seq(from = 0.0,to = 1, by =0.05))

Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionAncientBottleneck0_N10000.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionAncientBottleneck50_N10000.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionAncientBottleneck100_N10000.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionAncientBottleneck-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionAncientBottleneck-100_N10000.txt")


Plot <- paste("PotentialPaperFigures/","AncientBottleneckInferenceFigure.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)


beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="C) Inference of Selection",cex.axis=1.3,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)
abline(h=0,lty=3)
abline(h=-50,lty=3)
abline(h=50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)

dev.off()

###Recent bottleneck
quantile(Selection4Ns_1$V1,prob=seq(from = 0.0,to = 1, by =0.05))

Selection4Ns_0 <- read.table("ResultsSelectionInferred/SelectionRecentBottleneck0_N10000.txt")
Selection4Ns_50 <- read.table("ResultsSelectionInferred/SelectionRecentBottleneck50_N10000.txt")
Selection4Ns_100 <- read.table("ResultsSelectionInferred/SelectionRecentBottleneck100_N10000.txt")
Selection4Ns_Minus50 <- read.table("ResultsSelectionInferred/SelectionRecentBottleneck-50_N10000.txt")
Selection4Ns_Minus100 <- read.table("ResultsSelectionInferred/SelectionRecentBottleneck-100_N10000.txt")


Plot <- paste("PotentialPaperFigures/","RecentBottleneckInferenceFigure.pdf",sep="")


pdf(Plot)
par(mar=c(5,5,4,2) + 0.1)


beanplot(Selection4Ns_0$V1-200,Selection4Ns_50$V1-200,Selection4Ns_Minus50$V1-200,Selection4Ns_100$V1-200,Selection4Ns_Minus100$V1-200,names=c("0","50","-50","100","-100"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="C) Inference of Selection",cex.axis=1.3,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
abline(h=-50,lty=3)
abline(h=50,lty=3)
abline(h=100,lty=3)
abline(h=-100,lty=3)

dev.off()

####### DFE selection bootstrap ########

DFESelection <- read.table("ResultsSelectionInferred/SelectionDFEUK10KBootstrap.txt")

SelectionDFERow <- ((DFESelection %% 50 ) + 1) * 5
SelectionDFEColumn <- (floor(DFESelection / 50 ) + 1) *.01

Plot <- paste("PotentialPaperFigures/","DFEInferenceHex.pdf",sep="")
pdf(Plot,width=14)
library(hexbin)
par(mfrow=c(1,2))
par(mar=c(5,5,4,2) + 0.1)
# Create hexbin object and plot
df <- data.frame(SelectionDFEColumn$V1,SelectionDFERow$V1)
colnames(df) <- c("Beta","Alpha")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
h <- hexbin(df, xbins = 301,IDs=TRUE)
#slot(h,"ybnds")[2] <- 2005
#slot(h,"xbnds")[2] <- 3005
#plot(h)
#plot(h, colramp=rf)
ColorViridis <- viridis(23)
plot(slot(h,"ycm"),slot(h,"xcm"),col= ColorViridis[23],pch=19,cex=3,ylab="Alpha",xlab="Beta",cex.lab=2,cex.axis=2,main="Variation in DFE parameter estimates\n in the UK10K dataset")
text(slot(h,"ycm"),slot(h,"xcm"),slot(h,"count"),col="red",cex=1)
# beanplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.axis=1.3,cex.lab=2,cex.main=1.2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
boxplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.lab=2,cex.axis=2)
dev.off()

####### DFE selection bootstrap single s ########

DFESelectionSingleS <- read.table("ResultsSelectionInferred/SelectionUK10KBootstrap.txt")

quantile(DFESelectionSingleS$V1,prob=seq(from = 0.0,to = 1, by =0.05))
pdf("PotentialPaperFigures/BootstrapBeanplot.pdf")
beanplot(DFESelectionSingleS$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="Data",main="C) Bootstrap",cex.axis=1.3,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=0,lty=3)
dev.off()

###### DFE Real Data ######

SelectionDFERow <- floor(549 / 50 )
SelectionDFEColumn <- (549 %% 50 )

SelectionDFERow <- ( SelectionDFERow + 1) * 0.01
SelectionDFEColumn <- ( SelectionDFEColumn + 1) * 5

