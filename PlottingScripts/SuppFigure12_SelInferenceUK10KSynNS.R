setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)


SelectionNS <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KBootstrap.txt")
SelectionSyn <- read.table("../Results/ResultsSelectionInferred/SelectionSynUK10KBootstrap.txt")

Plot <- paste("../Figures/SuppFigure12_UK10KSelInferenceSynNS.pdf",sep="")

pdf(Plot,width=14)
par(mfrow=c(1,2),mar=c(5,5,4,2) + 0.1)

### ,mar=c(5,5,4,2) + 0.1

beanplot(SelectionNS$V1, SelectionSyn$V1, names=c("Non Syn","Syn"), ylab="Estimated 4Ns values", xlab="Type of Variants", main="Inference of Selection in the\nscaled UK10K model", cex.axis=1.25, cex.lab=2, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, overall=10000, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)

dev.off()
