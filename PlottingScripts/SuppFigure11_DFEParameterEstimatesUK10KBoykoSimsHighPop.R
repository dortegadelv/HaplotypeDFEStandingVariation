setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

####### DFE selection bootstrap ########

DFESelection <- read.table("../Results/ResultsSelectionInferred/SelectionLargerSpaceHighPopUK10KDFETestHighPop.txt")

AllRows <- c()
AllColumns <- c()

for (i in 1:length(DFESelection$V1)){
    if (DFESelection$V1[i] == 0){
        
        SelectionDFERow <- ((DFESelection$V2[i] %% 52 ) + 1) * 5
        SelectionDFEColumn <- (floor(DFESelection$V2[i] / 52 ) + 1) *.01
        AllColumns <- c(AllColumns, SelectionDFEColumn)
#        print (SelectionDFERow)
        if (SelectionDFERow == 5){
            AllRows <- c(AllRows,-55)

        }
        if (SelectionDFERow == 10){
            AllRows <- c(AllRows,-20)
            SelectionDFERow = -10
        }
        if (SelectionDFERow >= 15){
            SelectionDFERow = SelectionDFERow + 250 - 10
            AllRows <- c(AllRows,SelectionDFERow)
        }
        
    }else{
    
    SelectionDFERow <- ((DFESelection$V2[i] %% 50 ) + 1) * 5
    SelectionDFEColumn <- (floor(DFESelection$V2[i] / 50 ) + 1) *.01
    AllColumns <- c(AllColumns, SelectionDFEColumn)
    
    AllRows <- c(AllRows, SelectionDFERow)
    print (SelectionDFERow)
    
    }
}


Plot <- paste("../Figures/SuppFigure11_DFEParameterEstimatesUK10KBoykoDFE.pdf",sep="")
pdf(Plot,width=10)
library(hexbin)
par(mfrow=c(1,1))
par(mar=c(5,5,4,2) + 0.1)
# Create hexbin object and plot
df <- data.frame(AllColumns,AllRows)
colnames(df) <- c("Scale","Shape")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
h <- hexbin(df, xbins = 301,IDs=TRUE)
#slot(h,"ybnds")[2] <- 2005
#slot(h,"xbnds")[2] <- 3005
#plot(h)
#plot(h, colramp=rf)
ColorViridis <- viridis(23)
plot(slot(h,"ycm"),slot(h,"xcm"),col= ColorViridis[23],pch=19,cex=3,ylab="Scale",xlab="Shape",cex.lab=2,cex.axis=2,main="Variation in DFE parameter estimates in simulations\n under the UK10K model and the Boyko DFE",xaxt="n")
text(slot(h,"ycm"),slot(h,"xcm"),slot(h,"count"),col="red",cex=1)
# abline(v=-60, lty = 2)
abline(v=-55, lty = 2)
abline(v=-20, lty = 2)
abline(v=5, lty = 2)
abline(v=250, lty = 2)
axis(1, at=c(-55, -20, 5, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500), labels = c("0.03", "3", "30", "300", "600", "900", "1200", "1500", "15000", "30000", "45000", "60000", "75000"), cex.axis = 1.2)
# beanplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.axis=1.3,cex.lab=2,cex.main=1.2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
# boxplot(-SelectionDFEColumn$V1*SelectionDFERow$V1,names=c("Data"),ylab="Estimated 4Ns values",xlab="",main="Variation in the estimated 4Ns values\n in the UK10K dataset",cex.lab=2,cex.axis=2)
dev.off()

