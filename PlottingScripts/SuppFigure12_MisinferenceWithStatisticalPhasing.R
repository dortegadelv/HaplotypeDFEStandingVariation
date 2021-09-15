library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("0", "50", "100", "-50", "-100")
DemographicScenariosTitle <- c("Constant Population Size","Population Expansion")
FourNsTitle  <- c("4Ns = 0", "4Ns = 50", "4Ns = 100", "4Ns = -50", "4Ns = -100")

Medians <- c()

pdf ("../Figures/SuppFigure12_MisinferenceWithStatisticalPhasing.pdf", width = 8)
par(mfrow = c(1,2))
par(mar = c(4, 5, 5, 2))
    BiasedEstimators <- c()
    UnbiasedEstimators <- c()
    for (j in 1:5){
    File <- paste("../Results/ResultsSelectionInferred/Selection",DemographicScenarios[1],"LessStatPhasing",FourNs[j],"_N10000.txt", sep = "")
    FileTwo <- paste("../Results/ResultsSelectionInferred/Selection",DemographicScenarios[1],"Phasing",FourNs[j],"_N10000.txt", sep = "")

BiasedInference <- read.table(File)
UnbiasedInference <- read.table(FileTwo)
BiasedEstimators <- c(BiasedEstimators, BiasedInference$V1)
UnbiasedEstimators <- c(UnbiasedEstimators, UnbiasedInference$V1)
    }
    
    boxplot( abs(BiasedEstimators[1:100] - 200) - abs(UnbiasedEstimators[1:100]- 200), abs(BiasedEstimators[101:200] - 200) - abs(UnbiasedEstimators[101:200] - 200) , abs(BiasedEstimators[201:300] - 200) - abs(UnbiasedEstimators[201:300] - 200), abs(BiasedEstimators[301:400] - 200) - abs(UnbiasedEstimators[301:400] - 200), abs(BiasedEstimators[401:500] - 200) - abs(UnbiasedEstimators[401:500] - 200) , ylim = c(-400,400), xlab = "4Ns", ylab = "| Estimated 4Ns on statistically phased data | - | Estimated 4Ns on haplotype data |", main = "Constant population size", names = c(0, 50, 100, -50, 100) )

abline (h= 0 , lty=2)

    BiasedEstimators <- c()
    UnbiasedEstimators <- c()
    for (j in 1:5){
    File <- paste("../Results/ResultsSelectionInferred/Selection",DemographicScenarios[2],"LessStatPhasing",FourNs[j],"_N10000.txt", sep = "")
    FileTwo <- paste("../Results/ResultsSelectionInferred/Selection",DemographicScenarios[2],"Phasing",FourNs[j],"_N10000.txt", sep = "")

BiasedInference <- read.table(File)
UnbiasedInference <- read.table(FileTwo)
BiasedEstimators <- c(BiasedEstimators, BiasedInference$V1)
UnbiasedEstimators <- c(UnbiasedEstimators, UnbiasedInference$V1)
    }
    
    boxplot( BiasedEstimators[1:100] - UnbiasedEstimators[1:100], BiasedEstimators[101:200] - UnbiasedEstimators[101:200] , BiasedEstimators[201:300] - UnbiasedEstimators[201:300] , BiasedEstimators[301:400] - UnbiasedEstimators[301:400] , BiasedEstimators[401:500] - UnbiasedEstimators[401:500] , ylim = c(-400,400), xlab = "4Ns", ylab = "Estimated 4Ns on statistically phased data - Estimated 4Ns on haplotype data", main = "Population expansion", names = c(0, 50, 100, -50, 100))

abline (h= 0 , lty=2)

dev.off()
