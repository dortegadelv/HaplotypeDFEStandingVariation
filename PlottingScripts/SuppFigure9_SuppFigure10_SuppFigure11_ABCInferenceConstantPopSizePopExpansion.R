library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(viridis)

FiveColors <- viridis(5)

Data <- read.table("../Results/ABCResults/MedianResultsConstantPopSizes.txt")

pdf("../Figures/SuppFigure9_ABCInferenceConstantPopSizes.pdf", height= 14)
par(mfrow=c(2,1))
boxplot(Data$V1, main = "N")
abline(h=10000,lty=2)


PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpGConstantPopSize.txt")

plot(density(PriorData$V1,from=1000,to=20000), col="black", xlab="N", ylab="", main="" ,lty=2,ylim = c(0,0.8e-3), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

PosteriorQuantile <- c()
for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGConstantPopSize",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V1,from=1000,to=20000), col=FiveColors[i], cex=2, lwd=3)

SortValues <- sort (Posterior100$V1)
for (j in 1:100){
    if (SortValues[j] > 10000 ){
        PosteriorQuantile <- c(PosteriorQuantile, j)
        break
    }
}

}

legend("topright",c("Dotted line - Prior distribution","Solid lines - 5 Posterior distributions"), bty="n")

dev.off()


Data <- read.table("../Results/ABCResults/MedianResultsPopExpansion.txt")


pdf("../Figures/SuppFigure10_ABCInferencePopExpansion.pdf",width=14, height= 14)
par(mfrow=c(2,3))

boxplot(Data$V1, main = "N in the present epoch", cex.axis = 2, cex.main = 2 )
abline(h=50000,lty=2)
boxplot(Data$V2, main =  "N in the past epoch", cex.axis = 2, cex.main = 2)
abline(h=5000,lty=2)
boxplot(Data$V3, main = "Time of population size change", cex.axis = 2, cex.main = 2)
abline(h=100,lty=2)


PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpGPopExpansion.txt")

plot(density(PriorData$V1,from=10000,to=100000), col="black", xlab="N in the past epoch", ylab="", main="" ,lty=2,ylim = c(0,0.3e-4), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansion",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V1,from=10000,to=100000), col=FiveColors[i], cex=2, lwd=3)

}


plot(density(PriorData$V2,from=1000,to=10000), col="black", xlab="N in the present epoch", ylab="", main="" ,lty=2,ylim = c(0,0.03e-2), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansion",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V2,from=1000,to=10000), col=FiveColors[i], cex=2, lwd=3)

}



plot(density(PriorData$V3,from=0,to=500), col="black", xlab="Time of population size change", ylab="", main="" ,lty=2,ylim = c(0,2e-2), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansion",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V3,from=0,to=500), col=FiveColors[i], cex=2, lwd=3)

}

legend("topright",c("Dotted line - Prior distribution","Solid lines - 5 Posterior distributions"), bty="n",cex=1.5)


dev.off()

Data <- read.table("../Results/ABCResults/MedianResultsPopExpansionDifRecRate.txt")


pdf("../Figures/SuppFigure11_ABCInferencePopExpansionDifRecRate.pdf",width=14, height= 14)
par(mfrow=c(2,3))

boxplot(Data$V1, main = "N in the present epoch", cex.axis = 2, cex.main = 2 )
abline(h=50000,lty=2)
boxplot(Data$V2, main =  "N in the past epoch", cex.axis = 2, cex.main = 2)
abline(h=5000,lty=2)
boxplot(Data$V3, main = "Time of population size change", cex.axis = 2, cex.main = 2)
abline(h=100,lty=2)


PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpGPopExpansion.txt")

plot(density(PriorData$V1,from=10000,to=100000), col="black", xlab="N in the past epoch", ylab="", main="" ,lty=2,ylim = c(0,0.3e-4), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansionDifRate",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V1,from=10000,to=100000), col=FiveColors[i], cex=2, lwd=3)

}


plot(density(PriorData$V2,from=1000,to=10000), col="black", xlab="N in the present epoch", ylab="", main="" ,lty=2,ylim = c(0,0.03e-2), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansionDifRate",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V2,from=1000,to=10000), col=FiveColors[i], cex=2, lwd=3)

}



plot(density(PriorData$V3,from=0,to=500), col="black", xlab="Time of population size change", ylab="", main="" ,lty=2,ylim = c(0,2e-2), yaxt = "n", cex.lab=2, cex.axis=2, lwd=3)

for (i in 1:5){
    Title <- paste("../Results/ABCResults/Best100NotCpGPopExpansionDifRate",i,".txt",sep="")
    Posterior100 <- read.table(Title)
lines(density(Posterior100$V3,from=0,to=500), col=FiveColors[i], cex=2, lwd=3)

}

legend("topright",c("Dotted line - Prior distribution","Solid lines - 5 Posterior distributions"), bty="n",cex=1.5)


dev.off()


