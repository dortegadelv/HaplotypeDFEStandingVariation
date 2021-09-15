library(here)


Data <- read.table("../Results/AllAgeESS/FinalStats.txt")

Title = c("Constant Population Size", "Population Expansion Model\n(Expansion Time = 100 Gens ago)", "Ancient Bottleneck Model", "Population expansion Model \n(Expansion Time = 100,000 Gens ago)", "Population expansion Model\n(Expansion Time = 10,000 Gens ago)", "Population expansion Model\n(Expansion Time = 1,000 Gens ago)", "", "Schiffels and Durbin (2014)\nNature Genetics model", "Demographic Model in Africans\nTennessen et al (2012) Science model", "Scaled UK10K demographic model")

pdf("../Figures/SuppFigure25_AllPlots.pdf",height = 3*7/2, width = 7*3/2)
par(mfrow=c(3,3),mar=c(4.1,3.1,6.1,1.1))

for (i in 1:6){

plot(-200:200,Data[i,403:803],type="l",ylab="ESS",xlab="4Ns",cex.lab=1.4,cex.axis=1.5,lwd=2, ylim =c(0,max(Data[i,403:803])), main = Title[i])
abline(h=100, col = "red")
}

for (i in 8:10){

plot(-200:200,Data[i,403:803],type="l",ylab="ESS",xlab="4Ns",cex.lab=1.4,cex.axis=1.5,lwd=2, ylim =c(0,max(Data[i,403:803])), main = Title[i])
abline(h=100, col = "red")
}

dev.off()
