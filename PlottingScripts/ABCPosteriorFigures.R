### One Percenters

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/Data/ABC_Analysis/FifthTryOctober15_2016")

PriorData <- read.table("ParametersAndStatistics.txt")

Posterior100 <- read.table("Best100.txt")

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/PotentialPaperFigures")

pdf("DemParametersAllPercenters.pdf",height=35/6,width=7*2.2/4)

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
# dev.off()

min(PriorData$V2)
min(PriorData$V3)
min(PriorData$V4)

max(PriorData$V2)
max(PriorData$V3)
max(PriorData$V4)

cor(Posterior100$V1,Posterior100$V2)
cor(Posterior100$V1,Posterior100$V3)
cor(Posterior100$V1,Posterior100$V4)

cor(Posterior100$V2,Posterior100$V3)
cor(Posterior100$V2,Posterior100$V4)

cor(Posterior100$V3,Posterior100$V4)

dens <-density(Posterior100$V1)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V1)
median(Posterior100$V1)

dens <-density(Posterior100$V2)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V2)
median(Posterior100$V2)

dens <-density(Posterior100$V3)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V3)
median(Posterior100$V3)

dens <-density(Posterior100$V4)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V4)
median(Posterior100$V4)

### Point Two Percenters

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/Data/ABC_Analysis/ThirteenthTry_December19_2016")

PriorData <- read.table("ParametersAndStatistics.txt")

Posterior100 <- read.table("Best100.txt")

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/PotentialPaperFigures")

#pdf("DemParametersPointTwoPercenters.pdf",height=18/6,width=7*2.2/4)

#par(mfrow=c(3,2),mar=c(2.1,1.1,1.1,2.1),mgp=c(3,0,0))

plot(density((Posterior100$V5),from=0,to=699),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density((PriorData$V5),from=0,to=699))
legend("topleft",c(expression(T[1]),"median = 409"),bty="n")
title(xlab="Prior ~ unif (0, 699)", line=0)

plot(density(Posterior100$V6,from=0,to=19999),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V6,from=0,to=19999))
legend("bottom",c(expression(T[2]),"median = 10434"),bty="n")
Join <- c(expression( Prior ~ unif ( T[1] + 1, 19999)))
#expression(T[1])
title(xlab=Join, line=0.2)

plot(density(Posterior100$V2,from=200000,to=1000000),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V2,from=200000,to=1000000))
legend("topleft",c(expression(N[1]),"median = 790955"),bty="n")
title(xlab="Prior ~ unif (200000, 1000000)", line=0)

plot(density(Posterior100$V3,from=1000,to=100000),col="blue",xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(PriorData$V3,from=1000,to=100000))
legend("topright",c(expression(N[2]),"median = 2744"),bty="n")
title(xlab="Prior ~ log10 (3, 5)", line=0)

plot(density(PriorData$V4,from=1000,to=100000),xlab="",ylab="",main="",xaxt="n",yaxt="n")
lines(density(Posterior100$V4,from=1000,to=100000),col="blue")
legend("topright",c(expression(N[3]),"median = 14341"),bty="n")
title(xlab="Prior ~ log10 (3, 5)", line=0)

plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10), axes=FALSE)
legend("center",c("Prior","Posterior"),pch=19,col=c("black","blue"),bty="n")
dev.off()

min(PriorData$V2)
min(PriorData$V3)
min(PriorData$V4)
min(PriorData$V5)
min(PriorData$V6)

max(PriorData$V2)
max(PriorData$V3)
max(PriorData$V4)
max(PriorData$V5)
max(PriorData$V6)


cor(Posterior100$V1,Posterior100$V2)
cor(Posterior100$V1,Posterior100$V3)
cor(Posterior100$V1,Posterior100$V4)

cor(Posterior100$V2,Posterior100$V3)
cor(Posterior100$V2,Posterior100$V4)

cor(Posterior100$V3,Posterior100$V4)



dens <-density(Posterior100$V1)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V1)
median(Posterior100$V1)

dens <-density(Posterior100$V2)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V2)
median(Posterior100$V2)

dens <-density(Posterior100$V3)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V3)
median(Posterior100$V3)

dens <-density(Posterior100$V4)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V4)
median(Posterior100$V4)


dens <-density(Posterior100$V5)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V5)
median(Posterior100$V5)


dens <-density(Posterior100$V6)
x.mode <- dens$x[i.mode <- which.max(dens$y)]
x.mode
mean(Posterior100$V6)
median(Posterior100$V6)


