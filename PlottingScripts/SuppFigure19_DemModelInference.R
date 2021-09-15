### One Percenters

library(here)
PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG50000.txt")

Posterior100 <- read.table("../Results/ABCResults/BestNotCpGOrdered100Sims.txt")

pdf("../Figures/SuppFigure19_DemModelInference.pdf",height=35/6,width=7*2.2/4)

par(mfrow=c(5,2),mar=c(2.1,1.1,1.1,2.1),mgp=c(3,0,0))

plot(density(Posterior100$V4,from=0,to=1449),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V4,from=0,to=1449))
legend("topright",c(expression(T[1]),"median = 243"),bty="n")
title(xlab="Prior ~ unif (0, 1449)", line=0)
#axis(1,"Prior ~ unif(0, 1449)")
plot(density(Posterior100$V2,from=1000,to=1000000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V2,from=1000,to=1000000))
legend("bottom",c(expression(N[1]),"median = 411155"),bty="n")
title(xlab="Prior ~ unif (1000, 1000000)", line=0)
plot(density(Posterior100$V3,from=500,to=20000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V3,from=500,to=20000))
legend("topright",c(expression(N[2]),"median = 3184.5"),bty="n")
title(xlab="Prior ~ unif (500, 20000)", line=0)
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), axes=FALSE)
legend("center",c("Prior","Posterior"),pch=19,col=c("black","blue"),bty="n")
dev.off()

####################### Not CpG


PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG50000.txt")

Posterior100 <- read.table("../Results/ABCResults/Best500NotCpG.txt")

pdf("../Figures/SuppFigure19_DemModelInferenceNotCpG.pdf",height=35/6,width=7*2.2/4)

par(mfrow=c(5,2),mar=c(2.1,1.1,1.1,2.1),mgp=c(3,0,0))

plot(density(Posterior100$V4,from=0,to=1449),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V4,from=0,to=1449))
legend("topright",c(expression(T[1]),"median = 238"),bty="n")
title(xlab="Prior ~ unif (0, 1449)", line=0)
#axis(1,"Prior ~ unif(0, 1449)")
plot(density(Posterior100$V2,from=1000,to=1000000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V2,from=1000,to=1000000))
legend("bottomright",c(expression(N[1]),"median = 505048"),bty="n")
title(xlab="Prior ~ unif (1000, 1000000)", line=0)
plot(density(Posterior100$V3,from=500,to=20000),col="blue",ylab="",xlab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V3,from=500,to=20000))
legend("topright",c(expression(N[2]),"median = 3482"),bty="n")
title(xlab="Prior ~ unif (500, 20000)", line=0)
plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), axes=FALSE)
legend("center",c("Prior","Posterior"),pch=19,col=c("black","blue"),bty="n")
dev.off()

pdf("../Figures/SuppFigure19_FitDifferentNe.pdf",height=35/6,width=7*2.2/4)

PriorData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpGRound4.txt")

Names <- c(PriorData$V2[2401],PriorData$V2[2301],PriorData$V2[2201],PriorData$V2[2101],PriorData$V2[2001],PriorData$V2[1901],PriorData$V2[1801],PriorData$V2[1701],PriorData$V2[1601],PriorData$V2[1501],PriorData$V2[1401],PriorData$V2[1301],PriorData$V2[1201],PriorData$V2[1101],PriorData$V2[1001],PriorData$V2[901],PriorData$V2[1],PriorData$V2[101],PriorData$V2[201],PriorData$V2[301],PriorData$V2[401],PriorData$V2[501],PriorData$V2[601],PriorData$V2[701],PriorData$V2[801])

boxplot(PriorData$V5[2401:2500],PriorData$V5[2301:2400],PriorData$V5[2201:2300],PriorData$V5[2101:2200],PriorData$V5[2001:2100],PriorData$V5[1901:2000],PriorData$V5[1801:1900],PriorData$V5[1701:1800],PriorData$V5[1601:1700],PriorData$V5[1501:1600],PriorData$V5[1401:1500],PriorData$V5[1301:1400],PriorData$V5[1201:1300],PriorData$V5[1101:1200],PriorData$V5[1001:1100],PriorData$V5[901:1000],PriorData$V5[1:100],PriorData$V5[101:200],PriorData$V5[201:300],PriorData$V5[301:400],PriorData$V5[401:500],PriorData$V5[501:600],PriorData$V5[601:700],PriorData$V5[701:800],PriorData$V5[801:900], names = Names)

dev.off()


for (i in 1:25){
    
    NumberOne <- (i - 1) * 100 + 1
    NumberTwo <- (i) * 100
    print (i)
    print(median(PriorData$V5[NumberOne:NumberTwo]))
}
