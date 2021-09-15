library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(viridis)

DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("0", "50", "100", "-50", "-100")
FourNsLine <- c(0, 50, 100, 50, 100)
Magnitude <- c( "NotSoSmallMut", "FivePercentSmallMut", "FivePercentBigMut", "NotSoBigMut")
Titles <- c("Constant Population Size 4Ns = 0\nActual Mutation rate = 1.2e-8","Constant Population Size 4Ns = 50\nActual Mutation rate = 1.2e-8","Constant Population Size 4Ns = 100\nActual Mutation rate = 1.2e-8","Constant Population Size 4Ns = -50\nActual Mutation rate = 1.2e-8","Constant Population Size 4Ns = -100\nActual Mutation rate = 1.2e-8")

ViridisColors <- viridis(5)

pdf ("../Figures/SuppFigure27_UK10K4Ns0AncMis.pdf")
par(mar = c(6, 5, 1, 1))


Data <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecMisAnc4Ns4Ns_0.txt")
Data1 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecMisAnc4Ns4Ns_25.txt")
Data2 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecMisAnc4Ns4Ns_50.txt")
DataTwo <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_0CoefNum5.txt")
DataTwo1 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_25CoefNum5.txt")
DataTwo2 <- read.table("../Results/ResultsSelectionInferred/SelectionUK10K4Ns_50CoefNum5.txt")

        beanplot(DataTwo[,1], Data[,1] ,DataTwo1[,1], Data1[,1] ,DataTwo2[,1], Data2[,1] ,names=c("No a.m.\n 4Ns = 0","With a.m.\n 4Ns = 0","No a.m.\n 4Ns = 25","With a.m.\n 4Ns = 25","No a.m.\n 4Ns = 50","With a.m.\n 4Ns = 50"),ylab="Estimated 4Ns values",main="", cex.names = 0.75, cex = 1, cex.axis=1.,cex.lab=1.5,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
        abline(h=0,lty=3)
abline(h=50,lty=3)
abline(h=25,lty=3)

DataSet <- data.frame(Data[,1], DataTwo[,1])
kruskal.test(Data...1. ~ DataTwo...1., data = DataSet)

dev.off()


# , xlab="Real 4Ns values"
