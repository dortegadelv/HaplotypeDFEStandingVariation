### One Percenters

library(here)
PriorData <- read.table("../Results/ABCResults/ParametersAndStatistics.txt")

Posterior100 <- read.table("../Results/ABCResults/Best100.txt")

pdf("../Figures/SuppFigure5_DemModelInference.pdf",height=35/6,width=7*2.2/4)

par(mfrow=c(5,2),mar=c(2.1,1.1,1.1,2.1),mgp=c(3,0,0))

plot(density(Posterior100$V4,from=0,to=1449),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V4,from=0,to=1449))
legend("topright",c(expression(T[1]),"median = 303"),bty="n")
title(xlab="Prior ~ unif (0, 1449)", line=0)
#axis(1,"Prior ~ unif(0, 1449)")
plot(density(Posterior100$V2,from=1000,to=1000000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V2,from=1000,to=1000000))
legend("bottomright",c(expression(N[1]),"median = 551894"),bty="n")
title(xlab="Prior ~ unif (1000, 1000000)", line=0)
plot(density(Posterior100$V3,from=500,to=50000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V3,from=500,to=50000))
legend("topright",c(expression(N[2]),"median = 6685"),bty="n")
title(xlab="Prior ~ unif (500, 50000)", line=0)
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), axes=FALSE)
legend("center",c("Prior","Posterior"),pch=19,col=c("black","blue"),bty="n")
dev.off()

####################### Not CpG


PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG.txt")

Posterior100 <- read.table("../Results/ABCResults/Best100NotCpG.txt")

pdf("../Figures/SuppFigure5_DemModelInferenceNotCpG.pdf",height=35/6,width=7*2.2/4)

par(mfrow=c(5,2),mar=c(2.1,1.1,1.1,2.1),mgp=c(3,0,0))

plot(density(Posterior100$V4,from=0,to=1449),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V4,from=0,to=1449))
legend("topright",c(expression(T[1]),"median = 228"),bty="n")
title(xlab="Prior ~ unif (0, 1449)", line=0)
#axis(1,"Prior ~ unif(0, 1449)")
plot(density(Posterior100$V2,from=1000,to=1000000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V2,from=1000,to=1000000))
legend("bottomright",c(expression(N[1]),"median = 565631"),bty="n")
title(xlab="Prior ~ unif (1000, 1000000)", line=0)
plot(density(Posterior100$V3,from=500,to=50000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V3,from=500,to=50000))
legend("topright",c(expression(N[2]),"median = 3740"),bty="n")
title(xlab="Prior ~ unif (500, 50000)", line=0)
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), axes=FALSE)
legend("center",c("Prior","Posterior"),pch=19,col=c("black","blue"),bty="n")
dev.off()

