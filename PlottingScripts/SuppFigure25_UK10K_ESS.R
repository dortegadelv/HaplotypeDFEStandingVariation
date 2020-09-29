library(here)


Data <- read.table("../Results/AllAgeESS/FinalStatsUK10KTestTwo.txt")

pdf("../Figures/SuppFigure25_UK10K_ESS.pdf")
plot(-200:200,Data[12,403:803],type="l",ylab="ESS",xlab="4Ns",cex.lab=1.4,cex.axis=1.5,lwd=2)
#lines(-200:200,Data[2,403:803],type="l",col="red",cex.lab=1.4,cex.axis=1.5,lwd=2)
#lines(-200:200,Data[3,403:803],type="l",col="blue",cex.lab=1.4,cex.axis=1.5,lwd=2)

#Data <- read.table("../Results/AllAgeESS/FinalStatsUK10KNeutral.txt")
#lines(-200:200,Data[403:803],type="l",col="green",cex.lab=1.4,cex.axis=1.5,lwd=2)
dev.off()
