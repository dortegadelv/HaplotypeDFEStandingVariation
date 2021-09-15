library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

pdf ("../Figures/SuppFigureSX11_ABCDemModelComparison.pdf")

LDataFile <- read.table("../Results/ComparisonUK10K_ABC/OneHundredSimsUnderInferredDemModel.txt")

boxplot(LDataFile$V1, LDataFile$V2, LDataFile$V3, LDataFile$V4, LDataFile$V5, LDataFile$V6,ylab = "Probability" , xlab = "L", cex.lab = 1.0, ylim = c(0.0,0.45), main = "Comparison between the demographic model inferred with ABC \nand the data on synonymous sites in the UK10K dataset", names = c(expression(w[1]), expression(w[2]),expression(w[3]),expression(w[4]),expression(w[5]),expression(w[6])))

LDataPoints <- read.table("../Results/ComparisonUK10K_ABC/LDistributionOnePercentSynSites_NotCpG.txt")

points(c(1,2,3,4,5,6),LDataPoints, col = "red", pch = 19)

dev.off()
