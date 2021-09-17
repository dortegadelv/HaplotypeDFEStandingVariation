library(here)

Data <- read.table("../Results/AllAgeESS/FinalStatsConstantPopSize.txt")

pdf("../Figures/SuppFigure25_ConstantPopSizeESS.pdf")
plot(-200:200,Data[403:803],type="l",ylab="ESS",xlab="4Ns",cex.lab=1.4,cex.axis=1.5,lwd=2)
dev.off()
