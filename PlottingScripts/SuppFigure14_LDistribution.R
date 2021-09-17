library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)


DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("4Ns_0", "4Ns_50", "4Ns_100", "4Ns_-50", "4Ns_-100")
DemographicScenariosTitle <- c("Constant Population Size","Population Expansion")
FourNsTitle  <- c("4Ns = 0", "4Ns = 50", "4Ns = 100", "4Ns = -50", "4Ns = -100")

Medians <- c()


pdf ("../Figures/SuppFigure14_PhasingEffectOnL.pdf", height = 10)
par(mfrow = c(5,2))
par(mar = c(4, 7, 5, 2))
for (j in 1:5){
    for (i in 1:2){
    File <- paste("../Results/PhaseLDistribution/LDistributionStatPhased",DemographicScenarios[i],"_",FourNs[j],".txt", sep = "")
LDataFile <- read.table(File)
Title <- paste (DemographicScenariosTitle[i]," ",FourNsTitle[j] , sep = "")
Medians <- c(Medians,median((LDataFile$V7 - LDataFile$V1)/1560),median((LDataFile$V8 - LDataFile$V2)/1560), median((LDataFile$V9 - LDataFile$V3)/1560), median((LDataFile$V10 - LDataFile$V4)/1560), median((LDataFile$V11 - LDataFile$V5)/1560), median((LDataFile$V12 - LDataFile$V6)/1560))

CurrentMedians <- c(median((LDataFile$V7 - LDataFile$V1)/1560),median((LDataFile$V8 - LDataFile$V2)/1560), median((LDataFile$V9 - LDataFile$V3)/1560), median((LDataFile$V10 - LDataFile$V4)/1560), median((LDataFile$V11 - LDataFile$V5)/1560), median((LDataFile$V12 - LDataFile$V6)/1560))

boxplot((LDataFile$V7 - LDataFile$V1)/1560, (LDataFile$V8 - LDataFile$V2)/1560, (LDataFile$V9 - LDataFile$V3)/1560, (LDataFile$V10 - LDataFile$V4)/1560, (LDataFile$V11 - LDataFile$V5)/1560, (LDataFile$V12 - LDataFile$V6)/1560, xaxt = "n",ylab = expression(atop("Mean(P(Real " * L %in% w[i] * ") -", "P(Statistically Phased " * L %in% w[i] * ")")) , xlab = "L", cex.lab = 1.0, ylim = c(-0.1,0.12), main = Title)
## expression("Mean(P(Real L " * %in% * "wi) - P(Statistically Phased L " * %in% * "wi")
CurrentMedians <- round(CurrentMedians,3)
text(1,0.1,labels=CurrentMedians[1])
text(2,0.1,labels=CurrentMedians[2])
text(3,0.1,labels=CurrentMedians[3])
text(4,0.1,labels=CurrentMedians[4])
text(5,0.1,labels=CurrentMedians[5])
text(6,0.1,labels=CurrentMedians[6])

abline(h=0.0, lty = 2)
axis(1, at=c(1, 2, 3, 4, 5, 6), labels=c(expression(w[1]), expression(w[2]), expression(w[3]), expression(w[4]), expression(w[5]), expression(w[6])))
}
}

dev.off()
