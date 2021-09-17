library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(reshape2)
library(gridBase)
library(grid)
library(ggplot2)

##########

Plot <- paste("../Figures/SuppFigure19_BothSidesPart1.pdf",sep="")

pdf(Plot, width = 7*3, height = 7*1)
par(mfrow=c(1,3), mar=c(5,5,5,3) + 0.1)

### Figure 3

Selection4Ns_0_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize0_N10000.txt")
Selection4Ns_50_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize50_N10000.txt")
Selection4Ns_100_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize100_N10000.txt")
Selection4Ns_Minus50_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-50_N10000.txt")
Selection4Ns_Minus100_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSize-100_N10000.txt")

Selection4Ns_0_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeMoreSims0_N10000.txt")
Selection4Ns_50_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeMoreSims50_N10000.txt")
Selection4Ns_100_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeMoreSims100_N10000.txt")
Selection4Ns_Minus50_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeMoreSims-50_N10000.txt")
Selection4Ns_Minus100_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeMoreSims-100_N10000.txt")

Selection4Ns_0_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeBothSides0_N10000.txt")
Selection4Ns_50_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeBothSides50_N10000.txt")
Selection4Ns_100_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeBothSides100_N10000.txt")
Selection4Ns_Minus50_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeBothSides-50_N10000.txt")
Selection4Ns_Minus100_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionConstantPopSizeBothSides-100_N10000.txt")

note <- c(abs(Selection4Ns_0_5Windows$V1 - 200), abs(Selection4Ns_50_5Windows$V1 - 200), abs(Selection4Ns_100_5Windows$V1 - 200), abs(Selection4Ns_Minus50_5Windows$V1 - 200), abs(Selection4Ns_Minus100_5Windows$V1 - 200), abs(Selection4Ns_0_10Windows$V1 - 200), abs(Selection4Ns_50_10Windows$V1 - 200), abs(Selection4Ns_100_10Windows$V1 - 200), abs(Selection4Ns_Minus50_10Windows$V1 - 200), abs(Selection4Ns_Minus100_10Windows$V1 - 200), abs(Selection4Ns_0_50Windows$V1 - 200), abs(Selection4Ns_50_50Windows$V1 - 200), abs(Selection4Ns_100_50Windows$V1 - 200), abs(Selection4Ns_Minus50_50Windows$V1 - 200), abs(Selection4Ns_Minus100_50Windows$V1 - 200))

treatment <- c(rep("One side",500), rep("Double sims",500), rep("Both sides",500))
FourNs <- c(rep("0",100), rep("50",100), rep("100",100), rep("-50",100), rep("-100",100))
variety <- c(FourNs, FourNs, FourNs)

data=data.frame(variety, treatment ,  note)

data$variety <- factor(data$variety, levels = c('0','-50','50','-100','100'),ordered = TRUE)
data$treatment <- factor(data$treatment, levels = c('One side','Double sims','Both sides'),ordered = TRUE)

plot.new()              ## suggested by @Josh
vps <- baseViewports()
pushViewport(vps$figure) ##   I am in the space of the autocorrelation plot
vp1 <-plotViewport(c(1.8,1,0,1)) ## create new vp with margins, you play with this values

p <- ggplot(data, aes(x=variety, y=note, fill=treatment)) + geom_boxplot() + xlab("Real 4Ns values") + ylab("Estimated |4Ns| values") + scale_fill_discrete(name = "Adjacent regions taken") + ggtitle("Estimates of selection in a Constant Population Size model")
print(p,vp = vp1)

RMSE_4Ns0_5 <- (sum(((Selection4Ns_0_5Windows$V1-200)^2)/100))^(1/2)
RMSE_4Ns0_10 <- (sum(((Selection4Ns_0_10Windows$V1-200)^2)/100))^(1/2)
RMSE_4Ns0_50 <- (sum(((Selection4Ns_0_50Windows$V1-200)^2)/100))^(1/2)

RMSE_4Ns50_5 <- (sum(((abs(Selection4Ns_50_5Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4Ns50_10 <- (sum(((abs(Selection4Ns_50_10Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4Ns50_50 <- (sum(((abs(Selection4Ns_50_50Windows$V1-200) - 50))^2)/100)^(1/2)

RMSE_4Ns100_5 <- (sum(((abs(Selection4Ns_100_5Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4Ns100_10 <- (sum(((abs(Selection4Ns_100_10Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4Ns100_50 <- (sum(((abs(Selection4Ns_100_50Windows$V1-200) - 100))^2)/100)^(1/2)

RMSE_4NsMinus50_5 <- (sum(((abs(Selection4Ns_Minus50_5Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4NsMinus50_10 <- (sum(((abs(Selection4Ns_Minus50_10Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4NsMinus50_50 <- (sum(((abs(Selection4Ns_Minus50_50Windows$V1-200) - 50))^2)/100)^(1/2)

RMSE_4NsMinus100_5 <- (sum(((abs(Selection4Ns_Minus100_5Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4NsMinus100_10 <- (sum(((abs(Selection4Ns_Minus100_10Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4NsMinus100_50 <- (sum(((abs(Selection4Ns_Minus100_50Windows$V1-200) - 100))^2)/100)^(1/2)

ViridisColors <- viridis(5)
plot(c(median(abs(Selection4Ns_0_5Windows$V1-200)),median(abs(Selection4Ns_0_10Windows$V1-200)),median(abs(Selection4Ns_0_50Windows$V1-200))), col = ViridisColors[1], xlab = "Adjacent regions taken", ylab = "Median |4Ns| estimate - Real |4Ns| value", cex.axis=2.2, cex.lab=2.5, cex.main=2.5, xaxt= "n", lwd = 6, ylim = c(-5,20), type = "b", pch = 19, cex = 3, main = "Constant Population Size model")
legend("top",legend = c(0, 50, 100, -50, -100),col=ViridisColors, pch=19, cex = 2, title = "4Ns", bty = "n")
# arrows(x0=1, y0=quantile(medqRMSE_4Ns0_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns0_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns0_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns0_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns0_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns0_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns0_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns0_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns0_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns0_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)

lines(c(median(abs(Selection4Ns_50_5Windows$V1-200)-50), median(abs(Selection4Ns_50_10Windows$V1-200)-50), median(abs(Selection4Ns_50_50Windows$V1-200)-50)), col = ViridisColors[2], lwd = 5, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4Ns50_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns50_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns50_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns50_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns50_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)

lines(c(median(abs(Selection4Ns_100_5Windows$V1-200)-100),median(abs(Selection4Ns_100_10Windows$V1-200)-100),median(abs(Selection4Ns_100_50Windows$V1-200)-100)), col = ViridisColors[3], lwd = 4, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4Ns100_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns100_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns100_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns100_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns100_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)

lines(c(median(abs(Selection4Ns_Minus50_5Windows$V1-200)-50),median(abs(Selection4Ns_Minus50_10Windows$V1-200)-50),median(abs(Selection4Ns_Minus50_50Windows$V1-200)-50)), col = ViridisColors[4], lwd = 3, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4NsMinus50_3,0.05), x1=1, y1=quantile(medqRMSE_4NsMinus50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=2, y0=quantile(medqRMSE_4NsMinus50_5,0.05), x1=2, y1=quantile(medqRMSE_4NsMinus50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=3, y0=quantile(medqRMSE_4NsMinus50_10,0.05), x1=3, y1=quantile(medqRMSE_4NsMinus50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=4, y0=quantile(medqRMSE_4NsMinus50_50,0.05), x1=4, y1=quantile(medqRMSE_4NsMinus50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=5, y0=quantile(medqRMSE_4NsMinus50_100,0.05), x1=5, y1=quantile(medqRMSE_4NsMinus50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)

lines(c(median(abs(Selection4Ns_Minus100_5Windows$V1-200)-100),median(abs(Selection4Ns_Minus100_10Windows$V1-200)-100),median(abs(Selection4Ns_Minus100_50Windows$V1-200)-100)), col = ViridisColors[5], lwd = 2, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4NsMinus100_3,0.05), x1=1, y1=quantile(medqRMSE_4NsMinus100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=2, y0=quantile(medqRMSE_4NsMinus100_5,0.05), x1=2, y1=quantile(medqRMSE_4NsMinus100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=3, y0=quantile(medqRMSE_4NsMinus100_10,0.05), x1=3, y1=quantile(medqRMSE_4NsMinus100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=4, y0=quantile(medqRMSE_4NsMinus100_50,0.05), x1=4, y1=quantile(medqRMSE_4NsMinus100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=5, y0=quantile(medqRMSE_4NsMinus100_100,0.05), x1=5, y1=quantile(medqRMSE_4NsMinus100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)

axis(1, at=c(1, 2, 3), labels = c("One side", "Double sims", "Both sides"), cex.axis=2.2, cex.lab=2.5)


ViridisColors <- viridis(5)
plot(c(RMSE_4Ns0_5,RMSE_4Ns0_10,RMSE_4Ns0_50), col = ViridisColors[1], xlab = "Adjacent regions taken", ylab = "RMSE", cex.axis=2.2, cex.lab=2.5, cex.main=2.5, xaxt= "n", lwd = 6, ylim = c(10,50), type = "b", pch = 19, cex = 3, main = "Constant Population Size model")
legend("top",legend = c(0, 50, 100, -50, -100),col=ViridisColors, pch=19, cex = 2, title = "4Ns", bty = "n")

# arrows(x0=1, y0=quantile(qRMSE_4Ns0_3,0.05), x1=1, y1=quantile(qRMSE_4Ns0_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=2, y0=quantile(qRMSE_4Ns0_5,0.05), x1=2, y1=quantile(qRMSE_4Ns0_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=3, y0=quantile(qRMSE_4Ns0_10,0.05), x1=3, y1=quantile(qRMSE_4Ns0_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=4, y0=quantile(qRMSE_4Ns0_50,0.05), x1=4, y1=quantile(qRMSE_4Ns0_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=5, y0=quantile(qRMSE_4Ns0_100,0.05), x1=5, y1=quantile(qRMSE_4Ns0_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)

# lines(c(median(Selection4Ns_50_3Windows$V1-200),median(Selection4Ns_50_5Windows$V1-200),median(Selection4Ns_50_10Windows$V1-200),median(Selection4Ns_50_50Windows$V1-200),median(Selection4Ns_50_100Windows$V1-200)), col = ViridisColors[2])
lines(c(RMSE_4Ns50_5,RMSE_4Ns50_10,RMSE_4Ns50_50), col = ViridisColors[2], lwd = 5, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4Ns50_3,0.05), x1=1, y1=quantile(qRMSE_4Ns50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=2, y0=quantile(qRMSE_4Ns50_5,0.05), x1=2, y1=quantile(qRMSE_4Ns50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=3, y0=quantile(qRMSE_4Ns50_10,0.05), x1=3, y1=quantile(qRMSE_4Ns50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=4, y0=quantile(qRMSE_4Ns50_50,0.05), x1=4, y1=quantile(qRMSE_4Ns50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=5, y0=quantile(qRMSE_4Ns50_100,0.05), x1=5, y1=quantile(qRMSE_4Ns50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)

# lines(c(median(Selection4Ns_100_3Windows$V1-200),median(Selection4Ns_100_5Windows$V1-200),median(Selection4Ns_100_10Windows$V1-200),median(Selection4Ns_100_50Windows$V1-200),median(Selection4Ns_100_100Windows$V1-200), col = ViridisColors[3])
lines(c(RMSE_4Ns100_5,RMSE_4Ns100_10,RMSE_4Ns100_50), col = ViridisColors[3], lwd = 4, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4Ns100_3,0.05), x1=1, y1=quantile(qRMSE_4Ns100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=2, y0=quantile(qRMSE_4Ns100_5,0.05), x1=2, y1=quantile(qRMSE_4Ns100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=3, y0=quantile(qRMSE_4Ns100_10,0.05), x1=3, y1=quantile(qRMSE_4Ns100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=4, y0=quantile(qRMSE_4Ns100_50,0.05), x1=4, y1=quantile(qRMSE_4Ns100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=5, y0=quantile(qRMSE_4Ns100_100,0.05), x1=5, y1=quantile(qRMSE_4Ns100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)

# lines(c(median(Selection4NsMinus50_3Windows$V1-200),median(Selection4NsMinus50_5Windows$V1-200),median(Selection4NsMinus50_10Windows$V1-200),median(Selection4NsMinus50_50Windows$V1-200),median(Selection4NsMinus50_100Windows$V1-200), col = ViridisColors[4])
lines(c(RMSE_4NsMinus50_5,RMSE_4NsMinus50_10,RMSE_4NsMinus50_50), col = ViridisColors[4], lwd = 3, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4NsMinus50_3,0.05), x1=1, y1=quantile(qRMSE_4NsMinus50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=2, y0=quantile(qRMSE_4NsMinus50_5,0.05), x1=2, y1=quantile(qRMSE_4NsMinus50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=3, y0=quantile(qRMSE_4NsMinus50_10,0.05), x1=3, y1=quantile(qRMSE_4NsMinus50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=4, y0=quantile(qRMSE_4NsMinus50_50,0.05), x1=4, y1=quantile(qRMSE_4NsMinus50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=5, y0=quantile(qRMSE_4NsMinus50_100,0.05), x1=5, y1=quantile(qRMSE_4NsMinus50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)

# lines(c(median(Selection4NsMinus100_3Windows$V1-200),median(Selection4NsMinus100_5Windows$V1-200),median(Selection4NsMinus100_10Windows$V1-200),median(Selection4NsMinus100_50Windows$V1-200),median(Selection4NsMinus100_100Windows$V1-200), col = ViridisColors[5])
lines(c(RMSE_4NsMinus100_5,RMSE_4NsMinus100_10,RMSE_4NsMinus100_50), col = ViridisColors[5], lwd = 2, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4NsMinus100_3,0.05), x1=1, y1=quantile(qRMSE_4NsMinus100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
#arrows(x0=2, y0=quantile(qRMSE_4NsMinus100_5,0.05), x1=2, y1=quantile(qRMSE_4NsMinus100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=3, y0=quantile(qRMSE_4NsMinus100_10,0.05), x1=3, y1=quantile(qRMSE_4NsMinus100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5],  lwd=2)
# arrows(x0=4, y0=quantile(qRMSE_4NsMinus100_50,0.05), x1=4, y1=quantile(qRMSE_4NsMinus100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=5, y0=quantile(qRMSE_4NsMinus100_100,0.05), x1=5, y1=quantile(qRMSE_4NsMinus100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)

axis(1, at=c(1, 2, 3), labels = c("One side", "Double sims", "Both sides"), cex.axis=2.2, cex.lab=2.5)
# axis(2, at=c(1, 2, 3, 4, 5), labels = c(3, 5, 10, 50, 100))

dev.off()

## 4Ns = 0

###################################### Pop Expansion #######################################

Plot <- paste("../Figures/SuppFigure19_BothSidesPart2.pdf",sep="")

pdf(Plot, width = 7*3, height = 7*1)
par(mfrow=c(1,3), mar=c(5,5,5,3) + 0.1)

Selection4Ns_0_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion0_N10000.txt")
Selection4Ns_50_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion50_N10000.txt")
Selection4Ns_100_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion100_N10000.txt")
Selection4Ns_Minus50_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-50_N10000.txt")
Selection4Ns_Minus100_5Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansion-100_N10000.txt")

Selection4Ns_0_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionMoreSims0_N10000.txt")
Selection4Ns_50_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionMoreSims50_N10000.txt")
Selection4Ns_100_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionMoreSims100_N10000.txt")
Selection4Ns_Minus50_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionMoreSims-50_N10000.txt")
Selection4Ns_Minus100_10Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionMoreSims-100_N10000.txt")

Selection4Ns_0_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBothSides0_N10000.txt")
Selection4Ns_50_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBothSides50_N10000.txt")
Selection4Ns_100_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBothSides100_N10000.txt")
Selection4Ns_Minus50_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBothSides-50_N10000.txt")
Selection4Ns_Minus100_50Windows <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBothSides-100_N10000.txt")

note <- c((Selection4Ns_0_5Windows$V1 - 200), (Selection4Ns_50_5Windows$V1 - 200), (Selection4Ns_100_5Windows$V1 - 200), (Selection4Ns_Minus50_5Windows$V1 - 200), (Selection4Ns_Minus100_5Windows$V1 - 200), (Selection4Ns_0_10Windows$V1 - 200), (Selection4Ns_50_10Windows$V1 - 200), (Selection4Ns_100_10Windows$V1 - 200), (Selection4Ns_Minus50_10Windows$V1 - 200), (Selection4Ns_Minus100_10Windows$V1 - 200), (Selection4Ns_0_50Windows$V1 - 200), (Selection4Ns_50_50Windows$V1 - 200), (Selection4Ns_100_50Windows$V1 - 200), (Selection4Ns_Minus50_50Windows$V1 - 200), (Selection4Ns_Minus100_50Windows$V1 - 200))

treatment <- c(rep("One side",500), rep("Double sims",500), rep("Both sides",500))
FourNs <- c(rep("0",100), rep("50",100), rep("100",100), rep("-50",100), rep("-100",100))
variety <- c(FourNs, FourNs, FourNs)

data=data.frame(variety, treatment ,  note)

data$variety <- factor(data$variety, levels = c('0','-50','50','-100','100'),ordered = TRUE)
data$treatment <- factor(data$treatment, levels = c('One side','Double sims','Both sides'),ordered = TRUE)

plot.new()              ## suggested by @Josh
vps <- baseViewports()
pushViewport(vps$figure) ##   I am in the space of the autocorrelation plot
vp1 <-plotViewport(c(1.8,1,0,1)) ## create new vp with margins, you play with this values

p <- ggplot(data, aes(x=variety, y=note, fill=treatment)) + geom_boxplot() + xlab("Real 4Ns values") + ylab("Estimated |4Ns| values") + scale_fill_discrete(name = "Adjacent regions taken") + ggtitle("Estimates of selection in a Population Expansion model")
print(p,vp = vp1)

RMSE_4Ns0_5 <- (sum(((Selection4Ns_0_5Windows$V1-200)^2)/100))^(1/2)
RMSE_4Ns0_10 <- (sum(((Selection4Ns_0_10Windows$V1-200)^2)/100))^(1/2)
RMSE_4Ns0_50 <- (sum(((Selection4Ns_0_50Windows$V1-200)^2)/100))^(1/2)

RMSE_4Ns50_5 <- (sum((((Selection4Ns_50_5Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4Ns50_10 <- (sum((((Selection4Ns_50_10Windows$V1-200) - 50))^2)/100)^(1/2)
RMSE_4Ns50_50 <- (sum((((Selection4Ns_50_50Windows$V1-200) - 50))^2)/100)^(1/2)

RMSE_4Ns100_5 <- (sum((((Selection4Ns_100_5Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4Ns100_10 <- (sum((((Selection4Ns_100_10Windows$V1-200) - 100))^2)/100)^(1/2)
RMSE_4Ns100_50 <- (sum((((Selection4Ns_100_50Windows$V1-200) - 100))^2)/100)^(1/2)

RMSE_4NsMinus50_5 <- (sum((((Selection4Ns_Minus50_5Windows$V1-200) + 50))^2)/100)^(1/2)
RMSE_4NsMinus50_10 <- (sum((((Selection4Ns_Minus50_10Windows$V1-200) + 50))^2)/100)^(1/2)
RMSE_4NsMinus50_50 <- (sum((((Selection4Ns_Minus50_50Windows$V1-200) + 50))^2)/100)^(1/2)

RMSE_4NsMinus100_5 <- (sum((((Selection4Ns_Minus100_5Windows$V1-200) + 100))^2)/100)^(1/2)
RMSE_4NsMinus100_10 <- (sum((((Selection4Ns_Minus100_10Windows$V1-200) + 100))^2)/100)^(1/2)
RMSE_4NsMinus100_50 <- (sum((((Selection4Ns_Minus100_50Windows$V1-200) + 100))^2)/100)^(1/2)

ViridisColors <- viridis(5)
plot(c(median((Selection4Ns_0_5Windows$V1-200)),median((Selection4Ns_0_10Windows$V1-200)),median((Selection4Ns_0_50Windows$V1-200))), col = ViridisColors[1], xlab = "Adjacent regions taken", ylab = "Median 4Ns estimate - Real 4Ns value", cex.axis=2.2, cex.lab=2.5, cex.main=2.5, xaxt= "n", lwd = 6, ylim = c(-15,15), type = "b", pch = 19, cex = 3, main = "Population Expansion model")
legend("top",legend = c(0, 50, 100, -50, -100),col=ViridisColors, pch=19, cex = 2, title = "4Ns", bty = "n")
# arrows(x0=1, y0=quantile(medqRMSE_4Ns0_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns0_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns0_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns0_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns0_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns0_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns0_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns0_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns0_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns0_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)

lines(c(median((Selection4Ns_50_5Windows$V1-200)-50), median((Selection4Ns_50_10Windows$V1-200)-50), median((Selection4Ns_50_50Windows$V1-200)-50)), col = ViridisColors[2], lwd = 5, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4Ns50_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns50_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns50_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns50_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns50_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)

lines(c(median((Selection4Ns_100_5Windows$V1-200)-100),median((Selection4Ns_100_10Windows$V1-200)-100),median((Selection4Ns_100_50Windows$V1-200)-100)), col = ViridisColors[3], lwd = 4, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4Ns100_3,0.05), x1=1, y1=quantile(medqRMSE_4Ns100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=2, y0=quantile(medqRMSE_4Ns100_5,0.05), x1=2, y1=quantile(medqRMSE_4Ns100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=3, y0=quantile(medqRMSE_4Ns100_10,0.05), x1=3, y1=quantile(medqRMSE_4Ns100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=4, y0=quantile(medqRMSE_4Ns100_50,0.05), x1=4, y1=quantile(medqRMSE_4Ns100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=5, y0=quantile(medqRMSE_4Ns100_100,0.05), x1=5, y1=quantile(medqRMSE_4Ns100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)

lines(c(median((Selection4Ns_Minus50_5Windows$V1-200)+50),median((Selection4Ns_Minus50_10Windows$V1-200)+50),median((Selection4Ns_Minus50_50Windows$V1-200)+50)), col = ViridisColors[4], lwd = 3, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4NsMinus50_3,0.05), x1=1, y1=quantile(medqRMSE_4NsMinus50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=2, y0=quantile(medqRMSE_4NsMinus50_5,0.05), x1=2, y1=quantile(medqRMSE_4NsMinus50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=3, y0=quantile(medqRMSE_4NsMinus50_10,0.05), x1=3, y1=quantile(medqRMSE_4NsMinus50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=4, y0=quantile(medqRMSE_4NsMinus50_50,0.05), x1=4, y1=quantile(medqRMSE_4NsMinus50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=5, y0=quantile(medqRMSE_4NsMinus50_100,0.05), x1=5, y1=quantile(medqRMSE_4NsMinus50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)

lines(c(median((Selection4Ns_Minus100_5Windows$V1-200)+100),median((Selection4Ns_Minus100_10Windows$V1-200)+100),median((Selection4Ns_Minus100_50Windows$V1-200)+100)), col = ViridisColors[5], lwd = 2, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(medqRMSE_4NsMinus100_3,0.05), x1=1, y1=quantile(medqRMSE_4NsMinus100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=2, y0=quantile(medqRMSE_4NsMinus100_5,0.05), x1=2, y1=quantile(medqRMSE_4NsMinus100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=3, y0=quantile(medqRMSE_4NsMinus100_10,0.05), x1=3, y1=quantile(medqRMSE_4NsMinus100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=4, y0=quantile(medqRMSE_4NsMinus100_50,0.05), x1=4, y1=quantile(medqRMSE_4NsMinus100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=5, y0=quantile(medqRMSE_4NsMinus100_100,0.05), x1=5, y1=quantile(medqRMSE_4NsMinus100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)

axis(1, at=c(1, 2, 3), labels = c("One side", "Double sims", "Both sides"), cex.axis=2.2, cex.lab=2.5)


ViridisColors <- viridis(5)
plot(c(RMSE_4Ns0_5,RMSE_4Ns0_10,RMSE_4Ns0_50), col = ViridisColors[1], xlab = "Adjacent regions taken", ylab = "RMSE", cex.axis=2.2, cex.lab=2.5, cex.main=2.5, xaxt= "n", lwd = 6, ylim = c(0,120), type = "b", pch = 19, cex = 3, main = "Population Expansion model")
legend("top",legend = c(0, 50, 100, -50, -100),col=ViridisColors, pch=19, cex = 2, title = "4Ns", bty = "n")

# arrows(x0=1, y0=quantile(qRMSE_4Ns0_3,0.05), x1=1, y1=quantile(qRMSE_4Ns0_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=2, y0=quantile(qRMSE_4Ns0_5,0.05), x1=2, y1=quantile(qRMSE_4Ns0_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=3, y0=quantile(qRMSE_4Ns0_10,0.05), x1=3, y1=quantile(qRMSE_4Ns0_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=4, y0=quantile(qRMSE_4Ns0_50,0.05), x1=4, y1=quantile(qRMSE_4Ns0_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)
# arrows(x0=5, y0=quantile(qRMSE_4Ns0_100,0.05), x1=5, y1=quantile(qRMSE_4Ns0_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[1], lwd=6)

# lines(c(median(Selection4Ns_50_3Windows$V1-200),median(Selection4Ns_50_5Windows$V1-200),median(Selection4Ns_50_10Windows$V1-200),median(Selection4Ns_50_50Windows$V1-200),median(Selection4Ns_50_100Windows$V1-200)), col = ViridisColors[2])
lines(c(RMSE_4Ns50_5,RMSE_4Ns50_10,RMSE_4Ns50_50), col = ViridisColors[2], lwd = 5, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4Ns50_3,0.05), x1=1, y1=quantile(qRMSE_4Ns50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=2, y0=quantile(qRMSE_4Ns50_5,0.05), x1=2, y1=quantile(qRMSE_4Ns50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=3, y0=quantile(qRMSE_4Ns50_10,0.05), x1=3, y1=quantile(qRMSE_4Ns50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=4, y0=quantile(qRMSE_4Ns50_50,0.05), x1=4, y1=quantile(qRMSE_4Ns50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)
# arrows(x0=5, y0=quantile(qRMSE_4Ns50_100,0.05), x1=5, y1=quantile(qRMSE_4Ns50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[2], lwd=5)

# lines(c(median(Selection4Ns_100_3Windows$V1-200),median(Selection4Ns_100_5Windows$V1-200),median(Selection4Ns_100_10Windows$V1-200),median(Selection4Ns_100_50Windows$V1-200),median(Selection4Ns_100_100Windows$V1-200), col = ViridisColors[3])
lines(c(RMSE_4Ns100_5,RMSE_4Ns100_10,RMSE_4Ns100_50), col = ViridisColors[3], lwd = 4, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4Ns100_3,0.05), x1=1, y1=quantile(qRMSE_4Ns100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=2, y0=quantile(qRMSE_4Ns100_5,0.05), x1=2, y1=quantile(qRMSE_4Ns100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=3, y0=quantile(qRMSE_4Ns100_10,0.05), x1=3, y1=quantile(qRMSE_4Ns100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=4, y0=quantile(qRMSE_4Ns100_50,0.05), x1=4, y1=quantile(qRMSE_4Ns100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)
# arrows(x0=5, y0=quantile(qRMSE_4Ns100_100,0.05), x1=5, y1=quantile(qRMSE_4Ns100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[3], lwd=4)

# lines(c(median(Selection4NsMinus50_3Windows$V1-200),median(Selection4NsMinus50_5Windows$V1-200),median(Selection4NsMinus50_10Windows$V1-200),median(Selection4NsMinus50_50Windows$V1-200),median(Selection4NsMinus50_100Windows$V1-200), col = ViridisColors[4])
lines(c(RMSE_4NsMinus50_5,RMSE_4NsMinus50_10,RMSE_4NsMinus50_50), col = ViridisColors[4], lwd = 3, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4NsMinus50_3,0.05), x1=1, y1=quantile(qRMSE_4NsMinus50_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=2, y0=quantile(qRMSE_4NsMinus50_5,0.05), x1=2, y1=quantile(qRMSE_4NsMinus50_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=3, y0=quantile(qRMSE_4NsMinus50_10,0.05), x1=3, y1=quantile(qRMSE_4NsMinus50_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=4, y0=quantile(qRMSE_4NsMinus50_50,0.05), x1=4, y1=quantile(qRMSE_4NsMinus50_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)
# arrows(x0=5, y0=quantile(qRMSE_4NsMinus50_100,0.05), x1=5, y1=quantile(qRMSE_4NsMinus50_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[4], lwd=3)

# lines(c(median(Selection4NsMinus100_3Windows$V1-200),median(Selection4NsMinus100_5Windows$V1-200),median(Selection4NsMinus100_10Windows$V1-200),median(Selection4NsMinus100_50Windows$V1-200),median(Selection4NsMinus100_100Windows$V1-200), col = ViridisColors[5])
lines(c(RMSE_4NsMinus100_5,RMSE_4NsMinus100_10,RMSE_4NsMinus100_50), col = ViridisColors[5], lwd = 2, type = "b", pch = 19, cex = 3)
# arrows(x0=1, y0=quantile(qRMSE_4NsMinus100_3,0.05), x1=1, y1=quantile(qRMSE_4NsMinus100_3,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
#arrows(x0=2, y0=quantile(qRMSE_4NsMinus100_5,0.05), x1=2, y1=quantile(qRMSE_4NsMinus100_5,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=3, y0=quantile(qRMSE_4NsMinus100_10,0.05), x1=3, y1=quantile(qRMSE_4NsMinus100_10,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5],  lwd=2)
# arrows(x0=4, y0=quantile(qRMSE_4NsMinus100_50,0.05), x1=4, y1=quantile(qRMSE_4NsMinus100_50,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)
# arrows(x0=5, y0=quantile(qRMSE_4NsMinus100_100,0.05), x1=5, y1=quantile(qRMSE_4NsMinus100_100,0.95), code=3, angle=90, length=0.5, col=ViridisColors[5], lwd=2)

axis(1, at=c(1, 2, 3), labels = c("One side", "Double sims", "Both sides"), cex.axis=2.2, cex.lab=2.5)
# axis(2, at=c(1, 2, 3, 4, 5), labels = c(3, 5, 10, 50, 100))

dev.off()
