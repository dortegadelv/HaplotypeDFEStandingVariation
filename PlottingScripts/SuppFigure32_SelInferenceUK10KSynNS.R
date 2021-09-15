library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)


SelectionNS <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KBootstrap.txt")
SelectionSyn <- read.table("../Results/ResultsSelectionInferred/SelectionSynUK10KBootstrap.txt")

Plot <- paste("../Figures/SuppFigure32_UK10KSelInferenceSynNS.pdf",sep="")

pdf(Plot,width=14)
par(mfrow=c(1,2),mar=c(5,5,4,2) + 0.1)

### ,mar=c(5,5,4,2) + 0.1

beanplot(SelectionNS$V1, SelectionSyn$V1, names=c("Non Syn","Syn"), ylab="Estimated 4Ns values", xlab="Type of Variants", bw = "nrd0", main="Inference of Selection in the\nUK10K data", cex.axis=1.25, cex.lab=2, cex.main=1.5, col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", maxstripline=0.15, beanlinewd=0.5, what=c(FALSE,TRUE,TRUE,TRUE), overallline = "median", ll=0.5)

dev.off()
