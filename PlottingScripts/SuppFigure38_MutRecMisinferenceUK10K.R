library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(viridis)

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

DemographicScenarios <- c("UK10K")
FourNs <- c("0", "-25", "-50", "25", "50")
FourNsLine <- c(0, -25, -50, 25, 50)
Magnitude <- c( "10", "12")
Titles <- c("UK10K 4Ns = 0\nActual recombination rate = 5 X 8.25e-9","UK10K 4Ns = -25\nActual recombination rate = 5 X 8.25e-9","UK10K 4Ns = -50\nActual recombination rate = 5 X 8.25e-9","UK10K 4Ns = 25\nActual recombination rate = 5 X 8.25e-9","UK10K 4Ns = 50\nActual recombination rate = 5 X 8.25e-9")

ViridisColors <- viridis(5)

for (i in 1:1){
    pdf ("../Figures/SuppFigure38_MutRecMisinferenceUK10K.pdf", width = 45/1.5, height=21/3)
    par(mfrow = c(1,5))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)

            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], "9","SmallRec" , FourNs[j], ".txt", sep = "")
                Data <- read.table(Title)
                for (l in 1:100){
                    DataMatrix[l,1] <- Data$V1[l]
                }
                
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], "10","SmallRec" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,2] <- Data$V1[l]
            }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i],"11","SmallRec", FourNs[j], ".txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i],"12","SmallRec", FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,4] <- Data$V1[l]
            }
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i],"13","SmallRec", FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,5] <- Data$V1[l]
            }
        beanplot(DataMatrix[,1] , DataMatrix[,2], DataMatrix[,3], DataMatrix[,4], DataMatrix[,5], ylab = "4Ns", cex.lab = 2, cex.axis = 1.3, ylim = c(-95, 95), xlab = "Recombination rate used", names = c("5 X 6.11e-9","5 X 7.01e-9","5 X 8.25e-9","5 X 9.67e-9","1.12e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" )
        abline(h=FourNsLine[j], lty = 2)
}
}

dev.off()

Titles <- c("UK10K 4Ns = 0\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = -25\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = -50\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = 25\nActual mutation rate = 5 X 1.5e-8","UK10K 4Ns = 50\nActual mutation rate = 5 X 1.5e-8")

    pdf ("../Figures/SuppFigure29_MutMisinferenceUK10K.pdf", width = 45/1.5, height=21/3)
    par(mfrow = c(1,5))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)

            Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K2SmallRecLowerMut_" , FourNs[j], ".txt", sep = "")
                Data <- read.table(Title)
                for (l in 1:100){
                    DataMatrix[l,1] <- Data$V1[l]
                }
            
        Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K0SmallRecLowMut_" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,2] <- Data$V1[l]
            }
        
        Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K11SmallRec", FourNs[j], ".txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
        
            Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K1SmallRecHighMut_" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,4] <- Data$V1[l]
            }
            Title <- paste("../Results/ResultsSelectionInferred/SelectionUK10K3SmallRecHigherMut_" , FourNs[j], ".txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,5] <- Data$V1[l]
            }
    
        beanplot(DataMatrix[,1] , DataMatrix[,2], DataMatrix[,3], DataMatrix[,4], DataMatrix[,5], ylab = "4Ns", cex.lab = 2, cex.axis = 1.3, ylim = c(-95, 95), xlab = "Mutation rate used", names = c("5 X 1.35e-8","5 X 1.425e-8","5 X 1.5e-8","5 X 1.575e-8","5 X 1.65e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" )
        abline(h=FourNsLine[j], lty = 2)
}


dev.off()

