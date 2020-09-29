library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(viridis)

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts")

DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("0", "50", "100", "-50", "-100")
FourNsLine <- c(0, 50, 100, 50, 100)
Magnitude <- c( "NotSoSmallMut", "FivePercentSmallMut", "FivePercentBigMut", "NotSoBigMut")
Titles <- c("Constant Population Size 4Ns = 0","Constant Population Size 4Ns = 50","Constant Population Size 4Ns = 100","Constant Population Size 4Ns = -50","Constant Population Size 4Ns = -100")

ViridisColors <- viridis(5)

for (i in 1:1){
    pdf ("../Figures/SuppFigure13_MutRecMisinferenceConstantPopSize.pdf", width = 35/1.5, height=21/1.5)
    par(mfrow = c(2,5))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)
        for (k in 1:2){

        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], FourNs[j], "_N10000.txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
        for (k in 3:4){
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot(abs(DataMatrix[,1] - 200) , abs(DataMatrix[,2] - 200 ), abs(DataMatrix[,3] - 200) , abs( DataMatrix[,4] - 200 ) , abs( DataMatrix[,5] - 200 ), ylab = "| 4Ns |", names = c("9e-9","1.14e-8","1.2e-8","1.26e-8","1.5e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), xlab = expression("Per base mutation rate " * mu * " used in simulations"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" , cex.lab = 1.5 , cex.axis = 1.25)
        abline(h=FourNsLine[j], lty = 2, cex.axis = 2)
}
}

Magnitude <- c( "NotSoSmallRec", "FivePercentSmallRec", "FivePercentBigRec", "NotSoBigRec")
Titles <- c("Constant Population Size 4Ns = 0","Constant Population Size 4Ns = 50","Constant Population Size 4Ns = 100","Constant Population Size 4Ns = -50","Constant Population Size 4Ns = -100")

for (i in 1:1){
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)
        for (k in 1:2){

        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], FourNs[j], "_N10000.txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
        for (k in 3:4){
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot(abs(DataMatrix[,1] - 200) , abs(DataMatrix[,2] - 200 ), abs(DataMatrix[,3] - 200) , abs( DataMatrix[,4] - 200 ) , abs( DataMatrix[,5] - 200 ), ylab = "| 4Ns |", names = c("7.5e-9","9.5e-9","1.0e-8","1.05e-8","1.25e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), xlab = expression("Per base recombination rate " * rho * " used in simulations"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" , cex.lab = 1.5 , cex.axis = 1.25)
        abline(h=FourNsLine[j], lty = 2, cex.axis = 2)
}
}

dev.off()


########################################################################################




DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("0", "50", "100", "-50", "-100")
FourNsLine <- c(0, 50, 100, -50, -100)
Magnitude <- c( "NotSoSmallMut", "FivePercentSmallMut", "FivePercentBigMut", "NotSoBigMut")
Titles <- c("Population expansion 4Ns = 0","Population expansion 4Ns = 50","Population expansion 4Ns = 100","Population expansion 4Ns = -50","Population expansion 4Ns = -100")

ViridisColors <- viridis(5)

for (i in 2:2){
    pdf ("../Figures/SuppFigure14_MutRecMisinferencePopExpansion.pdf", width = 35/1.5, height=21/1.5)
    par(mfrow = c(2,5))
    par(mar = c(5, 6, 5, 1))
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)
        for (k in 1:2){

        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], FourNs[j], "_N10000.txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
        for (k in 3:4){
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot((DataMatrix[,1] - 200) , (DataMatrix[,2] - 200 ), (DataMatrix[,3] - 200) , ( DataMatrix[,4] - 200 ) , ( DataMatrix[,5] - 200 ), ylab = "4Ns", names = c("9e-9","1.14e-8","1.2e-8","1.26e-8","1.5e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), xlab = expression("Per base mutation rate " * mu * " used in simulations"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" , cex.lab = 1.5 , cex.axis = 1.25)
        abline(h=FourNsLine[j], lty = 2, cex.axis = 2)
}
}

Magnitude <- c( "NotSoSmallRec", "FivePercentSmallRec", "FivePercentBigRec", "NotSoBigRec")
Titles <- c("Population expansion 4Ns = 0","Population expansion 4Ns = 50","Population expansion 4Ns = 100","Population expansion 4Ns = -50","Population expansion 4Ns = -100")

for (i in 2:2){
        for (j in 1:5){
            DataMatrix <- matrix(,nrow= 100, ncol = 5)
        for (k in 1:2){

        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k] <- Data$V1[l]
            }
        }
        Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], FourNs[j], "_N10000.txt", sep = "")
        Data <- read.table(Title)
        for (l in 1:100){
            DataMatrix[l,3] <- Data$V1[l]
        }
        for (k in 3:4){
            Title <- paste("../Results/ResultsSelectionInferred/Selection", DemographicScenarios[i], Magnitude[k], FourNs[j], "_N10000.txt", sep = "")
            Data <- read.table(Title)
            for (l in 1:100){
                DataMatrix[l,k+1] <- Data$V1[l]
            }
        }
        beanplot((DataMatrix[,1] - 200) , (DataMatrix[,2] - 200 ), (DataMatrix[,3] - 200) , ( DataMatrix[,4] - 200 ) , ( DataMatrix[,5] - 200 ), ylab = "4Ns", names = c("7.5e-9","9.5e-9","1.0e-8","1.05e-8","1.25e-8"), cex.names = 0.1, main = Titles[j], cex.main = 2 ,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), xlab = expression("Per base recombination rate " * rho * " used in simulations"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0" , cex.lab = 1.5 , cex.axis = 1.25)
        abline(h=FourNsLine[j], lty = 2, cex.axis = 2)
}
}

dev.off()


