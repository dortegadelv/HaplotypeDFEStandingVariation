############# Plot Boyko plus positive selection

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoPositiveMLE.txt")

Sel <- MLE$V1 %% 3

hist(Sel)

AllMLEs <- round(MLE / 3,0)

Row <- ( AllMLEs$V1 ) %% 30 + 1
Column <- floor(( AllMLEs$V1 ) / 30) + 1

pdf("../Figures/SuppFigure5_PopExpansionPosPlusNegSelection.pdf")
par(mfrow = c(2,2))

plot(Row*30,Column*.02, xlim=c(0,450), ylim=c(0,0.3), xlab="Shape", ylab="Scale", main="A) Pop Expansion \nDeleterious variation DFE parameters", cex.lab=1.35,cex.main=1.2,pch=19)
points(29.1767603378041,0.190915110603425,col="red",pch=19,lwd=3)
lines(1:450,5.570284/1:450,lty="dashed",lwd=2,col="red")

boxplot(-2*Row*30*Column*.02,main="B) Pop Expansion\nDeleterious variation mean 4Ns value",ylab="Mean 4Ns value",cex.lab=1.5)
points(1,-2*2.926423e+01*0.1906465,col="red",pch=19)

Sel <- MLE$V1 %% 3
par(mar = c(5,5,4,3))

hist(Sel,main="C) Pop Expansion\nProportion of positive selection variants",axes=FALSE,xlab="Proportion of variants under positive selection",ylab="Number of times a certain proportion of\n variants under positive selection were inferred")
axis(2,)
axis(1,at=c(0.1,0.9,1.9),labels=c("0%","5%","10%"))
dev.off()


