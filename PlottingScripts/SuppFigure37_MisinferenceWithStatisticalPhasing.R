library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

DemographicScenarios <- c("UK10K","UK10K")
FourNs <- c("4Ns_0", "4Ns_25", "4Ns_50", "4Ns_-25", "4Ns_-50")
DemographicScenariosTitle <- c("UK10K")
FourNsTitle  <- c("4Ns = 0", "4Ns = 25", "4Ns = 50", "4Ns = -25", "4Ns = -50")

Medians <- c()

pdf ("../Figures/SuppFigure37_MisinferenceWithStatisticalPhasingUK10K.pdf", width = 8)
par(mfrow = c(1,1))
par(mar = c(4, 5, 5, 2))
    BiasedEstimators <- c()
    UnbiasedEstimators <- c()
    for (j in 1:5){
    File <- paste("../Results/ResultsSelectionInferred/SelectionUK10KLessStatPhasing",FourNs[j],"_N10000.txt", sep = "")
    FileTwo <- paste("../Results/ResultsSelectionInferred/SelectionUK10KPhasing",FourNs[j],"_N10000.txt", sep = "")

BiasedInference <- read.table(File)
UnbiasedInference <- read.table(FileTwo)
BiasedEstimators <- c(BiasedEstimators, BiasedInference$V1)
UnbiasedEstimators <- c(UnbiasedEstimators, UnbiasedInference$V1)
    }
    
    boxplot( BiasedEstimators[1:100]  - UnbiasedEstimators[1:100], BiasedEstimators[101:200]  - UnbiasedEstimators[101:200], BiasedEstimators[201:300] - UnbiasedEstimators[201:300], BiasedEstimators[301:400]  - UnbiasedEstimators[301:400], BiasedEstimators[401:500] - UnbiasedEstimators[401:500] , ylim = c(-400,400), xlab = "4Ns", ylab = "Estimated 4Ns on statistically phased data - Estimated 4Ns on haplotype data", main = "UK10K", names = c(0, 25, 50, -25, -50) )

abline (h= 0 , lty=2)

dev.off()
