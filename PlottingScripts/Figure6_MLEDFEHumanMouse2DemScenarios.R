setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

pdf("../Figures/Figure6_MLEDFEHumanMouse2DemScenarios.pdf",width=7*2,height=7*2/4)
par(mfrow = c(1,4),mar=c(5,5,4,2))

MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab="Shape",ylab="Scale",main="A) Constant size\nHuman DFE",cex.lab=2,cex.main=2,cex.axis=2)
points(50.454203927295,0.184753036884482,col="red",pch=19,lwd=3)
lines(1:350,9.321567/1:350,lty="dashed",lwd=2,col="red")
MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab="Shape",ylab="Scale",main="B) Constant size\nMouse DFE",cex.lab=2,cex.main=2,cex.axis=2)
points(50.8608219789938,0.109621224838877,col="red",pch=19,lwd=3)
lines(1:350,5.575426/1:350,lty="dashed",lwd=2,col="red")
MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab="Shape",ylab="Scale",main="C) Population expansion\nHuman DFE",cex.lab=2,cex.main=2,cex.axis=2)
points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
lines(1:350,5.570284/1:350,lty="dashed",lwd=2,col="red")

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

plot(Row*5,Column*.01,xlim=c(0,350),ylim=c(0,0.3),xlab="Shape",ylab="Scale",main="D) Population expansion\nMouse DFE",cex.lab=2,cex.main=2,cex.axis=2)
points(30.9631108230993,0.112475018218557,col="red",pch=19,lwd=3)
lines(1:350,3.482576/1:350,lty="dashed",lwd=2,col="red")

dev.off()
