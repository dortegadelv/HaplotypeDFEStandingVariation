setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

pdf("../Figures/SuppFigure4_MeanDFEMouseHuman2DemScenarios.pdf")
par(mfrow = c(2,2))
par(mar=c(2.1,5.1,4.1,1.1))
MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

boxplot(-2*Row*5*Column*.01,main="Constant Boyko",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-50,0))
points(1,-2*5.028910e+01*0.1851583,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

boxplot(-2*Row*5*Column*.01,main="Constant Mouse",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-50,0))
points(1,-2*5.115042e+01*0.1097575,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

boxplot(-2*Row*5*Column*.01,main="Pop expansion Boyko",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,0))
points(1,-2*2.926423e+01*0.1906465,col="red",pch=19)

MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

boxplot(-2*Row*5*Column*.01,main="Pop expansion Mouse",ylab="Mean 4Ns value",cex.lab=1.5,ylim=c(-100,0))
points(1,-2*3.100203e+01*0.1123318,col="red",pch=19)

dev.off()
