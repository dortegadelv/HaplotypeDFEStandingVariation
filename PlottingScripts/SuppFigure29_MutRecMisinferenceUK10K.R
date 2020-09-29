library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(viridis)

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts")

DemographicScenarios <- c("UK10K")
FourNs <- c("0", "-25", "-50")
FourNsLine <- c(0, -25, -50)
Magnitude <- c( "10", "12")
Titles <- c("UK10K 4Ns = 0\nActual recombination rate = 5 X 7.49e-9","UK10K 4Ns = -25\nActual recombination rate = 5 X 7.49e-9","UK10K 4Ns = -50\nActual recombination rate = 5 X 7.49e-9")

ViridisColors <- viridis(5)

for (i in 1:1){
    pdf ("../Figures/SuppFigure29_MutRecMisinferenceUK10K.pdf", width = 35/1.5, height=21/1.5)
    par(mfrow = c(2,3))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:3){
            DataMatrix <- matrix(,nrow= 50, ncol = 5)
        for (k in 1:1){

        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k],"SmallRec" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:50){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i],"11","SmallRec", FourNs[j], ".txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:50){
            DataMatrix[l,2] <- Data$V1[l]
        }
        for (k in 2:2){
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k],"SmallRec", FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:50){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot(DataMatrix[,1] , DataMatrix[,2], DataMatrix[,3], ylab = "4Ns", cex.lab = 2, cex.axis = 1.3, ylim = c(-75, 75), xlab = "Recombination rate used", names = c("5 X 7.22e-9","5 X 7.49e-9","5 X 9.95e-9"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" )
        abline(h=FourNsLine[j], lty = 2)
}
}

dev.off()

Titles <- c("UK10K 4Ns = 0\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = -25\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = -50\nActual mutation rate = 5 X 1.5e-8")

for (i in 1:1){
    pdf ("../Figures/SuppFigure29_MutMisinferenceUK10K.pdf", width = 35/1.5, height=21/1.5)
    par(mfrow = c(2,3))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:3){
            DataMatrix <- matrix(,nrow= 50, ncol = 5)
        for (k in 1:1){

        Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K0SmallRecLowMut_" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:50){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K11SmallRec", FourNs[j], ".txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:50){
            DataMatrix[l,2] <- Data$V1[l]
        }
        for (k in 2:2){
            Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K1SmallRecHighMut_" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:50){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot(DataMatrix[,1] , DataMatrix[,2], DataMatrix[,3], ylab = "4Ns", cex.lab = 2, cex.axis = 1.3, ylim = c(-75, 75), xlab = "Mutation rate used", names = c("5 X 1.43e-8","5 X 1.5e-8","5 X 1.58e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" )
        abline(h=FourNsLine[j], lty = 2)
}
}

dev.off()

