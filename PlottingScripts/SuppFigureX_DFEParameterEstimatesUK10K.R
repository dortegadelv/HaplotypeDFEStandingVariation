setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

####### DFE selection bootstrap ########

DFESelection <- read.table("../Results/ResultsSelectionInferred/SelectionDFEUK10KBootstrap.txt")

SelectionDFERow <- ((DFESelection %% 52 ) + 1) * 5
SelectionDFEColumn <- (floor(DFESelection / 52 ) + 1) *.01

# for (i in 1:length(SelectionDFERow$V1)){
#    if (SelectionDFERow$V1[i] == 5){
#        SelectionDFERow$V1[i] = -60
#    }
#   }

for (i in 1:length(SelectionDFERow$V1)){
    if (SelectionDFERow$V1[i] == 5){
        SelectionDFERow$V1[i] = -35
    }
}

for (i in 1:length(SelectionDFERow$V1)){
    if (SelectionDFERow$V1[i] == 10){
        SelectionDFERow$V1[i] = -10
    }
}



Plot <- paste("../Figures/SuppFigure9_DFEParameterEstimatesUK10K.pdf",sep="")
pdf(Plot,width=10)
library(hexbin)
par(mfrow=c(1,1))
par(mar=c(5,5,4,2) + 0.1)
# Create hexbin object and plot
df <- data.frame(SelectionDFEColumn$V1,SelectionDFERow$V1)
colnames(df) <- c("Scale","Shape")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
h <- hexbin(df, xbins = 301,IDs=TRUE)
#slot(h,"ybnds")[2] <- 2005
#slot(h,"xbnds")[2] <- 3005
#plot(h)
#plot(h, colramp=rf)
ColorViridis <- viridis(23)
plot(slot(h,"ycm"),slot(h,"xcm"),col= ColorViridis[23],pch=19,cex=3,ylab="Scale",xlab="Shape",cex.lab=2,cex.axis=2,main="Variation in DFE parameter estimates\n in the UK10K dataset",xaxt="n")
text(slot(h,"ycm"),slot(h,"xcm"),slot(h,"count"),col="red",cex=1)
abline(v=-60, lty = 2)
abline(v=-35, lty = 2)
abline(v=-10, lty = 2)
abline(v=20, lty = 2)
axis(1, at=c(-60, -35, -10, 20, 70, 120, 170, 220, 260), labels = c("0.003", "0.03", "3", "1500", "16500", "31500", "46500", "61500", "75000"), cex.axis = 1.2)
# beanplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.axis=1.3,cex.lab=2,cex.main=1.2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
# boxplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.lab=2,cex.axis=2)
dev.off()

